import 'dart:io';

import 'package:dievas_migrate/src/diagnostic.dart';

/// Loads analyzer diagnostics for [paths]. Injected so orchestration can be
/// tested without spawning the analyzer.
typedef Analyze = Future<AnalysisOutput> Function(List<String> paths);

/// Runs `dart analyze --format=json`, which resolves the consumer project and
/// reports the old names as undefined.
Analyze processAnalyzer({String workingDirectory = '.'}) => (paths) async {
  final result = await Process.run('dart', ['analyze', '--format=json', ...paths], workingDirectory: workingDirectory);
  return parseAnalysis(result.stdout.toString());
};
