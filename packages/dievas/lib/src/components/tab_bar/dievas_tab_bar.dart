import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// A horizontal row of tabs with an underline indicator that slides between tabs.
///
/// ```dart
/// DievasTabBar(
///   tabs: ['Details', 'Activity', 'Settings'],
///   selectedIndex: 1,
///   onChanged: (i) => print(i),
/// )
/// ```
class DievasTabBar extends StatefulWidget {
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
  State<DievasTabBar> createState() => _DievasTabBarState();
}

class _DievasTabBarState extends State<DievasTabBar> {
  /// Anchors the indicator coordinate space to the row of tabs.
  final _indicatorLayerKey = GlobalKey();

  final _tabKeys = <GlobalKey>[];

  double? _indicatorLeft;
  double _indicatorWidth = 0;
  bool _syncScheduled = false;

  @override
  void initState() {
    super.initState();
    _syncKeys();
  }

  @override
  void didUpdateWidget(DievasTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabs.length != oldWidget.tabs.length) _syncKeys();
  }

  void _syncKeys() {
    while (_tabKeys.length < widget.tabs.length) {
      _tabKeys.add(GlobalKey());
    }
    while (_tabKeys.length > widget.tabs.length) {
      _tabKeys.removeLast();
    }
  }

  /// Measures the selected tab after the frame so the indicator can track it.
  void _scheduleIndicatorSync() {
    if (_syncScheduled) return;
    _syncScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncScheduled = false;
      _syncIndicator();
    });
  }

  void _syncIndicator() {
    if (!mounted) return;
    if (widget.selectedIndex < 0 || widget.selectedIndex >= _tabKeys.length) return;

    final layerBox = _indicatorLayerKey.currentContext?.findRenderObject() as RenderBox?;
    final tabBox = _tabKeys[widget.selectedIndex].currentContext?.findRenderObject() as RenderBox?;
    if (layerBox == null || tabBox == null || !layerBox.hasSize || !tabBox.hasSize) return;

    final left = tabBox.localToGlobal(Offset.zero, ancestor: layerBox).dx;
    final width = tabBox.size.width;
    if (left != _indicatorLeft || width != _indicatorWidth) {
      setState(() {
        _indicatorLeft = left;
        _indicatorWidth = width;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).tabBar;
    _scheduleIndicatorSync();

    final opacity = widget.enabled ? 1.0 : theme.disabledOpacity;
    final easing = DievasTheme.animationOf(context).easingEnter;

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
                child: Stack(
                  key: _indicatorLayerKey,
                  children: [
                    Row(
                      mainAxisSize: .min,
                      crossAxisAlignment: .stretch,
                      children: [
                        for (var i = 0; i < widget.tabs.length; i++)
                          _Tab(
                            key: _tabKeys[i],
                            label: widget.tabs[i],
                            isSelected: i == widget.selectedIndex,
                            padding: theme.tabPadding,
                            minTabWidth: theme.minTabWidth,
                            labelStyle: theme.labelStyle,
                            selectedLabelStyle: theme.selectedLabelStyle,
                            onTap: (widget.enabled && widget.onChanged != null) ? () => widget.onChanged!(i) : null,
                          ),
                      ],
                    ),
                    if (_indicatorLeft case final left?)
                      AnimatedPositioned(
                        key: const ValueKey('dievas_tab_bar_indicator'),
                        duration: theme.animationDuration,
                        curve: easing,
                        left: left,
                        width: _indicatorWidth,
                        bottom: 0,
                        height: theme.indicatorHeight,
                        child: ColoredBox(color: theme.indicatorColour),
                      ),
                  ],
                ),
              ),
            ),
            Container(height: 1, color: theme.dividerColour),
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
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final EdgeInsets padding;
  final double minTabWidth;
  final TextStyle labelStyle;
  final TextStyle selectedLabelStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: Container(
      constraints: BoxConstraints(minWidth: minTabWidth),
      padding: padding,
      alignment: .center,
      child: Text(label, style: isSelected ? selectedLabelStyle : labelStyle),
    ),
  );
}
