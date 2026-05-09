// Semantic opacity tokens.
//
// Pure Dart. No Flutter dependency.
// Named aliases over DievasOpacityPrimitives for consistent transparency
// across disabled states, overlays, hover effects, and ghost elements.

import '../primitives/opacity_primitives.dart';

/// Semantic opacity tokens for the Dievas design system.
///
/// References [DievasOpacityPrimitives] exclusively.
abstract final class DievasOpacitySemantic {
  /// 40% — disabled interactive elements (buttons, inputs, icons).
  static const double disabled = DievasOpacityPrimitives.o40;

  /// 8% — ghost hover surface tint (icon buttons, list tiles).
  static const double hoverGhost = DievasOpacityPrimitives.o8;

  /// 16% — pressed / active surface tint.
  static const double pressedGhost = DievasOpacityPrimitives.o16;

  /// 10% — focus ring fill (keyboard focus highlight).
  static const double focusRing = DievasOpacityPrimitives.o10;

  /// 56% — modal / bottom sheet scrim overlay.
  static const double overlay = DievasOpacityPrimitives.overlay;

  /// 0% — fully transparent. Animation start states.
  static const double transparent = DievasOpacityPrimitives.o0;

  /// 100% — fully opaque. Animation end states and solid surfaces.
  static const double opaque = DievasOpacityPrimitives.o100;

  /// 13% — shadow layer 1 (elevations xs).
  static const double shadow1 = DievasOpacityPrimitives.o13;

  /// 10% — shadow layer 2 upper (elevations sm, md).
  static const double shadow2Upper = DievasOpacityPrimitives.o10;

  /// 15% — shadow layer 2 lower (elevations sm).
  static const double shadow2Lower = DievasOpacityPrimitives.o15;

  /// 20% — shadow layer 2 (elevations md, lg).
  static const double shadow2 = DievasOpacityPrimitives.o20;

  /// 8% — shadow layer 1 (elevations lg, xl).
  static const double shadow1Light = DievasOpacityPrimitives.o8;

  /// 25% — shadow layer 2 (elevations xl).
  static const double shadow2Heavy = DievasOpacityPrimitives.o25;
}
