part of '../themes.dart';

/// Default Dievas light theme.
///
/// Uses the indigo/slate palette. This is the reference implementation and
/// the fallback theme for the gallery. Consumer apps do not subclass this —
/// they subclass [DievasGlobalThemeData] and provide their own brand tokens.
final class DievasLightThemeData extends DievasGlobalThemeData {
  DievasLightThemeData({super.components}) : super(colors: _lightColors);

  static final DievasColourThemeData _lightColors = DievasColourThemeData(
    brightness: .light,
    core: const CoreColours(
      brand: Color(DievasColourSemanticLight.brand),
      brandSubtle: Color(DievasColourSemanticLight.brandSubtle),
      onBrand: Color(DievasColourSemanticLight.onBrand),
    ),
    text: const TextColours(
      textPrimary: Color(DievasColourSemanticLight.textPrimary),
      textSecondary: Color(DievasColourSemanticLight.textSecondary),
      textTertiary: Color(DievasColourSemanticLight.textTertiary),
      textDisabled: Color(DievasColourSemanticLight.textDisabled),
      textInverse: Color(DievasColourSemanticLight.textInverse),
      textOnBrand: Color(DievasColourSemanticLight.textOnBrand),
    ),
    icon: const IconColours(
      iconPrimary: Color(DievasColourSemanticLight.iconPrimary),
      iconSecondary: Color(DievasColourSemanticLight.iconSecondary),
      iconDisabled: Color(DievasColourSemanticLight.iconDisabled),
      iconOnBrand: Color(DievasColourSemanticLight.iconOnBrand),
    ),
    background: const BackgroundColours(
      bgBase: Color(DievasColourSemanticLight.bgBase),
      bgSubtle: Color(DievasColourSemanticLight.bgSubtle),
      bgElevated: Color(DievasColourSemanticLight.bgElevated),
      bgOverlay: Color(DievasColourSemanticLight.bgOverlay),
    ),
    border: const BorderColours(
      borderDefault: Color(DievasColourSemanticLight.borderDefault),
      borderStrong: Color(DievasColourSemanticLight.borderStrong),
      borderDisabled: Color(DievasColourSemanticLight.borderDisabled),
      borderFocus: Color(DievasColourSemanticLight.borderFocus),
      borderBrand: Color(DievasColourSemanticLight.borderBrand),
    ),
    action: const ActionColours(
      actionPrimary: Color(DievasColourSemanticLight.actionPrimary),
      actionPrimaryHover: Color(DievasColourSemanticLight.actionPrimaryHover),
      actionPrimaryActive: Color(DievasColourSemanticLight.actionPrimaryActive),
      actionPrimaryDisabled: Color(DievasColourSemanticLight.actionPrimaryDisabled),
      actionSecondary: Color(DievasColourSemanticLight.actionSecondary),
      actionSecondaryHover: Color(DievasColourSemanticLight.actionSecondaryHover),
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
      inputText: Color(DievasColourSemanticLight.inputText),
      inputPlaceholder: Color(DievasColourSemanticLight.inputPlaceholder),
    ),
    switchColours: const SwitchColours(
      switchTrackOn: Color(DievasColourSemanticLight.switchTrackOn),
      switchTrackOff: Color(DievasColourSemanticLight.switchTrackOff),
      switchThumb: Color(DievasColourSemanticLight.switchThumb),
      switchBorder: Color(DievasColourSemanticLight.switchBorder),
    ),
    staticColours: const StaticColours(
      staticWhite: Color(DievasColourSemanticLight.staticWhite),
      staticBlack: Color(DievasColourSemanticLight.staticBlack),
      staticTransparent: Color(DievasColourSemanticLight.staticTransparent),
    ),
  );

  @override
  DievasThemeData copyWith({DievasComponentThemeData? components}) =>
      DievasLightThemeData(components: components ?? this.components);
}
