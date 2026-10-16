// Brand palette application — parity and boundary tests.
//
// Parity: applying the default indigo palette to the built-in reference
// themes must be a no-op (identical colour data).
// Boundary: a non-indigo palette must re-resolve every brand-derived role
// while leaving neutral, text, surface, and feedback roles untouched.

import 'package:dievas/dievas.dart';
import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final lightColours = DievasLightThemeData().colours;
  final darkColours = DievasDarkThemeData().colours;

  group('applyBrandPalette parity', () {
    test('indigo palette reproduces the light reference theme exactly', () {
      expect(applyBrandPalette(lightColours, DievasBrandPalettes.indigo), equals(lightColours));
    });

    test('indigo palette reproduces the dark reference theme exactly', () {
      expect(applyBrandPalette(darkColours, DievasBrandPalettes.indigo), equals(darkColours));
    });
  });

  group('applyBrandPalette boundary', () {
    final green = applyBrandPalette(lightColours, DievasBrandPalettes.green);

    test('brand-derived roles follow the selected palette', () {
      expect(green.core.brand, Color(DievasColourPrimitives.green500));
      expect(green.core.brandSubtle, Color(DievasColourPrimitives.green200));
      expect(green.action.actionPrimary, Color(DievasColourPrimitives.green500));
      expect(green.action.actionPrimaryHover, Color(DievasColourPrimitives.green600));
      expect(green.action.actionPrimaryActive, Color(DievasColourPrimitives.green700));
      expect(green.action.actionSecondary, Color(DievasColourPrimitives.green50));
      expect(green.action.actionSecondaryHover, Color(DievasColourPrimitives.green100));
      expect(green.border.borderBrand, Color(DievasColourPrimitives.green500));
      expect(green.border.borderFocus, Color(DievasColourPrimitives.green500));
      expect(green.input.inputBorderFocus, Color(DievasColourPrimitives.green500));
      expect(green.switchColours.switchTrackOn, Color(DievasColourPrimitives.green500));
    });

    test('neutral and semantic roles are untouched', () {
      expect(green.text.textPrimary, lightColours.text.textPrimary);
      expect(green.background.bgBase, lightColours.background.bgBase);
      expect(green.feedback.feedbackError, lightColours.feedback.feedbackError);
      expect(green.staticColours.staticBlack, lightColours.staticColours.staticBlack);
      expect(green.action.actionError, lightColours.action.actionError);
      expect(green.action.actionPrimaryDisabled, lightColours.action.actionPrimaryDisabled);
      expect(green.brightness, lightColours.brightness);
    });

    test('on-brand contrast roles follow the palette', () {
      expect(green.text.textOnBrand, Color(DievasColourPrimitives.white));
      expect(green.icon.iconOnBrand, Color(DievasColourPrimitives.white));

      final amber = applyBrandPalette(lightColours, DievasBrandPalettes.amber);
      expect(amber.core.onBrand, Color(DievasColourPrimitives.slate950));
      expect(amber.text.textOnBrand, Color(DievasColourPrimitives.slate950));
    });
  });

  group('DievasGlobalThemeData brandPalette selection point', () {
    test('no palette leaves the base colours unchanged', () {
      final theme = DievasGlobalThemeData(colours: lightColours);
      expect(theme.colours, equals(lightColours));
    });

    test('a palette re-skins the resolved theme colours', () {
      final theme = DievasGlobalThemeData(colours: lightColours, brandPalette: DievasBrandPalettes.green);
      expect(theme.colours.core.brand, Color(DievasColourPrimitives.green500));
      expect(theme.colours.text.textPrimary, lightColours.text.textPrimary);
    });
  });
}
