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
    this.recordFields = const [],
  });

  final String old;

  /// Declaring type for getters and methods; `null` for named parameters,
  /// whose diagnostics omit it.
  final String? receiverType;

  final String file;
  final int offset;
  final int length;
  final bool isNamedParameter;

  /// Member names named by a whole-record-literal diagnostic, empty for a
  /// single-member diagnostic. When populated, [offset] and [length] address
  /// the literal rather than one member, and the record pass rewrites its keys.
  final List<String> recordFields;

  bool get isRecordLiteral => recordFields.isNotEmpty;
}

/// Every diagnostic the analyzer reported, so verification can detect an
/// unrelated error the tool might have introduced.
final class AnalysisOutput {
  const AnalysisOutput({required this.total, required this.diagnostics});

  final int total;
  final List<RenameDiagnostic> diagnostics;
}

/// Parses the raw JSON emitted by `dart analyze --format=json` into the handful
/// of diagnostics this tool can act on. Output is external data, so it is
/// validated rather than trusted; a shape this tool cannot read fails loudly
/// instead of silently reporting an empty project.
AnalysisOutput parseAnalysis(String json) {
  if (jsonDecode(json) case {'diagnostics': final List<Object?> entries}) {
    return AnalysisOutput(
      total: entries.length,
      diagnostics: [
        for (final Object? entry in entries)
          if (_toDiagnostic(entry) case final RenameDiagnostic diagnostic) diagnostic,
      ],
    );
  }
  throw const FormatException('Unexpected `dart analyze --format=json` output.');
}

List<RenameDiagnostic> parseDiagnostics(String json) => parseAnalysis(json).diagnostics;

RenameDiagnostic? _toDiagnostic(Object? entry) {
  if (entry case {
    'code': final String code,
    'problemMessage': final String message,
    'location': {
      'file': final String file,
      'range': {'start': {'offset': final int start}, 'end': {'offset': final int end}},
    },
  }) {
    return _rename(code, message, file: file, offset: start, length: end - start);
  }
  return null;
}

RenameDiagnostic? _rename(
  String code,
  String message, {
  required String file,
  required int offset,
  required int length,
}) => switch (code) {
  'undefined_getter' => _member(_getter, message, file: file, offset: offset, length: length),
  'undefined_method' => _member(_method, message, file: file, offset: offset, length: length),
  'undefined_enum_constant' => _member(_enumConstant, message, file: file, offset: offset, length: length),
  'dot_shorthand_undefined_member' => _member(_dotShorthand, message, file: file, offset: offset, length: length),
  'undefined_named_parameter' => _parameterOf(_parameter, message, file: file, offset: offset, length: length),
  'invalid_assignment' ||
  'return_of_invalid_type' ||
  'argument_type_not_assignable' => _recordLiteral(message, file: file, offset: offset, length: length),
  _ => null,
};

/// Reads a whole-record-literal diagnostic: the literal's range plus the member
/// names the record typedef expects. Only named record fields that this tool
/// knows how to rename survive, so an unrelated record typedef is ignored.
RenameDiagnostic? _recordLiteral(String message, {required String file, required int offset, required int length}) {
  final RegExpMatch? type = _recordType.firstMatch(message);
  final String? typedef = type?.group(2);
  if (typedef == null) {
    return null;
  }
  final List<String> fields = [
    for (final RegExpMatch field in _recordField.allMatches(type!.group(1)!)) field.group(1)!,
  ];
  if (fields.isEmpty) {
    return null;
  }
  return RenameDiagnostic(
    old: fields.first,
    receiverType: typedef,
    file: file,
    offset: offset,
    length: length,
    isNamedParameter: false,
    recordFields: fields,
  );
}

RenameDiagnostic? _member(
  RegExp pattern,
  String message, {
  required String file,
  required int offset,
  required int length,
}) {
  final RegExpMatch? match = pattern.firstMatch(message);
  return switch ((match?.group(1), match?.group(2))) {
    (final String old, final String type) => RenameDiagnostic(
      old: old,
      receiverType: type,
      file: file,
      offset: offset,
      length: length,
      isNamedParameter: false,
    ),
    _ => null,
  };
}

RenameDiagnostic? _parameterOf(
  RegExp pattern,
  String message, {
  required String file,
  required int offset,
  required int length,
}) {
  final RegExpMatch? match = pattern.firstMatch(message);
  return switch (match?.group(1)) {
    final String old => RenameDiagnostic(
      old: old,
      receiverType: null,
      file: file,
      offset: offset,
      length: length,
      isNamedParameter: true,
    ),
    null => null,
  };
}

final RegExp _getter = RegExp(r"The getter '(\w+)' isn't defined for the type '([\w.]+)'");
final RegExp _method = RegExp(r"The method '(\w+)' isn't defined for the type '([\w.]+)'");
final RegExp _enumConstant = RegExp(r"There's no constant named '(\w+)' in '([\w.]+)'");
final RegExp _dotShorthand = RegExp(r"The static getter '(\w+)' isn't defined for the context type '([\w.]+)'");
final RegExp _parameter = RegExp(r"The named parameter '(\w+)' isn't defined");

/// Captures the field list of an inferred record type (`({double LG, double MD})`)
/// and the record typedef it conflicts with (`DievasInputThemeValue<double>`).
final RegExp _recordType = RegExp(r"'\(\{([^}]*)\}\)'.*?'([A-Za-z]\w*)(?:<[^>]*>)?'");
final RegExp _recordField = RegExp(r'(\w+)\s*[,}]');
