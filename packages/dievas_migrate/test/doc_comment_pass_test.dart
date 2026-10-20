import 'package:dievas_migrate/src/doc_comment_pass.dart';
import 'package:dievas_migrate/src/text_edit.dart';
import 'package:test/test.dart';

String migrateComments(String source) => applyEdits(source, const CommentRewriter().edits(source));

void main() {
  test('rewrites known receivers in line and block comments', () {
    const source = '''
/// Spacing [context.spacing.MD] and [DievasSpacingSemantic.XS].
void a() {}

/* Radius [DievasRadiusSemantic.R28] and [context.elevation.MDPlus]. */
void b() {}
''';
    final result = migrateComments(source);
    expect(result, contains('[context.spacing.md]'));
    expect(result, contains('[DievasSpacingSemantic.xs]'));
    expect(result, contains('[DievasRadiusSemantic.r28]'));
    expect(result, contains('[context.elevation.mdPlus]'));
  });

  test('leaves unrelated types and bare members alone', () {
    const source = '''
// [UnrelatedSize.MD] and a bare MD and [somethingElse.SM].
const label = 'MD';
''';
    expect(migrateComments(source), source);
  });

  test('rewrites component size references now that they are renamed', () {
    const source = '''
/// Button [DievasButtonSize.MD] and avatar [DievasAvatarSize.XL2].
void a() {}
''';
    final result = migrateComments(source);
    expect(result, contains('[DievasButtonSize.md]'));
    expect(result, contains('[DievasAvatarSize.xl2]'));
  });

  test('does not edit comment markers inside strings', () {
    const source = "const s = '// [context.spacing.MD]';\n";
    expect(migrateComments(source), source);
  });

  test('handles trailing comments at end of file', () {
    expect(migrateComments('void a() {} // [context.spacing.LG]'), endsWith('[context.spacing.lg]'));
  });
}
