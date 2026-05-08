// Semantic colour tokens — light theme.
//
// Pure Dart. No Flutter dependency.
// Every constant is an ARGB int aliased from DievasColourPrimitives.
// The Color() wrapper is applied in the dievas Flutter package.
//
// Naming: grouped descriptive names (textPrimary, bgBase, actionPrimary).
// Moon DS role names are referenced in comments for cross-reference only.

import '../primitives/colour_primitives.dart';

/// Light-theme semantic colour tokens for the Dievas design system.
///
/// References [DievasColourPrimitives] exclusively — no raw hex values
/// are permitted in this file.
abstract final class DievasColourSemanticLight {
  //Brand

  /// Primary brand colour. Interactive elements, CTAs, selected states.
  /// Moon ref: piccolo
  static const int brand = DievasColourPrimitives.indigo500;

  /// Subtle brand tint. Backgrounds behind brand-coloured icons or badges.
  static const int brandSubtle = DievasColourPrimitives.indigo50;

  /// Text or icons placed on top of [brand] surfaces.
  static const int onBrand = DievasColourPrimitives.white;

  //Text

  /// Highest-contrast body text. Headlines, labels, primary copy.
  /// Moon ref: bulma
  static const int textPrimary = DievasColourPrimitives.slate900;

  /// Secondary / supporting copy. Subtitles, captions, metadata.
  /// Moon ref: trunks
  static const int textSecondary = DievasColourPrimitives.slate500;

  /// Tertiary / placeholder-level text. Hints, helper copy.
  static const int textTertiary = DievasColourPrimitives.slate400;

  /// Text on disabled interactive elements.
  static const int textDisabled = DievasColourPrimitives.slate300;

  /// Text on dark / inverted surfaces (overlays, toasts).
  static const int textInverse = DievasColourPrimitives.white;

  /// Text placed directly on a [brand]-coloured background.
  static const int textOnBrand = DievasColourPrimitives.white;

  //Icon

  /// Default icon fill on light backgrounds.
  static const int iconPrimary = DievasColourPrimitives.slate900;

  /// Muted / secondary icons.
  static const int iconSecondary = DievasColourPrimitives.slate500;

  /// Icons on disabled controls.
  static const int iconDisabled = DievasColourPrimitives.slate300;

  /// Icons placed on a [brand]-coloured surface.
  static const int iconOnBrand = DievasColourPrimitives.white;

  //Background

  /// Page / scaffold background. The base layer.
  /// Moon ref: goku
  static const int bgBase = DievasColourPrimitives.slate50;

  /// Card / surface background. One level above [bgBase].
  /// Moon ref: gohan
  static const int bgSubtle = DievasColourPrimitives.white;

  /// Elevated surfaces: modals, bottom sheets, popovers.
  /// Moon ref: goten
  static const int bgElevated = DievasColourPrimitives.white;

  /// Scrim / overlay behind modals and bottom sheets.
  static const int bgOverlay = DievasColourPrimitives.slate900;

  //Border

  /// Default dividers and container strokes.
  /// Moon ref: beerus
  static const int borderDefault = DievasColourPrimitives.slate200;

  /// High-emphasis borders. Active input outlines, selected containers.
  static const int borderStrong = DievasColourPrimitives.slate900;

  /// Borders on disabled inputs and containers.
  static const int borderDisabled = DievasColourPrimitives.slate200;

  /// Focus ring. Applied on keyboard focus.
  /// Moon ref: zeno
  static const int borderFocus = DievasColourPrimitives.indigo500;

  /// Brand-coloured border. Selected states, brand highlights.
  static const int borderBrand = DievasColourPrimitives.indigo500;

  //Action

  /// Primary CTA background (filled button, active toggle).
  /// Moon ref: piccolo
  static const int actionPrimary = DievasColourPrimitives.indigo500;

  /// Hover state of [actionPrimary].
  static const int actionPrimaryHover = DievasColourPrimitives.indigo600;

  /// Pressed / active state of [actionPrimary].
  static const int actionPrimaryActive = DievasColourPrimitives.indigo700;

