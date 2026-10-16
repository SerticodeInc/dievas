// Parity and coverage tests for the brand palette selection layer.
//
// A palette's resolved roles must reproduce the built-in reference semantic
// values for the default [DievasBrandPalettes.indigo] palette, and every
// shipped palette must carry a full 11-tint ramp.

import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:test/test.dart';

void main() {
  group('DievasBrandPalettes.indigo light parity', () {
    final roles = DievasBrandPalettes.indigo.rolesForLight();

    test('primary roles match the light reference semantics', () {
      expect(roles.primary, DievasColourSemanticLight.primary);
      expect(roles.badgePrimaryTintedBackground, DievasColourSemanticLight.badgePrimaryTintedBackground);
      expect(roles.buttonPrimaryText, DievasColourSemanticLight.buttonPrimaryText);
      expect(roles.buttonPrimaryBackground, DievasColourSemanticLight.buttonPrimaryBackground);
      expect(roles.buttonPrimaryHoveredBackground, DievasColourSemanticLight.buttonPrimaryHoveredBackground);
      expect(roles.buttonPrimaryPressedBackground, DievasColourSemanticLight.buttonPrimaryPressedBackground);
      expect(roles.buttonSecondaryBackground, DievasColourSemanticLight.buttonSecondaryBackground);
      expect(roles.buttonSecondaryHoveredBackground, DievasColourSemanticLight.buttonSecondaryHoveredBackground);
      expect(roles.selectionBorder, DievasColourSemanticLight.selectionBorder);
      expect(roles.focusIndicatorColour, DievasColourSemanticLight.focusIndicatorColour);
      expect(roles.inputFocusedBorder, DievasColourSemanticLight.inputFocusedBorder);
      expect(roles.switchOnTrack, DievasColourSemanticLight.switchOnTrack);
    });
  });

  group('DievasBrandPalettes.indigo dark parity', () {
    final roles = DievasBrandPalettes.indigo.rolesForDark();

    test('primary roles match the dark reference semantics', () {
      expect(roles.primary, DievasColourSemanticDark.primary);
      expect(roles.badgePrimaryTintedBackground, DievasColourSemanticDark.badgePrimaryTintedBackground);
      expect(roles.buttonPrimaryText, DievasColourSemanticDark.buttonPrimaryText);
      expect(roles.buttonPrimaryBackground, DievasColourSemanticDark.buttonPrimaryBackground);
      expect(roles.buttonPrimaryHoveredBackground, DievasColourSemanticDark.buttonPrimaryHoveredBackground);
      expect(roles.buttonPrimaryPressedBackground, DievasColourSemanticDark.buttonPrimaryPressedBackground);
      expect(roles.buttonSecondaryBackground, DievasColourSemanticDark.buttonSecondaryBackground);
      expect(roles.buttonSecondaryHoveredBackground, DievasColourSemanticDark.buttonSecondaryHoveredBackground);
      expect(roles.selectionBorder, DievasColourSemanticDark.selectionBorder);
      expect(roles.focusIndicatorColour, DievasColourSemanticDark.focusIndicatorColour);
      expect(roles.inputFocusedBorder, DievasColourSemanticDark.inputFocusedBorder);
      expect(roles.switchOnTrack, DievasColourSemanticDark.switchOnTrack);
    });
  });

  group('DievasBrandPalettes catalogue', () {
    test('every palette carries a full 11-tint ramp', () {
      for (final palette in DievasBrandPalettes.all.values) {
        final ramp = [
          palette.s50,
          palette.s100,
          palette.s200,
          palette.s300,
          palette.s400,
          palette.s500,
          palette.s600,
          palette.s700,
          palette.s800,
          palette.s900,
          palette.s950,
        ];
        expect(ramp.every((shade) => shade != 0), isTrue, reason: '${palette.name} has a zero shade');
      }
    });

    test('map keys match palette names', () {
      DievasBrandPalettes.all.forEach((key, palette) {
        expect(palette.name, key);
      });
    });

    test('light primary of the default palette matches the indigo primary', () {
      expect(DievasBrandPalettes.indigo.rolesForLight().primary, DievasColourSemanticLight.primary);
    });

    test('amber uses a dark on-primary ink for contrast', () {
      expect(DievasBrandPalettes.amber.buttonPrimaryText, DievasColourPrimitives.slate950);
      expect(DievasBrandPalettes.indigo.buttonPrimaryText, DievasColourPrimitives.white);
    });
  });
}
