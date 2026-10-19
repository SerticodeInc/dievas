import 'dart:io';

import 'package:dievas_migrate/src/diagnostic.dart';
import 'package:dievas_migrate/src/migrator.dart';
import 'package:test/test.dart';

RenameDiagnostic _getter(String file, String source, String type, String member) {
  final offset = source.indexOf('.$member') + 1;
  return RenameDiagnostic(
    old: member,
    receiverType: type,
    file: file,
    offset: offset,
    length: member.length,
    isNamedParameter: false,
  );
}

RenameDiagnostic _parameter(String file, String source, String member) {
  return RenameDiagnostic(
    old: member,
    receiverType: null,
    file: file,
    offset: source.indexOf('$member:'),
    length: member.length,
    isNamedParameter: true,
  );
}

void main() {
  late Directory dir;
  late File file;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('dievas_migrate_test');
    file = File('${dir.path}/consumer.dart');
  });

  tearDown(() => dir.deleteSync(recursive: true));

  test('rewrites eligible members and reports the change', () async {
    const original = 'const a = DievasSpacingSemantic.MD;\nconst b = DievasSpacingSemantic.R28;\n';
    file.writeAsStringSync(original);
    var calls = 0;
    Future<AnalysisOutput> analyze(List<String> _) async {
      calls++;
      if (calls == 1) {
        return AnalysisOutput(
          total: 2,
          diagnostics: [
            _getter(file.path, original, 'DievasSpacingSemantic', 'MD'),
            _getter(file.path, original, 'DievasSpacingSemantic', 'R28'),
          ],
        );
      }
      return const AnalysisOutput(total: 0, diagnostics: []);
    }

    final report = await migrate(paths: [dir.path], write: true, analyze: analyze);

    expect(report.applied, isTrue);
    expect(report.failed, isFalse);
    expect(report.memberEdits, 2);
    expect(report.files, hasLength(1));
    expect(file.readAsStringSync(), 'const a = DievasSpacingSemantic.md;\nconst b = DievasSpacingSemantic.r28;\n');
  });

  test('dry run reports work without writing', () async {
    const original = 'const a = DievasSpacingSemantic.MD;\n';
    file.writeAsStringSync(original);
    Future<AnalysisOutput> analyze(List<String> _) async =>
        AnalysisOutput(total: 1, diagnostics: [_getter(file.path, original, 'DievasSpacingSemantic', 'MD')]);

    final report = await migrate(paths: [dir.path], write: false, analyze: analyze);

    expect(report.applied, isFalse);
    expect(report.pending, 1);
    expect(report.totalEdits, 1);
    expect(file.readAsStringSync(), original);
  });

  test('restores every file when verification fails', () async {
    const original = 'const a = DievasSpacingSemantic.MD;\n';
    file.writeAsStringSync(original);
    final diagnostic = _getter(file.path, original, 'DievasSpacingSemantic', 'MD');
    Future<AnalysisOutput> analyze(List<String> _) async => AnalysisOutput(total: 1, diagnostics: [diagnostic]);

    final report = await migrate(paths: [dir.path], write: true, analyze: analyze);

    expect(report.failed, isTrue);
    expect(report.applied, isFalse);
    expect(file.readAsStringSync(), original, reason: 'a failed run must not touch the tree');
  });

  test('skips members whose declaring type is not migrated', () async {
    const original = 'const a = DievasButtonSize.MD;\n';
    file.writeAsStringSync(original);
    Future<AnalysisOutput> analyze(List<String> _) async =>
        AnalysisOutput(total: 1, diagnostics: [_getter(file.path, original, 'DievasButtonSize', 'MD')]);

    final report = await migrate(paths: [dir.path], write: true, analyze: analyze);

    expect(report.memberEdits, 0);
    expect(report.skipped, ['DievasButtonSize.MD']);
    expect(file.readAsStringSync(), original);
  });

  test('migrates a named parameter only on an allowed owner', () async {
    const allowed = 'DievasSpacingThemeData(MD: 1.0);\n';
    const denied = 'Unrelated(MD: 1.0);\n';
    final allowedFile = File('${dir.path}/allowed.dart')..writeAsStringSync(allowed);
    final deniedFile = File('${dir.path}/denied.dart')..writeAsStringSync(denied);

    var calls = 0;
    Future<AnalysisOutput> analyze(List<String> _) async {
      calls++;
      if (calls == 1) {
        return AnalysisOutput(
          total: 2,
          diagnostics: [_parameter(allowedFile.path, allowed, 'MD'), _parameter(deniedFile.path, denied, 'MD')],
        );
      }
      return const AnalysisOutput(total: 1, diagnostics: []);
    }

    final report = await migrate(paths: [dir.path], write: true, analyze: analyze);

    expect(allowedFile.readAsStringSync(), 'DievasSpacingThemeData(md: 1.0);\n');
    expect(deniedFile.readAsStringSync(), denied);
    expect(report.memberEdits, 1);
    expect(report.skipped, ['named parameter MD']);
  });

  test('migrates doc-comment references that emit no diagnostic', () async {
    const original = '/// Spacing [context.spacing.MD].\nvoid a() {}\n';
    file.writeAsStringSync(original);
    Future<AnalysisOutput> analyze(List<String> _) async => const AnalysisOutput(total: 0, diagnostics: []);

    final report = await migrate(paths: [dir.path], write: true, analyze: analyze);

    expect(report.commentEdits, 1);
    expect(report.memberEdits, 0);
    expect(file.readAsStringSync(), '/// Spacing [context.spacing.md].\nvoid a() {}\n');
  });
}
