import 'dart:io';

import 'package:dievas_migrate/src/analyzer_runner.dart';
import 'package:dievas_migrate/src/diagnostic.dart';
import 'package:dievas_migrate/src/doc_comment_pass.dart';
import 'package:dievas_migrate/src/size_vocabulary.dart';
import 'package:dievas_migrate/src/text_edit.dart';

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

/// Rewrites every eligible renamed member in [paths] until the analyzer reports
/// none left.
///
/// `write: false` plans the run without touching files. When writing, each pass
/// verifies itself: if the total diagnostic count does not fall, every file is
/// restored and the run reports [MigrationReport.failed], so a mis-guessed
/// named parameter can never leave the tree corrupted.
Future<MigrationReport> migrate({
  required List<String> paths,
  required bool write,
  required Analyze analyze,
  int maxPasses = 20,
}) async {
  final originals = <String, String>{};
  final changed = <String>{};
  final skipped = <String>{};
  var memberEdits = 0;
  var commentEdits = 0;

  for (var pass = 0; pass < maxPasses; pass++) {
    final before = await analyze(paths);
    final plan = _plan(before.diagnostics, _dartFiles(paths), skipped);
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

    for (final file in plan.editsByFile.keys) {
      originals.putIfAbsent(file, () => File(file).readAsStringSync());
    }
    for (final entry in plan.editsByFile.entries) {
      File(entry.key).writeAsStringSync(applyEdits(File(entry.key).readAsStringSync(), entry.value));
      changed.add(entry.key);
    }
    memberEdits += plan.memberEdits;
    commentEdits += plan.commentEdits;

    final after = await analyze(paths);
    if (plan.memberEdits > 0 && after.total >= before.total) {
      for (final entry in originals.entries) {
        File(entry.key).writeAsStringSync(entry.value);
      }
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

final class _Plan {
  const _Plan({required this.editsByFile, required this.memberEdits, required this.commentEdits});

  final Map<String, List<TextEdit>> editsByFile;
  final int memberEdits;
  final int commentEdits;

  bool get isEmpty => editsByFile.isEmpty;
  Iterable<String> get editedFiles => editsByFile.keys;
}

_Plan _plan(List<RenameDiagnostic> diagnostics, List<String> dartFiles, Set<String> skipped) {
  final editsByFile = <String, List<TextEdit>>{};
  final sources = <String, String>{};
  final seen = <String>{};
  var memberEdits = 0;

  String source(String file) => sources.putIfAbsent(file, () => File(file).readAsStringSync());

  for (final diagnostic in diagnostics) {
    final file = _canonical(diagnostic.file);
    final renamed = renamedMember(diagnostic.old);
    if (renamed == null) {
      continue;
    }
    if (!_isEligible(diagnostic, source)) {
      skipped.add(
        diagnostic.isNamedParameter
            ? 'named parameter ${diagnostic.old}'
            : '${diagnostic.receiverType}.${diagnostic.old}',
      );
      continue;
    }
    if (seen.add('$file:${diagnostic.offset}')) {
      (editsByFile[file] ??= []).add(
        TextEdit(offset: diagnostic.offset, length: diagnostic.length, replacement: renamed),
      );
      memberEdits++;
    }
  }

  var commentEditCount = 0;
  for (final file in dartFiles) {
    final edits = commentEdits(source(file));
    if (edits.isEmpty) {
      continue;
    }
    (editsByFile[file] ??= []).addAll(edits);
    commentEditCount += edits.length;
  }

  return _Plan(editsByFile: editsByFile, memberEdits: memberEdits, commentEdits: commentEditCount);
}

bool _isEligible(RenameDiagnostic diagnostic, String Function(String) source) {
  if (!diagnostic.isNamedParameter) {
    return renamedTypes.contains(diagnostic.receiverType);
  }
  final owner = _enclosingCall(source(_canonical(diagnostic.file)), diagnostic.offset);
  return owner != null && renamedParameterOwners.contains(owner);
}

/// Finds the member name before the unclosed `(` that opens the argument list
/// containing [offset].
String? _enclosingCall(String source, int offset) {
  var depth = 0;
  for (var i = offset - 1; i >= 0; i--) {
    final char = source[i];
    if (char == ')' || char == ']' || char == '}') {
      depth++;
      continue;
    }
    if (char == '(' || char == '[' || char == '{') {
      if (depth > 0) {
        depth--;
        continue;
      }
      if (char != '(') {
        return null;
      }
      var end = i;
      while (end > 0 && _isSpace(source[end - 1])) {
        end--;
      }
      var start = end;
      while (start > 0 && _isIdentifierPart(source[start - 1])) {
        start--;
      }
      return start == end ? null : source.substring(start, end);
    }
  }
  return null;
}

/// Doc-comment pass entry point, kept here to keep the orchestration in one
/// file.
List<TextEdit> commentEditsFor(String source) => commentEdits(source);

bool _isSpace(String char) => char == ' ' || char == '\t' || char == '\n' || char == '\r';
bool _isIdentifierPart(String char) => _identifierPart.hasMatch(char);

final RegExp _identifierPart = RegExp(r'[\w$]');

String _canonical(String path) => File(path).resolveSymbolicLinksSync();

List<String> _dartFiles(List<String> paths) {
  final files = <String>[];
  for (final path in paths) {
    if (FileSystemEntity.typeSync(path) case FileSystemEntityType.file) {
      if (path.endsWith('.dart')) {
        files.add(_canonical(path));
      }
      continue;
    }
    for (final entity in Directory(path).listSync(recursive: true, followLinks: false)) {
      if (entity is! File || !entity.path.endsWith('.dart')) {
        continue;
      }
      if (entity.path.contains('/.dart_tool/') || entity.path.contains('/build/')) {
        continue;
      }
      files.add(_canonical(entity.path));
    }
  }
  return files;
}
