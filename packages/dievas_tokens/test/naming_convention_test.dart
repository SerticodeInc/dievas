// Guard test for the Dievas token naming law.
//
// Size-axis tokens use `<base><SIZE>`: a lowercase base followed by an
// UPPERCASE size suffix (XS, SM, MD, LG, XL, XL2..XL8) with half-steps
// written as `<base>SMPlus`, `<base>XL2Plus`, etc. This test fails if any
// source file under lib/ regresses to the pre-1.0 lowercase axis names.

import 'dart:io';

import 'package:test/test.dart';

final RegExp _legacyAxis = RegExp(
  r'\b(x2l|x3l|x4l|x5l|x6l|x7l|x8l|smPlus|mdPlus|lgPlus|xlPlus|x2lPlus|xs|sm|md|lg|xl)\b'
  r'|\b[A-Za-z_]\w*(Xs|Sm|Md|Lg|Xl|Xsm)\b',
);

final RegExp _uppercaseAxis = RegExp(
  r'\b(NONE|FULL|BASE|XL2Plus|SMPlus|MDPlus|LGPlus|XLPlus|XL8|XL7|XL6|XL5|XL4|XL3|XL2|XS|SM|MD|LG|XL)\b',
);

void main() {
  test('no source file under lib/ uses legacy lowercase size-axis identifiers', () {
    final offenders = <String>[];
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      for (final match in _legacyAxis.allMatches(entity.readAsStringSync())) {
        offenders.add('${entity.path}: ${match.group(0)}');
      }
    }

    expect(offenders, isEmpty, reason: 'Legacy lowercase size-axis identifiers found:\n${offenders.join('\n')}');
  });

  test('uppercase size-axis suffix convention is present', () {
    var matches = 0;
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      matches += _uppercaseAxis.allMatches(entity.readAsStringSync()).length;
    }

    expect(matches, greaterThan(0));
  });
}
