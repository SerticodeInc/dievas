// Dark theme semantic colour tokens for the Dievas design system. Every
// constant is an ARGB int aliased from DievasColourPrimitives; the Color()
// wrapper is applied in the dievas Flutter package.

import 'package:dievas_tokens/src/primitives/colour_primitives.dart';

/// Dark theme semantic colour tokens. Neutral reference roles match the
/// recorded Moon token values; brand, feedback, and component states retain
/// the existing Dievas mappings. Values reference [DievasColourPrimitives].
abstract final class DievasColourSemanticDark {
  //  Core / Brand

  /// Primary palette identity. Component roles below name each usage.
  static const int primary = DievasColourPrimitives.indigo400;

  /// Background of a tinted badge using the primary palette.
  static const int badgePrimaryTintedBackground = DievasColourPrimitives.indigo950;

  /// Text on a filled primary button.
  static const int buttonPrimaryText = DievasColourPrimitives.white;

  // Text

  /// Highest contrast body text on dark backgrounds.
  static const int textPrimary = DievasColourPrimitives.white;

  /// Secondary / supporting copy.
  static const int textSecondary = DievasColourPrimitives.steelGreyLight;

  /// Tertiary / placeholder level text.
  static const int textTertiary = DievasColourPrimitives.slate500;

  /// Text on disabled interactive elements.
  static const int textDisabled = DievasColourPrimitives.slate600;

  /// Text on light / inverted surfaces inside a dark UI.
  static const int textInverse = DievasColourPrimitives.black;

  // Icon

  /// Default icon fill on dark backgrounds.
  static const int iconPrimary = DievasColourPrimitives.white;

  /// Muted / secondary icons.
  static const int iconSecondary = DievasColourPrimitives.steelGreyLight;

  /// Icons on disabled controls.
  static const int iconDisabled = DievasColourPrimitives.slate600;

  /// Icons placed on a [primary]-coloured surface.
  static const int buttonPrimaryIcon = DievasColourPrimitives.white;

  // Background

  /// Page / scaffold background. The base dark layer.
  static const int pageBackground = DievasColourPrimitives.black;

  /// Card background.
  static const int cardBackground = DievasColourPrimitives.charcoalDeep;

  /// Dialog background.
  static const int dialogBackground = DievasColourPrimitives.slate800;

  /// Scrim / overlay behind modals and bottom sheets.
  /// Moon ref: zeno. Alpha is exactly 0x8F.
  static const int modalBarrierBackground = DievasColourPrimitives.blackAlpha8F;

  //Surface

  /// Canvas / drawing surface. Distinguishable from [pageBackground] for creative
  /// workspaces, whiteboards, and illustration areas.
  static const int canvasBackground = DievasColourPrimitives.slate950;

  /// Code block / inline code background. Visually distinct from [pageBackground]
  /// so code stands apart from surrounding content.
  static const int codeBlockBackground = DievasColourPrimitives.slate900;

  /// Sidebar / navigation rail background. Provides a visual anchor for
  /// persistent navigation alongside the main content area.
  static const int sidebarBackground = DievasColourPrimitives.slate900;

  /// Alternating table row background. Applied to every other row for
  /// horizontal scanability in data tables and list views.
  static const int tableRowAlternateBackground = DievasColourPrimitives.slate800;

  // Border

  /// Divider stroke colour.
  static const int dividerColour = DievasColourPrimitives.charcoal;

  /// High emphasis borders. Active input outlines, selected containers.
  static const int inputActiveBorder = DievasColourPrimitives.slate400;

  /// Borders on disabled inputs and containers.
  static const int inputDisabledBorder = DievasColourPrimitives.slate700;

  /// Focus ring. Applied on keyboard focus.
  static const int focusIndicatorColour = DievasColourPrimitives.indigo400;

  /// Brand coloured border. Selected states, brand highlights.
  static const int selectionBorder = DievasColourPrimitives.indigo400;

  // Action

  /// Primary CTA background.
  static const int buttonPrimaryBackground = DievasColourPrimitives.indigo500;

  /// Hover state of [buttonPrimaryBackground].
  static const int buttonPrimaryHoveredBackground = DievasColourPrimitives.indigo400;

  /// Pressed / active state of [buttonPrimaryBackground].
  static const int buttonPrimaryPressedBackground = DievasColourPrimitives.indigo300;

  /// Disabled primary action surface.
  static const int buttonPrimaryDisabledBackground = DievasColourPrimitives.slate700;

  /// Secondary action background (outlined / ghost resting surface).
  static const int buttonSecondaryBackground = DievasColourPrimitives.indigo950;

  /// Hover state of [buttonSecondaryBackground].
  static const int buttonSecondaryHoveredBackground = DievasColourPrimitives.indigo900;

  /// Destructive / error action.
  static const int buttonDestructiveBackground = DievasColourPrimitives.red500;

  /// Hover state of [buttonDestructiveBackground].
  static const int buttonDestructiveHoveredBackground = DievasColourPrimitives.red400;

  /// Success / constructive action surface.
  static const int buttonSuccessBackground = DievasColourPrimitives.green500;

  // Feedback: Success

  /// Success alert background on dark surfaces.
  static const int alertSuccessBackground = DievasColourPrimitives.green950;

  /// Success border.
  static const int alertSuccessBorder = DievasColourPrimitives.green800;

  /// Success icon fill.
  static const int alertSuccessIcon = DievasColourPrimitives.green400;

  /// Success body text.
  static const int alertSuccessText = DievasColourPrimitives.green200;

  // Feedback: Warning

  /// Warning alert background.
  static const int alertWarningBackground = DievasColourPrimitives.amber950;

  /// Warning border.
  static const int alertWarningBorder = DievasColourPrimitives.amber800;

