// Semantic breakpoint tokens.
//
// Pure Dart. No Flutter dependency.
// Named aliases over DievasBreakpointPrimitives for responsive layout
// decisions across the design system.

import '../primitives/breakpoint_primitives.dart';

/// Semantic breakpoint tokens for the Dievas design system.
///
/// References [DievasBreakpointPrimitives] exclusively — no raw doubles
/// are permitted in this file.
abstract final class DievasBreakpointSemantic {
  /// 0px+ — smallest viewport. Baseline mobile layout.
  static const double xs = DievasBreakpointPrimitives.xs;

  /// 360px+ — small mobile / entry-level handset.
  static const double sm = DievasBreakpointPrimitives.sm;

  /// 700px+ — tablet portrait.
  static const double md = DievasBreakpointPrimitives.md;

  /// 1000px+ — tablet landscape.
  static const double lg = DievasBreakpointPrimitives.lg;

  /// 1348px+ — desktop.
  static const double xl = DievasBreakpointPrimitives.xl;
}
