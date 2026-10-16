part of 'example_theme.dart';

/// Example App light brand theme.
///
/// Extends [DievasGlobalThemeData] and supplies the light colour set plus a
/// brand typography built over the Dievas type ramp. Everything else ,
/// component theme data, elevation, Material bridge, is derived automatically
/// inside the constructor.
///
/// Copy this file to create your own brand's light theme: swap
/// [ExampleColours] for your tokens and pass a brand `typography`.
final class ExampleLightThemeData extends DievasGlobalThemeData {
  ExampleLightThemeData({super.components, DievasTypographyThemeData? typography})
    : super(
        colours: _lightColours,
        typography: typography ?? buildExampleTypography(textColor: _lightColours.text.textPrimary),
      );

  static const DievasColourThemeData _lightColours = DievasColourThemeData(
    brightness: .light,
    core: CoreColours(
      primary: Color(ExampleColours.primary),
      badgePrimaryTintedBackground: Color(ExampleColours.badgePrimaryTintedBackground),
      // White over the peach: the filled CTA is the brightest object on the
      // sheet. Dark mode matches this rather than inverting.
    ),
    text: TextColours(
      textPrimary: Color(ExampleColours.warm900),
      textSecondary: Color(ExampleColours.warm600),
      textTertiary: Color(ExampleColours.warm500),
      textDisabled: Color(ExampleColours.warm300),
      // textInverse colours text on elevated surfaces (e.g. tooltips). In light
      // mode those surfaces are dark, so the inverse text must be light.
      textInverse: Color(ExampleColours.warm50),
      buttonPrimaryText: Color(ExampleColours.actualWhite),
    ),
    icon: IconColours(
      iconPrimary: Color(ExampleColours.warm900),
      iconSecondary: Color(ExampleColours.warm600),
      iconDisabled: Color(ExampleColours.warm300),
      buttonPrimaryIcon: Color(ExampleColours.actualWhite),
    ),
    background: BackgroundColours(
      // Warm paper scaffold with clean white cards on top.
      pageBackground: Color(ExampleColours.warm50),
      cardBackground: Color(ExampleColours.actualWhite),
      listItemSelectedBackground: Color(ExampleColours.actualWhite),
      badgeNeutralTintedBackground: Color(ExampleColours.actualWhite),
      iconButtonBackground: Color(ExampleColours.actualWhite),
      progressTrack: Color(ExampleColours.actualWhite),
      segmentedControlBackground: Color(ExampleColours.actualWhite),
      dialogBackground: Color(ExampleColours.actualWhite),
      bottomSheetBackground: Color(ExampleColours.actualWhite),
      tooltipBackground: Color(ExampleColours.actualWhite),
      drawerBackground: Color(ExampleColours.actualWhite),
      menuBackground: Color(ExampleColours.actualWhite),
      popoverBackground: Color(ExampleColours.actualWhite),
      snackbarBackground: Color(ExampleColours.actualWhite),
      tagBackground: Color(ExampleColours.actualWhite),
      badgeNeutralFilledBackground: Color(ExampleColours.actualWhite),
      iconButtonFocusedBackground: Color(ExampleColours.actualWhite),
      modalBarrierBackground: Color(ExampleColours.overlay),
    ),
    border: BorderColours(
      dividerColour: Color(ExampleColours.warm200),
      inputActiveBorder: Color(ExampleColours.warm900),
      inputDisabledBorder: Color(ExampleColours.warm200),
      focusIndicatorColour: Color(ExampleColours.peach500),
      selectionBorder: Color(ExampleColours.peach500),
    ),
    action: ActionColours(
      badgePrimaryText: Color(ExampleColours.actualWhite),
      checkboxCheckmark: Color(ExampleColours.actualWhite),
      progressOnPrimaryIndicator: Color(ExampleColours.actualWhite),
      radioDot: Color(ExampleColours.actualWhite),
      segmentedControlSelectedText: Color(ExampleColours.actualWhite),

      buttonPrimaryBackground: Color(ExampleColours.peach500),
      badgePrimaryBackground: Color(ExampleColours.peach500),
      badgePrimaryTintedText: Color(ExampleColours.peach500),
      checkboxCheckedBackground: Color(ExampleColours.peach500),
      radioSelectedBackground: Color(ExampleColours.peach500),
      progressIndicator: Color(ExampleColours.peach500),
      sliderActiveTrack: Color(ExampleColours.peach500),
      inputCursor: Color(ExampleColours.peach500),
      segmentedControlSelectedBackground: Color(ExampleColours.peach500),
      tabSelectedIndicator: Color(ExampleColours.peach500),
      buttonPrimaryHoveredBackground: Color(ExampleColours.peach600),
      buttonPrimaryPressedBackground: Color(ExampleColours.peach700),
      buttonPrimaryDisabledBackground: Color(ExampleColours.warm200),
      checkboxDisabledBackground: Color(ExampleColours.warm200),
      radioDisabledBackground: Color(ExampleColours.warm200),
      // The theme wall's dark-sheet indigo, surfaced as a whisper-quiet tint.
      buttonSecondaryBackground: Color(ExampleColours.indigo50),
      buttonSecondaryHoveredBackground: Color(ExampleColours.indigo100),
      buttonDestructiveBackground: Color(ExampleColours.error),
      buttonDestructiveHoveredBackground: Color(ExampleColours.errorHover),
      buttonSuccessBackground: Color(ExampleColours.success),
    ),
    feedback: FeedbackColours(
      feedbackSuccess: FeedbackColour(
        background: Color(ExampleColours.successBg),
        border: Color(ExampleColours.successBorder),
        icon: Color(ExampleColours.successIcon),
        text: Color(ExampleColours.successText),
      ),
      feedbackWarning: FeedbackColour(
        background: Color(ExampleColours.warningBg),
        border: Color(ExampleColours.warningBorder),
        icon: Color(ExampleColours.warningIcon),
        text: Color(ExampleColours.warningText),
      ),
      feedbackError: FeedbackColour(
        background: Color(ExampleColours.errorBg),
        border: Color(ExampleColours.errorBorder),
        icon: Color(ExampleColours.errorIcon),
        text: Color(ExampleColours.errorText),
      ),
      feedbackInfo: FeedbackColour(
        background: Color(ExampleColours.infoBg),
        border: Color(ExampleColours.infoBorder),
        icon: Color(ExampleColours.infoIcon),
        text: Color(ExampleColours.infoText),
      ),
    ),
    input: InputColours(
      inputBackground: Color(ExampleColours.actualWhite),
      inputBorder: Color(ExampleColours.warm300),
      inputFocusedBorder: Color(ExampleColours.peach500),
      inputErrorBorder: Color(ExampleColours.inputErrorBorder),
      inputWarningBorder: Color(ExampleColours.inputWarningBorder),
      inputText: Color(ExampleColours.warm900),
      inputPlaceholderText: Color(ExampleColours.warm500),
    ),
    surface: SurfaceColours(
      canvasBackground: Color(ExampleColours.actualWhite),
      codeBlockBackground: Color(ExampleColours.warm100),
      sidebarBackground: Color(ExampleColours.warm100),
      tableRowAlternateBackground: Color(ExampleColours.warm100),
    ),
    switchColours: SwitchColours(
      switchOnTrack: Color(ExampleColours.peach500),
      switchOffTrack: Color(ExampleColours.warm200),
      switchOnThumb: Color(ExampleColours.actualWhite),
      switchOffThumb: Color(ExampleColours.warm300),
    ),
    staticColours: StaticColours(
      staticWhite: Color(ExampleColours.actualWhite),
      staticBlack: Color(ExampleColours.staticBlack),
      staticTransparent: Color(ExampleColours.transparent),
    ),
  );

  @override
  DievasThemeData copyWith({DievasComponentThemeData? components, DievasTypographyThemeData? typography}) =>
      ExampleLightThemeData(components: components, typography: typography);
}
