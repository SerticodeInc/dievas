// Check size declarations, not comments or example prose.
import 'dart:io';
import 'dart:isolate';

import 'package:test/test.dart';

final RegExp _declaration = RegExp(r'static const\s+[\w<> ,]+\s+(\w+)\s*=');
final RegExp _legacyAxis = RegExp(
  r'^(x[2-8]l|xlPlus|x2lPlus)$'
  r'|[A-Za-z_]\w*(Xs|Sm|Md|Lg|Xl|Xsm)$',
);
final RegExp _sizeName = RegExp(
  r'^(?:[a-z][a-zA-Z]*)?(?:XS|SM|MD|LG|XL|XL[2-8]|SMPlus|MDPlus|LGPlus|XLPlus|XL2Plus)$'
  r'|^(?:NONE|FULL|BASE)$'
  r'|^(?:height|width)\d+$'
  r'|^R\d+$',
);

Future<void> main() async {
  final packageUri = switch (await Isolate.resolvePackageUri(Uri.parse('package:dievas_tokens/dievas_tokens.dart'))) {
    final Uri uri => uri,
    null => throw StateError('Cannot resolve dievas_tokens package.'),
  };
  final sourceDirectory = Directory.fromUri(packageUri.resolve('.'));

  test('no constant declaration uses a legacy lowercase size name', () {
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

  test('size families use class-scoped scales or role names with uppercase suffixes', () {
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
      final declarations = _declaration.allMatches(File.fromUri(packageUri.resolve('src/$path')).readAsStringSync());
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
