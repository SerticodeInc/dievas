part of 'example_theme.dart';

/// Example App light brand theme.
///
/// Extends [DievasGlobalThemeData] and supplies the light colour set plus a
/// brand typography built over the Dievas type ramp. Everything else —
/// component theme data, elevation, Material bridge — is derived automatically
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
      brand: Color(ExampleColours.brand),
      brandSubtle: Color(ExampleColours.brandSubtle),
      // Espresso over peach — see ExampleColours.onBrand. White would only
      // reach ~3.1:1 here, which is fine for a tag but not a button label.
      onBrand: Color(ExampleColours.onBrand),
    ),
    text: TextColours(
      textPrimary: Color(ExampleColours.warm900),
      textSecondary: Color(ExampleColours.warm600),
      textTertiary: Color(ExampleColours.warm500),
      textDisabled: Color(ExampleColours.warm300),
      // textInverse colours text on elevated surfaces (e.g. tooltips). In light
      // mode those surfaces are dark, so the inverse text must be light.
      textInverse: Color(ExampleColours.warm50),
      textOnBrand: Color(ExampleColours.onBrand),
    ),
    icon: IconColours(
      iconPrimary: Color(ExampleColours.warm900),
      iconSecondary: Color(ExampleColours.warm600),
      iconDisabled: Color(ExampleColours.warm300),
      iconOnBrand: Color(ExampleColours.onBrand),
    ),
    background: BackgroundColours(
      // Warm paper scaffold with clean white cards on top.
      bgBase: Color(ExampleColours.warm50),
      bgSubtle: Color(ExampleColours.actualWhite),
      bgElevated: Color(ExampleColours.actualWhite),
      bgOverlay: Color(ExampleColours.overlay),
    ),
    border: BorderColours(
      borderDefault: Color(ExampleColours.warm200),
      borderStrong: Color(ExampleColours.warm900),
      borderDisabled: Color(ExampleColours.warm200),
      borderFocus: Color(ExampleColours.peach500),
      borderBrand: Color(ExampleColours.peach500),
    ),
    action: ActionColours(
      actionPrimary: Color(ExampleColours.peach500),
      actionPrimaryHover: Color(ExampleColours.peach600),
      actionPrimaryActive: Color(ExampleColours.peach700),
      actionPrimaryDisabled: Color(ExampleColours.warm200),
      // The theme wall's dark-sheet indigo, surfaced as a whisper-quiet tint.
      actionSecondary: Color(ExampleColours.indigo50),
      actionSecondaryHover: Color(ExampleColours.indigo100),
      actionError: Color(ExampleColours.error),
      actionErrorHover: Color(ExampleColours.errorHover),
      actionSuccess: Color(ExampleColours.success),
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
      inputBg: Color(ExampleColours.actualWhite),
      inputBorder: Color(ExampleColours.warm300),
      inputBorderFocus: Color(ExampleColours.peach500),
      inputBorderError: Color(ExampleColours.inputBorderError),
      inputBorderWarning: Color(ExampleColours.inputBorderWarning),
      inputText: Color(ExampleColours.warm900),
      inputPlaceholder: Color(ExampleColours.warm500),
    ),
    surface: SurfaceColours(
      surfaceCanvas: Color(ExampleColours.actualWhite),
      surfaceCode: Color(ExampleColours.warm100),
      surfaceSidebar: Color(ExampleColours.warm100),
      surfaceTableStriped: Color(ExampleColours.warm100),
    ),
    switchColours: SwitchColours(
      switchTrackOn: Color(ExampleColours.peach500),
      switchTrackOff: Color(ExampleColours.warm200),
      switchThumbOn: Color(ExampleColours.actualWhite),
      switchThumbOff: Color(ExampleColours.warm300),
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
