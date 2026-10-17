part of '../themes.dart';

/// Default Dievas dark theme.
///
/// Uses Moon Piccolo branding and the dark neutral reference palette. Mirror of [DievasLightThemeData] using
/// [DievasColourSemanticDark] token values. Consumer apps do not subclass this —
/// they subclass [DievasGlobalThemeData] with their own brand tokens.
final class DievasDarkThemeData extends DievasGlobalThemeData {
  DievasDarkThemeData({super.components, super.typography}) : super(colours: _darkColours);

  static final DievasColourThemeData _darkColours = DievasColourThemeData(
    brightness: .dark,
    core: const CoreColours(
      primary: Color(DievasColourSemanticDark.primary),
      badgePrimaryTintedBackground: Color(DievasColourSemanticDark.badgePrimaryTintedBackground),
    ),
    text: const TextColours(
      textPrimary: Color(DievasColourSemanticDark.textPrimary),
      textSecondary: Color(DievasColourSemanticDark.textSecondary),
      textTertiary: Color(DievasColourSemanticDark.textTertiary),
      textDisabled: Color(DievasColourSemanticDark.textDisabled),
      textInverse: Color(DievasColourSemanticDark.textInverse),
      buttonPrimaryText: Color(DievasColourSemanticDark.buttonPrimaryText),
    ),
    icon: const IconColours(
      iconPrimary: Color(DievasColourSemanticDark.iconPrimary),
      iconSecondary: Color(DievasColourSemanticDark.iconSecondary),
      iconDisabled: Color(DievasColourSemanticDark.iconDisabled),
      buttonPrimaryIcon: Color(DievasColourSemanticDark.buttonPrimaryIcon),
    ),
    background: const BackgroundColours(
      bottomSheetBackground: Color(DievasColourSemanticDark.bottomSheetBackground),
      tooltipBackground: Color(DievasColourSemanticDark.tooltipBackground),
      drawerBackground: Color(DievasColourSemanticDark.drawerBackground),
      menuBackground: Color(DievasColourSemanticDark.menuBackground),
      popoverBackground: Color(DievasColourSemanticDark.popoverBackground),
      snackbarBackground: Color(DievasColourSemanticDark.snackbarBackground),
      tagBackground: Color(DievasColourSemanticDark.tagBackground),
      badgeNeutralFilledBackground: Color(DievasColourSemanticDark.badgeNeutralFilledBackground),
      iconButtonFocusedBackground: Color(DievasColourSemanticDark.iconButtonFocusedBackground),
      listItemSelectedBackground: Color(DievasColourSemanticDark.listItemSelectedBackground),
      badgeNeutralTintedBackground: Color(DievasColourSemanticDark.badgeNeutralTintedBackground),
      iconButtonBackground: Color(DievasColourSemanticDark.iconButtonBackground),
      progressTrack: Color(DievasColourSemanticDark.progressTrack),
      segmentedControlBackground: Color(DievasColourSemanticDark.segmentedControlBackground),
      pageBackground: Color(DievasColourSemanticDark.pageBackground),
      cardBackground: Color(DievasColourSemanticDark.cardBackground),
      dialogBackground: Color(DievasColourSemanticDark.dialogBackground),
      modalBarrierBackground: Color(DievasColourSemanticDark.modalBarrierBackground),
    ),
    border: const BorderColours(
      dividerColour: Color(DievasColourSemanticDark.dividerColour),
      inputActiveBorder: Color(DievasColourSemanticDark.inputActiveBorder),
      inputDisabledBorder: Color(DievasColourSemanticDark.inputDisabledBorder),
      focusIndicatorColour: Color(DievasColourSemanticDark.focusIndicatorColour),
      selectionBorder: Color(DievasColourSemanticDark.selectionBorder),
    ),
    action: const ActionColours(
      badgePrimaryBackground: Color(DievasColourSemanticDark.badgePrimaryBackground),
      badgePrimaryTintedText: Color(DievasColourSemanticDark.badgePrimaryTintedText),
      checkboxCheckedBackground: Color(DievasColourSemanticDark.checkboxCheckedBackground),
      radioSelectedBackground: Color(DievasColourSemanticDark.radioSelectedBackground),
      progressIndicator: Color(DievasColourSemanticDark.progressIndicator),
      sliderActiveTrack: Color(DievasColourSemanticDark.sliderActiveTrack),
      inputCursor: Color(DievasColourSemanticDark.inputCursor),
      segmentedControlSelectedBackground: Color(DievasColourSemanticDark.segmentedControlSelectedBackground),
      tabSelectedIndicator: Color(DievasColourSemanticDark.tabSelectedIndicator),
      checkboxDisabledBackground: Color(DievasColourSemanticDark.checkboxDisabledBackground),
      radioDisabledBackground: Color(DievasColourSemanticDark.radioDisabledBackground),
      badgePrimaryText: Color(DievasColourSemanticDark.badgePrimaryText),
      checkboxCheckmark: Color(DievasColourSemanticDark.checkboxCheckmark),
      radioDot: Color(DievasColourSemanticDark.radioDot),
      progressOnPrimaryIndicator: Color(DievasColourSemanticDark.progressOnPrimaryIndicator),
      segmentedControlSelectedText: Color(DievasColourSemanticDark.segmentedControlSelectedText),
      buttonPrimaryBackground: Color(DievasColourSemanticDark.buttonPrimaryBackground),
      buttonPrimaryHoveredBackground: Color(DievasColourSemanticDark.buttonPrimaryHoveredBackground),
      buttonPrimaryPressedBackground: Color(DievasColourSemanticDark.buttonPrimaryPressedBackground),
      buttonPrimaryDisabledBackground: Color(DievasColourSemanticDark.buttonPrimaryDisabledBackground),
      buttonSecondaryBackground: Color(DievasColourSemanticDark.buttonSecondaryBackground),
      buttonSecondaryHoveredBackground: Color(DievasColourSemanticDark.buttonSecondaryHoveredBackground),
      buttonDestructiveBackground: Color(DievasColourSemanticDark.buttonDestructiveBackground),
      buttonDestructiveHoveredBackground: Color(DievasColourSemanticDark.buttonDestructiveHoveredBackground),
      buttonSuccessBackground: Color(DievasColourSemanticDark.buttonSuccessBackground),
    ),
    feedback: const FeedbackColours(
      feedbackSuccess: FeedbackColour(
        background: Color(DievasColourSemanticDark.alertSuccessBackground),
        border: Color(DievasColourSemanticDark.alertSuccessBorder),
        icon: Color(DievasColourSemanticDark.alertSuccessIcon),
        text: Color(DievasColourSemanticDark.alertSuccessText),
      ),
      feedbackWarning: FeedbackColour(
        background: Color(DievasColourSemanticDark.alertWarningBackground),
        border: Color(DievasColourSemanticDark.alertWarningBorder),
        icon: Color(DievasColourSemanticDark.alertWarningIcon),
        text: Color(DievasColourSemanticDark.alertWarningText),
      ),
      feedbackError: FeedbackColour(
        background: Color(DievasColourSemanticDark.alertErrorBackground),
        border: Color(DievasColourSemanticDark.alertErrorBorder),
        icon: Color(DievasColourSemanticDark.alertErrorIcon),
        text: Color(DievasColourSemanticDark.alertErrorText),
      ),
      feedbackInfo: FeedbackColour(
        background: Color(DievasColourSemanticDark.alertInfoBackground),
        border: Color(DievasColourSemanticDark.alertInfoBorder),
        icon: Color(DievasColourSemanticDark.alertInfoIcon),
        text: Color(DievasColourSemanticDark.alertInfoText),
      ),
    ),
    input: const InputColours(
      inputBackground: Color(DievasColourSemanticDark.inputBackground),
      inputBorder: Color(DievasColourSemanticDark.inputBorder),
      inputFocusedBorder: Color(DievasColourSemanticDark.inputFocusedBorder),
      inputErrorBorder: Color(DievasColourSemanticDark.inputErrorBorder),
      inputWarningBorder: Color(DievasColourSemanticDark.inputWarningBorder),
      inputText: Color(DievasColourSemanticDark.inputText),
      inputPlaceholderText: Color(DievasColourSemanticDark.inputPlaceholderText),
    ),
    surface: const SurfaceColours(
      canvasBackground: Color(DievasColourSemanticDark.canvasBackground),
      codeBlockBackground: Color(DievasColourSemanticDark.codeBlockBackground),
      sidebarBackground: Color(DievasColourSemanticDark.sidebarBackground),
      tableRowAlternateBackground: Color(DievasColourSemanticDark.tableRowAlternateBackground),
    ),
    switchColours: const SwitchColours(
      switchOnTrack: Color(DievasColourSemanticDark.switchOnTrack),
      switchOffTrack: Color(DievasColourSemanticDark.switchOffTrack),
      switchOnThumb: Color(DievasColourSemanticDark.switchOnThumb),
      switchOffThumb: Color(DievasColourSemanticDark.switchOffThumb),
    ),
    staticColours: const StaticColours(
      staticWhite: Color(DievasColourSemanticDark.staticWhite),
      staticBlack: Color(DievasColourSemanticDark.staticBlack),
      staticTransparent: Color(DievasColourSemanticDark.staticTransparent),
    ),
  );

  @override
  DievasThemeData copyWith({DievasComponentThemeData? components, DievasTypographyThemeData? typography}) =>
      DievasDarkThemeData(components: components, typography: typography);
}
