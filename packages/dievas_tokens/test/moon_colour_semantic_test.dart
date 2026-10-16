import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:test/test.dart';

// Expected values come from the recorded upstream fixture, not our primitives.
const _referenceRoles = <String, String>{
  'textPrimary': 'textPrimary',
  'textSecondary': 'textSecondary',
  'iconPrimary': 'iconPrimary',
  'iconSecondary': 'iconSecondary',
  'pageBackground': 'goku',
  'cardBackground': 'gohan',
  'dividerColour': 'beerus',
  'modalBarrierBackground': 'zeno',
  'staticWhite': 'goten',
  'staticBlack': 'popo',
  'inputText': 'textPrimary',
};

const _light = <String, int>{
  'textPrimary': DievasColourSemanticLight.textPrimary,
  'textSecondary': DievasColourSemanticLight.textSecondary,
  'iconPrimary': DievasColourSemanticLight.iconPrimary,
  'iconSecondary': DievasColourSemanticLight.iconSecondary,
  'pageBackground': DievasColourSemanticLight.pageBackground,
  'cardBackground': DievasColourSemanticLight.cardBackground,
  'dividerColour': DievasColourSemanticLight.dividerColour,
  'modalBarrierBackground': DievasColourSemanticLight.modalBarrierBackground,
  'staticWhite': DievasColourSemanticLight.staticWhite,
  'staticBlack': DievasColourSemanticLight.staticBlack,
  'inputText': DievasColourSemanticLight.inputText,
};

const _dark = <String, int>{
  'textPrimary': DievasColourSemanticDark.textPrimary,
  'textSecondary': DievasColourSemanticDark.textSecondary,
  'iconPrimary': DievasColourSemanticDark.iconPrimary,
  'iconSecondary': DievasColourSemanticDark.iconSecondary,
  'pageBackground': DievasColourSemanticDark.pageBackground,
  'cardBackground': DievasColourSemanticDark.cardBackground,
  'dividerColour': DievasColourSemanticDark.dividerColour,
  'modalBarrierBackground': DievasColourSemanticDark.modalBarrierBackground,
  'staticWhite': DievasColourSemanticDark.staticWhite,
  'staticBlack': DievasColourSemanticDark.staticBlack,
  'inputText': DievasColourSemanticDark.inputText,
};

Future<void> main() async {
  final packageUri = switch (await Isolate.resolvePackageUri(Uri.parse('package:dievas_tokens/dievas_tokens.dart'))) {
    final Uri uri => uri,
    null => throw StateError('Cannot resolve dievas_tokens package.'),
  };
  final reference =
      jsonDecode(await File.fromUri(packageUri.resolve('../test/fixtures/moon_colours_reference.json')).readAsString())
          as Map<String, dynamic>;
  final themes = reference['default_themes'] as Map<String, dynamic>;

  for (final theme in {'light': _light, 'dark': _dark}.entries) {
    test('${theme.key} neutral semantic roles match the Moon reference', () {
      final expected = themes[theme.key] as Map<String, dynamic>;
      expect(theme.value.keys.toSet(), _referenceRoles.keys.toSet());
      for (final role in theme.value.entries) {
        expect(
          role.value,
          int.parse(expected[_referenceRoles[role.key]] as String),
          reason: '${theme.key}.${role.key}',
        );
      }
    });
  }

  test('inverse text uses the opposite theme primary foreground', () {
    expect(DievasColourSemanticLight.textInverse, DievasColourSemanticDark.textPrimary);
    expect(DievasColourSemanticDark.textInverse, DievasColourSemanticLight.textPrimary);
  });
}
