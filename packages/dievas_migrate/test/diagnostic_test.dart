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
      "code": "undefined_enum_constant",
      "severity": "ERROR",
      "problemMessage": "There's no constant named 'MD' in 'DievasButtonSize'.",
      "location": {
        "file": "/tmp/c.dart",
        "range": {"start": {"offset": 40, "line": 0, "column": 41}, "end": {"offset": 42, "line": 0, "column": 43}}
      }
    },
    {
      "code": "dot_shorthand_undefined_member",
      "severity": "ERROR",
      "problemMessage": "The static getter 'XL2' isn't defined for the context type 'DievasAvatarSize'.",
      "location": {
        "file": "/tmp/c.dart",
        "range": {"start": {"offset": 60, "line": 0, "column": 61}, "end": {"offset": 63, "line": 0, "column": 64}}
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

    expect(output.total, 6, reason: 'total counts every diagnostic for verification');
    expect(output.diagnostics, hasLength(5));

    final getter = output.diagnostics.first;
    expect(getter.old, 'MD');
    expect(getter.receiverType, 'DievasSpacingSemantic');
    expect(getter.isNamedParameter, isFalse);
    expect(getter.offset, 30);
    expect(getter.length, 2);

    final parameter = output.diagnostics[2];
    expect(parameter.old, 'LG');
    expect(parameter.receiverType, isNull);
    expect(parameter.isNamedParameter, isTrue);
    expect(parameter.file, '/tmp/b.dart');

    final enumConstant = output.diagnostics[3];
    expect(enumConstant.old, 'MD');
    expect(enumConstant.receiverType, 'DievasButtonSize');
    expect(enumConstant.isNamedParameter, isFalse);

    final shorthand = output.diagnostics[4];
    expect(shorthand.old, 'XL2');
    expect(shorthand.receiverType, 'DievasAvatarSize');
    expect(shorthand.isNamedParameter, isFalse);
  });

  test('fails loudly when the shape is not analyzer output', () {
    expect(() => parseAnalysis('{}'), throwsFormatException);
    expect(() => parseAnalysis('{"diagnostics": "nope"}'), throwsFormatException);
    expect(parseAnalysis('{"diagnostics": []}').total, 0);
  });
}
