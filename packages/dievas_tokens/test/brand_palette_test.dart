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

    test('brand roles match the light reference semantics', () {
      expect(roles.brand, DievasColourSemanticLight.brand);
      expect(roles.brandSubtle, DievasColourSemanticLight.brandSubtle);
      expect(roles.onBrand, DievasColourSemanticLight.onBrand);
      expect(roles.actionPrimary, DievasColourSemanticLight.actionPrimary);
      expect(roles.actionPrimaryHover, DievasColourSemanticLight.actionPrimaryHover);
      expect(roles.actionPrimaryActive, DievasColourSemanticLight.actionPrimaryActive);
      expect(roles.actionSecondary, DievasColourSemanticLight.actionSecondary);
      expect(roles.actionSecondaryHover, DievasColourSemanticLight.actionSecondaryHover);
      expect(roles.borderBrand, DievasColourSemanticLight.borderBrand);
      expect(roles.borderFocus, DievasColourSemanticLight.borderFocus);
      expect(roles.inputBorderFocus, DievasColourSemanticLight.inputBorderFocus);
      expect(roles.switchTrackOn, DievasColourSemanticLight.switchTrackOn);
    });
  });

  group('DievasBrandPalettes.indigo dark parity', () {
    final roles = DievasBrandPalettes.indigo.rolesForDark();

    test('brand roles match the dark reference semantics', () {
      expect(roles.brand, DievasColourSemanticDark.brand);
      expect(roles.brandSubtle, DievasColourSemanticDark.brandSubtle);
      expect(roles.onBrand, DievasColourSemanticDark.onBrand);
      expect(roles.actionPrimary, DievasColourSemanticDark.actionPrimary);
      expect(roles.actionPrimaryHover, DievasColourSemanticDark.actionPrimaryHover);
      expect(roles.actionPrimaryActive, DievasColourSemanticDark.actionPrimaryActive);
      expect(roles.actionSecondary, DievasColourSemanticDark.actionSecondary);
      expect(roles.actionSecondaryHover, DievasColourSemanticDark.actionSecondaryHover);
      expect(roles.borderBrand, DievasColourSemanticDark.borderBrand);
      expect(roles.borderFocus, DievasColourSemanticDark.borderFocus);
      expect(roles.inputBorderFocus, DievasColourSemanticDark.inputBorderFocus);
      expect(roles.switchTrackOn, DievasColourSemanticDark.switchTrackOn);
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

    test('light brand of the default palette matches the indigo brand', () {
      expect(DievasBrandPalettes.indigo.rolesForLight().brand, DievasColourSemanticLight.brand);
    });

    test('amber uses a dark on-brand ink for contrast', () {
      expect(DievasBrandPalettes.amber.onBrand, DievasColourPrimitives.slate950);
      expect(DievasBrandPalettes.indigo.onBrand, DievasColourPrimitives.white);
    });
  });
}
