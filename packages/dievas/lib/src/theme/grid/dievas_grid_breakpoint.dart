import 'package:flutter/widgets.dart';
import 'package:dievas_tokens/dievas_tokens.dart';

/// A single breakpoint in the Dievas grid system.
///
/// Implements [Comparable] and comparison operators so layout code can
/// branch cleanly:
/// ```dart
/// if (context.grid >= DievasGridBreakpoint.md) { ... }
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
  static const DievasGridBreakpoint xs = DievasGridBreakpoint._(
    name: 'xs',
    minWidth: DievasBreakpointSemantic.xs,
    columns: 4,
    margin: 16,
    gutter: 16,
    family: 'mobile',
  );

  /// 360–699px · 4 columns · mobile
  static const DievasGridBreakpoint sm = DievasGridBreakpoint._(
    name: 'sm',
    minWidth: DievasBreakpointSemantic.sm,
    columns: 4,
    margin: 16,
    gutter: 16,
    family: 'mobile',
  );

  /// 700–999px · 8 columns · tablet
  static const DievasGridBreakpoint md = DievasGridBreakpoint._(
    name: 'md',
    minWidth: DievasBreakpointSemantic.md,
    columns: 8,
    margin: 32,
    gutter: 24,
    family: 'tablet',
  );

  /// 1000–1347px · 12 columns · tablet
  static const DievasGridBreakpoint lg = DievasGridBreakpoint._(
    name: 'lg',
    minWidth: DievasBreakpointSemantic.lg,
    columns: 12,
    margin: 32,
    gutter: 24,
    family: 'tablet',
  );

  /// 1348px+ · 12 columns · desktop
  static const DievasGridBreakpoint xl = DievasGridBreakpoint._(
    name: 'xl',
    minWidth: DievasBreakpointSemantic.xl,
    columns: 12,
    margin: 32,
    gutter: 24,
    family: 'desktop',
  );

  /// All breakpoints in ascending order of [minWidth].
  static const List<DievasGridBreakpoint> values = [xs, sm, md, lg, xl];

  /// Returns the breakpoint that applies to [width].
  static DievasGridBreakpoint fromWidth(double width) {
    return values.lastWhere((bp) => width >= bp.minWidth, orElse: () => xs);
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
