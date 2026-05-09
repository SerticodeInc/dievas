part of '../themes.dart';

/// Default Dievas dark theme.
///
/// Uses the indigo/slate dark palette. Mirror of [DievasLightThemeData] using
/// [DievasColourSemanticDark] token values. Consumer apps do not subclass this —
/// they subclass [DievasGlobalThemeData] with their own brand tokens.
final class DievasDarkThemeData extends DievasGlobalThemeData {
  DievasDarkThemeData({super.components}) : super(colors: _darkColors);

  static final DievasColourThemeData _darkColors = DievasColourThemeData(
    brightness: .dark,
    core: const CoreColours(
      brand: Color(DievasColourSemanticDark.brand),
      brandSubtle: Color(DievasColourSemanticDark.brandSubtle),
      onBrand: Color(DievasColourSemanticDark.onBrand),
    ),
    text: const TextColours(
      textPrimary: Color(DievasColourSemanticDark.textPrimary),
      textSecondary: Color(DievasColourSemanticDark.textSecondary),
      textTertiary: Color(DievasColourSemanticDark.textTertiary),
      textDisabled: Color(DievasColourSemanticDark.textDisabled),
      textInverse: Color(DievasColourSemanticDark.textInverse),
      textOnBrand: Color(DievasColourSemanticDark.textOnBrand),
    ),
    icon: const IconColours(
      iconPrimary: Color(DievasColourSemanticDark.iconPrimary),
      iconSecondary: Color(DievasColourSemanticDark.iconSecondary),
      iconDisabled: Color(DievasColourSemanticDark.iconDisabled),
      iconOnBrand: Color(DievasColourSemanticDark.iconOnBrand),
    ),
    background: const BackgroundColours(
      bgBase: Color(DievasColourSemanticDark.bgBase),
      bgSubtle: Color(DievasColourSemanticDark.bgSubtle),
      bgElevated: Color(DievasColourSemanticDark.bgElevated),
      bgOverlay: Color(DievasColourSemanticDark.bgOverlay),
    ),
    border: const BorderColours(
      borderDefault: Color(DievasColourSemanticDark.borderDefault),
      borderStrong: Color(DievasColourSemanticDark.borderStrong),
      borderDisabled: Color(DievasColourSemanticDark.borderDisabled),
      borderFocus: Color(DievasColourSemanticDark.borderFocus),
      borderBrand: Color(DievasColourSemanticDark.borderBrand),
    ),
    action: const ActionColours(
      actionPrimary: Color(DievasColourSemanticDark.actionPrimary),
      actionPrimaryHover: Color(DievasColourSemanticDark.actionPrimaryHover),
      actionPrimaryActive: Color(DievasColourSemanticDark.actionPrimaryActive),
      actionPrimaryDisabled: Color(DievasColourSemanticDark.actionPrimaryDisabled),
      actionSecondary: Color(DievasColourSemanticDark.actionSecondary),
      actionSecondaryHover: Color(DievasColourSemanticDark.actionSecondaryHover),
      actionError: Color(DievasColourSemanticDark.actionError),
      actionErrorHover: Color(DievasColourSemanticDark.actionErrorHover),
      actionSuccess: Color(DievasColourSemanticDark.actionSuccess),
    ),
    feedback: const FeedbackColours(
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
    input: const InputColours(
      inputBg: Color(DievasColourSemanticDark.inputBg),
      inputBorder: Color(DievasColourSemanticDark.inputBorder),
      inputBorderFocus: Color(DievasColourSemanticDark.inputBorderFocus),
      inputBorderError: Color(DievasColourSemanticDark.inputBorderError),
      inputText: Color(DievasColourSemanticDark.inputText),
      inputPlaceholder: Color(DievasColourSemanticDark.inputPlaceholder),
    ),
    switchColours: const SwitchColours(
      switchTrackOn: Color(DievasColourSemanticDark.switchTrackOn),
      switchTrackOff: Color(DievasColourSemanticDark.switchTrackOff),
      switchThumb: Color(DievasColourSemanticDark.switchThumb),
      switchBorder: Color(DievasColourSemanticDark.switchBorder),
    ),
    staticColours: const StaticColours(
      staticWhite: Color(DievasColourSemanticDark.staticWhite),
      staticBlack: Color(DievasColourSemanticDark.staticBlack),
      staticTransparent: Color(DievasColourSemanticDark.staticTransparent),
    ),
  );

  @override
  DievasThemeData copyWith({DievasComponentThemeData? components}) =>
      DievasDarkThemeData(components: components ?? this.components);
}
