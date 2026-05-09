// Semantic offset tokens.
//
// Pure Dart. No Flutter dependency.
// Named aliases over DievasOffsetPrimitives for shadow positioning.

import '../primitives/offset_primitives.dart';

/// Semantic offset tokens for the Dievas design system.
///
/// References [DievasOffsetPrimitives] exclusively.
abstract final class DievasOffsetSemantic {
  /// Subtle drop shadow — 1px vertical.
  static const double xs = DievasOffsetPrimitives.y1;

  /// Small elevation — 2px vertical.
  static const double sm = DievasOffsetPrimitives.y2;

  /// Medium elevation — 4px vertical.
  static const double md = DievasOffsetPrimitives.y4;

  /// Large elevation — 8px vertical.
  static const double lg = DievasOffsetPrimitives.y8;

  /// Extra-large elevation — 16px vertical.
  static const double xl = DievasOffsetPrimitives.y16;
}