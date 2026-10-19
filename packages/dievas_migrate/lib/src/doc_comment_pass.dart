import 'package:dievas_migrate/src/text_edit.dart';
import 'package:dievas_migrate/src/token_vocabulary.dart';

/// Rewrites `[context.spacing.MD]`-style references inside comments.
///
/// Comments produce no analyzer diagnostic, so this runs as a separate text
/// pass. Only members qualified by a known receiver migrate; bare `MD` and
/// unrelated `[DievasButtonSize.MD]` references stay.
final class CommentRewriter {
  const CommentRewriter();

  List<TextEdit> edits(String source) {
    final List<TextEdit> result = [];
    for (final (int start, int end) in _commentRanges(source)) {
      for (final RegExpMatch match in _pattern.allMatches(source.substring(start, end))) {
        final String? member = match.group(1);
        final String? renamed = member == null ? null : renamedMember(member);
        if ((member, renamed) case (final String member, final String renamed)) {
          result.add(TextEdit(offset: start + match.end - member.length, length: member.length, replacement: renamed));
        }
      }
    }
    return result;
  }

  /// Ranges of `//` and `/* */` comments, skipping string literals that merely
  /// contain comment markers. Interpolation with nested same-quote strings is
  /// out of scope; a mis-scan can only miss an edit, never corrupt code.
  List<(int, int)> _commentRanges(String source) {
    final List<(int, int)> ranges = [];
    int i = 0;
    while (i < source.length) {
      final String char = source[i];
      if (char == "'" ||
          char == '"' ||
          (char == 'r' && i + 1 < source.length && (source[i + 1] == "'" || source[i + 1] == '"'))) {
        i = _skipString(source, i);
        continue;
      }
      if (char == '/' && source.startsWith('//', i)) {
        final int stop = switch (source.indexOf('\n', i)) {
          -1 => source.length,
          final int newline => newline,
        };
        ranges.add((i, stop));
        i = stop;
        continue;
      }
      if (char == '/' && source.startsWith('/*', i)) {
        final int close = source.indexOf('*/', i + 2);
        final int stop = close == -1 ? source.length : close + 2;
        ranges.add((i, stop));
        i = stop;
        continue;
      }
      i++;
    }
    return ranges;
  }

  int _skipString(String source, int start) {
    final bool raw = source[start] == 'r';
    int i = raw ? start + 1 : start;
    final String quote = source[i];
    final bool triple = i + 2 < source.length && source[i + 1] == quote && source[i + 2] == quote;
    i += triple ? 3 : 1;
    while (i < source.length) {
      final String char = source[i];
      if (!raw && char == r'\') {
        i += 2;
        continue;
      }
      if (char == quote && !triple) {
        return i + 1;
      }
      if (char == quote && triple && i + 2 < source.length && source[i + 1] == quote && source[i + 2] == quote) {
        return i + 3;
      }
      i++;
    }
    return source.length;
  }

  static final RegExp _pattern = _buildPattern();

  static RegExp _buildPattern() {
    final List<String> receivers = commentReceiverNames.toList()
      ..sort((String a, String b) => b.length.compareTo(a.length));
    return RegExp('(?<![\\w])(?:${receivers.join('|')})(?:\\.\\w+)*\\.(${renamedMembersByLength.join('|')})\\b');
  }
}
