import 'package:flutter/material.dart';

import 'package:dievas/l10n/dievas_localizations.dart';
import 'package:dievas/src/theme/dievas_theme.dart';

/// Semantic tone of a [DievasAlert].
enum DievasAlertTone { success, warning, error, info }

/// Presentation of the alert surface.
enum DievasAlertVariant { base, filled, outlined }

/// An inline status message with optional leading, content, and trailing slots.
class DievasAlert extends StatelessWidget {
  const DievasAlert({
    super.key,
    required this.title,
    this.tone = .info,
    this.variant = .filled,
    this.description,
    this.label,
    this.content,
    this.leading,
    this.trailing,
    this.leadingIcon,
    this.showLeading = true,
    this.showTrailing = true,
    this.showBorder,
    this.disabled = false,
    this.onDismiss,
    this.onTrailingTap,
    this.leadingColour,
    this.labelColour,
    this.trailingColour,
    this.contentColour,
    this.backgroundColour,
    this.borderColour,
    this.borderRadius,
    this.padding,
    this.semanticLabel,
    this.trailingSemanticLabel,
  });

  final DievasAlertTone tone;
  final DievasAlertVariant variant;
  final String title;
  final String? description;

  /// Replaces the title's text widget when provided.
  final Widget? label;

  /// Replaces the description when provided.
  final Widget? content;
  final Widget? leading;
  final Widget? trailing;

  /// Existing leading-icon API; [leading] takes precedence when both are set.
  final Widget? leadingIcon;
  final bool showLeading;
  final bool showTrailing;

  /// Defaults to true for outlined alerts and false for other variants.
  final bool? showBorder;

  /// Disables the trailing action while keeping the alert readable.
  final bool disabled;
  final VoidCallback? onDismiss;

  /// Handles a trailing-slot tap; takes precedence over [onDismiss].
  final VoidCallback? onTrailingTap;
  final Color? leadingColour;
  final Color? labelColour;
  final Color? trailingColour;
  final Color? contentColour;
  final Color? backgroundColour;
  final Color? borderColour;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final String? semanticLabel;
  final String? trailingSemanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).alert;
    final colours = DievasTheme.coloursOf(context);
    final feedback = switch (tone) {
      .success => colours.feedback.feedbackSuccess,
      .warning => colours.feedback.feedbackWarning,
      .error => colours.feedback.feedbackError,
      .info => colours.feedback.feedbackInfo,
    };
    final foreground = switch (variant) {
      .base => colours.text.textPrimary,
      .filled || .outlined => feedback.text,
    };
    final iconColour = switch (variant) {
      .base => colours.icon.iconPrimary,
      .filled || .outlined => feedback.icon,
    };
    final action = onTrailingTap ?? onDismiss;
    final body = switch ((content, description)) {
      (final content?, _) => content,
      (_, final text?) => Text(text),
      _ => null,
    };

    return Semantics(
      container: true,
      liveRegion: true,
      label: semanticLabel,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: switch ((backgroundColour, variant)) {
            (final colour?, _) => colour,
            (null, .base) => colours.background.cardBackground,
            (null, .filled) => feedback.background,
            (null, .outlined) => Colors.transparent,
          },
          border: switch ((showBorder, variant)) {
            (true, _) || (null, .outlined) => .all(color: borderColour ?? feedback.border, width: theme.borderWidth),
            _ => null,
          },
          borderRadius: borderRadius ?? theme.borderRadius,
        ),
        child: Padding(
          padding: padding ?? theme.padding,
          child: Row(
            crossAxisAlignment: body == null ? .center : .start,
            children: [
              ...switch (showLeading) {
                true => [
                  Padding(
                    padding: .only(right: theme.iconSpacing),
                    child: _AlertSlot(
                      colour: leadingColour ?? iconColour,
                      iconSize: theme.iconSize,
                      child: switch ((leading, leadingIcon, tone)) {
                        (final leading?, _, _) => leading,
                        (_, final icon?, _) => icon,
                        (_, _, .success) => const Icon(Icons.check_circle),
                        (_, _, .warning) => const Icon(Icons.warning),
                        (_, _, .error) => const Icon(Icons.error),
                        (_, _, .info) => const Icon(Icons.info),
                      },
                    ),
                  ),
                ],
                false => <Widget>[],
              },
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    DefaultTextStyle(
                      style: theme.titleStyle.copyWith(color: labelColour ?? foreground),
                      child: label ?? Text(title),
                    ),
                    ...switch (body) {
                      final child? => [
                        SizedBox(height: DievasTheme.spacingOf(context).xs),
                        DefaultTextStyle(
                          style: theme.bodyStyle.copyWith(color: contentColour ?? foreground),
                          child: child,
                        ),
                      ],
                      null => <Widget>[],
                    },
                  ],
                ),
              ),
              ...switch ((showTrailing, trailing, action)) {
                (true, final child?, _) => [
                  _AlertTrailing(
                    onTap: action,
                    disabled: disabled,
                    colour: trailingColour ?? iconColour,
                    semanticLabel: trailingSemanticLabel,
                    child: child,
                  ),
                ],
                (true, null, final callback?) => [
                  _AlertTrailing(
                    onTap: callback,
                    disabled: disabled,
                    colour: trailingColour ?? iconColour,
                    semanticLabel: trailingSemanticLabel ?? DievasLocalizations.of(context).alertDismissLabel,
                    child: const Icon(Icons.close),
                  ),
                ],
                _ => <Widget>[],
              },
            ],
          ),
        ),
      ),
    );
  }
}

class _AlertSlot extends StatelessWidget {
  const _AlertSlot({required this.colour, required this.iconSize, required this.child});

  final Color colour;
  final double iconSize;
  final Widget child;

  @override
  Widget build(BuildContext context) => IconTheme(
    data: IconThemeData(color: colour, size: iconSize),
    child: DefaultTextStyle.merge(
      style: TextStyle(color: colour),
      child: child,
    ),
  );
}

class _AlertTrailing extends StatelessWidget {
  const _AlertTrailing({
    required this.onTap,
    required this.disabled,
    required this.colour,
    required this.semanticLabel,
    required this.child,
  });

  final VoidCallback? onTap;
  final bool disabled;
  final Color colour;
  final String? semanticLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).alert;
    final slot = _AlertSlot(
      colour: disabled ? DievasTheme.coloursOf(context).icon.iconDisabled : colour,
      iconSize: theme.dismissIconSize,
      child: child,
    );

    return Padding(
      padding: .only(left: DievasTheme.spacingOf(context).sm),
      child: switch (onTap) {
        final callback? => IconButton(
          onPressed: disabled ? null : callback,
          tooltip: semanticLabel,
          padding: .zero,
          visualDensity: .compact,
          constraints: .tightFor(
            width: DievasTheme.sizingOf(context).touchMin,
            height: DievasTheme.sizingOf(context).touchMin,
          ),
          icon: slot,
        ),
        null => Semantics(label: semanticLabel, child: slot),
      },
    );
  }
}
