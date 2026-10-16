// Breakpoint primitives — raw viewport widths in logical pixels.
//
// Pure Dart. No Flutter dependency.
// These are the atomic min-width values. Nothing in the app references
// them directly — consume DievasBreakpointSemantic instead.

/// Raw breakpoint primitives for the Dievas responsive grid.
///
/// Values match the grid system in `packages/dievas/lib/src/theme/grid/`.
abstract final class DievasBreakpointPrimitives {
  /// 0px — smallest viewport. Baseline mobile.
  static const double XS = 0;

  /// 360px — small mobile. Entry-level handset width.
  static const double SM = 360;

  /// 700px — medium / tablet portrait.
  static const double MD = 700;

  /// 1000px — large / tablet landscape.
  static const double LG = 1000;

  /// 1348px — extra-large / desktop.
  static const double XL = 1348;
}
