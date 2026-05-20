import 'package:dievas/l10n/dievas_localizations.dart';
import 'package:dievas/src/extensions/dievas_theme_context_extension.dart';
import 'package:flutter/widgets.dart';

import '../../theme/color/dievas_colour_theme_data.dart';
import '../../theme/dievas_theme.dart';
import '../alert/dievas_alert.dart';

/// A persistent, scope-owned banner shown at the top of the viewport.
///
/// Pass to [DievasScopeController.showBanner]:
///
/// ```dart
/// DievasScope.of(context).showBanner(
///   (context, animation) => DievasBanner(
///     tone: .warning,
///     message: 'You are in offline mode.',
///     onDismiss: () => DievasScope.of(context).hideBanner(),
///   ),
/// );
/// ```
///
/// Moon reference: InsetBanner
class DievasBanner extends StatelessWidget {
  const DievasBanner({super.key, required this.tone, required this.message, this.onDismiss, this.action});

  /// Semantic tone — drives colour.
  final DievasAlertTone tone;

  /// The banner message text.
  final String message;

  /// If provided, renders a dismiss (×) button.
  final VoidCallback? onDismiss;

  /// Optional inline action widget (e.g. a [DievasTextButton]).
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final alertTheme = DievasTheme.componentsOf(context).alert;
    final palette = _palette(tone, _BannerPalette(DievasTheme.colorsOf(context)));

    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.background,
        border: Border(
          bottom: BorderSide(color: palette.border, width: alertTheme.borderWidth),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: .symmetric(horizontal: alertTheme.padding.left, vertical: alertTheme.padding.top),
          child: Row(
            children: [
              Expanded(
                child: Text(message, style: alertTheme.bodyStyle.copyWith(color: palette.text)),
              ),
              if (action case final widget?) ...[SizedBox(width: context.spacing.smPlus), widget],
              if (onDismiss != null)
                Semantics(
                  label: DievasLocalizations.of(context).alertDismissLabel,
                  button: true,
                  child: GestureDetector(
                    onTap: onDismiss,
                    child: Padding(
                      padding: .only(left: context.spacing.sm),
                      child: SizedBox.square(
                        dimension: alertTheme.dismissIconSize,
                        child: IconTheme(
                          data: IconThemeData(color: palette.text, size: alertTheme.dismissIconSize),
                          child: const _CloseIcon(),
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

  _BannerAppearance _palette(DievasAlertTone tone, _BannerPalette p) => switch (tone) {
    .success => (background: p.successBg, border: p.successBorder, text: p.successText),
    .warning => (background: p.warningBg, border: p.warningBorder, text: p.warningText),
    .error => (background: p.errorBg, border: p.errorBorder, text: p.errorText),
    .info => (background: p.infoBg, border: p.infoBorder, text: p.infoText),
  };
}

class _CloseIcon extends StatelessWidget {
  const _CloseIcon();

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    return Text(
      .fromCharCode(0xe5cd), // MaterialIcons close
      style: TextStyle(fontFamily: 'MaterialIcons', fontSize: iconTheme.size, color: iconTheme.color),
    );
  }
}

typedef _BannerAppearance = ({Color background, Color border, Color text});

final class _BannerPalette {
  _BannerPalette(DievasColourThemeData colors)
    : successBg = colors.feedback.feedbackSuccess.background,
      successBorder = colors.feedback.feedbackSuccess.border,
      successText = colors.feedback.feedbackSuccess.text,
      warningBg = colors.feedback.feedbackWarning.background,
      warningBorder = colors.feedback.feedbackWarning.border,
      warningText = colors.feedback.feedbackWarning.text,
      errorBg = colors.feedback.feedbackError.background,
      errorBorder = colors.feedback.feedbackError.border,
      errorText = colors.feedback.feedbackError.text,
      infoBg = colors.feedback.feedbackInfo.background,
      infoBorder = colors.feedback.feedbackInfo.border,
      infoText = colors.feedback.feedbackInfo.text;

  final Color successBg, successBorder, successText;
  final Color warningBg, warningBorder, warningText;
  final Color errorBg, errorBorder, errorText;
  final Color infoBg, infoBorder, infoText;
}
