// Parity and coverage tests for the brand palette selection layer.
//
// A palette's resolved roles must reproduce the built-in reference semantic
// values for the optional [DievasBrandPalettes.indigo] palette, and every
// shipped palette must carry a full 11-tint ramp.

import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:test/test.dart';

void main() {
  group('DievasBrandPalettes.indigo light parity', () {
    final roles = DievasBrandPalettes.indigo.rolesForLight();

    test('primary roles match the light indigo ramp', () {
      expect(roles.primary, DievasColourPrimitives.indigo500);
      expect(roles.badgePrimaryTintedBackground, DievasColourPrimitives.indigo200);
      expect(roles.buttonPrimaryText, DievasColourPrimitives.white);
      expect(roles.buttonPrimaryBackground, DievasColourPrimitives.indigo500);
      expect(roles.buttonPrimaryHoveredBackground, DievasColourPrimitives.indigo600);
      expect(roles.buttonPrimaryPressedBackground, DievasColourPrimitives.indigo700);
      expect(roles.buttonSecondaryBackground, DievasColourPrimitives.indigo50);
      expect(roles.buttonSecondaryHoveredBackground, DievasColourPrimitives.indigo100);
      expect(roles.selectionBorder, DievasColourPrimitives.indigo500);
      expect(roles.focusIndicatorColour, DievasColourPrimitives.indigo500);
      expect(roles.inputFocusedBorder, DievasColourPrimitives.indigo500);
      expect(roles.switchOnTrack, DievasColourPrimitives.indigo500);
    });
  });

  group('DievasBrandPalettes.indigo dark parity', () {
    final roles = DievasBrandPalettes.indigo.rolesForDark();

    test('primary roles match the dark indigo ramp', () {
      expect(roles.primary, DievasColourPrimitives.indigo400);
      expect(roles.badgePrimaryTintedBackground, DievasColourPrimitives.indigo950);
      expect(roles.buttonPrimaryText, DievasColourPrimitives.white);
      expect(roles.buttonPrimaryBackground, DievasColourPrimitives.indigo500);
      expect(roles.buttonPrimaryHoveredBackground, DievasColourPrimitives.indigo400);
      expect(roles.buttonPrimaryPressedBackground, DievasColourPrimitives.indigo300);
      expect(roles.buttonSecondaryBackground, DievasColourPrimitives.indigo950);
      expect(roles.buttonSecondaryHoveredBackground, DievasColourPrimitives.indigo900);
      expect(roles.selectionBorder, DievasColourPrimitives.indigo400);
      expect(roles.focusIndicatorColour, DievasColourPrimitives.indigo400);
      expect(roles.inputFocusedBorder, DievasColourPrimitives.indigo400);
      expect(roles.switchOnTrack, DievasColourPrimitives.indigo500);
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

    test('light primary of the indigo palette matches its primitive', () {
      expect(DievasBrandPalettes.indigo.rolesForLight().primary, DievasColourPrimitives.indigo500);
    });

    test('amber uses a dark on-primary ink for contrast', () {
      expect(DievasBrandPalettes.amber.buttonPrimaryText, DievasColourPrimitives.slate950);
      expect(DievasBrandPalettes.indigo.buttonPrimaryText, DievasColourPrimitives.white);
    });
  });
}
