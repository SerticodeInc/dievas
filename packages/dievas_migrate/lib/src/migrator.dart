import 'dart:io';

import 'package:dievas_migrate/src/analyzer_runner.dart';
import 'package:dievas_migrate/src/diagnostic.dart';
import 'package:dievas_migrate/src/doc_comment_pass.dart';
import 'package:dievas_migrate/src/record_literal_pass.dart';
import 'package:dievas_migrate/src/text_edit.dart';
import 'package:dievas_migrate/src/token_vocabulary.dart';

/// Outcome of a migration run.
final class MigrationReport {
  const MigrationReport({
    required this.files,
    required this.memberEdits,
    required this.commentEdits,
    required this.pending,
    required this.applied,
    required this.failed,
    required this.skipped,
  });

  const MigrationReport.failed()
    : files = const [],
      memberEdits = 0,
      commentEdits = 0,
      pending = 0,
      applied = false,
      failed = true,
      skipped = const [];

  final List<String> files;
  final int memberEdits;
  final int commentEdits;
  final int pending;
  final bool applied;
  final bool failed;
  final List<String> skipped;

  int get totalEdits => memberEdits + commentEdits;
  bool get hasWork => totalEdits > 0;
}

/// Rewrites every eligible renamed member in a set of paths until the analyzer
/// reports none left.
///
/// A dry run plans without touching files. When writing, each pass verifies
/// itself: if the total diagnostic count does not fall, every file is restored
/// and the run reports [MigrationReport.failed], so a mis-guessed named
/// parameter can never leave the tree corrupted.
final class Migrator {
  const Migrator({required this.analyze, this.maxPasses = 20});

  /// Loads analyzer diagnostics for a set of paths.
  final Analyze analyze;

  final int maxPasses;

  Future<MigrationReport> run({required List<String> paths, required bool write}) async {
    final Map<String, String> originals = {};
    final Set<String> changed = {};
    final Set<String> skipped = {};
    int memberEdits = 0;
    int commentEdits = 0;

    for (int pass = 0; pass < maxPasses; pass++) {
      final AnalysisOutput before = await analyze(paths);
      final _Plan plan = _plan(before.diagnostics, _dartFiles(paths), skipped);

      if (plan.isEmpty) {
        return MigrationReport(
          files: changed.toList()..sort(),
          memberEdits: memberEdits,
          commentEdits: commentEdits,
          pending: 0,
          applied: write && changed.isNotEmpty,
          failed: false,
          skipped: skipped.toList()..sort(),
        );
      }
      if (!write) {
        return MigrationReport(
          files: plan.editedFiles.toList()..sort(),
          memberEdits: plan.memberEdits,
          commentEdits: plan.commentEdits,
          pending: plan.memberEdits,
          applied: false,
          failed: false,
          skipped: skipped.toList()..sort(),
        );
      }

      _apply(plan, originals, changed);
      memberEdits += plan.memberEdits;
      commentEdits += plan.commentEdits;

      final AnalysisOutput after = await analyze(paths);
      if (plan.memberEdits > 0 && after.total >= before.total) {
        _restore(originals);
        return const MigrationReport.failed();
      }
    }

    return MigrationReport(
      files: changed.toList()..sort(),
      memberEdits: memberEdits,
      commentEdits: commentEdits,
      pending: 1,
      applied: write && changed.isNotEmpty,
      failed: false,
      skipped: skipped.toList()..sort(),
    );
  }

  _Plan _plan(List<RenameDiagnostic> diagnostics, List<String> dartFiles, Set<String> skipped) {
    final Map<String, List<TextEdit>> editsByFile = {};
    final Map<String, String> sources = {};
    final Set<String> seen = {};
    int memberEdits = 0;

    String source(String file) => sources.putIfAbsent(file, () => File(file).readAsStringSync());

    for (final RenameDiagnostic diagnostic in diagnostics) {
      if (diagnostic.isRecordLiteral) {
        final String file = _canonical(diagnostic.file);
        if (!renamedTypes.contains(diagnostic.receiverType)) {
          skipped.add(_describe(diagnostic));
          continue;
        }
        final List<TextEdit> edits = const RecordLiteralRewriter().edits(
          source(file),
          offset: diagnostic.offset,
          length: diagnostic.length,
          fields: diagnostic.recordFields,
        );
        if (edits.isEmpty || !seen.add('$file:${diagnostic.offset}')) {
          continue;
        }
        (editsByFile[file] ??= []).addAll(edits);
        memberEdits += edits.length;
        continue;
      }
      final String? renamed = renamedMember(diagnostic.old);
      if (renamed == null) {
        continue;
      }
      if (!_isEligible(diagnostic, source)) {
        skipped.add(_describe(diagnostic));
        continue;
      }
      final String file = _canonical(diagnostic.file);
      if (seen.add('$file:${diagnostic.offset}')) {
        (editsByFile[file] ??= []).add(
          TextEdit(offset: diagnostic.offset, length: diagnostic.length, replacement: renamed),
        );
        memberEdits++;
      }
    }

    int commentEdits = 0;
    for (final String file in dartFiles) {
      final List<TextEdit> edits = const CommentRewriter().edits(source(file));
      if (edits.isEmpty) {
        continue;
      }
      (editsByFile[file] ??= []).addAll(edits);
      commentEdits += edits.length;
    }

    return _Plan(editsByFile: editsByFile, memberEdits: memberEdits, commentEdits: commentEdits);
  }

