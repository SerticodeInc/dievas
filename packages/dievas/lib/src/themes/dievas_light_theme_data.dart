part of '../themes.dart';

/// Default Dievas light theme.
///
/// Uses Moon Piccolo branding and the neutral reference palette. This is the reference implementation and
/// the fallback theme for the gallery. Consumer apps do not subclass this —
/// they subclass [DievasGlobalThemeData] and provide their own brand tokens.
final class DievasLightThemeData extends DievasGlobalThemeData {
  DievasLightThemeData({super.components, super.typography}) : super(colours: _lightColours);

  static final DievasColourThemeData _lightColours = DievasColourThemeData(
    brightness: .light,
    core: const CoreColours(
      primary: Color(DievasColourSemanticLight.primary),
      badgePrimaryTintedBackground: Color(DievasColourSemanticLight.badgePrimaryTintedBackground),
    ),
    text: const TextColours(
      textPrimary: Color(DievasColourSemanticLight.textPrimary),
      textSecondary: Color(DievasColourSemanticLight.textSecondary),
      textTertiary: Color(DievasColourSemanticLight.textTertiary),
      textDisabled: Color(DievasColourSemanticLight.textDisabled),
      textInverse: Color(DievasColourSemanticLight.textInverse),
      buttonPrimaryText: Color(DievasColourSemanticLight.buttonPrimaryText),
    ),
    icon: const IconColours(
      iconPrimary: Color(DievasColourSemanticLight.iconPrimary),
      iconSecondary: Color(DievasColourSemanticLight.iconSecondary),
      iconDisabled: Color(DievasColourSemanticLight.iconDisabled),
      buttonPrimaryIcon: Color(DievasColourSemanticLight.buttonPrimaryIcon),
    ),
    background: const BackgroundColours(
      bottomSheetBackground: Color(DievasColourSemanticLight.bottomSheetBackground),
      tooltipBackground: Color(DievasColourSemanticLight.tooltipBackground),
      drawerBackground: Color(DievasColourSemanticLight.drawerBackground),
      menuBackground: Color(DievasColourSemanticLight.menuBackground),
      popoverBackground: Color(DievasColourSemanticLight.popoverBackground),
      snackbarBackground: Color(DievasColourSemanticLight.snackbarBackground),
      tagBackground: Color(DievasColourSemanticLight.tagBackground),
      badgeNeutralFilledBackground: Color(DievasColourSemanticLight.badgeNeutralFilledBackground),
      iconButtonFocusedBackground: Color(DievasColourSemanticLight.iconButtonFocusedBackground),
      listItemSelectedBackground: Color(DievasColourSemanticLight.listItemSelectedBackground),
      badgeNeutralTintedBackground: Color(DievasColourSemanticLight.badgeNeutralTintedBackground),
      iconButtonBackground: Color(DievasColourSemanticLight.iconButtonBackground),
      progressTrack: Color(DievasColourSemanticLight.progressTrack),
      segmentedControlBackground: Color(DievasColourSemanticLight.segmentedControlBackground),
      pageBackground: Color(DievasColourSemanticLight.pageBackground),
      cardBackground: Color(DievasColourSemanticLight.cardBackground),
      dialogBackground: Color(DievasColourSemanticLight.dialogBackground),
      modalBarrierBackground: Color(DievasColourSemanticLight.modalBarrierBackground),
    ),
    border: const BorderColours(
      dividerColour: Color(DievasColourSemanticLight.dividerColour),
      inputActiveBorder: Color(DievasColourSemanticLight.inputActiveBorder),
      inputDisabledBorder: Color(DievasColourSemanticLight.inputDisabledBorder),
      focusIndicatorColour: Color(DievasColourSemanticLight.focusIndicatorColour),
      selectionBorder: Color(DievasColourSemanticLight.selectionBorder),
    ),
    action: const ActionColours(
      badgePrimaryBackground: Color(DievasColourSemanticLight.badgePrimaryBackground),
      badgePrimaryTintedText: Color(DievasColourSemanticLight.badgePrimaryTintedText),
      checkboxCheckedBackground: Color(DievasColourSemanticLight.checkboxCheckedBackground),
      radioSelectedBackground: Color(DievasColourSemanticLight.radioSelectedBackground),
      progressIndicator: Color(DievasColourSemanticLight.progressIndicator),
      sliderActiveTrack: Color(DievasColourSemanticLight.sliderActiveTrack),
      inputCursor: Color(DievasColourSemanticLight.inputCursor),
      segmentedControlSelectedBackground: Color(DievasColourSemanticLight.segmentedControlSelectedBackground),
      tabSelectedIndicator: Color(DievasColourSemanticLight.tabSelectedIndicator),
      checkboxDisabledBackground: Color(DievasColourSemanticLight.checkboxDisabledBackground),
      radioDisabledBackground: Color(DievasColourSemanticLight.radioDisabledBackground),
      badgePrimaryText: Color(DievasColourSemanticLight.badgePrimaryText),
      checkboxCheckmark: Color(DievasColourSemanticLight.checkboxCheckmark),
      radioDot: Color(DievasColourSemanticLight.radioDot),
      progressOnPrimaryIndicator: Color(DievasColourSemanticLight.progressOnPrimaryIndicator),
      segmentedControlSelectedText: Color(DievasColourSemanticLight.segmentedControlSelectedText),
      buttonPrimaryBackground: Color(DievasColourSemanticLight.buttonPrimaryBackground),
      buttonPrimaryHoveredBackground: Color(DievasColourSemanticLight.buttonPrimaryHoveredBackground),
      buttonPrimaryPressedBackground: Color(DievasColourSemanticLight.buttonPrimaryPressedBackground),
      buttonPrimaryDisabledBackground: Color(DievasColourSemanticLight.buttonPrimaryDisabledBackground),
      buttonSecondaryBackground: Color(DievasColourSemanticLight.buttonSecondaryBackground),
      buttonSecondaryHoveredBackground: Color(DievasColourSemanticLight.buttonSecondaryHoveredBackground),
      buttonDestructiveBackground: Color(DievasColourSemanticLight.buttonDestructiveBackground),
      buttonDestructiveHoveredBackground: Color(DievasColourSemanticLight.buttonDestructiveHoveredBackground),
      buttonSuccessBackground: Color(DievasColourSemanticLight.buttonSuccessBackground),
    ),
    feedback: const FeedbackColours(
      feedbackSuccess: FeedbackColour(
        background: Color(DievasColourSemanticLight.alertSuccessBackground),
        border: Color(DievasColourSemanticLight.alertSuccessBorder),
        icon: Color(DievasColourSemanticLight.alertSuccessIcon),
        text: Color(DievasColourSemanticLight.alertSuccessText),
      ),
      feedbackWarning: FeedbackColour(
        background: Color(DievasColourSemanticLight.alertWarningBackground),
        border: Color(DievasColourSemanticLight.alertWarningBorder),
        icon: Color(DievasColourSemanticLight.alertWarningIcon),
        text: Color(DievasColourSemanticLight.alertWarningText),
      ),
      feedbackError: FeedbackColour(
        background: Color(DievasColourSemanticLight.alertErrorBackground),
        border: Color(DievasColourSemanticLight.alertErrorBorder),
        icon: Color(DievasColourSemanticLight.alertErrorIcon),
        text: Color(DievasColourSemanticLight.alertErrorText),
      ),
      feedbackInfo: FeedbackColour(
        background: Color(DievasColourSemanticLight.alertInfoBackground),
        border: Color(DievasColourSemanticLight.alertInfoBorder),
        icon: Color(DievasColourSemanticLight.alertInfoIcon),
        text: Color(DievasColourSemanticLight.alertInfoText),
      ),
    ),
    input: const InputColours(
      inputBackground: Color(DievasColourSemanticLight.inputBackground),
      inputBorder: Color(DievasColourSemanticLight.inputBorder),
      inputFocusedBorder: Color(DievasColourSemanticLight.inputFocusedBorder),
      inputErrorBorder: Color(DievasColourSemanticLight.inputErrorBorder),
      inputWarningBorder: Color(DievasColourSemanticLight.inputWarningBorder),
      inputText: Color(DievasColourSemanticLight.inputText),
      inputPlaceholderText: Color(DievasColourSemanticLight.inputPlaceholderText),
    ),
    surface: const SurfaceColours(
      canvasBackground: Color(DievasColourSemanticLight.canvasBackground),
      codeBlockBackground: Color(DievasColourSemanticLight.codeBlockBackground),
      sidebarBackground: Color(DievasColourSemanticLight.sidebarBackground),
      tableRowAlternateBackground: Color(DievasColourSemanticLight.tableRowAlternateBackground),
    ),
    switchColours: const SwitchColours(
      switchOnTrack: Color(DievasColourSemanticLight.switchOnTrack),
      switchOffTrack: Color(DievasColourSemanticLight.switchOffTrack),
      switchOnThumb: Color(DievasColourSemanticLight.switchOnThumb),
      switchOffThumb: Color(DievasColourSemanticLight.switchOffThumb),
    ),
    staticColours: const StaticColours(
      staticWhite: Color(DievasColourSemanticLight.staticWhite),
      staticBlack: Color(DievasColourSemanticLight.staticBlack),
      staticTransparent: Color(DievasColourSemanticLight.staticTransparent),
    ),
  );

  @override
  DievasThemeData copyWith({DievasComponentThemeData? components, DievasTypographyThemeData? typography}) =>
      DievasLightThemeData(components: components, typography: typography);
}
