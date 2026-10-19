import 'package:dievas_migrate/src/diagnostic.dart';
import 'package:test/test.dart';

void main() {
  test('parses getters, methods, and named parameters', () {
    const json = '''
{
  "version": 1,
  "diagnostics": [
    {
      "code": "undefined_getter",
      "severity": "ERROR",
      "problemMessage": "The getter 'MD' isn't defined for the type 'DievasSpacingSemantic'.",
      "location": {
        "file": "/tmp/a.dart",
        "range": {"start": {"offset": 30, "line": 1, "column": 31}, "end": {"offset": 32, "line": 1, "column": 33}}
      }
    },
    {
      "code": "undefined_method",
      "severity": "ERROR",
      "problemMessage": "The method 'XL' isn't defined for the type 'DievasSizingSemantic'.",
      "location": {
        "file": "/tmp/a.dart",
        "range": {"start": {"offset": 5, "line": 0, "column": 6}, "end": {"offset": 7, "line": 0, "column": 8}}
      }
    },
    {
      "code": "undefined_named_parameter",
      "severity": "ERROR",
      "problemMessage": "The named parameter 'LG' isn't defined.",
      "location": {
        "file": "/tmp/b.dart",
        "range": {"start": {"offset": 11, "line": 0, "column": 12}, "end": {"offset": 13, "line": 0, "column": 14}}
      }
    },
    {
      "code": "unused_import",
      "severity": "WARNING",
      "problemMessage": "Unused import: 'dart:io'.",
      "location": {
        "file": "/tmp/b.dart",
        "range": {"start": {"offset": 0, "line": 0, "column": 1}, "end": {"offset": 8, "line": 0, "column": 9}}
      }
    }
  ]
}
''';

    final output = parseAnalysis(json);

    expect(output.total, 4, reason: 'total counts every diagnostic for verification');
    expect(output.diagnostics, hasLength(3));

    final getter = output.diagnostics.first;
    expect(getter.old, 'MD');
    expect(getter.receiverType, 'DievasSpacingSemantic');
    expect(getter.isNamedParameter, isFalse);
    expect(getter.offset, 30);
    expect(getter.length, 2);

    final parameter = output.diagnostics.last;
    expect(parameter.old, 'LG');
    expect(parameter.receiverType, isNull);
    expect(parameter.isNamedParameter, isTrue);
    expect(parameter.file, '/tmp/b.dart');
  });

  test('degrades to empty output when the shape is unexpected', () {
    expect(parseAnalysis('{}').diagnostics, isEmpty);
    expect(parseAnalysis('{"diagnostics": "nope"}').diagnostics, isEmpty);
    expect(parseAnalysis('{"diagnostics": []}').total, 0);
  });
}
