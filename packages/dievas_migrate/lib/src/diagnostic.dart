import 'dart:convert';

/// A single analyzer diagnostic that names a member or parameter to rename.
final class RenameDiagnostic {
  const RenameDiagnostic({
    required this.old,
    required this.receiverType,
    required this.file,
    required this.offset,
    required this.length,
    required this.isNamedParameter,
  });

  final String old;

  /// Declaring type for getters and methods; `null` for named parameters,
  /// whose diagnostics omit it.
  final String? receiverType;

  final String file;
  final int offset;
  final int length;
  final bool isNamedParameter;
}

final RegExp _getter = RegExp(r"The getter '(\w+)' isn't defined for the type '([\w.]+)'");
final RegExp _method = RegExp(r"The method '(\w+)' isn't defined for the type '([\w.]+)'");
final RegExp _parameter = RegExp(r"The named parameter '(\w+)' isn't defined");

/// Every diagnostic the analyzer reported, so verification can detect an
/// unrelated error the tool might have introduced.
final class AnalysisOutput {
  const AnalysisOutput({required this.total, required this.diagnostics});

  final int total;
  final List<RenameDiagnostic> diagnostics;
}

/// Parses the raw JSON emitted by `dart analyze --format=json` into the handful
/// of diagnostics this tool can act on. Output is external data, so it is
/// validated rather than trusted.
AnalysisOutput parseAnalysis(String json) {
  final decoded = jsonDecode(json);
  if (decoded case {'diagnostics': final List<Object?> entries}) {
    final all = entries.whereType<Map<String, Object?>>().toList();
    return AnalysisOutput(total: all.length, diagnostics: all.map(_toDiagnostic).nonNulls.toList());
  }
  return const AnalysisOutput(total: 0, diagnostics: []);
}

List<RenameDiagnostic> parseDiagnostics(String json) => parseAnalysis(json).diagnostics;

RenameDiagnostic? _toDiagnostic(Map<String, Object?> entry) {
  final code = entry['code'];
  final message = entry['problemMessage'];
  if (message is! String) {
    return null;
  }
  if (code == 'undefined_getter' || code == 'undefined_method') {
    final match = (code == 'undefined_getter' ? _getter : _method).firstMatch(message);
    if (match == null) {
      return null;
    }
    return _location(entry, old: match.group(1)!, receiverType: match.group(2), isNamedParameter: false);
  }
  if (code == 'undefined_named_parameter') {
    final match = _parameter.firstMatch(message);
    if (match == null) {
      return null;
    }
    return _location(entry, old: match.group(1)!, receiverType: null, isNamedParameter: true);
  }
  return null;
}

RenameDiagnostic? _location(
  Map<String, Object?> entry, {
  required String old,
  required String? receiverType,
  required bool isNamedParameter,
}) {
  final location = entry['location'];
  if (location is! Map<String, Object?>) {
    return null;
  }
  if (location['file'] case final String file) {
    if (location['range'] case final Map<String, Object?> range) {
      if (range['start'] case final Map<String, Object?> start) {
        if (range['end'] case final Map<String, Object?> end) {
          if (start['offset'] case final int offset) {
            if (end['offset'] case final int endOffset) {
              return RenameDiagnostic(
                old: old,
                receiverType: receiverType,
                file: file,
                offset: offset,
                length: endOffset - offset,
                isNamedParameter: isNamedParameter,
              );
            }
          }
        }
      }
    }
  }
  return null;
}
