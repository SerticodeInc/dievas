part of 'example_theme.dart';

/// Example App dark brand theme.
///
/// Mirror of [ExampleLightThemeData] using the dark colour set. Consumer apps
/// subclass [DievasGlobalThemeData] directly (as done here) rather than the
/// built-in [DievasDarkThemeData], so both modes carry the same brand.
///
/// The dark sheet is a clean neutral black (#171717 and its variants) with
/// the peach lifted a step so it still glows against the ink.
final class ExampleDarkThemeData extends DievasGlobalThemeData {
  ExampleDarkThemeData({super.components, DievasTypographyThemeData? typography})
    : super(
        colours: _darkColours,
        typography: typography ?? buildExampleTypography(textColor: _darkColours.text.textPrimary),
      );

  static const DievasColourThemeData _darkColours = DievasColourThemeData(
    brightness: .dark,
    core: CoreColours(
      primary: Color(ExampleColours.brandDark),
      badgePrimaryTintedBackground: Color(ExampleColours.brandSubtleDark),
      // White over the lifted dark peach, matching light mode so the filled CTA
      // reads the same either way.
    ),
    text: TextColours(
      textPrimary: Color(ExampleColours.warm50),
      textSecondary: Color(ExampleColours.warm400),
      textTertiary: Color(ExampleColours.warm500),
      textDisabled: Color(ExampleColours.warm600),
      // textInverse colours text on elevated surfaces (e.g. tooltips). In dark
      // mode those surfaces are light, so the inverse text must be dark.
      textInverse: Color(ExampleColours.warm900),
      buttonPrimaryText: Color(ExampleColours.actualWhite),
    ),
    icon: IconColours(
      iconPrimary: Color(ExampleColours.warm50),
      iconSecondary: Color(ExampleColours.warm400),
      iconDisabled: Color(ExampleColours.warm600),
      buttonPrimaryIcon: Color(ExampleColours.actualWhite),
    ),
    background: BackgroundColours(
      // Neutral #171717 scaffold, one step lighter per surface tier.
      pageBackground: Color(ExampleColours.inkBase),
      cardBackground: Color(ExampleColours.inkSubtle),
      listItemSelectedBackground: Color(ExampleColours.inkSubtle),
      badgeNeutralTintedBackground: Color(ExampleColours.inkSubtle),
      iconButtonBackground: Color(ExampleColours.inkSubtle),
      progressTrack: Color(ExampleColours.inkSubtle),
      segmentedControlBackground: Color(ExampleColours.inkSubtle),
      dialogBackground: Color(ExampleColours.inkElevated),
      bottomSheetBackground: Color(ExampleColours.inkElevated),
      tooltipBackground: Color(ExampleColours.inkElevated),
      drawerBackground: Color(ExampleColours.inkElevated),
      menuBackground: Color(ExampleColours.inkElevated),
      popoverBackground: Color(ExampleColours.inkElevated),
      snackbarBackground: Color(ExampleColours.inkElevated),
      tagBackground: Color(ExampleColours.inkElevated),
      badgeNeutralFilledBackground: Color(ExampleColours.inkElevated),
      iconButtonFocusedBackground: Color(ExampleColours.inkElevated),
      modalBarrierBackground: Color(ExampleColours.overlay),
    ),
    border: BorderColours(
      dividerColour: Color(ExampleColours.inkBorder),
      inputActiveBorder: Color(ExampleColours.warm400),
      inputDisabledBorder: Color(ExampleColours.inkBorder),
      focusIndicatorColour: Color(ExampleColours.brandDark),
      selectionBorder: Color(ExampleColours.brandDark),
    ),
    action: ActionColours(
      badgePrimaryText: Color(ExampleColours.actualWhite),
      checkboxCheckmark: Color(ExampleColours.actualWhite),
      progressOnPrimaryIndicator: Color(ExampleColours.actualWhite),
      radioDot: Color(ExampleColours.actualWhite),
      segmentedControlSelectedText: Color(ExampleColours.actualWhite),

      // Lighter peach on the way down the hover/press ramp: dark-mode
      // interaction brightens rather than darkens.
      buttonPrimaryBackground: Color(ExampleColours.brandDark),
      badgePrimaryBackground: Color(ExampleColours.brandDark),
      badgePrimaryTintedText: Color(ExampleColours.brandDark),
      checkboxCheckedBackground: Color(ExampleColours.brandDark),
      radioSelectedBackground: Color(ExampleColours.brandDark),
      progressIndicator: Color(ExampleColours.brandDark),
      sliderActiveTrack: Color(ExampleColours.brandDark),
      inputCursor: Color(ExampleColours.brandDark),
      segmentedControlSelectedBackground: Color(ExampleColours.brandDark),
      tabSelectedIndicator: Color(ExampleColours.brandDark),
      buttonPrimaryHoveredBackground: Color(ExampleColours.peachDarkHover),
      buttonPrimaryPressedBackground: Color(ExampleColours.peachDarkActive),
      buttonPrimaryDisabledBackground: Color(ExampleColours.inkElevated),
      checkboxDisabledBackground: Color(ExampleColours.inkElevated),
      radioDisabledBackground: Color(ExampleColours.inkElevated),
      buttonSecondaryBackground: Color(ExampleColours.indigo950),
      buttonSecondaryHoveredBackground: Color(ExampleColours.indigo900),
      buttonDestructiveBackground: Color(ExampleColours.errorDark),
      buttonDestructiveHoveredBackground: Color(ExampleColours.errorHoverDark),
      buttonSuccessBackground: Color(ExampleColours.successDark),
    ),
    feedback: FeedbackColours(
      feedbackSuccess: FeedbackColour(
        background: Color(ExampleColours.successBgDark),
        border: Color(ExampleColours.successBorderDark),
        icon: Color(ExampleColours.successIconDark),
        text: Color(ExampleColours.successTextDark),
      ),
      feedbackWarning: FeedbackColour(
        background: Color(ExampleColours.warningBgDark),
        border: Color(ExampleColours.warningBorderDark),
        icon: Color(ExampleColours.warningIconDark),
        text: Color(ExampleColours.warningTextDark),
      ),
      feedbackError: FeedbackColour(
        background: Color(ExampleColours.errorBgDark),
        border: Color(ExampleColours.errorBorderDark),
        icon: Color(ExampleColours.errorIconDark),
        text: Color(ExampleColours.errorTextDark),
      ),
      feedbackInfo: FeedbackColour(
        background: Color(ExampleColours.infoBgDark),
        border: Color(ExampleColours.infoBorderDark),
        icon: Color(ExampleColours.infoIconDark),
        text: Color(ExampleColours.infoTextDark),
      ),
    ),
    input: InputColours(
      inputBackground: Color(ExampleColours.inkInputBg),
      inputBorder: Color(ExampleColours.inkInputBorder),
      inputFocusedBorder: Color(ExampleColours.brandDark),
      inputErrorBorder: Color(ExampleColours.inputBorderErrorDark),
      inputWarningBorder: Color(ExampleColours.inputBorderWarningDark),
      inputText: Color(ExampleColours.warm50),
      inputPlaceholderText: Color(ExampleColours.warm500),
    ),
    surface: SurfaceColours(
      canvasBackground: Color(ExampleColours.inkBase),
      codeBlockBackground: Color(ExampleColours.inkSubtle),
      sidebarBackground: Color(ExampleColours.inkSubtle),
      tableRowAlternateBackground: Color(ExampleColours.inkElevated),
    ),
    switchColours: SwitchColours(
      switchOnTrack: Color(ExampleColours.brandDark),
      switchOffTrack: Color(ExampleColours.inkBorder),
      switchOnThumb: Color(ExampleColours.actualWhite),
      switchOffThumb: Color(ExampleColours.warm400),
    ),
    staticColours: StaticColours(
      staticWhite: Color(ExampleColours.actualWhite),
      staticBlack: Color(ExampleColours.staticBlack),
      staticTransparent: Color(ExampleColours.transparent),
    ),
  );

  @override
  DievasThemeData copyWith({DievasComponentThemeData? components, DievasTypographyThemeData? typography}) =>
      ExampleDarkThemeData(components: components, typography: typography);
}