  /// Warning icon fill.
  static const int alertWarningIcon = DievasColourPrimitives.amber400;

  /// Warning body text.
  static const int alertWarningText = DievasColourPrimitives.amber200;

  // Feedback: Error

  /// Error alert background.
  static const int alertErrorBackground = DievasColourPrimitives.red950;

  /// Error border.
  static const int alertErrorBorder = DievasColourPrimitives.red800;

  /// Error icon fill.
  static const int alertErrorIcon = DievasColourPrimitives.red400;

  /// Error body text.
  static const int alertErrorText = DievasColourPrimitives.red200;

  // Feedback: Info

  /// Informational alert background.
  static const int alertInfoBackground = DievasColourPrimitives.sky950;

  /// Info border.
  static const int alertInfoBorder = DievasColourPrimitives.sky800;

  /// Info icon fill.
  static const int alertInfoIcon = DievasColourPrimitives.sky400;

  /// Info body text.
  static const int alertInfoText = DievasColourPrimitives.sky200;

  // Input

  /// Input field background surface.
  static const int inputBackground = DievasColourPrimitives.slate800;

  /// Default input border.
  static const int inputBorder = DievasColourPrimitives.slate600;

  /// Input border when focused.
  static const int inputFocusedBorder = DievasColourPrimitives.indigo400;

  /// Input border in error state.
  static const int inputErrorBorder = DievasColourPrimitives.red500;

  /// Input border in warning state.
  static const int inputWarningBorder = DievasColourPrimitives.amber500;

  /// Input text colour (typed value).
  static const int inputText = DievasColourPrimitives.white;

  /// Input placeholder / hint text colour.
  static const int inputPlaceholderText = DievasColourPrimitives.slate500;

  // Switch

  /// Track colour when the switch is ON.
  static const int switchOnTrack = DievasColourPrimitives.indigo500;

  /// Track colour when the switch is OFF.
  static const int switchOffTrack = DievasColourPrimitives.slate700;

  /// Thumb (knob) colour when the switch is ON.
  static const int switchOnThumb = DievasColourPrimitives.white;

  /// Thumb (knob) colour when the switch is OFF.
  static const int switchOffThumb = DievasColourPrimitives.slate500;

  // Static

  /// Pure white. Theme invariant. Never flips.
  static const int staticWhite = DievasColourPrimitives.white;

  /// Pure black. Theme invariant.
  static const int staticBlack = DievasColourPrimitives.black;

  /// Fully transparent. Useful for animation start/end states.
  static const int staticTransparent = DievasColourPrimitives.transparent;
  // Component colours

  /// bottom sheet background.
  static const int bottomSheetBackground = DievasColourPrimitives.slate800;

  /// tooltip background.
  static const int tooltipBackground = DievasColourPrimitives.slate800;

  /// drawer background.
  static const int drawerBackground = DievasColourPrimitives.slate800;

  /// menu background.
  static const int menuBackground = DievasColourPrimitives.slate800;

  /// popover background.
  static const int popoverBackground = DievasColourPrimitives.slate800;

  /// snackbar background.
  static const int snackbarBackground = DievasColourPrimitives.slate800;

  /// tag background.
  static const int tagBackground = DievasColourPrimitives.slate800;

  /// badge neutral filled background.
  static const int badgeNeutralFilledBackground = DievasColourPrimitives.slate800;

  /// icon button focused background.
  static const int iconButtonFocusedBackground = DievasColourPrimitives.slate800;

  /// list item selected background.
  static const int listItemSelectedBackground = DievasColourPrimitives.charcoalDeep;

  /// badge neutral tinted background.
  static const int badgeNeutralTintedBackground = DievasColourPrimitives.charcoalDeep;

  /// icon button background.
  static const int iconButtonBackground = DievasColourPrimitives.charcoalDeep;

  /// progress track.
  static const int progressTrack = DievasColourPrimitives.charcoalDeep;

  /// segmented control background.
  static const int segmentedControlBackground = DievasColourPrimitives.charcoalDeep;

  /// badge primary background.
  static const int badgePrimaryBackground = DievasColourPrimitives.indigo500;

  /// badge primary tinted text.
  static const int badgePrimaryTintedText = DievasColourPrimitives.indigo500;

  /// checkbox checked background.
  static const int checkboxCheckedBackground = DievasColourPrimitives.indigo500;

  /// radio selected background.
  static const int radioSelectedBackground = DievasColourPrimitives.indigo500;

  /// progress indicator.
  static const int progressIndicator = DievasColourPrimitives.indigo500;

  /// slider active track.
  static const int sliderActiveTrack = DievasColourPrimitives.indigo500;

  /// input cursor.
  static const int inputCursor = DievasColourPrimitives.indigo500;

  /// segmented control selected background.
  static const int segmentedControlSelectedBackground = DievasColourPrimitives.indigo500;

  /// tab selected indicator.
  static const int tabSelectedIndicator = DievasColourPrimitives.indigo500;

  /// checkbox disabled background.
  static const int checkboxDisabledBackground = DievasColourPrimitives.slate700;

  /// radio disabled background.
  static const int radioDisabledBackground = DievasColourPrimitives.slate700;

  /// badge primary text.
  static const int badgePrimaryText = DievasColourPrimitives.white;

  /// checkbox checkmark.
  static const int checkboxCheckmark = DievasColourPrimitives.white;

  /// radio dot.
  static const int radioDot = DievasColourPrimitives.white;

  /// progress on primary indicator.
  static const int progressOnPrimaryIndicator = DievasColourPrimitives.white;

  /// segmented control selected text.
  static const int segmentedControlSelectedText = DievasColourPrimitives.white;
}