  /// Disabled primary action surface.
  static const int actionPrimaryDisabled = DievasColourPrimitives.slate200;

  /// Secondary action background (outlined / ghost button resting surface).
  /// Moon ref: hit
  static const int actionSecondary = DievasColourPrimitives.indigo50;

  /// Hover state of [actionSecondary].
  static const int actionSecondaryHover = DievasColourPrimitives.indigo100;

  /// Destructive / error action.
  /// Moon ref: chichi
  static const int actionError = DievasColourPrimitives.red500;

  /// Hover state of [actionError].
  static const int actionErrorHover = DievasColourPrimitives.red600;

  /// Success / constructive action surface.
  /// Moon ref: roshi
  static const int actionSuccess = DievasColourPrimitives.green500;

  //Success

  /// Success alert / toast background.
  static const int feedbackSuccessBackground = DievasColourPrimitives.green50;

  /// Success border.
  static const int feedbackSuccessBorder = DievasColourPrimitives.green200;

  /// Success icon fill.
  static const int feedbackSuccessIcon = DievasColourPrimitives.green600;

  /// Success body text.
  static const int feedbackSuccessText = DievasColourPrimitives.green900;

  //Warning

  /// Warning alert background.
  /// Moon ref: krillin
  static const int feedbackWarningBackground = DievasColourPrimitives.amber50;

  /// Warning border.
  static const int feedbackWarningBorder = DievasColourPrimitives.amber200;

  /// Warning icon fill.
  static const int feedbackWarningIcon = DievasColourPrimitives.amber600;

  /// Warning body text.
  static const int feedbackWarningText = DievasColourPrimitives.amber900;

  //Error

  /// Error alert background.
  /// Moon ref: chichi
  static const int feedbackErrorBackground = DievasColourPrimitives.red50;

  /// Error border.
  static const int feedbackErrorBorder = DievasColourPrimitives.red200;

  /// Error icon fill.
  static const int feedbackErrorIcon = DievasColourPrimitives.red600;

  /// Error body text.
  static const int feedbackErrorText = DievasColourPrimitives.red900;

  //Info

  /// Informational alert background.
  /// Moon ref: whis
  static const int feedbackInfoBackground = DievasColourPrimitives.sky50;

  /// Info border.
  static const int feedbackInfoBorder = DievasColourPrimitives.sky200;

  /// Info icon fill.
  static const int feedbackInfoIcon = DievasColourPrimitives.sky600;

  /// Info body text.
  static const int feedbackInfoText = DievasColourPrimitives.sky900;

  //Input

  /// Input field background surface.
  static const int inputBg = DievasColourPrimitives.white;

  /// Default input border.
  static const int inputBorder = DievasColourPrimitives.slate300;

  /// Input border when focused.
  static const int inputBorderFocus = DievasColourPrimitives.indigo500;

  /// Input border in error state.
  static const int inputBorderError = DievasColourPrimitives.red500;

  /// Input text colour (typed value).
  static const int inputText = DievasColourPrimitives.slate900;

  /// Input placeholder / hint text colour.
  static const int inputPlaceholder = DievasColourPrimitives.slate400;

  //Switch

  /// Track colour when the switch is ON.
  static const int switchTrackOn = DievasColourPrimitives.indigo500;

  /// Track colour when the switch is OFF.
  static const int switchTrackOff = DievasColourPrimitives.slate200;

  /// Thumb (knob) colour in both states.
  static const int switchThumb = DievasColourPrimitives.white;

  /// Switch track border (outlined switch variant).
  static const int switchBorder = DievasColourPrimitives.slate300;

  //Static

  /// Pure white. Theme-invariant. Never flips in dark mode.
  static const int staticWhite = DievasColourPrimitives.white;

  /// Pure black. Theme-invariant.
  static const int staticBlack = DievasColourPrimitives.black;

  /// Fully transparent. Useful for animation start/end states.
  static const int staticTransparent = DievasColourPrimitives.transparent;
}
