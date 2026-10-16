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

    test('primary-derived roles follow the selected palette', () {
      expect(green.core.primary, Color(DievasColourPrimitives.green500));
      expect(green.core.badgePrimaryTintedBackground, Color(DievasColourPrimitives.green200));
      expect(green.action.buttonPrimaryBackground, Color(DievasColourPrimitives.green500));
      expect(green.action.buttonPrimaryHoveredBackground, Color(DievasColourPrimitives.green600));
      expect(green.action.buttonPrimaryPressedBackground, Color(DievasColourPrimitives.green700));
      expect(green.action.buttonSecondaryBackground, Color(DievasColourPrimitives.green50));
      expect(green.action.buttonSecondaryHoveredBackground, Color(DievasColourPrimitives.green100));
      expect(green.border.selectionBorder, Color(DievasColourPrimitives.green500));
      expect(green.border.focusIndicatorColour, Color(DievasColourPrimitives.green500));
      expect(green.input.inputFocusedBorder, Color(DievasColourPrimitives.green500));
      expect(green.switchColours.switchOnTrack, Color(DievasColourPrimitives.green500));
    });

    test('neutral and semantic roles are untouched', () {
      expect(green.text.textPrimary, lightColours.text.textPrimary);
      expect(green.background.pageBackground, lightColours.background.pageBackground);
      expect(green.feedback.feedbackError, lightColours.feedback.feedbackError);
      expect(green.staticColours.staticBlack, lightColours.staticColours.staticBlack);
      expect(green.action.buttonDestructiveBackground, lightColours.action.buttonDestructiveBackground);
      expect(green.action.buttonPrimaryDisabledBackground, lightColours.action.buttonPrimaryDisabledBackground);
      expect(green.brightness, lightColours.brightness);
    });

    test('on-primary contrast roles follow the palette', () {
      expect(green.text.buttonPrimaryText, Color(DievasColourPrimitives.white));
      expect(green.icon.buttonPrimaryIcon, Color(DievasColourPrimitives.white));

      final amber = applyBrandPalette(lightColours, DievasBrandPalettes.amber);
      expect(amber.text.buttonPrimaryText, Color(DievasColourPrimitives.slate950));
      expect(amber.text.buttonPrimaryText, Color(DievasColourPrimitives.slate950));
    });
  });

  group('DievasGlobalThemeData brandPalette selection point', () {
    test('no palette leaves the base colours unchanged', () {
      final theme = DievasGlobalThemeData(colours: lightColours);
      expect(theme.colours, equals(lightColours));
    });

    test('a palette re-skins the resolved theme colours', () {
      final theme = DievasGlobalThemeData(colours: lightColours, brandPalette: DievasBrandPalettes.green);
      expect(theme.colours.core.primary, Color(DievasColourPrimitives.green500));
      expect(theme.colours.text.textPrimary, lightColours.text.textPrimary);
    });
  });
}
