import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:flutter/material.dart' show Brightness, Color;

import 'dievas_colour_theme_data.dart';

/// Applies a [DievasBrandPalette] to a [DievasColourThemeData], overriding
/// every brand-derived role while leaving neutral, text, surface, and feedback
/// roles untouched.
///
/// The mapping is brightness-aware: [DievasBrandPalette.rolesForLight] is used
/// on light surfaces and [DievasBrandPalette.rolesForDark] on dark surfaces.
///
/// The built-in themes use Moon Piccolo. Passing a palette replaces that brand.
DievasColourThemeData applyBrandPalette(DievasColourThemeData colours, DievasBrandPalette palette) {
  final roles = switch (colours.brightness) {
    Brightness.dark => palette.rolesForDark(),
    Brightness.light => palette.rolesForLight(),
  };

  return colours.copyWith(
    core: colours.core.copyWith(
      primary: Color(roles.primary),
      badgePrimaryTintedBackground: Color(roles.badgePrimaryTintedBackground),
    ),
    text: colours.text.copyWith(buttonPrimaryText: Color(roles.buttonPrimaryText)),
    icon: colours.icon.copyWith(buttonPrimaryIcon: Color(roles.buttonPrimaryText)),
    action: colours.action.copyWith(
      badgePrimaryBackground: Color(roles.badgePrimaryBackground),
      badgePrimaryTintedText: Color(roles.badgePrimaryTintedText),
      checkboxCheckedBackground: Color(roles.checkboxCheckedBackground),
      radioSelectedBackground: Color(roles.radioSelectedBackground),
      progressIndicator: Color(roles.progressIndicator),
      sliderActiveTrack: Color(roles.sliderActiveTrack),
      inputCursor: Color(roles.inputCursor),
      segmentedControlSelectedBackground: Color(roles.segmentedControlSelectedBackground),
      tabSelectedIndicator: Color(roles.tabSelectedIndicator),
      badgePrimaryText: Color(roles.badgePrimaryText),
      checkboxCheckmark: Color(roles.checkboxCheckmark),
      radioDot: Color(roles.radioDot),
      progressOnPrimaryIndicator: Color(roles.progressOnPrimaryIndicator),
      segmentedControlSelectedText: Color(roles.segmentedControlSelectedText),

      buttonPrimaryBackground: Color(roles.buttonPrimaryBackground),
      buttonPrimaryHoveredBackground: Color(roles.buttonPrimaryHoveredBackground),
      buttonPrimaryPressedBackground: Color(roles.buttonPrimaryPressedBackground),
      buttonSecondaryBackground: Color(roles.buttonSecondaryBackground),
      buttonSecondaryHoveredBackground: Color(roles.buttonSecondaryHoveredBackground),
    ),
    border: colours.border.copyWith(
      selectionBorder: Color(roles.selectionBorder),
      focusIndicatorColour: Color(roles.focusIndicatorColour),
    ),
    input: colours.input.copyWith(inputFocusedBorder: Color(roles.inputFocusedBorder)),
    switchColours: colours.switchColours.copyWith(switchOnTrack: Color(roles.switchOnTrack)),
  );
}
