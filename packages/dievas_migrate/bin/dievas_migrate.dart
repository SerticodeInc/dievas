import 'dart:io';

import 'package:dievas_migrate/dievas_migrate.dart';

Future<void> main(List<String> args) async {
  if (args.contains('--help') || args.contains('-h')) {
    stdout.writeln(_usage);
    return;
  }

  final List<String> paths = args.where((String arg) => !arg.startsWith('-')).toList();
  final MigrationReport report;
  try {
    report = await Migrator(
      analyze: processAnalyzer(),
    ).run(paths: paths.isEmpty ? ['.'] : paths, write: args.contains('--write'));
  } on FormatException {
    stderr.writeln('Could not read `dart analyze --format=json` output. Run it directly to see why.');
    exitCode = 2;
    return;
  } on ProcessException catch (error) {
    stderr.writeln('Could not run the analyzer: ${error.message}');
    exitCode = 2;
    return;
  }

  if (report.failed) {
    stderr.writeln('Migration aborted: verification failed and every file was restored.');
    stderr.writeln('No files were changed. Please report this at https://github.com/SerticodeInc/dievas/issues.');
    exitCode = 2;
    return;
  }

  if (!report.hasWork) {
    stdout.writeln('Nothing to migrate. Upgrade dievas_tokens and dievas to the new vocabulary first.');
    return;
  }

  stdout.writeln('${report.totalEdits} edit(s) across ${report.files.length} file(s):');
  stdout.writeln('  ${report.memberEdits} member reference(s)');
  stdout.writeln('  ${report.commentEdits} comment reference(s)');
  for (final file in report.files) {
    stdout.writeln('  $file');
  }
  for (final skipped in report.skipped) {
    stdout.writeln('  skipped: $skipped');
  }

  if (args.contains('--check')) {
    stdout.writeln('Run without --check to apply.');
    exitCode = 1;
    return;
  }
  if (!report.applied) {
    stdout.writeln('Dry run. Re-run with --write to apply.');
  }
}

const String _usage = '''
Migrate Dievas token names to the lowercased vocabulary.

Usage: dart run dievas_migrate [paths...] [options]

  paths            Files or directories to migrate (default: current directory).
  --write          Apply the edits. Without it the run is a dry run.
  --check          Exit 1 when any migration is pending, without writing.
  -h, --help       Show this message.

The tool reads `dart analyze` diagnostics, so upgrade dievas_tokens and dievas
first; the old names must be undefined for the tool to see them.
''';
