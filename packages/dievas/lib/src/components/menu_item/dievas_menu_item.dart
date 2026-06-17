import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// A list item typically used inside menus, drawers, and dropdowns.
///
/// Renders a row with an optional [leadingIcon], a [label] (and optional
/// [subtitle]), and an optional [trailing] widget. Tapping fires [onTap].
///
/// ```dart
/// DievasMenuItem(
///   label: 'Profile',
///   leadingIcon: Icon(Icons.person),
///   onTap: () => print('Profile tapped'),
/// )
/// DievasMenuItem(
///   label: 'Delete',
///   subtitle: 'This action cannot be undone',
///   leadingIcon: Icon(Icons.delete),
///   enabled: false,
/// )
/// ```
class DievasMenuItem extends StatelessWidget {
  const DievasMenuItem({
    super.key,
    required this.label,
    this.leadingIcon,
    this.trailing,
    this.subtitle,
    this.onTap,
    this.enabled = true,
    this.dense = false,
  });

  /// Primary label text.
  final String label;

  /// Optional icon widget shown before the label.
  final Widget? leadingIcon;

  /// Optional widget shown after the label (e.g. a chevron, badge, or shortcut hint).
  final Widget? trailing;

  /// Optional secondary text shown below the label.
  final String? subtitle;

  /// Called when the item is tapped.
  final VoidCallback? onTap;

  /// When `false` the item is dimmed and does not respond to taps.
  final bool enabled;

  /// When `true` applies reduced vertical padding.
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).menuItem;

    final textColor = enabled ? theme.textColor : theme.textColorDisabled;
    final iconColor = enabled ? theme.iconColor : theme.iconColorDisabled;
    final subtitleColor = enabled ? theme.subtitleColor : theme.subtitleColorDisabled;

    final content = Row(
      mainAxisSize: .min,
      crossAxisAlignment: .center,
      children: [
        if (leadingIcon case final icon?) ...[
          IconTheme.merge(
            data: IconThemeData(size: theme.iconSize, color: iconColor),
            child: icon,
          ),
          SizedBox(width: theme.iconSpacing),
        ],
        Expanded(
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Text(label, style: theme.textStyle.copyWith(color: textColor)),
              if (subtitle case final subtitle?) ...[
                Padding(
                  padding: const .only(top: 2),
                  child: Text(subtitle, style: theme.subtitleStyle.copyWith(color: subtitleColor)),
                ),
              ],
            ],
          ),
        ),
        ?trailing,
      ],
    );

    final effective = GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: dense ? theme.densePadding : theme.padding,
        decoration: BoxDecoration(borderRadius: theme.borderRadius),
        child: content,
      ),
    );

    if (!enabled) {
      return Opacity(opacity: theme.disabledOpacity, child: effective);
    }

    return effective;
  }
}
