// Light theme semantic colour tokens for the Dievas design system. Every
// constant is an ARGB int aliased from DievasColourPrimitives; the Color()
// wrapper is applied in the dievas Flutter package.

import 'package:dievas_tokens/src/primitives/colour_primitives.dart';

/// Light theme semantic colour tokens. Brand and neutral reference roles use Moon colours.
/// Interactive brand shades derive from Piccolo; feedback roles retain
/// their Dievas mappings. Values reference [DievasColourPrimitives].
abstract final class DievasColourSemanticLight {
  //Brand

  /// Primary palette identity. Component roles below name each usage.
  static const int primary = DievasColourPrimitives.royalPurple;

  /// Background of a tinted badge using the primary palette.
  static const int badgePrimaryTintedBackground = DievasColourPrimitives.royalPurpleAlpha1F;

  /// Text on a filled primary button.
  static const int buttonPrimaryText = DievasColourPrimitives.white;

  //Text

  /// Highest contrast body text. Headlines, labels, primary copy.
  /// Moon ref: bulma
  static const int textPrimary = DievasColourPrimitives.black;

  /// Secondary / supporting copy. Subtitles, captions, metadata.
  /// Moon ref: trunks
  static const int textSecondary = DievasColourPrimitives.steelGrey;

  /// Tertiary / placeholder level text. Hints, helper copy.
  static const int textTertiary = DievasColourPrimitives.slate400;

  /// Text on disabled interactive elements.
  static const int textDisabled = DievasColourPrimitives.slate300;

  /// Text on dark / inverted surfaces (overlays, toasts).
  static const int textInverse = DievasColourPrimitives.white;

  //Icon

  /// Default icon fill on light backgrounds.
  static const int iconPrimary = DievasColourPrimitives.black;

  /// Muted / secondary icons.
  static const int iconSecondary = DievasColourPrimitives.steelGrey;

  /// Icons on disabled controls.
  static const int iconDisabled = DievasColourPrimitives.slate300;

  /// Icons placed on a [primary]-coloured surface.
  static const int buttonPrimaryIcon = DievasColourPrimitives.white;

  //Background

  /// Page / scaffold background. The base layer.
  /// Moon ref: goku
  static const int pageBackground = DievasColourPrimitives.white;

  /// Card background.
  /// Moon ref: gohan
  static const int cardBackground = DievasColourPrimitives.nearWhite;

  /// Dialog background.
  static const int dialogBackground = DievasColourPrimitives.white;

  /// Scrim / overlay behind modals and bottom sheets.
  /// Moon ref: zeno. Alpha is exactly 0x8F.
  static const int modalBarrierBackground = DievasColourPrimitives.blackAlpha8F;

  //Surface

  /// Canvas / drawing surface. Distinguishable from [pageBackground] for creative
  /// workspaces, whiteboards, and illustration areas.
  static const int canvasBackground = DievasColourPrimitives.white;

  /// Code block / inline code background. Visually distinct from [pageBackground]
  /// so code stands apart from surrounding content.
  static const int codeBlockBackground = DievasColourPrimitives.slate100;

  /// Sidebar / navigation rail background. Provides a visual anchor for
  /// persistent navigation alongside the main content area.
  static const int sidebarBackground = DievasColourPrimitives.white;

  /// Alternating table row background. Applied to every other row for
  /// horizontal scanability in data tables and list views.
  static const int tableRowAlternateBackground = DievasColourPrimitives.slate50;

  //Border

  /// Divider stroke colour.
  /// Moon ref: beerus
  static const int dividerColour = DievasColourPrimitives.coolGreyLight;

  /// High emphasis borders. Active input outlines, selected containers.
  static const int inputActiveBorder = DievasColourPrimitives.slate900;

  /// Borders on disabled inputs and containers.
  static const int inputDisabledBorder = DievasColourPrimitives.slate200;

  /// Focus ring. Applied on keyboard focus.
  static const int focusIndicatorColour = DievasColourPrimitives.royalPurple;

  /// Brand coloured border. Selected states, brand highlights.
  static const int selectionBorder = DievasColourPrimitives.royalPurple;

  //Action

  /// Primary CTA background (filled button, active toggle).
  static const int buttonPrimaryBackground = DievasColourPrimitives.royalPurple;

  /// Hover state of [buttonPrimaryBackground].
  static const int buttonPrimaryHoveredBackground = DievasColourPrimitives.royalPurpleShade8;

  /// Pressed / active state of [buttonPrimaryBackground].
  static const int buttonPrimaryPressedBackground = DievasColourPrimitives.royalPurpleShade16;

  /// Disabled primary action surface.
  static const int buttonPrimaryDisabledBackground = DievasColourPrimitives.slate200;

  /// Secondary action background (outlined / ghost button resting surface).
  static const int buttonSecondaryBackground = DievasColourPrimitives.royalPurpleAlpha14;

  /// Hover state of [buttonSecondaryBackground].
  static const int buttonSecondaryHoveredBackground = DievasColourPrimitives.royalPurpleAlpha1F;

  /// Destructive / error action.
  static const int buttonDestructiveBackground = DievasColourPrimitives.red500;

  /// Hover state of [buttonDestructiveBackground].
  static const int buttonDestructiveHoveredBackground = DievasColourPrimitives.red600;

  /// Success / constructive action surface.
  static const int buttonSuccessBackground = DievasColourPrimitives.green500;

  //Success

  /// Success alert / toast background.
  static const int alertSuccessBackground = DievasColourPrimitives.green50;

  /// Success border.
  static const int alertSuccessBorder = DievasColourPrimitives.green200;

