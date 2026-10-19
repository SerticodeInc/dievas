// Check size declarations, not comments or example prose.
import 'dart:io';

import 'package:test/test.dart';

final RegExp _declaration = RegExp(r'static const\s+[\w<> ,]+\s+(\w+)\s*=');
final RegExp _legacyAxis = RegExp(
  r'^(?:NONE|FULL|BASE|R\d+)$'
  r'|(?:XS|SM|MD|LG|XL|XL[2-5]|SMPlus|MDPlus|LGPlus|XLPlus|XL2Plus)$',
);
final RegExp _sizeName = RegExp(
  r'^(?:none|base|full)$'
  r'|^(?:xs|sm|smPlus|md|mdPlus|lg|lgPlus|xl|xlPlus|xl2|xl2Plus|xl3|xl4|xl5)$'
  r'|^(?:buttonHeight|inputHeight|icon|avatar)(?:Xs|Sm|Md|Lg|Xl)$'
  r'|^(?:display|heading|title|body|label|code)(?:Xs|Sm|Md|Lg|Xl)$'
  r'|^(?:height|width)\d+$'
  r'|^r\d+$',
);

void main() {
  final sourceDirectory = Directory('${Directory.current.path}/lib');

  test('no constant declaration uses a legacy uppercase size name', () {
    final offenders = <String>[];
    for (final entity in sourceDirectory.listSync(recursive: true)) {
      if (entity case File() when entity.path.endsWith('.dart')) {
        for (final match in _declaration.allMatches(entity.readAsStringSync())) {
          if (match.group(1) case final String name when _legacyAxis.hasMatch(name)) {
            offenders.add('${entity.path}: $name');
          }
        }
      }
    }
    expect(offenders, isEmpty);
  });

  test('size families use class-scoped scales or role names with lowerCamelCase suffixes', () {
    const files = [
      'primitives/breakpoint_primitives.dart',
      'semantic/spacing_semantic.dart',
      'semantic/radius_semantic.dart',
      'semantic/sizing_semantic.dart',
      'semantic/breakpoint_semantic.dart',
      'semantic/elevation_semantic.dart',
      'semantic/typography_semantic.dart',
    ];
    for (final path in files) {
      final declarations = _declaration.allMatches(File('${Directory.current.path}/lib/src/$path').readAsStringSync());
      expect(declarations, isNotEmpty, reason: path);
      for (final declaration in declarations) {
        final name = declaration.group(1);
        // These describe a minimum target and an ink, not size scales.
        if (name == 'touchMin' || name == 'shadowColour') continue;
        expect(name, matches(_sizeName), reason: '$path: $name');
      }
    }
  });
}
