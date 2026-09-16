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

  static final DievasColourThemeData _lightColours = DievasColourThemeData(
    brightness: .light,
    core: const CoreColours(
      brand: Color(ExampleColours.brand),
      brandSubtle: Color(ExampleColours.brandSubtle),
      // Text on action surfaces. This brand's primary action is ink
      // (ExampleColours.actionPrimary), so onBrand must be a light colour —
      // lavender mirrors the brand's real ink-button + light-label look.
      onBrand: Color(ExampleColours.textLight),
    ),
    text: const TextColours(
      textPrimary: Color(ExampleColours.textDark),
      textSecondary: Color(DievasColourSemanticLight.textSecondary),
      textTertiary: Color(DievasColourSemanticLight.textTertiary),
      textDisabled: Color(DievasColourSemanticLight.textDisabled),
      // textInverse colours text on elevated surfaces (e.g. tooltips). In light
      // mode those surfaces are white, so the inverse text must be dark.
      textInverse: Color(ExampleColours.textDark),
      textOnBrand: Color(ExampleColours.onBrand),
    ),
    icon: const IconColours(
      iconPrimary: Color(DievasColourSemanticLight.iconPrimary),
      iconSecondary: Color(DievasColourSemanticLight.iconSecondary),
      iconDisabled: Color(DievasColourSemanticLight.iconDisabled),
      iconOnBrand: Color(ExampleColours.onBrand),
    ),
    background: const BackgroundColours(
      // Brand scaffold: the warm off-white this product surfaces on.
      bgBase: Color(ExampleColours.scaffoldBG),
      bgSubtle: Color(DievasColourSemanticLight.bgSubtle),
      bgElevated: Color(DievasColourSemanticLight.bgElevated),
      bgOverlay: Color(DievasColourSemanticLight.bgOverlay),
    ),
    border: const BorderColours(
      borderDefault: Color(DievasColourSemanticLight.borderDefault),
      borderStrong: Color(DievasColourSemanticLight.borderStrong),
      borderDisabled: Color(DievasColourSemanticLight.borderDisabled),
      borderFocus: Color(DievasColourSemanticLight.borderFocus),
      borderBrand: Color(ExampleColours.borderBrand),
    ),
    action: const ActionColours(
      actionPrimary: Color(ExampleColours.actionPrimary),
      actionPrimaryHover: Color(ExampleColours.actionPrimaryHover),
      actionPrimaryActive: Color(ExampleColours.actionPrimaryActive),
      actionPrimaryDisabled: Color(DievasColourSemanticLight.actionPrimaryDisabled),
      actionSecondary: Color(ExampleColours.actionSecondary),
      actionSecondaryHover: Color(ExampleColours.actionSecondaryHover),
      actionError: Color(DievasColourSemanticLight.actionError),
      actionErrorHover: Color(DievasColourSemanticLight.actionErrorHover),
      actionSuccess: Color(DievasColourSemanticLight.actionSuccess),
    ),
    feedback: const FeedbackColours(
      feedbackSuccess: FeedbackColour(
        background: Color(DievasColourSemanticLight.feedbackSuccessBackground),
        border: Color(DievasColourSemanticLight.feedbackSuccessBorder),
        icon: Color(DievasColourSemanticLight.feedbackSuccessIcon),
        text: Color(DievasColourSemanticLight.feedbackSuccessText),
      ),
      feedbackWarning: FeedbackColour(
        background: Color(DievasColourSemanticLight.feedbackWarningBackground),
        border: Color(DievasColourSemanticLight.feedbackWarningBorder),
        icon: Color(DievasColourSemanticLight.feedbackWarningIcon),
        text: Color(DievasColourSemanticLight.feedbackWarningText),
      ),
      feedbackError: FeedbackColour(
        background: Color(DievasColourSemanticLight.feedbackErrorBackground),
        border: Color(DievasColourSemanticLight.feedbackErrorBorder),
        icon: Color(DievasColourSemanticLight.feedbackErrorIcon),
        text: Color(DievasColourSemanticLight.feedbackErrorText),
      ),
      feedbackInfo: FeedbackColour(
        background: Color(DievasColourSemanticLight.feedbackInfoBackground),
        border: Color(DievasColourSemanticLight.feedbackInfoBorder),
        icon: Color(DievasColourSemanticLight.feedbackInfoIcon),
        text: Color(DievasColourSemanticLight.feedbackInfoText),
      ),
    ),
    input: const InputColours(
      inputBg: Color(DievasColourSemanticLight.inputBg),
      inputBorder: Color(DievasColourSemanticLight.inputBorder),
      inputBorderFocus: Color(DievasColourSemanticLight.inputBorderFocus),
      inputBorderError: Color(DievasColourSemanticLight.inputBorderError),
      inputBorderWarning: Color(DievasColourSemanticLight.inputBorderWarning),
      inputText: Color(DievasColourSemanticLight.inputText),
      inputPlaceholder: Color(DievasColourSemanticLight.inputPlaceholder),
    ),
    surface: const SurfaceColours(
      surfaceCanvas: Color(DievasColourSemanticLight.surfaceCanvas),
      surfaceCode: Color(DievasColourSemanticLight.surfaceCode),
      surfaceSidebar: Color(DievasColourSemanticLight.surfaceSidebar),
      surfaceTableStriped: Color(DievasColourSemanticLight.surfaceTableStriped),
    ),
    switchColours: const SwitchColours(
      switchTrackOn: Color(DievasColourSemanticLight.switchTrackOn),
      switchTrackOff: Color(DievasColourSemanticLight.switchTrackOff),
      switchThumbOn: Color(DievasColourSemanticLight.switchThumbOn),
      switchThumbOff: Color(DievasColourSemanticLight.switchThumbOff),
    ),
    staticColours: const StaticColours(
      staticWhite: Color(ExampleColours.staticWhite),
      staticBlack: Color(ExampleColours.staticBlack),
      staticTransparent: Color(DievasColourSemanticLight.staticTransparent),
    ),
  );

  @override
  DievasThemeData copyWith({DievasComponentThemeData? components, DievasTypographyThemeData? typography}) =>
      ExampleLightThemeData(components: components, typography: typography);
}
