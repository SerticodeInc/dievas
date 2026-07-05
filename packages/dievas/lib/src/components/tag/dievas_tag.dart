import 'package:dievas/src/theme/color/dievas_colour_theme_data.dart';
import 'package:dievas/src/theme/component/tag/dievas_tag_border_radius.dart';
import 'package:dievas/src/theme/component/tag/dievas_tag_theme_data.dart';
import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// Visual style of [DievasTag].
enum DievasTagStyle {
  /// Solid background.
  filled,

  /// Tinted background — default.
  tinted,

  /// Border only, transparent background.
  outlined,
}

/// An interactive or read-only chip that can carry a label, a leading icon,
/// and an optional dismiss (×) affordance.
///
/// When [onPressed] is non-null the whole chip is tappable. When [onRemove]
/// is non-null a trailing ×-button is rendered.
///
/// Per-instance colour overrides follow this priority:
/// 1. Widget-level param (`backgroundColor`, `foregroundColor`, `borderColor`)
/// 2. Theme-level override (`DievasTagThemeData.backgroundColor`, etc.)
/// 3. Style-derived default (from the colour theme via [DievasTagStyle])
///
/// Moon reference: Tag
///
/// ```dart
/// DievasTag(label: 'Flutter')
/// DievasTag(label: 'Active', style: .filled, leadingIcon: Icon(Icons.circle, size: 8))
/// DievasTag(label: 'Remove me', onRemove: () { ... })
/// DievasTag(label: 'Click me', onPressed: () { ... })
/// DievasTag(label: 'Custom', backgroundColor: Colors.blue, foregroundColor: Colors.white)
/// ```
class DievasTag extends StatelessWidget {
  const DievasTag({
    super.key,
    required this.label,
    this.style = .tinted,
    this.leadingIcon,
    this.onPressed,
    this.onRemove,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderRadius,
  });

  final String label;
  final DievasTagStyle style;

  /// Optional leading icon widget.
  final Widget? leadingIcon;

  /// Tap callback. `null` → non-interactive (static display).
  final VoidCallback? onPressed;

  /// Remove callback. Renders a dismiss (×) button when non-null.
  final VoidCallback? onRemove;

  /// Overrides the tag background colour for this instance only.
  final Color? backgroundColor;

  /// Overrides the tag text and icon colour for this instance only.
  final Color? foregroundColor;

  /// Overrides the tag border colour for this instance only.
  final Color? borderColor;

  /// Overrides the border radius shape for this instance only.
  ///
  /// When `null` the theme level [DievasTagThemeData.borderRadius] is used.
  final DievasTagBorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).tag;
    final colours = _TagColors(DievasTheme.coloursOf(context));

    final content = _DievasTagContent(
      theme: theme,
      borderRadius: borderRadius,
      appearance: _appearance(
        colours,
        instanceBackground: backgroundColor ?? theme.backgroundColor,
        instanceForeground: foregroundColor ?? theme.foregroundColor,
        instanceBorder: borderColor ?? theme.borderColor,
      ),
      label: label,
      leadingIcon: leadingIcon,
      onRemove: onRemove,
    );

    return switch (onPressed) {
      final onPressed? => GestureDetector(onTap: onPressed, behavior: .opaque, child: content),
      _ => content,
    };
  }

  _DievasTagAppearance _appearance(
    _TagColors colours, {
    Color? instanceBackground,
    Color? instanceForeground,
    Color? instanceBorder,
  }) => switch (style) {
    .filled => (
      background: instanceBackground ?? colours.bgElevated,
      border: instanceBorder ?? colours.transparent,
      foreground: instanceForeground ?? colours.textPrimary,
    ),
    .tinted => (
      background: instanceBackground ?? colours.bgSubtle,
      border: instanceBorder ?? colours.transparent,
      foreground: instanceForeground ?? colours.textSecondary,
    ),
    .outlined => (
      background: instanceBackground ?? colours.transparent,
      border: instanceBorder ?? colours.borderDefault,
      foreground: instanceForeground ?? colours.textSecondary,
    ),
  };
}

class _DievasTagContent extends StatelessWidget {
  const _DievasTagContent({
    required this.theme,
    required this.appearance,
    required this.label,
    this.borderRadius,
    this.leadingIcon,
    this.onRemove,
  });

  final String label;
  final _DievasTagAppearance appearance;
  final DievasTagThemeData theme;
  final DievasTagBorderRadius? borderRadius;

  final Widget? leadingIcon;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(minHeight: theme.minHeight),
    padding: theme.padding,
    decoration: BoxDecoration(
      color: appearance.background,
      borderRadius: (borderRadius ?? theme.borderRadius).resolve(theme.minHeight),
      border: .all(color: appearance.border, width: theme.borderWidth),
    ),
    child: _DievasTagRow(
      label: label,
      appearance: appearance,
      leadingIcon: leadingIcon,
      onRemove: onRemove,
      theme: theme,
    ),
  );
}

class _DievasTagRow extends StatelessWidget {
  const _DievasTagRow({
    required this.label,
    required this.appearance,
    required this.theme,
    this.leadingIcon,
    this.onRemove,
  });

  final String label;
  final _DievasTagAppearance appearance;
  final DievasTagThemeData theme;

  final Widget? leadingIcon;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) => Row(
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
      DefaultTextStyle(
        style: theme.textStyle.copyWith(color: appearance.foreground),
        child: Text(label),
      ),
      if (onRemove case final remove?) ...[
        SizedBox(width: theme.removeIconSpacing),
        GestureDetector(
          onTap: remove,
          behavior: .opaque,
          child: SizedBox.square(
            dimension: theme.removeIconSize,
            child: Center(
              child: Icon(Icons.close, size: theme.removeIconSize, color: appearance.foreground),
            ),
          ),
        ),
      ],
    ],
  );
}

typedef _DievasTagAppearance = ({Color background, Color border, Color foreground});

// Private helper that bundles frequently needed colour lookups.
final class _TagColors {
  _TagColors(DievasColourThemeData colourTheme)
    : bgSubtle = colourTheme.background.bgSubtle,
      bgElevated = colourTheme.background.bgElevated,
      textPrimary = colourTheme.text.textPrimary,
      textSecondary = colourTheme.text.textSecondary,
      borderDefault = colourTheme.border.borderDefault,
      transparent = colourTheme.staticColours.staticTransparent;

  final Color bgSubtle;
  final Color bgElevated;
  final Color textPrimary;
  final Color textSecondary;
  final Color borderDefault;
  final Color transparent;
}
