import 'package:dievas/src/theme/colour/dievas_colour_theme_data.dart';
import 'package:dievas/src/theme/component/badge/dievas_badge_theme_data.dart';
import 'package:flutter/material.dart';

import 'package:dievas/src/theme/colour/sets/feedback_colours.dart';
import 'package:dievas/src/theme/dievas_theme.dart';

/// Visual style of [DievasBadge].
enum DievasBadgeStyle {
  /// Solid coloured background — high emphasis.
  filled,

  /// Tinted background — medium emphasis.
  tinted,

  /// Border only, transparent background — low emphasis.
  outlined,
}

/// Colour variant driving the semantic tone of a [DievasBadge].
enum DievasBadgeTone {
  /// Neutral informational — uses text / background colours.
  neutral,

  /// Brand primary — uses action colours.
  primary,

  /// Success / positive state.
  success,

  /// Warning / cautionary state.
  warning,

  /// Error / destructive state.
  error,
}

/// A small label used to communicate status, count, or categorical metadata.
///
/// Moon reference: Chip / Tag (badge variant)
///
/// ```dart
/// DievasBadge(label: 'New')
/// DievasBadge(label: '3', style: .filled, tone: .primary)
/// DievasBadge(label: 'Active', tone: .success, leadingIcon: Icon(Icons.circle, size: 8))
/// ```

class DievasBadge extends StatelessWidget {
  const DievasBadge({super.key, required this.label, this.style = .tinted, this.tone = .neutral, this.leadingIcon});

  final String label;
  final DievasBadgeStyle style;
  final DievasBadgeTone tone;

  /// Optional leading icon. Sized by the badge theme's [iconSize] token.
  final Widget? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).badge;
    final badgeColours = _BadgeColours(DievasTheme.coloursOf(context));
    final appearance = _appearance(style, tone, badgeColours);

    final hasBorder = appearance.border != badgeColours.transparent;

    return Container(
      padding: theme.padding,
      decoration: BoxDecoration(
        color: appearance.background,
        borderRadius: theme.borderRadius,
        border: hasBorder ? .all(color: appearance.border) : null,
      ),
      child: _DievasBadgeContent(theme: theme, appearance: appearance, label: label, leadingIcon: leadingIcon),
    );
  }

  // Resolves the (background, border, foreground) triple from the active
  // colour sub-system for the current style × tone combination.
  _BadgeAppearance _appearance(DievasBadgeStyle style, DievasBadgeTone tone, _BadgeColours badgeColours) {
    final feedback = switch (tone) {
      .success => badgeColours.feedbackSuccess,
      .warning => badgeColours.feedbackWarning,
      .error => badgeColours.feedbackError,
      _ => badgeColours.feedbackInfo, // not used for neutral/primary
    };

    return switch ((style, tone)) {
      // filled × neutral
      (.filled, .neutral) => (
        background: badgeColours.badgeNeutralFilledBackground,
        border: badgeColours.transparent,
        foreground: badgeColours.textPrimary,
      ),
      // filled × primary
      (.filled, .primary) => (
        background: badgeColours.badgePrimaryBackground,
        border: badgeColours.transparent,
        foreground: badgeColours.badgePrimaryText,
      ),
      // filled × feedback tones
      (.filled, _) => (background: feedback.background, border: badgeColours.transparent, foreground: feedback.text),
      // tinted × neutral
      (.tinted, .neutral) => (
        background: badgeColours.badgeNeutralTintedBackground,
        border: badgeColours.transparent,
        foreground: badgeColours.textSecondary,
      ),
      // tinted × primary
      (.tinted, .primary) => (
        background: badgeColours.badgePrimaryTintedBackground,
        border: badgeColours.transparent,
        foreground: badgeColours.badgePrimaryTintedText,
      ),
      // tinted × feedback tones
      (.tinted, _) => (background: feedback.background, border: badgeColours.transparent, foreground: feedback.icon),
      // outlined × neutral
      (.outlined, .neutral) => (
        background: badgeColours.transparent,
        border: badgeColours.dividerColour,
        foreground: badgeColours.textSecondary,
      ),
      // outlined × primary
      (.outlined, .primary) => (
        background: badgeColours.transparent,
        border: badgeColours.badgePrimaryBackground,
        foreground: badgeColours.badgePrimaryBackground,
      ),
      // outlined × feedback tones
      (.outlined, _) => (background: badgeColours.transparent, border: feedback.border, foreground: feedback.icon),
    };
  }
}

class _DievasBadgeContent extends StatelessWidget {
  const _DievasBadgeContent({required this.theme, required this.appearance, required this.label, this.leadingIcon});

  final String label;
  final DievasBadgeThemeData theme;
  final _BadgeAppearance appearance;
  final Widget? leadingIcon;

  @override
  Widget build(BuildContext context) => DefaultTextStyle(
    style: theme.textStyle.copyWith(color: appearance.foreground),
    child: Row(
      mainAxisSize: .min,
      children: [
        if (leadingIcon case final icon?) ...[
          SizedBox.square(
            dimension: theme.iconSize,
            child: Center(
              child: IconTheme(
                data: IconThemeData(color: appearance.foreground, size: theme.iconSize),
                child: icon,
              ),
            ),
          ),
          SizedBox(width: theme.iconSpacing),
        ],
        Text(label),
      ],
    ),
  );
}

typedef _BadgeAppearance = ({Color background, Color border, Color foreground});

// Private helper that bundles frequently needed colour lookups to avoid
// deep chaining inside the switch expression.
final class _BadgeColours {
  _BadgeColours(DievasColourThemeData c)
    : badgePrimaryBackground = c.action.badgePrimaryBackground,
      badgePrimaryTintedText = c.action.badgePrimaryTintedText,
      badgePrimaryText = c.action.badgePrimaryText,
      badgePrimaryTintedBackground = c.core.badgePrimaryTintedBackground,
      badgeNeutralTintedBackground = c.background.badgeNeutralTintedBackground,
      badgeNeutralFilledBackground = c.background.badgeNeutralFilledBackground,
      textPrimary = c.text.textPrimary,
      textSecondary = c.text.textSecondary,
      dividerColour = c.border.dividerColour,
      feedbackSuccess = c.feedback.feedbackSuccess,
      feedbackWarning = c.feedback.feedbackWarning,
      feedbackError = c.feedback.feedbackError,
      feedbackInfo = c.feedback.feedbackInfo,
      transparent = c.staticColours.staticTransparent;

  final Color badgePrimaryBackground;
  final Color badgePrimaryTintedText;
  final Color badgePrimaryText;
  final Color badgePrimaryTintedBackground;
  final Color badgeNeutralTintedBackground;
  final Color badgeNeutralFilledBackground;
  final Color textPrimary;
  final Color textSecondary;
  final Color dividerColour;
  final FeedbackColour feedbackSuccess;
  final FeedbackColour feedbackWarning;
  final FeedbackColour feedbackError;
  final FeedbackColour feedbackInfo;
  final Color transparent;
}
