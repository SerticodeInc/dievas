part of 'example_theme.dart';

/// Example App dark brand theme.
///
/// Mirror of [ExampleLightThemeData] using the dark colour set. Consumer apps
/// subclass [DievasGlobalThemeData] directly (as done here) rather than the
/// built-in [DievasDarkThemeData], so both modes carry the same brand.
///
/// The dark sheet is a clean neutral black — #171717 and its variants — with
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
      brand: Color(ExampleColours.brandDark),
      brandSubtle: Color(ExampleColours.brandSubtleDark),
      onBrand: Color(ExampleColours.onBrand),
    ),
    text: TextColours(
      textPrimary: Color(ExampleColours.warm50),
      textSecondary: Color(ExampleColours.warm400),
      textTertiary: Color(ExampleColours.warm500),
      textDisabled: Color(ExampleColours.warm600),
      // textInverse colours text on elevated surfaces (e.g. tooltips). In dark
      // mode those surfaces are light, so the inverse text must be dark.
      textInverse: Color(ExampleColours.warm900),
      textOnBrand: Color(ExampleColours.onBrand),
    ),
    icon: IconColours(
      iconPrimary: Color(ExampleColours.warm50),
      iconSecondary: Color(ExampleColours.warm400),
      iconDisabled: Color(ExampleColours.warm600),
      iconOnBrand: Color(ExampleColours.onBrand),
    ),
    background: BackgroundColours(
      // Neutral #171717 scaffold, one step lighter per surface tier.
      bgBase: Color(ExampleColours.inkBase),
      bgSubtle: Color(ExampleColours.inkSubtle),
      bgElevated: Color(ExampleColours.inkElevated),
      bgOverlay: Color(ExampleColours.overlay),
    ),
    border: BorderColours(
      borderDefault: Color(ExampleColours.inkBorder),
      borderStrong: Color(ExampleColours.warm400),
      borderDisabled: Color(ExampleColours.inkBorder),
      borderFocus: Color(ExampleColours.brandDark),
      borderBrand: Color(ExampleColours.brandDark),
    ),
    action: ActionColours(
      // Lighter peach on the way down the hover/press ramp — dark-mode
      // interaction brightens rather than darkens.
      actionPrimary: Color(ExampleColours.brandDark),
      actionPrimaryHover: Color(ExampleColours.peachDarkHover),
      actionPrimaryActive: Color(ExampleColours.peachDarkActive),
      actionPrimaryDisabled: Color(ExampleColours.inkElevated),
      actionSecondary: Color(ExampleColours.indigo950),
      actionSecondaryHover: Color(ExampleColours.indigo900),
      actionError: Color(ExampleColours.errorDark),
      actionErrorHover: Color(ExampleColours.errorHoverDark),
      actionSuccess: Color(ExampleColours.successDark),
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
      inputBg: Color(ExampleColours.inkInputBg),
      inputBorder: Color(ExampleColours.inkInputBorder),
      inputBorderFocus: Color(ExampleColours.brandDark),
      inputBorderError: Color(ExampleColours.inputBorderErrorDark),
      inputBorderWarning: Color(ExampleColours.inputBorderWarningDark),
      inputText: Color(ExampleColours.warm50),
      inputPlaceholder: Color(ExampleColours.warm500),
    ),
    surface: SurfaceColours(
      surfaceCanvas: Color(ExampleColours.inkBase),
      surfaceCode: Color(ExampleColours.inkSubtle),
      surfaceSidebar: Color(ExampleColours.inkSubtle),
      surfaceTableStriped: Color(ExampleColours.inkElevated),
    ),
    switchColours: SwitchColours(
      switchTrackOn: Color(ExampleColours.brandDark),
      switchTrackOff: Color(ExampleColours.inkBorder),
      switchThumbOn: Color(ExampleColours.actualWhite),
      switchThumbOff: Color(ExampleColours.warm400),
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
