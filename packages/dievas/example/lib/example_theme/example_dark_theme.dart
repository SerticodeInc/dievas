part of 'example_theme.dart';

/// Example App dark brand theme.
///
/// Mirror of [ExampleLightThemeData] using the dark colour set. Consumer apps
/// subclass [DievasGlobalThemeData] directly (as done here) rather than the
/// built-in [DievasDarkThemeData], so both modes carry the same brand.
final class ExampleDarkThemeData extends DievasGlobalThemeData {
  ExampleDarkThemeData({super.components, DievasTypographyThemeData? typography})
    : super(
        colours: _darkColours,
        typography: typography ?? buildExampleTypography(textColor: _darkColours.text.textPrimary),
      );

  static const DievasColourThemeData _darkColours = DievasColourThemeData(
    brightness: .dark,
    core: CoreColours(
      brand: Color(ExampleColours.brand),
      brandSubtle: Color(ExampleColours.brandSubtle),
      onBrand: Color(ExampleColours.onBrand),
    ),
    text: TextColours(
      textPrimary: Color(ExampleColours.textLight),
      textSecondary: Color(DievasColourSemanticDark.textSecondary),
      textTertiary: Color(DievasColourSemanticDark.textTertiary),
      textDisabled: Color(DievasColourSemanticDark.textDisabled),
      // textInverse colours text on elevated surfaces (e.g. tooltips). In dark
      // mode those surfaces are dark, so the inverse text must be light.
      textInverse: Color(ExampleColours.textLight),
      textOnBrand: Color(ExampleColours.onBrand),
    ),
    icon: IconColours(
      iconPrimary: Color(DievasColourSemanticDark.iconPrimary),
      iconSecondary: Color(DievasColourSemanticDark.iconSecondary),
      iconDisabled: Color(DievasColourSemanticDark.iconDisabled),
      iconOnBrand: Color(ExampleColours.onBrand),
    ),
    background: BackgroundColours(
      // Brand scaffold: the near-black indigo this product surfaces on.
      bgBase: Color(ExampleColours.bgDark),
      bgSubtle: Color(DievasColourSemanticDark.bgSubtle),
      bgElevated: Color(DievasColourSemanticDark.bgElevated),
      bgOverlay: Color(DievasColourSemanticDark.bgOverlay),
    ),
    border: BorderColours(
      borderDefault: Color(DievasColourSemanticDark.borderDefault),
      borderStrong: Color(DievasColourSemanticDark.borderStrong),
      borderDisabled: Color(DievasColourSemanticDark.borderDisabled),
      borderFocus: Color(DievasColourSemanticDark.borderFocus),
      borderBrand: Color(ExampleColours.borderBrand),
    ),
    action: ActionColours(
      actionPrimary: Color(ExampleColours.actionPrimaryDark),
      actionPrimaryHover: Color(ExampleColours.actionPrimaryHoverDark),
      actionPrimaryActive: Color(ExampleColours.actionPrimaryActiveDark),
      actionPrimaryDisabled: Color(DievasColourSemanticDark.actionPrimaryDisabled),
      actionSecondary: Color(ExampleColours.actionSecondary),
      actionSecondaryHover: Color(ExampleColours.actionSecondaryHover),
      actionError: Color(DievasColourSemanticDark.actionError),
      actionErrorHover: Color(DievasColourSemanticDark.actionErrorHover),
      actionSuccess: Color(DievasColourSemanticDark.actionSuccess),
    ),
    feedback: FeedbackColours(
      feedbackSuccess: FeedbackColour(
        background: Color(DievasColourSemanticDark.feedbackSuccessBackground),
        border: Color(DievasColourSemanticDark.feedbackSuccessBorder),
        icon: Color(DievasColourSemanticDark.feedbackSuccessIcon),
        text: Color(DievasColourSemanticDark.feedbackSuccessText),
      ),
      feedbackWarning: FeedbackColour(
        background: Color(DievasColourSemanticDark.feedbackWarningBackground),
        border: Color(DievasColourSemanticDark.feedbackWarningBorder),
        icon: Color(DievasColourSemanticDark.feedbackWarningIcon),
        text: Color(DievasColourSemanticDark.feedbackWarningText),
      ),
      feedbackError: FeedbackColour(
        background: Color(DievasColourSemanticDark.feedbackErrorBackground),
        border: Color(DievasColourSemanticDark.feedbackErrorBorder),
        icon: Color(DievasColourSemanticDark.feedbackErrorIcon),
        text: Color(DievasColourSemanticDark.feedbackErrorText),
      ),
      feedbackInfo: FeedbackColour(
        background: Color(DievasColourSemanticDark.feedbackInfoBackground),
        border: Color(DievasColourSemanticDark.feedbackInfoBorder),
        icon: Color(DievasColourSemanticDark.feedbackInfoIcon),
        text: Color(DievasColourSemanticDark.feedbackInfoText),
      ),
    ),
    input: InputColours(
      inputBg: Color(DievasColourSemanticDark.inputBg),
      inputBorder: Color(DievasColourSemanticDark.inputBorder),
      inputBorderFocus: Color(DievasColourSemanticDark.inputBorderFocus),
      inputBorderError: Color(DievasColourSemanticDark.inputBorderError),
      inputBorderWarning: Color(DievasColourSemanticDark.inputBorderWarning),
      inputText: Color(DievasColourSemanticDark.inputText),
      inputPlaceholder: Color(DievasColourSemanticDark.inputPlaceholder),
    ),
    surface: SurfaceColours(
      surfaceCanvas: Color(DievasColourSemanticDark.surfaceCanvas),
      surfaceCode: Color(DievasColourSemanticDark.surfaceCode),
      surfaceSidebar: Color(DievasColourSemanticDark.surfaceSidebar),
      surfaceTableStriped: Color(DievasColourSemanticDark.surfaceTableStriped),
    ),
    switchColours: SwitchColours(
      switchTrackOn: Color(DievasColourSemanticDark.switchTrackOn),
      switchTrackOff: Color(DievasColourSemanticDark.switchTrackOff),
      switchThumbOn: Color(DievasColourSemanticDark.switchThumbOn),
      switchThumbOff: Color(DievasColourSemanticDark.switchThumbOff),
    ),
    staticColours: StaticColours(
      staticWhite: Color(ExampleColours.staticWhite),
      staticBlack: Color(ExampleColours.staticBlack),
      staticTransparent: Color(DievasColourSemanticDark.staticTransparent),
    ),
  );

  @override
  DievasThemeData copyWith({DievasComponentThemeData? components, DievasTypographyThemeData? typography}) =>
      ExampleDarkThemeData(components: components, typography: typography);
}
