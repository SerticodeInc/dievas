import 'package:flutter/widgets.dart';

import 'dievas_grid_breakpoint.dart';

/// InheritedWidget that provides [DievasGridBreakpoint] to the subtree.
class _DievasGridData extends InheritedWidget {
  const _DievasGridData({required this.breakpoint, required super.child});

  final DievasGridBreakpoint breakpoint;

  @override
  bool updateShouldNotify(_DievasGridData oldWidget) => breakpoint != oldWidget.breakpoint;
}

/// A [LayoutBuilder]-backed widget that inserts the current [DievasGridBreakpoint]
/// into the widget tree.
///
/// Wrap screens or sections that need breakpoint-aware layout:
/// ```dart
/// DievasGrid(
///   child: Row(
///     children: [
///       if (context.grid >= DievasGridBreakpoint.medium) SideNav(),
///       Expanded(child: content),
///     ],
///   ),
/// )
/// ```
///
/// Read the current breakpoint via [DievasGrid.breakpointOf] or the
/// `context.grid` extension shorthand.
class DievasGrid extends StatelessWidget {
  const DievasGrid({super.key, required this.child});

  /// The subtree that will receive grid breakpoint data.
  final Widget child;

  /// Returns the [DievasGridBreakpoint] from the nearest [DievasGrid] ancestor.
  static DievasGridBreakpoint breakpointOf(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<_DievasGridData>();
    assert(data != null, 'No DievasGrid found. Wrap your screen in DievasGrid.');
    return data!.breakpoint;
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final breakpoint = DievasGridBreakpoint.fromWidth(constraints.maxWidth);
      return _DievasGridData(breakpoint: breakpoint, child: child);
    },
  );
}

/// [BuildContext] extension for convenient grid breakpoint access.
extension DievasGridContextExtension on BuildContext {
  /// The current [DievasGridBreakpoint] from the nearest [DievasGrid] ancestor.
  DievasGridBreakpoint get grid => DievasGrid.breakpointOf(this);
}
