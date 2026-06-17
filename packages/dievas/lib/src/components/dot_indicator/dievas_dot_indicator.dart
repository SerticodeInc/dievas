import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// A horizontal row of dots indicating page position.
///
/// Each dot animates in size and colour when it becomes the [activeIndex].
/// Tapping a dot calls [onDotTap] with that dot's index.
///
/// Moon reference: DotIndicator
///
/// ```dart
/// DievasDotIndicator(count: 4, activeIndex: 1)
/// DievasDotIndicator(count: 3, activeIndex: 0, onDotTap: (i) => pageController.jumpToPage(i))
/// ```
class DievasDotIndicator extends StatelessWidget {
  const DievasDotIndicator({
    super.key,
    required this.count,
    required this.activeIndex,
    this.onDotTap,
    this.enabled = true,
  });

  /// Total number of dots.
  final int count;

  /// Zero-based index of the active dot.
  final int activeIndex;

  /// Called when a dot is tapped. Receives the tapped dot's index.
  final ValueChanged<int>? onDotTap;

  /// When `false` all dots are dimmed.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).dotIndicator;

    Widget row = Row(
      mainAxisSize: .min,
      children: [
        for (var i = 0; i < count; i++) ...[
          if (i > 0) SizedBox(width: theme.dotSpacing),
          _Dot(
            index: i,
            isActive: i == activeIndex,
            enabled: enabled,
            onTap: onDotTap != null ? () => onDotTap!(i) : null,
          ),
        ],
      ],
    );

    if (!enabled) {
      row = Opacity(opacity: theme.disabledOpacity, child: row);
    }

    return row;
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.index, required this.isActive, required this.enabled, required this.onTap});

  final int index;
  final bool isActive;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).dotIndicator;
    final size = isActive ? theme.activeDotSize : theme.dotSize;
    final color = isActive ? theme.colorActive : theme.colorInactive;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: theme.animationDuration,
        curve: Curves.easeOutCubic,
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
