import 'package:dievas_migrate/src/text_edit.dart';
import 'package:dievas_migrate/src/token_vocabulary.dart';

/// Rewrites the keys of a record literal that the analyzer rejects whole.
///
/// A record literal like `(SM: …, MD: …, LG: …)` bound to a record typedef is
/// reported as a single assignment diagnostic covering the whole literal; the
/// individual keys emit no diagnostic of their own, so the member pass cannot
/// see them. This pass reads the diagnostic's range, confirms it is a record
/// literal, and lowercases only the size keys inside it.
final class RecordLiteralRewriter {
  const RecordLiteralRewriter();

  /// Produces edits for one whole-literal diagnostic. [offset] and [length]
  /// address the record literal; [fields] are the member names the diagnostic
  /// message named. Returns nothing when the range is not a record literal or
  /// holds no renamed key.
  List<TextEdit> edits(String source, {required int offset, required int length, required Iterable<String> fields}) {
    final String literal = source.substring(offset, offset + length);
    if (!_looksLikeRecordLiteral(literal)) {
      return const [];
    }
    final Set<String> candidates = {};
    for (final String field in fields) {
      if (renamedMember(field) != null) {
        candidates.add(field);
      }
    }
    if (candidates.isEmpty) {
      return const [];
    }
    final List<TextEdit> result = [];
    for (final RegExpMatch match in _keyPattern.allMatches(literal)) {
      final String? key = match.group(2);
      if (key == null || !candidates.contains(key)) {
        continue;
      }
      final String? renamedKey = renamedMember(key);
      if (renamedKey == null) {
        continue;
      }
      result.add(TextEdit(offset: offset + match.start, length: key.length, replacement: renamedKey));
    }
    return result;
  }

  /// A record literal opens with `(` and closes with `)`, and its fields are
  /// `name:` pairs. A call's argument list looks identical, but it never yields
  /// this diagnostic and its named parameters are owned by the member pass.
  bool _looksLikeRecordLiteral(String literal) =>
      literal.startsWith('(') && literal.endsWith(')') && _keyPattern.hasMatch(literal);

  /// Captures a boundary character (group 1) and an identifier used as a record
  /// field key (group 2), so a value's own nested `key:` is not mistaken for a
  /// top-level field.
  static final RegExp _keyPattern = RegExp(r'([(,])\s*([A-Za-z][A-Za-z0-9]*)\s*:');
}
