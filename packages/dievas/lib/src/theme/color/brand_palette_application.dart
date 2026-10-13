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
/// Passing [DievasBrandPalettes.indigo] reproduces the built-in reference
/// themes exactly.
DievasColourThemeData applyBrandPalette(DievasColourThemeData colours, DievasBrandPalette palette) {
  final roles = switch (colours.brightness) {
    Brightness.dark => palette.rolesForDark(),
    Brightness.light => palette.rolesForLight(),
  };

  return colours.copyWith(
    core: colours.core.copyWith(
      brand: Color(roles.brand),
      brandSubtle: Color(roles.brandSubtle),
      onBrand: Color(roles.onBrand),
    ),
    text: colours.text.copyWith(textOnBrand: Color(roles.onBrand)),
    icon: colours.icon.copyWith(iconOnBrand: Color(roles.onBrand)),
    action: colours.action.copyWith(
      actionPrimary: Color(roles.actionPrimary),
      actionPrimaryHover: Color(roles.actionPrimaryHover),
      actionPrimaryActive: Color(roles.actionPrimaryActive),
      actionSecondary: Color(roles.actionSecondary),
      actionSecondaryHover: Color(roles.actionSecondaryHover),
    ),
    border: colours.border.copyWith(
      borderBrand: Color(roles.borderBrand),
      borderFocus: Color(roles.borderFocus),
    ),
    input: colours.input.copyWith(inputBorderFocus: Color(roles.inputBorderFocus)),
    switchColours: colours.switchColours.copyWith(switchTrackOn: Color(roles.switchTrackOn)),
  );
}
