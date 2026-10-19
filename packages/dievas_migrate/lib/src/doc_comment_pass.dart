import 'package:dievas_migrate/src/size_vocabulary.dart';
import 'package:dievas_migrate/src/text_edit.dart';

/// Rewrites `[context.spacing.MD]`-style references inside comments.
///
/// Comments produce no analyzer diagnostic, so this runs as a separate text
/// pass. Only members qualified by a known receiver migrate; bare `MD` and
/// unrelated `[DievasButtonSize.MD]` references stay.
List<TextEdit> commentEdits(String source) {
  final pattern = _pattern();
  final edits = <TextEdit>[];
  for (final (start, end) in _commentRanges(source)) {
    final comment = source.substring(start, end);
    for (final match in pattern.allMatches(comment)) {
      final old = match.group(1)!;
      if (renamedMember(old) case final renamed?) {
        edits.add(
          TextEdit(
            offset: start + match.start + match.group(0)!.length - old.length,
            length: old.length,
            replacement: renamed,
          ),
        );
      }
    }
  }
  return edits;
}

RegExp _pattern() {
  final receivers = commentReceiverNames.toList()..sort((a, b) => b.length.compareTo(a.length));
  final members = renamedMembersByLength;
  return RegExp('(?<![\\w])(?:${receivers.join('|')})(?:\\.\\w+)*\\.(${members.join('|')})\\b');
}

/// Ranges of `//` and `/* */` comments, skipping string literals that merely
/// contain comment markers. Interpolation with nested same-quote strings is out
/// of scope; a mis-scan can only miss an edit, never corrupt code.
List<(int, int)> _commentRanges(String source) {
  final ranges = <(int, int)>[];
  var i = 0;
  while (i < source.length) {
    final char = source[i];
    if (char == "'" ||
        char == '"' ||
        (char == 'r' && i + 1 < source.length && (source[i + 1] == "'" || source[i + 1] == '"'))) {
      i = _skipString(source, i);
      continue;
    }
    if (char == '/' && i + 1 < source.length && source[i + 1] == '/') {
      final newline = source.indexOf('\n', i);
      final stop = newline == -1 ? source.length : newline;
      ranges.add((i, stop));
      i = stop;
      continue;
    }
    if (char == '/' && i + 1 < source.length && source[i + 1] == '*') {
      final close = source.indexOf('*/', i + 2);
      final stop = close == -1 ? source.length : close + 2;
      ranges.add((i, stop));
      i = stop;
      continue;
    }
    i++;
  }
  return ranges;
}

int _skipString(String source, int start) {
  var i = start;
  final raw = source[i] == 'r';
  if (raw) {
    i++;
  }
  final quote = source[i];
  final triple = i + 2 < source.length && source[i + 1] == quote && source[i + 2] == quote;
  i += triple ? 3 : 1;
  while (i < source.length) {
    if (!raw && source[i] == r'\') {
      i += 2;
      continue;
    }
    if (source[i] == quote) {
      if (!triple) {
        return i + 1;
      }
      if (i + 2 < source.length && source[i + 1] == quote && source[i + 2] == quote) {
        return i + 3;
      }
    }
    i++;
  }
  return source.length;
}
