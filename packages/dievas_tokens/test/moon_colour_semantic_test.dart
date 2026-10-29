import 'dart:convert';
import 'dart:io';

import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:test/test.dart';

// Expected values come from the recorded upstream fixture, not our primitives.
const _referenceRoles = <String, String>{
  'primary': 'piccolo',
  'buttonPrimaryBackground': 'piccolo',
  'badgePrimaryBackground': 'piccolo',
  'badgePrimaryTintedBackground': 'jiren',
  'badgePrimaryTintedText': 'piccolo',
  'focusIndicatorColour': 'piccolo',
  'selectionBorder': 'piccolo',
  'inputFocusedBorder': 'piccolo',
  'inputCursor': 'piccolo',
  'switchOnTrack': 'piccolo',
  'checkboxCheckedBackground': 'piccolo',
  'radioSelectedBackground': 'piccolo',
  'progressIndicator': 'piccolo',
  'sliderActiveTrack': 'piccolo',
  'segmentedControlSelectedBackground': 'goku',
  'tabSelectedIndicator': 'piccolo',
  'segmentedControlSelectedText': 'textPrimary',

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
  'primary': DievasColourSemanticLight.primary,
  'buttonPrimaryBackground': DievasColourSemanticLight.buttonPrimaryBackground,
  'badgePrimaryBackground': DievasColourSemanticLight.badgePrimaryBackground,
  'badgePrimaryTintedBackground': DievasColourSemanticLight.badgePrimaryTintedBackground,
  'badgePrimaryTintedText': DievasColourSemanticLight.badgePrimaryTintedText,
  'focusIndicatorColour': DievasColourSemanticLight.focusIndicatorColour,
  'selectionBorder': DievasColourSemanticLight.selectionBorder,
  'inputFocusedBorder': DievasColourSemanticLight.inputFocusedBorder,
  'inputCursor': DievasColourSemanticLight.inputCursor,
  'switchOnTrack': DievasColourSemanticLight.switchOnTrack,
  'checkboxCheckedBackground': DievasColourSemanticLight.checkboxCheckedBackground,
  'radioSelectedBackground': DievasColourSemanticLight.radioSelectedBackground,
  'progressIndicator': DievasColourSemanticLight.progressIndicator,
  'sliderActiveTrack': DievasColourSemanticLight.sliderActiveTrack,
  'segmentedControlSelectedBackground': DievasColourSemanticLight.segmentedControlSelectedBackground,
  'tabSelectedIndicator': DievasColourSemanticLight.tabSelectedIndicator,
  'segmentedControlSelectedText': DievasColourSemanticLight.segmentedControlSelectedText,

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
  'primary': DievasColourSemanticDark.primary,
  'buttonPrimaryBackground': DievasColourSemanticDark.buttonPrimaryBackground,
  'badgePrimaryBackground': DievasColourSemanticDark.badgePrimaryBackground,
  'badgePrimaryTintedBackground': DievasColourSemanticDark.badgePrimaryTintedBackground,
  'badgePrimaryTintedText': DievasColourSemanticDark.badgePrimaryTintedText,
  'focusIndicatorColour': DievasColourSemanticDark.focusIndicatorColour,
  'selectionBorder': DievasColourSemanticDark.selectionBorder,
  'inputFocusedBorder': DievasColourSemanticDark.inputFocusedBorder,
  'inputCursor': DievasColourSemanticDark.inputCursor,
  'switchOnTrack': DievasColourSemanticDark.switchOnTrack,
  'checkboxCheckedBackground': DievasColourSemanticDark.checkboxCheckedBackground,
  'radioSelectedBackground': DievasColourSemanticDark.radioSelectedBackground,
  'progressIndicator': DievasColourSemanticDark.progressIndicator,
  'sliderActiveTrack': DievasColourSemanticDark.sliderActiveTrack,
  'segmentedControlSelectedBackground': DievasColourSemanticDark.segmentedControlSelectedBackground,
  'tabSelectedIndicator': DievasColourSemanticDark.tabSelectedIndicator,
  'segmentedControlSelectedText': DievasColourSemanticDark.segmentedControlSelectedText,

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
  final reference =
      jsonDecode(await File('${Directory.current.path}/test/fixtures/moon_colours_reference.json').readAsString())
          as Map<String, dynamic>;
  final themes = reference['default_themes'] as Map<String, dynamic>;

  for (final theme in {'light': _light, 'dark': _dark}.entries) {
    test('${theme.key} brand and neutral semantic roles match the Moon reference', () {
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
