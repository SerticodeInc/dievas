import 'package:dievas/src/theme/color/dievas_colour_theme_data.dart';
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
/// Moon reference: Tag
///
/// ```dart
/// DievasTag(label: 'Flutter')
/// DievasTag(label: 'Active', style: .filled, leadingIcon: Icon(Icons.circle, size: 8))
/// DievasTag(label: 'Remove me', onRemove: () { ... })
/// DievasTag(label: 'Click me', onPressed: () { ... })
/// ```
class DievasTag extends StatelessWidget {
  const DievasTag({
    super.key,
    required this.label,
    this.style = .tinted,
    this.leadingIcon,
    this.onPressed,
    this.onRemove,
  });

  final String label;
  final DievasTagStyle style;

  /// Optional leading icon widget.
  final Widget? leadingIcon;

  /// Tap callback. `null` → non-interactive (static display).
  final VoidCallback? onPressed;

  /// Remove callback. Renders a dismiss (×) button when non-null.
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).tag;

    final content = _DievasTagContent(
      theme: theme,
      appearance: _appearance(_TagColors(DievasTheme.colorsOf(context))),
      label: label,
      leadingIcon: leadingIcon,
      onRemove: onRemove,
    );

    if (onPressed == null) {
      return content;
    }

    return GestureDetector(onTap: onPressed, behavior: .opaque, child: content);
  }

  // Resolves the (background, border, foreground) triple from the active colour sub-system for the current style.
  _DievasTagAppearance _appearance(_TagColors colours) => switch (style) {
    .filled => (background: colours.bgElevated, border: colours.transparent, foreground: colours.textPrimary),
    .tinted => (background: colours.bgSubtle, border: colours.transparent, foreground: colours.textSecondary),
    .outlined => (background: colours.transparent, border: colours.borderDefault, foreground: colours.textSecondary),
  };
}

class _DievasTagContent extends StatelessWidget {
  const _DievasTagContent({
    required this.theme,
    required this.appearance,
    required this.label,
    this.leadingIcon,
    this.onRemove,
  });

  final String label;
  final _DievasTagAppearance appearance;
  final DievasTagThemeData theme;

  final Widget? leadingIcon;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(minHeight: theme.minHeight),
    padding: theme.padding,
    decoration: BoxDecoration(
      color: appearance.background,
      borderRadius: theme.borderRadius,
      border: appearance.border != _TagColors(DievasTheme.colorsOf(context)).transparent
          ? .all(color: appearance.border)
          : null,
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
      if (onRemove != null) ...[
        SizedBox(width: theme.removeIconSpacing),
        GestureDetector(
          onTap: onRemove,
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
