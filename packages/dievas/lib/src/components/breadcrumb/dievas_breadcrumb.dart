import 'package:flutter/material.dart';
import 'package:dievas_tokens/dievas_tokens.dart';

import 'package:dievas/src/components/icon/dievas_icon.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// A horizontal navigation trail with optional collapsed middle items.
///
/// [visibleItemCount] counts actual items, excluding the overflow control.
/// When collapsed, the first item and the most recent trailing items remain.
/// Hidden items are available through a keyboard-accessible popup menu.
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
    this.visibleItemCount,
    this.gap,
    this.itemColour,
    this.currentItemColour,
    this.hoverEffectColour,
    this.dividerColour,
    this.leading,
    this.trailing,
    this.overflow,
    this.overflowSemanticLabel,
  }) : assert(visibleItemCount == null || visibleItemCount >= 2),
       assert(gap == null || gap >= 0);

  /// Ordered items in the trail. Empty lists render an empty trail.
  final List<T> items;

  /// Supplies the visible label and accessible name for each item.
  final String Function(T) displayString;

  /// Current page; its item is styled as active and cannot be tapped.
  final T? selectedItem;

  /// Called for visible and hidden pages. Null makes navigation read-only.
  final ValueChanged<T>? onItemTap;

  /// Callback for the optional home action. Disabled with the entire trail.
  final VoidCallback? onHomeTap;

  /// Optional home action content; defaults to a home icon with [onHomeTap].
  final Widget? homeIcon;

  /// Custom divider content. Custom icons own their size and colour.
  final Widget? separator;

  /// Disables all actions and applies the theme disabled opacity.
  final bool enabled;

  /// Maximum visible items, at least 2; null keeps the complete trail.
  final int? visibleItemCount;

  /// Space on each side of the separator.
  final double? gap;

  /// Foreground override for ordinary items and their slots.
  final Color? itemColour;

  /// Foreground override for the current page and its slots.
  final Color? currentItemColour;

  /// Optional hover background. Defaults to transparent; no splash is painted.
  final Color? hoverEffectColour;

  /// Foreground override for separators.
  final Color? dividerColour;

  /// Optional slots rendered inside each item. Custom icons own their styling.
  final Widget? leading;
  final Widget? trailing;

  /// Custom content for the collapsed-items menu trigger.
  final Widget? overflow;

  /// Tooltip override; defaults to the localized Material more-button label.
  final String? overflowSemanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).breadcrumb;
    final activeColour = currentItemColour ?? theme.activeItemStyle.color;
    final normalColour = itemColour ?? theme.itemStyle.color;
    final hoverColour = hoverEffectColour ?? Colors.transparent;
    final hiddenEnd = switch (visibleItemCount) {
      final count? when items.length > count => items.length - count + 1,
      _ => 1,
    };
    final indices = [
      for (int i = 0; i < items.length; i++)
        if (i == 0 || i >= hiddenEnd) i,
    ];

    return Opacity(
      opacity: enabled ? 1 : theme.disabledOpacity,
      child: SingleChildScrollView(
        scrollDirection: .horizontal,
        child: Row(
          mainAxisSize: .min,
          children: [
            if (homeIcon != null || onHomeTap != null) ...[
              _BreadcrumbAction(
                onTap: enabled ? onHomeTap : null,
                hoverColour: hoverColour,
                height: theme.minHitHeight,
                child: homeIcon ?? DievasIcon(Icons.home_outlined, size: .SM, color: normalColour),
              ),
              if (items.isNotEmpty) _BreadcrumbSeparator(separator: separator, gap: gap, colour: dividerColour),
            ],
            for (final index in indices) ...[
              if (index > 0) _BreadcrumbSeparator(separator: separator, gap: gap, colour: dividerColour),
              if (index == hiddenEnd && hiddenEnd > 1) ...[
                _BreadcrumbOverflow(
                  label: overflowSemanticLabel ?? MaterialLocalizations.of(context).moreButtonTooltip,
                  enabled: enabled && onItemTap != null,
                  hoverColour: hoverColour,
                  onSelected: (index) => onItemTap?.call(items.elementAt(index)),
                  entries: [
                    for (int i = 1; i < hiddenEnd; i++)
                      (i, displayString(items.elementAt(i)), items.elementAt(i) != selectedItem),
                  ],
                  child: DefaultTextStyle(
                    style: theme.itemStyle.copyWith(color: normalColour),
                    child: overflow ?? const Text('…'),
                  ),
                ),
                _BreadcrumbSeparator(separator: separator, gap: gap, colour: dividerColour),
              ],
              _BreadcrumbItem(
                label: displayString(items.elementAt(index)),
                selected: items.elementAt(index) == selectedItem,
                onTap: switch ((enabled, onItemTap, items.elementAt(index) == selectedItem)) {
                  (true, final callback?, false) => () => callback(items.elementAt(index)),
                  _ => null,
                },
                colour: items.elementAt(index) == selectedItem ? activeColour : normalColour,
                hoverColour: hoverColour,
                leading: leading,
                trailing: trailing,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BreadcrumbSeparator extends StatelessWidget {
  const _BreadcrumbSeparator({required this.separator, required this.gap, required this.colour});

  final double? gap;
  final Color? colour;
  final Widget? separator;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).breadcrumb;
    return ExcludeSemantics(
      child: Padding(
        padding: .symmetric(horizontal: gap ?? theme.separatorSpacing),
        child: DefaultTextStyle(
          style: theme.separatorStyle.copyWith(color: colour),
          child: switch (separator) {
            final separator? => separator,
            _ => DievasIcon(Icons.keyboard_arrow_right, size: .SM, color: colour ?? theme.separatorStyle.color),
          },
        ),
      ),
    );
  }
}

class _BreadcrumbItem extends StatelessWidget {
  const _BreadcrumbItem({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.colour,
    required this.hoverColour,
    required this.leading,
    required this.trailing,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final Color? colour;
  final Color hoverColour;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).breadcrumb;
    return Semantics(
      selected: selected,
      link: onTap != null,
      child: _BreadcrumbAction(
        onTap: onTap,
        hoverColour: hoverColour,
        height: theme.minHitHeight,
        child: DefaultTextStyle(
          style: (selected ? theme.activeItemStyle : theme.itemStyle).copyWith(color: colour),
          child: Row(
            mainAxisSize: .min,
            children: [
              if (leading case final widget?) ...[widget, SizedBox(width: theme.iconSpacing)],
              Text(label),
              if (trailing case final widget?) ...[SizedBox(width: theme.iconSpacing), widget],
            ],
          ),
        ),
      ),
    );
  }
}

class _BreadcrumbAction extends StatefulWidget {
  const _BreadcrumbAction({required this.onTap, required this.hoverColour, required this.height, required this.child});

  final double height;
  final Color hoverColour;
  final VoidCallback? onTap;
  final Widget child;

  @override
  State<_BreadcrumbAction> createState() => _BreadcrumbActionState();
}

class _BreadcrumbActionState extends State<_BreadcrumbAction> {
  bool _focused = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => FocusableActionDetector(
    enabled: widget.onTap != null,
    mouseCursor: widget.onTap == null ? SystemMouseCursors.basic : SystemMouseCursors.click,
    onShowFocusHighlight: (value) => setState(() => _focused = value),
    onShowHoverHighlight: (value) => setState(() => _hovered = value),
    actions: {
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (_) {
          widget.onTap?.call();
          return null;
        },
      ),
    },
    child: Semantics(
      button: widget.onTap != null,
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: .opaque,
        child: ColoredBox(
          color: switch ((_focused, _hovered, widget.onTap)) {
            (true, _, _?) => DievasTheme.coloursOf(context).core.badgePrimaryTintedBackground,
            (_, true, _?) => widget.hoverColour,
            _ => Colors.transparent,
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: widget.height),
            child: Center(child: widget.child),
          ),
        ),
      ),
    ),
  );
}

class _BreadcrumbOverflow extends StatefulWidget {
  const _BreadcrumbOverflow({
    required this.label,
    required this.enabled,
    required this.hoverColour,
    required this.onSelected,
    required this.entries,
    required this.child,
  });

  final String label;
  final bool enabled;
  final Color hoverColour;
  final ValueChanged<int> onSelected;
  final List<(int, String, bool)> entries;
  final Widget child;

  @override
  State<_BreadcrumbOverflow> createState() => _BreadcrumbOverflowState();
}

class _BreadcrumbOverflowState extends State<_BreadcrumbOverflow> {
  final MenuController _controller = MenuController();

  @override
  Widget build(BuildContext context) => MenuAnchor(
    controller: _controller,
    alignmentOffset: Offset(
      DievasTheme.sizingOf(context).width160 / (Directionality.of(context) == .rtl ? 2 : -2),
      DievasTheme.componentsOf(context).popover.verticalOffset,
    ),
    style: MenuStyle(
      alignment: .bottomCenter,
      backgroundColor: WidgetStatePropertyAll(DievasTheme.componentsOf(context).popover.backgroundColour),
      surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
      elevation: const WidgetStatePropertyAll(DievasElevationPrimitives.e1),
      shadowColor: WidgetStatePropertyAll(DievasTheme.coloursOf(context).text.textPrimary.withValues(alpha: 0.2)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: DievasTheme.borderOf(context).XL,
          side: BorderSide(
            color: DievasTheme.coloursOf(context).border.dividerColour,
            width: DievasTheme.borderOf(context).strokeThin,
          ),
        ),
      ),
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: DievasTheme.spacingOf(context).XS)),
      minimumSize: WidgetStatePropertyAll(Size(DievasTheme.sizingOf(context).width160, 0)),
    ),
    menuChildren: [
      for (final (index, label, enabled) in widget.entries)
        MenuItemButton(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.focused)
                  ? DievasTheme.coloursOf(context).core.badgePrimaryTintedBackground
                  : Colors.transparent,
            ),
            minimumSize: WidgetStatePropertyAll(
              Size(DievasTheme.sizingOf(context).width160, DievasTheme.sizingOf(context).height40),
            ),
            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: DievasTheme.spacingOf(context).MD)),
            alignment: .centerLeft,
          ),
          onPressed: enabled ? () => widget.onSelected(index) : null,
          child: Text(label, style: DievasTheme.componentsOf(context).popover.textStyle),
        ),
    ],
    builder: (context, controller, child) => Tooltip(
      message: widget.label,
      child: _BreadcrumbAction(
        onTap: widget.enabled ? () => controller.isOpen ? controller.close() : controller.open() : null,
        hoverColour: widget.hoverColour,
        height: DievasTheme.componentsOf(context).breadcrumb.minHitHeight,
        child: widget.child,
      ),
    ),
  );
}
