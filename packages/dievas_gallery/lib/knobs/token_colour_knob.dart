import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

/// Curated semantic roles offered by the gallery's colour dropdowns.
enum DievasColourRole {
  text([.primaryText, .secondaryText, .inverseText, .brand, .successText, .warningText, .errorText, .infoText]),
  icon([.primaryIcon, .secondaryIcon, .brand, .successIcon, .warningIcon, .errorIcon, .infoIcon]),
  background([
    .card,
    .page,
    .brand,
    .brandTint,
    .track,
    .successBackground,
    .warningBackground,
    .errorBackground,
    .infoBackground,
  ]),
  border([.divider, .brand, .successBorder, .warningBorder, .errorBorder, .infoBorder]);

  const DievasColourRole(this.options);

  final List<DievasGalleryColour> options;
}

/// Stable token identities keep saved selections valid across theme changes.
enum DievasGalleryColour {
  primaryText('Primary text'),
  secondaryText('Secondary text'),
  inverseText('Inverse text'),
  brand('Brand'),
  successText('Success text'),
  warningText('Warning text'),
  errorText('Error text'),
  infoText('Info text'),
  primaryIcon('Primary icon'),
  secondaryIcon('Secondary icon'),
  successIcon('Success icon'),
  warningIcon('Warning icon'),
  errorIcon('Error icon'),
  infoIcon('Info icon'),
  card('Card'),
  page('Page'),
  brandTint('Brand tint'),
  track('Progress track'),
  successBackground('Success background'),
  warningBackground('Warning background'),
  errorBackground('Error background'),
  infoBackground('Info background'),
  divider('Default divider'),
  successBorder('Success border'),
  warningBorder('Warning border'),
  errorBorder('Error border'),
  infoBorder('Info border');

  const DievasGalleryColour(this.label);

  final String label;

  Color resolve(DievasColourThemeData colours) => switch (this) {
    .primaryText => colours.text.textPrimary,
    .secondaryText => colours.text.textSecondary,
    .inverseText => colours.text.textInverse,
    .brand => colours.core.primary,
    .successText => colours.feedback.feedbackSuccess.text,
    .warningText => colours.feedback.feedbackWarning.text,
    .errorText => colours.feedback.feedbackError.text,
    .infoText => colours.feedback.feedbackInfo.text,
    .primaryIcon => colours.icon.iconPrimary,
    .secondaryIcon => colours.icon.iconSecondary,
    .successIcon => colours.feedback.feedbackSuccess.icon,
    .warningIcon => colours.feedback.feedbackWarning.icon,
    .errorIcon => colours.feedback.feedbackError.icon,
    .infoIcon => colours.feedback.feedbackInfo.icon,
    .card => colours.background.cardBackground,
    .page => colours.background.pageBackground,
    .brandTint => colours.core.badgePrimaryTintedBackground,
    .track => colours.background.progressTrack,
    .successBackground => colours.feedback.feedbackSuccess.background,
    .warningBackground => colours.feedback.feedbackWarning.background,
    .errorBackground => colours.feedback.feedbackError.background,
    .infoBackground => colours.feedback.feedbackInfo.background,
    .divider => colours.border.dividerColour,
    .successBorder => colours.feedback.feedbackSuccess.border,
    .warningBorder => colours.feedback.feedbackWarning.border,
    .errorBorder => colours.feedback.feedbackError.border,
    .infoBorder => colours.feedback.feedbackInfo.border,
  };
}

extension DievasTokenColourKnob on BuildContext {
  /// Resolves the selected semantic token against the active Dievas theme.
  Color tokenColourKnob({required String label, required DievasColourRole role, DievasGalleryColour? initialValue}) =>
      knobs.object
          .dropdown<DievasGalleryColour>(
            label: label,
            options: role.options,
            initialOption: initialValue,
            labelBuilder: (token) => token.label,
          )
          .resolve(DievasTheme.coloursOf(this));
}
