import 'package:flutter/widgets.dart';

/// A single breakpoint in the Dievas grid system.
///
/// Implements [Comparable] and comparison operators so layout code can
/// branch cleanly:
/// ```dart
/// if (context.grid >= DievasGridBreakpoint.medium) { ... }
/// ```
@immutable
final class DievasGridBreakpoint implements Comparable<DievasGridBreakpoint> {
  const DievasGridBreakpoint._({
    required this.name,
    required this.minWidth,
    required this.columns,
    required this.margin,
    required this.gutter,
    required this.family,
  });

  /// Descriptive name — matches the breakpoint token name.
  final String name;

  /// Minimum viewport width (logical pixels) at which this breakpoint applies.
  final double minWidth;

  /// Number of layout columns available at this breakpoint.
  final int columns;

  /// Horizontal margin (logical pixels) on each side of the content area.
  final double margin;

  /// Gap (logical pixels) between columns.
  final double gutter;

  /// Device family hint — `'mobile'`, `'tablet'`, or `'desktop'`.
  final String family;

  /// 0–359px · 4 columns · mobile
  static const DievasGridBreakpoint xSmall = DievasGridBreakpoint._(
    name: 'xSmall',
    minWidth: 0,
    columns: 4,
    margin: 16,
    gutter: 16,
    family: 'mobile',
  );

  /// 360–699px · 4 columns · mobile
  static const DievasGridBreakpoint small = DievasGridBreakpoint._(
    name: 'small',
    minWidth: 360,
    columns: 4,
    margin: 16,
    gutter: 16,
    family: 'mobile',
  );

  /// 700–999px · 8 columns · tablet
  static const DievasGridBreakpoint medium = DievasGridBreakpoint._(
    name: 'medium',
    minWidth: 700,
    columns: 8,
    margin: 32,
    gutter: 24,
    family: 'tablet',
  );

  /// 1000–1347px · 12 columns · tablet
  static const DievasGridBreakpoint large = DievasGridBreakpoint._(
    name: 'large',
    minWidth: 1000,
    columns: 12,
    margin: 32,
    gutter: 24,
    family: 'tablet',
  );

  /// 1348px+ · 12 columns · desktop
  static const DievasGridBreakpoint xLarge = DievasGridBreakpoint._(
    name: 'xLarge',
    minWidth: 1348,
    columns: 12,
    margin: 32,
    gutter: 24,
    family: 'desktop',
  );

  /// All breakpoints in ascending order of [minWidth].
  static const List<DievasGridBreakpoint> values = [xSmall, small, medium, large, xLarge];

  /// Returns the breakpoint that applies to [width].
  static DievasGridBreakpoint fromWidth(double width) {
    return values.lastWhere((bp) => width >= bp.minWidth, orElse: () => xSmall);
  }

  @override
  int compareTo(DievasGridBreakpoint other) => minWidth.compareTo(other.minWidth);

  bool operator <(DievasGridBreakpoint other) => compareTo(other) < 0;
  bool operator <=(DievasGridBreakpoint other) => compareTo(other) <= 0;
  bool operator >(DievasGridBreakpoint other) => compareTo(other) > 0;
  bool operator >=(DievasGridBreakpoint other) => compareTo(other) >= 0;

  @override
  bool operator ==(Object other) => other is DievasGridBreakpoint && minWidth == other.minWidth;

  @override
  int get hashCode => minWidth.hashCode;

  @override
  String toString() => 'DievasGridBreakpoint.$name(${minWidth}px, $columns cols)';
}
