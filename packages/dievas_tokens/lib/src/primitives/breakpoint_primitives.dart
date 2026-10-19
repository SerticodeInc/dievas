/// Raw breakpoint primitives for the Dievas responsive grid. Pure Dart, no
/// Flutter. These atomic min widths match packages/dievas/lib/src/theme/grid/;
/// consume DievasBreakpointSemantic instead of referencing them directly.
abstract final class DievasBreakpointPrimitives {
  /// 0px smallest viewport. Baseline mobile.
  static const double xs = 0;

  /// 360px small mobile. Entry level handset width.
  static const double sm = 360;

  /// 700px medium / tablet portrait.
  static const double md = 700;

  /// 1000px large / tablet landscape.
  static const double lg = 1000;

  /// 1348px extra large / desktop.
  static const double xl = 1348;
}
