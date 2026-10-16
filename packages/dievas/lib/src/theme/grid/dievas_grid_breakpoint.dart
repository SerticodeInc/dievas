import 'package:flutter/widgets.dart';
import 'package:dievas_tokens/dievas_tokens.dart';

/// A single breakpoint in the Dievas grid system.
///
/// Implements [Comparable] and comparison operators so layout code can
/// branch cleanly:
/// ```dart
/// if (context.grid >= DievasGridBreakpoint.MD) { ... }
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
  static const DievasGridBreakpoint XS = DievasGridBreakpoint._(
    name: 'XS',
    minWidth: DievasBreakpointSemantic.XS,
    columns: 4,
    margin: 16,
    gutter: 16,
    family: 'mobile',
  );

  /// 360–699px · 4 columns · mobile
  static const DievasGridBreakpoint SM = DievasGridBreakpoint._(
    name: 'SM',
    minWidth: DievasBreakpointSemantic.SM,
    columns: 4,
    margin: 16,
    gutter: 16,
    family: 'mobile',
  );

  /// 700–999px · 8 columns · tablet
  static const DievasGridBreakpoint MD = DievasGridBreakpoint._(
    name: 'MD',
    minWidth: DievasBreakpointSemantic.MD,
    columns: 8,
    margin: 32,
    gutter: 24,
    family: 'tablet',
  );

  /// 1000–1347px · 12 columns · tablet
  static const DievasGridBreakpoint LG = DievasGridBreakpoint._(
    name: 'LG',
    minWidth: DievasBreakpointSemantic.LG,
    columns: 12,
    margin: 32,
    gutter: 24,
    family: 'tablet',
  );

  /// 1348px+ · 12 columns · desktop
  static const DievasGridBreakpoint XL = DievasGridBreakpoint._(
    name: 'XL',
    minWidth: DievasBreakpointSemantic.XL,
    columns: 12,
    margin: 32,
    gutter: 24,
    family: 'desktop',
  );

  /// All breakpoints in ascending order of [minWidth].
  static const List<DievasGridBreakpoint> values = [XS, SM, MD, LG, XL];

  /// Returns the breakpoint that applies to [width].
  static DievasGridBreakpoint fromWidth(double width) {
    return values.lastWhere((bp) => width >= bp.minWidth, orElse: () => XS);
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
