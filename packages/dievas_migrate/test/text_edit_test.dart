import 'package:dievas_migrate/src/text_edit.dart';
import 'package:test/test.dart';

void main() {
  test('applies edits without invalidating earlier offsets', () {
    const source = 'MD and XS and MDPlus';
    final result = applyEdits(source, const [
      TextEdit(offset: 0, length: 2, replacement: 'md'),
      TextEdit(offset: 7, length: 2, replacement: 'xs'),
      TextEdit(offset: 14, length: 6, replacement: 'mdPlus'),
    ]);
    expect(result, 'md and xs and mdPlus');
  });

  test('returns the source unchanged when there is nothing to do', () {
    expect(applyEdits('unchanged', const []), 'unchanged');
  });
}
