// Brand palette application — parity and boundary tests.
//
// The default theme uses Moon Piccolo; indigo remains an optional palette.
// Boundary: a selected palette must re-resolve every brand-derived role
// while leaving neutral, text, surface, and feedback roles untouched.

import 'package:dievas/dievas.dart';
import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final lightColours = DievasLightThemeData().colours;
  final darkColours = DievasDarkThemeData().colours;

  group('Moon default branding', () {
    for (final theme in [DievasLightThemeData(), DievasDarkThemeData()]) {
      test('${theme.colours.brightness.name} propagates Piccolo through component and Material themes', () {
        const piccolo = Color(0xFF5C33CF);
        expect(theme.colours.core.primary, piccolo);
        expect(theme.colours.action.buttonPrimaryBackground, piccolo);
        expect(theme.colours.input.inputFocusedBorder, piccolo);
        expect(theme.colours.action.inputCursor, piccolo);
        expect(theme.components.authCode.borderColourFocused, piccolo);
        expect(theme.components.authCode.cursorColour, piccolo);
        expect(theme.material.colorScheme.primary, piccolo);
        expect(theme.colours.core.badgePrimaryTintedBackground, const Color(0x1F5C33CF));
      });
    }
  });

  group('applyBrandPalette parity', () {
    test('indigo can replace the light Moon brand', () {
      expect(
        applyBrandPalette(lightColours, DievasBrandPalettes.indigo).core.primary,
        const Color(DievasColourPrimitives.indigo500),
      );
    });

    test('indigo can replace the dark Moon brand', () {
      expect(
        applyBrandPalette(darkColours, DievasBrandPalettes.indigo).core.primary,
        const Color(DievasColourPrimitives.indigo400),
      );
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