  bool _isEligible(RenameDiagnostic diagnostic, String Function(String) source) => switch (diagnostic) {
    RenameDiagnostic(isNamedParameter: false, receiverType: final String type) => renamedTypes.contains(type),
    RenameDiagnostic(file: final String file, offset: final int offset) => switch (_enclosingCall(
      source(_canonical(file)),
      offset,
    )) {
      final String owner => renamedParameterOwners.contains(owner),
      null => false,
    },
  };

  void _apply(_Plan plan, Map<String, String> originals, Set<String> changed) {
    for (final MapEntry(key: String file, value: List<TextEdit> edits) in plan.editsByFile.entries) {
      originals.putIfAbsent(file, () => File(file).readAsStringSync());
      File(file).writeAsStringSync(applyEdits(File(file).readAsStringSync(), edits));
      changed.add(file);
    }
  }

  void _restore(Map<String, String> originals) {
    for (final MapEntry(key: String file, value: String contents) in originals.entries) {
      File(file).writeAsStringSync(contents);
    }
  }
}

String _describe(RenameDiagnostic diagnostic) => switch (diagnostic) {
  RenameDiagnostic(isRecordLiteral: true, receiverType: final String type, recordFields: final List<String> fields) =>
    'record literal for $type (${fields.join(', ')})',
  RenameDiagnostic(isNamedParameter: true, old: final String old) => 'named parameter $old',
  RenameDiagnostic(receiverType: final String type, old: final String old) => '$type.$old',
  _ => diagnostic.old,
};

/// Finds the member name before the unclosed `(` that opens the argument list
/// containing [offset].
String? _enclosingCall(String source, int offset) {
  int depth = 0;
  for (int i = offset - 1; i >= 0; i--) {
    switch (source[i]) {
      case ')' || ']' || '}':
        depth++;
      case '(' || '[' || '{':
        if (depth > 0) {
          depth--;
          break;
        }
        return source[i] == '(' ? _identifierBefore(source, i) : null;
    }
  }
  return null;
}

String? _identifierBefore(String source, int openParen) {
  int end = openParen;
  while (end > 0 && _isSpace(source[end - 1])) {
    end--;
  }
  int start = end;
  while (start > 0 && _isIdentifierPart(source[start - 1])) {
    start--;
  }
  return start == end ? null : source.substring(start, end);
}

bool _isSpace(String char) => char == ' ' || char == '\t' || char == '\n' || char == '\r';
bool _isIdentifierPart(String char) => _identifierPart.hasMatch(char);

final RegExp _identifierPart = RegExp(r'[\w$]');

const String _dartExtension = '.dart';
const String _dartToolDirectory = '/.dart_tool/';
const String _buildDirectory = '/build/';

String _canonical(String path) => File(path).resolveSymbolicLinksSync();

List<String> _dartFiles(List<String> paths) {
  final List<String> files = [];
  for (final String path in paths) {
    if (FileSystemEntity.typeSync(path) case FileSystemEntityType.file) {
      if (path.endsWith(_dartExtension)) {
        files.add(_canonical(path));
      }
      continue;
    }
    for (final FileSystemEntity entity in Directory(path).listSync(recursive: true, followLinks: false)) {
      if (entity case File(
        path: final String file,
      ) when file.endsWith(_dartExtension) && !file.contains(_dartToolDirectory) && !file.contains(_buildDirectory)) {
        files.add(_canonical(file));
      }
    }
  }
  return files;
}

final class _Plan {
  const _Plan({required this.editsByFile, required this.memberEdits, required this.commentEdits});

  final Map<String, List<TextEdit>> editsByFile;
  final int memberEdits;
  final int commentEdits;

  bool get isEmpty => editsByFile.isEmpty;
  Iterable<String> get editedFiles => editsByFile.keys;
}
