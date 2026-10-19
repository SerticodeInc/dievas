/// A single replacement in a source file, addressed by UTF-16 offset so it can
/// be applied without re-parsing.
final class TextEdit {
  const TextEdit({required this.offset, required this.length, required this.replacement});

  final int offset;
  final int length;
  final String replacement;
}

/// Applies edits to [source] in descending offset order so earlier offsets stay
/// valid. Edits must not overlap.
String applyEdits(String source, List<TextEdit> edits) {
  final ordered = edits.toList()..sort((a, b) => b.offset.compareTo(a.offset));
  String result = source;
  for (final edit in ordered) {
    result = result.replaceRange(edit.offset, edit.offset + edit.length, edit.replacement);
  }
  return result;
}
