import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// A horizontal breadcrumb navigation trail.
///
/// Each [items] entry renders as a tappable crumb, with the optional
/// [selectedItem] highlighted as the active step. Adjacent crumbs are
/// separated by a chevron (or a custom [separator] widget).
///
/// The leading [homeIcon] anchors the trail — tapping it calls [onHomeTap].
///
/// Moon reference: BreadCrumb
///
/// ```dart
/// DievasBreadcrumb<String>(
///   items: ['Home', 'Products', 'Shoes'],
///   displayString: (s) => s,
///   selectedItem: 'Shoes',
///   onItemTap: (item) => navigateTo(item),
/// )
/// ```
class DievasBreadcrumb<T> extends StatelessWidget {
  const DievasBreadcrumb({
    super.key,
    required this.items,
    required this.displayString,
    this.selectedItem,
    this.onItemTap,
    this.onHomeTap,
    this.homeIcon,
    this.separator,
    this.enabled = true,
  });

  /// Ordered list of breadcrumb items (left to right).
  final List<T> items;

  /// Converts an item to its display string.
  final String Function(T) displayString;

  /// The currently-selected item — rendered in the active style.
  final T? selectedItem;

  /// Called when a non-selected crumb is tapped.
  final ValueChanged<T>? onItemTap;

  /// Called when the leading home icon is tapped.
  final VoidCallback? onHomeTap;

  /// Leading home icon. Defaults to an outlined home icon.
  final Widget? homeIcon;

  /// Custom separator widget between crumbs. Defaults to a chevron.
  final Widget? separator;

  /// When `false` all items are dimmed.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).breadcrumb;
    final colors = DievasTheme.colorsOf(context);

    final defaultSeparator = Icon(Icons.chevron_right_rounded, size: theme.iconSize, color: colors.icon.iconDisabled);
    final defaultHomeIcon = Icon(Icons.home_outlined, size: theme.iconSize, color: colors.icon.iconPrimary);

    Widget trail = Row(
      mainAxisSize: .min,
      children: [
        if (homeIcon != null || onHomeTap != null)
          Padding(
            padding: EdgeInsetsDirectional.only(end: theme.iconSpacing),
            child: GestureDetector(
              onTap: onHomeTap,
              child: SizedBox(
                height: theme.minHitHeight,
                child: Center(child: homeIcon ?? defaultHomeIcon),
              ),
            ),
          ),
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0 || homeIcon != null || onHomeTap != null)
            Padding(
              padding: .symmetric(horizontal: theme.separatorSpacing),
              child: separator ?? defaultSeparator,
            ),
          _Crumb<T>(
            item: items[i],
            displayString: displayString,
            isSelected: items[i] == selectedItem,
            isLast: i == items.length - 1,
            enabled: enabled,
            onTap: () => onItemTap?.call(items[i]),
          ),
        ],
      ],
    );

    if (!enabled) {
      trail = Opacity(opacity: theme.disabledOpacity, child: trail);
    }

    return trail;
  }
}

class _Crumb<T> extends StatelessWidget {
  const _Crumb({
    required this.item,
    required this.displayString,
    required this.isSelected,
    required this.isLast,
    required this.enabled,
    required this.onTap,
  });

  final T item;
  final String Function(T) displayString;
  final bool isSelected;
  final bool isLast;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).breadcrumb;
    final style = isSelected ? theme.activeItemStyle : theme.itemStyle;

    if (!enabled || !isSelected && onTap == null) {
      return SizedBox(
        height: theme.minHitHeight,
        child: Center(child: Text(displayString(item), style: style)),
      );
    }

    return GestureDetector(
      onTap: isSelected ? null : onTap,
      child: SizedBox(
        height: theme.minHitHeight,
        child: Center(child: Text(displayString(item), style: style)),
      ),
    );
  }
}