  /// Success icon fill.
  static const int alertSuccessIcon = DievasColourPrimitives.green600;

  /// Success body text.
  static const int alertSuccessText = DievasColourPrimitives.green900;

  //Warning

  /// Warning alert background.
  static const int alertWarningBackground = DievasColourPrimitives.amber50;

  /// Warning border.
  static const int alertWarningBorder = DievasColourPrimitives.amber200;

  /// Warning icon fill.
  static const int alertWarningIcon = DievasColourPrimitives.amber600;

  /// Warning body text.
  static const int alertWarningText = DievasColourPrimitives.amber900;

  //Error

  /// Error alert background.
  static const int alertErrorBackground = DievasColourPrimitives.red50;

  /// Error border.
  static const int alertErrorBorder = DievasColourPrimitives.red200;

  /// Error icon fill.
  static const int alertErrorIcon = DievasColourPrimitives.red600;

  /// Error body text.
  static const int alertErrorText = DievasColourPrimitives.red900;

  //Info

  /// Informational alert background.
  static const int alertInfoBackground = DievasColourPrimitives.sky50;

  /// Info border.
  static const int alertInfoBorder = DievasColourPrimitives.sky200;

  /// Info icon fill.
  static const int alertInfoIcon = DievasColourPrimitives.sky600;

  /// Info body text.
  static const int alertInfoText = DievasColourPrimitives.sky900;

  //Input

  /// Input field background surface.
  static const int inputBackground = DievasColourPrimitives.white;

  /// Default input border.
  static const int inputBorder = DievasColourPrimitives.slate300;

  /// Input border when focused.
  static const int inputFocusedBorder = DievasColourPrimitives.royalPurple;

  /// Input border in error state.
  static const int inputErrorBorder = DievasColourPrimitives.red500;

  /// Input border in warning state.
  static const int inputWarningBorder = DievasColourPrimitives.amber500;

  /// Input text colour (typed value).
  static const int inputText = DievasColourPrimitives.black;

  /// Input placeholder / hint text colour.
  static const int inputPlaceholderText = DievasColourPrimitives.slate400;

  //Switch

  /// Track colour when the switch is ON.
  static const int switchOnTrack = DievasColourPrimitives.royalPurple;

  /// Track colour when the switch is OFF.
  static const int switchOffTrack = DievasColourPrimitives.slate200;

  /// Thumb (knob) colour when the switch is ON.
  static const int switchOnThumb = DievasColourPrimitives.white;

  /// Thumb (knob) colour when the switch is OFF.
  static const int switchOffThumb = DievasColourPrimitives.slate300;

  //Static

  /// Pure white. Theme invariant. Never flips in dark mode.
  static const int staticWhite = DievasColourPrimitives.white;

  /// Pure black. Theme invariant.
  static const int staticBlack = DievasColourPrimitives.black;

  /// Fully transparent. Useful for animation start/end states.
  static const int staticTransparent = DievasColourPrimitives.transparent;
  // Component colours

  /// bottom sheet background.
  static const int bottomSheetBackground = DievasColourPrimitives.white;

  /// tooltip background.
  static const int tooltipBackground = DievasColourPrimitives.white;

  /// drawer background.
  static const int drawerBackground = DievasColourPrimitives.white;

  /// menu background.
  static const int menuBackground = DievasColourPrimitives.white;

  /// Neutral menu hover overlay. Moon ref: heles.
  static const int menuHoveredBackground = DievasColourPrimitives.blackAlpha0A;

  /// popover background.
  static const int popoverBackground = DievasColourPrimitives.white;

  /// snackbar background.
  static const int snackbarBackground = DievasColourPrimitives.white;

  /// tag background.
  static const int tagBackground = DievasColourPrimitives.white;

  /// badge neutral filled background.
  static const int badgeNeutralFilledBackground = DievasColourPrimitives.white;

  /// icon button focused background.
  static const int iconButtonFocusedBackground = DievasColourPrimitives.white;

  /// list item selected background.
  static const int listItemSelectedBackground = DievasColourPrimitives.nearWhite;

  /// badge neutral tinted background.
  static const int badgeNeutralTintedBackground = DievasColourPrimitives.nearWhite;

  /// icon button background.
  static const int iconButtonBackground = DievasColourPrimitives.nearWhite;

  /// progress track.
  static const int progressTrack = DievasColourPrimitives.nearWhite;

  /// segmented control background.
  static const int segmentedControlBackground = DievasColourPrimitives.nearWhite;

  /// badge primary background.
  static const int badgePrimaryBackground = DievasColourPrimitives.royalPurple;

  /// badge primary tinted text.
  static const int badgePrimaryTintedText = DievasColourPrimitives.royalPurple;

  /// checkbox checked background.
  static const int checkboxCheckedBackground = DievasColourPrimitives.royalPurple;

  /// radio selected background.
  static const int radioSelectedBackground = DievasColourPrimitives.royalPurple;

  /// progress indicator.
  static const int progressIndicator = DievasColourPrimitives.royalPurple;

  /// slider active track.
  static const int sliderActiveTrack = DievasColourPrimitives.royalPurple;

  /// input cursor.
  static const int inputCursor = DievasColourPrimitives.royalPurple;

  /// segmented control selected background.
  static const int segmentedControlSelectedBackground = DievasColourPrimitives.royalPurple;

  /// tab selected indicator.
  static const int tabSelectedIndicator = DievasColourPrimitives.royalPurple;

  /// checkbox disabled background.
  static const int checkboxDisabledBackground = DievasColourPrimitives.slate200;

  /// radio disabled background.
  static const int radioDisabledBackground = DievasColourPrimitives.slate200;

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
