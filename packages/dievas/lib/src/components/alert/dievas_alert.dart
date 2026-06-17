import 'package:flutter/material.dart';
import 'package:dievas/l10n/dievas_localizations.dart';
import 'package:dievas/src/extensions/dievas_theme_context_extension.dart';
import 'package:dievas/src/theme/color/sets/feedback_colours.dart';
import 'package:dievas/src/theme/dievas_theme.dart';

/// Semantic tone of a [DievasAlert].
enum DievasAlertTone {
  /// Positive / success feedback.
  success,

  /// Cautionary / attention feedback.
  warning,

  /// Error / destructive feedback.
  error,

  /// Neutral informational message.
  info,
}

/// An inline alert surface communicating status or feedback to the user.
///
/// Moon reference: Alert
///
/// ```dart
/// DievasAlert(
///   tone: .success,
///   title: 'Changes saved',
///   description: 'Your profile has been updated.',
/// )
/// ```
class DievasAlert extends StatelessWidget {
  const DievasAlert({
    super.key,
    required this.tone,
    required this.title,
    this.description,
    this.onDismiss,
    this.leadingIcon,
  });

  /// Semantic tone — drives colour and default icon.
  final DievasAlertTone tone;

  /// Short, prominent title line.
  final String title;

  /// Optional supporting description shown below the title.
  final String? description;

  /// If provided, renders a dismiss (×) button that calls [onDismiss].
  final VoidCallback? onDismiss;

  /// Custom leading icon. Defaults to a tone-appropriate glyph when null.
  final Widget? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).alert;
    final palette = _palette(tone, _AlertPalette(DievasTheme.colorsOf(context).feedback));

    return Semantics(
      container: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: palette.background,
          border: .all(color: palette.border, width: theme.borderWidth),
          borderRadius: theme.borderRadius,
        ),
        child: Padding(
          padding: theme.padding,
          child: Row(
            crossAxisAlignment: .start,
            children: [
              // Leading icon
              Padding(
                padding: .only(right: theme.iconSpacing),
                child: leadingIcon ?? _DievasAlertDefaultIcon(tone: tone, color: palette.icon, size: theme.iconSize),
              ),

              // Text column
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(title, style: theme.titleStyle.copyWith(color: palette.text)),
                    if (description case final text?) ...[
                      SizedBox(height: context.spacing.xs),
                      Text(text, style: theme.bodyStyle.copyWith(color: palette.text)),
                    ],
                  ],
                ),
              ),

              // Dismiss button
              if (onDismiss != null)
                Semantics(
                  label: DievasLocalizations.of(context).alertDismissLabel,
                  button: true,
                  child: GestureDetector(
                    onTap: onDismiss,
                    child: Padding(
                      padding: EdgeInsets.only(left: context.spacing.sm),
                      child: SizedBox.square(
                        dimension: theme.dismissIconSize,
                        child: IconTheme(
                          data: IconThemeData(color: palette.icon, size: theme.dismissIconSize),
                          child: const Icon(Icons.close),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  ({Color background, Color border, Color icon, Color text}) _palette(DievasAlertTone tone, _AlertPalette p) =>
      switch (tone) {
        .success => (background: p.successBg, border: p.successBorder, icon: p.successIcon, text: p.successText),
        .warning => (background: p.warningBg, border: p.warningBorder, icon: p.warningIcon, text: p.warningText),
        .error => (background: p.errorBg, border: p.errorBorder, icon: p.errorIcon, text: p.errorText),
        .info => (background: p.infoBg, border: p.infoBorder, icon: p.infoIcon, text: p.infoText),
      };
}

/// Dievas Alert Default Icon
class _DievasAlertDefaultIcon extends StatelessWidget {
  const _DievasAlertDefaultIcon({required this.tone, required this.color, required this.size});

  final DievasAlertTone tone;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: IconTheme(
      data: IconThemeData(color: color, size: size),

      /// Simple geometric stand-ins — consumers can supply their own via leadingIcon.
      child: switch (tone) {
        .success => const Icon(Icons.check_circle),
        .warning => const Icon(Icons.warning),
        .error => const Icon(Icons.error),
        .info => const Icon(Icons.info),
      },
    ),
  );
}

final class _AlertPalette {
  _AlertPalette(FeedbackColours f)
    : successBg = f.feedbackSuccess.background,
      successBorder = f.feedbackSuccess.border,
      successIcon = f.feedbackSuccess.icon,
      successText = f.feedbackSuccess.text,
      warningBg = f.feedbackWarning.background,
      warningBorder = f.feedbackWarning.border,
      warningIcon = f.feedbackWarning.icon,
      warningText = f.feedbackWarning.text,
      errorBg = f.feedbackError.background,
      errorBorder = f.feedbackError.border,
      errorIcon = f.feedbackError.icon,
      errorText = f.feedbackError.text,
      infoBg = f.feedbackInfo.background,
      infoBorder = f.feedbackInfo.border,
      infoIcon = f.feedbackInfo.icon,
      infoText = f.feedbackInfo.text;

  final Color successBg, successBorder, successIcon, successText;
  final Color warningBg, warningBorder, warningIcon, warningText;
  final Color errorBg, errorBorder, errorIcon, errorText;
  final Color infoBg, infoBorder, infoIcon, infoText;
}
