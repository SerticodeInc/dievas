// Semantic colour tokens — dark theme.
//
// Pure Dart. No Flutter dependency.
// Every constant is an ARGB int aliased from DievasColourPrimitives.
// The Color() wrapper is applied in the dievas Flutter package.
//
// Naming: grouped descriptive names matching DievasColourSemanticLight.
// Every role defined in the light file has a counterpart here.

import '../primitives/colour_primitives.dart';

/// Dark-theme semantic colour tokens for the Dievas design system.
///
/// References [DievasColourPrimitives] exclusively — no raw hex values
/// are permitted in this file.
abstract final class DievasColourSemanticDark {
  //  Core / Brand

  /// Primary brand colour. Interactive elements, CTAs, selected states.
  static const int brand = DievasColourPrimitives.indigo400;

  /// Subtle brand tint on dark surfaces.
  static const int brandSubtle = DievasColourPrimitives.indigo950;

  /// Text or icons placed on top of [brand] surfaces.
  static const int onBrand = DievasColourPrimitives.white;

  // Text

  /// Highest-contrast body text on dark backgrounds.
  static const int textPrimary = DievasColourPrimitives.slate50;

  /// Secondary / supporting copy.
  static const int textSecondary = DievasColourPrimitives.slate400;

  /// Tertiary / placeholder-level text.
  static const int textTertiary = DievasColourPrimitives.slate500;

  /// Text on disabled interactive elements.
  static const int textDisabled = DievasColourPrimitives.slate600;

  /// Text on light / inverted surfaces inside a dark UI.
  static const int textInverse = DievasColourPrimitives.slate900;

  /// Text placed directly on a [brand]-coloured background.
  static const int textOnBrand = DievasColourPrimitives.white;

  // Icon

  /// Default icon fill on dark backgrounds.
  static const int iconPrimary = DievasColourPrimitives.slate50;

  /// Muted / secondary icons.
  static const int iconSecondary = DievasColourPrimitives.slate400;

  /// Icons on disabled controls.
  static const int iconDisabled = DievasColourPrimitives.slate600;

  /// Icons placed on a [brand]-coloured surface.
  static const int iconOnBrand = DievasColourPrimitives.white;

  // Background

  /// Page / scaffold background. The base dark layer.
  static const int bgBase = DievasColourPrimitives.slate950;

  /// Card / surface background. One level above [bgBase].
  static const int bgSubtle = DievasColourPrimitives.slate900;

  /// Elevated surfaces: modals, bottom sheets, popovers.
  static const int bgElevated = DievasColourPrimitives.slate800;

  /// Scrim / overlay behind modals and bottom sheets.
  static const int bgOverlay = DievasColourPrimitives.black;

  // Border

  /// Default dividers and container strokes.
  static const int borderDefault = DievasColourPrimitives.slate700;

  /// High-emphasis borders. Active input outlines, selected containers.
  static const int borderStrong = DievasColourPrimitives.slate400;

  /// Borders on disabled inputs and containers.
  static const int borderDisabled = DievasColourPrimitives.slate700;

  /// Focus ring. Applied on keyboard focus.
  static const int borderFocus = DievasColourPrimitives.indigo400;

  /// Brand-coloured border. Selected states, brand highlights.
  static const int borderBrand = DievasColourPrimitives.indigo400;

  // Action

  /// Primary CTA background.
  static const int actionPrimary = DievasColourPrimitives.indigo500;

  /// Hover state of [actionPrimary].
  static const int actionPrimaryHover = DievasColourPrimitives.indigo400;

  /// Pressed / active state of [actionPrimary].
  static const int actionPrimaryActive = DievasColourPrimitives.indigo300;

  /// Disabled primary action surface.
  static const int actionPrimaryDisabled = DievasColourPrimitives.slate700;

  /// Secondary action background (outlined / ghost resting surface).
  static const int actionSecondary = DievasColourPrimitives.indigo950;

  /// Hover state of [actionSecondary].
  static const int actionSecondaryHover = DievasColourPrimitives.indigo900;

  /// Destructive / error action.
  static const int actionError = DievasColourPrimitives.red500;

  /// Hover state of [actionError].
  static const int actionErrorHover = DievasColourPrimitives.red400;

  /// Success / constructive action surface.
  static const int actionSuccess = DievasColourPrimitives.green500;

  // Feedback — Success

  /// Success alert background on dark surfaces.
  static const int feedbackSuccessBackground = DievasColourPrimitives.green950;

  /// Success border.
  static const int feedbackSuccessBorder = DievasColourPrimitives.green800;

  /// Success icon fill.
  static const int feedbackSuccessIcon = DievasColourPrimitives.green400;

  /// Success body text.
  static const int feedbackSuccessText = DievasColourPrimitives.green200;

  // Feedback — Warning

  /// Warning alert background.
  static const int feedbackWarningBackground = DievasColourPrimitives.amber950;

  /// Warning border.
  static const int feedbackWarningBorder = DievasColourPrimitives.amber800;

  /// Warning icon fill.
  static const int feedbackWarningIcon = DievasColourPrimitives.amber400;

  /// Warning body text.
  static const int feedbackWarningText = DievasColourPrimitives.amber200;

  // Feedback — Error

  /// Error alert background.
  static const int feedbackErrorBackground = DievasColourPrimitives.red950;

  /// Error border.
  static const int feedbackErrorBorder = DievasColourPrimitives.red800;

  /// Error icon fill.
  static const int feedbackErrorIcon = DievasColourPrimitives.red400;

  /// Error body text.
  static const int feedbackErrorText = DievasColourPrimitives.red200;

  // Feedback — Info

  /// Informational alert background.
  static const int feedbackInfoBackground = DievasColourPrimitives.sky950;

  /// Info border.
  static const int feedbackInfoBorder = DievasColourPrimitives.sky800;

  /// Info icon fill.
  static const int feedbackInfoIcon = DievasColourPrimitives.sky400;

  /// Info body text.
  static const int feedbackInfoText = DievasColourPrimitives.sky200;

  // Input

  /// Input field background surface.
  static const int inputBg = DievasColourPrimitives.slate800;

  /// Default input border.
  static const int inputBorder = DievasColourPrimitives.slate600;

  /// Input border when focused.
  static const int inputBorderFocus = DievasColourPrimitives.indigo400;

  /// Input border in error state.
  static const int inputBorderError = DievasColourPrimitives.red500;

  /// Input text colour (typed value).
  static const int inputText = DievasColourPrimitives.slate50;

  /// Input placeholder / hint text colour.
  static const int inputPlaceholder = DievasColourPrimitives.slate500;

  // Switch

  /// Track colour when the switch is ON.
  static const int switchTrackOn = DievasColourPrimitives.indigo500;

  /// Track colour when the switch is OFF.
  static const int switchTrackOff = DievasColourPrimitives.slate700;

  /// Thumb (knob) colour in both states.
  static const int switchThumb = DievasColourPrimitives.white;

  /// Switch track border (outlined switch variant).
  static const int switchBorder = DievasColourPrimitives.slate600;

  // Static

  /// Pure white. Theme-invariant. Never flips.
  static const int staticWhite = DievasColourPrimitives.white;

  /// Pure black. Theme-invariant.
  static const int staticBlack = DievasColourPrimitives.black;

  /// Fully transparent. Useful for animation start/end states.
  static const int staticTransparent = DievasColourPrimitives.transparent;
}
