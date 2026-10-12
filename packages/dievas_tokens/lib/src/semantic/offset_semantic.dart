// Semantic offset tokens.
//
// Pure Dart. No Flutter dependency.
// Named aliases over DievasOffsetPrimitives for shadow positioning.

import 'package:dievas_tokens/src/primitives/offset_primitives.dart';

/// Semantic offset tokens for the Dievas design system.
///
/// References [DievasOffsetPrimitives] exclusively.
abstract final class DievasOffsetSemantic {
  /// Subtle drop shadow — 1px vertical.
  static const double XS = DievasOffsetPrimitives.y1;

  /// Small elevation — 2px vertical.
  static const double SM = DievasOffsetPrimitives.y2;

  /// Medium elevation — 4px vertical.
  static const double MD = DievasOffsetPrimitives.y4;

  /// Large elevation — 8px vertical.
  static const double LG = DievasOffsetPrimitives.y8;

  /// Extra-large elevation — 16px vertical.
  static const double XL = DievasOffsetPrimitives.y16;
}
