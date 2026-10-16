// Semantic breakpoint tokens.
//
// Pure Dart. No Flutter dependency.
// Named aliases over DievasBreakpointPrimitives for responsive layout
// decisions across the design system.

import 'package:dievas_tokens/src/primitives/breakpoint_primitives.dart';

/// Semantic breakpoint tokens for the Dievas design system.
///
/// References [DievasBreakpointPrimitives] exclusively — no raw doubles
/// are permitted in this file.
abstract final class DievasBreakpointSemantic {
  /// 0px+ — smallest viewport. Baseline mobile layout.
  static const double XS = DievasBreakpointPrimitives.XS;

  /// 360px+ — small mobile / entry-level handset.
  static const double SM = DievasBreakpointPrimitives.SM;

  /// 700px+ — tablet portrait.
  static const double MD = DievasBreakpointPrimitives.MD;

  /// 1000px+ — tablet landscape.
  static const double LG = DievasBreakpointPrimitives.LG;

  /// 1348px+ — desktop.
  static const double XL = DievasBreakpointPrimitives.XL;
}
