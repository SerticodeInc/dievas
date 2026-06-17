import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// A horizontal row of tabs with an animated underline indicator.
///
/// ```dart
/// DievasTabBar(
///   tabs: ['Details', 'Activity', 'Settings'],
///   selectedIndex: 1,
///   onChanged: (i) => print(i),
/// )
/// ```
class DievasTabBar extends StatelessWidget {
  const DievasTabBar({super.key, required this.tabs, required this.selectedIndex, this.onChanged, this.enabled = true});

  /// The list of tab labels.
  final List<String> tabs;

  /// Index of the currently active tab.
  final int selectedIndex;

  /// Called when the user taps a tab. When `null` the tab bar is read-only.
  final ValueChanged<int>? onChanged;

  /// When `false` the tab bar is dimmed and does not respond to taps.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).tabBar;

    final opacity = enabled ? 1.0 : theme.disabledOpacity;
    return Opacity(
      opacity: opacity,
      child: SizedBox(
        height: theme.height,
        child: Column(
          mainAxisSize: .min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: .horizontal,
                child: Row(
                  mainAxisSize: .min,
                  crossAxisAlignment: .stretch,
                  children: [
                    for (var i = 0; i < tabs.length; i++)
                      _Tab(
                        key: ValueKey('tab_$i'),
                        label: tabs[i],
                        isSelected: i == selectedIndex,
                        padding: theme.tabPadding,
                        minTabWidth: theme.minTabWidth,
                        labelStyle: theme.labelStyle,
                        selectedLabelStyle: theme.selectedLabelStyle,
                        indicatorColor: theme.indicatorColor,
                        indicatorHeight: theme.indicatorHeight,
                        animationDuration: theme.animationDuration,
                        onTap: (enabled && onChanged != null) ? () => onChanged!(i) : null,
                      ),
                  ],
                ),
              ),
            ),
            Container(height: 1, color: theme.dividerColor),
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    super.key,
    required this.label,
    required this.isSelected,
    required this.padding,
    required this.minTabWidth,
    required this.labelStyle,
    required this.selectedLabelStyle,
    required this.indicatorColor,
    required this.indicatorHeight,
    required this.animationDuration,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final EdgeInsets padding;
  final double minTabWidth;
  final TextStyle labelStyle;
  final TextStyle selectedLabelStyle;
  final Color indicatorColor;
  final double indicatorHeight;
  final Duration animationDuration;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: animationDuration,
      curve: Curves.easeOutCubic,
      constraints: BoxConstraints(minWidth: minTabWidth),
      padding: padding,
      decoration: BoxDecoration(
        border: Border(
          bottom: isSelected ? BorderSide(color: indicatorColor, width: indicatorHeight) : BorderSide.none,
        ),
      ),
      alignment: .center,
      child: Text(label, style: isSelected ? selectedLabelStyle : labelStyle),
    ),
  );
}
