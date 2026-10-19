@Tags(['integration'])
library;

import 'dart:io';

import 'package:dievas_migrate/dievas_migrate.dart';
import 'package:test/test.dart';

const String _consumer = '''
import 'package:dievas_tokens/dievas_tokens.dart';

/// Uses [DievasSpacingSemantic.MD] as the documented default.
const double horizontal = DievasSpacingSemantic.MD;
const double corner = DievasRadiusSemantic.R28;
const double unrelated = DievasSpacingPrimitives.s4;
''';

Future<ProcessResult> _run(List<String> command, String workingDirectory) =>
    Process.run(command.first, command.skip(1).toList(), workingDirectory: workingDirectory);

void main() {
  test('migrates a real consumer project end to end', () async {
    final tokensPath = Directory('../dievas_tokens').absolute.path;
    final dir = Directory.systemTemp.createTempSync('dievas_migrate_e2e');
    addTearDown(() => dir.deleteSync(recursive: true));

    File('${dir.path}/pubspec.yaml').writeAsStringSync('''
name: migrate_fixture
publish_to: none

environment:
  sdk: ^3.11.4

dependencies:
  dievas_tokens:
    path: $tokensPath
''');
    final consumer = File('${dir.path}/lib/consumer.dart')
      ..createSync(recursive: true)
      ..writeAsStringSync(_consumer);

    final pubGet = await _run(['dart', 'pub', 'get'], dir.path);
    expect(pubGet.exitCode, 0, reason: '${pubGet.stdout}\n${pubGet.stderr}');

    final report = await migrate(
      paths: [dir.path],
      write: true,
      analyze: processAnalyzer(workingDirectory: dir.path),
    );

    expect(report.failed, isFalse);
    expect(report.memberEdits, 2);

    final migrated = consumer.readAsStringSync();
    expect(migrated, contains('DievasSpacingSemantic.md'));
    expect(migrated, contains('DievasRadiusSemantic.r28'));
    expect(migrated, contains('[DievasSpacingSemantic.md]'));
    expect(migrated, contains('DievasSpacingPrimitives.s4'), reason: 'unrelated members stay');

    final verify = await _run(['dart', 'analyze', '.', '--format=json'], dir.path);
    final remaining = parseAnalysis(verify.stdout.toString());
    expect(remaining.diagnostics, isEmpty);
  }, timeout: const Timeout(Duration(minutes: 3)));
}
