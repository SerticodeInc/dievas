// Semantic opacity tokens: named aliases over DievasOpacityPrimitives. Role
// tokens cover disabled states, overlays, hover effects, and ghost elements;
// the `O<percent>` scale exposes every opacity primitive by percentage.

import 'package:dievas_tokens/src/primitives/opacity_primitives.dart';

/// Semantic opacity tokens for the Dievas design system. References
/// [DievasOpacityPrimitives] exclusively. Role tokens name the common cases,
/// while the `O<percent>` scale exposes every primitive for arbitrary alpha.
abstract final class DievasOpacitySemantic {
  // Component roles

  /// 40%: disabled interactive elements (buttons, inputs, icons).
  static const double disabled = DievasOpacityPrimitives.o40;

  /// 8%: ghost hover surface tint (icon buttons, list tiles).
  static const double hoverGhost = DievasOpacityPrimitives.o8;

  /// 16%: pressed / active surface tint.
  static const double pressedGhost = DievasOpacityPrimitives.o16;

  /// 12%: focus ring fill (keyboard focus highlight).
  static const double focusRing = DievasOpacityPrimitives.o12;

  /// 56%: modal / bottom sheet scrim overlay.
  static const double overlay = DievasOpacityPrimitives.o56;

  /// 0%: fully transparent. Animation start states.
  static const double transparent = DievasOpacityPrimitives.o0;

  /// 100%: fully opaque. Animation end states and solid surfaces.
  static const double opaque = DievasOpacityPrimitives.o100;

  // Percentage scale

  /// 0%.
  static const double O0 = DievasOpacityPrimitives.o0;

  /// 4%.
  static const double O4 = DievasOpacityPrimitives.o4;

  /// 8%.
  static const double O8 = DievasOpacityPrimitives.o8;

  /// 12%.
  static const double O12 = DievasOpacityPrimitives.o12;

  /// 16%.
  static const double O16 = DievasOpacityPrimitives.o16;

  /// 20%.
  static const double O20 = DievasOpacityPrimitives.o20;

  /// 24%.
  static const double O24 = DievasOpacityPrimitives.o24;

  /// 28%.
  static const double O28 = DievasOpacityPrimitives.o28;

  /// 32%.
  static const double O32 = DievasOpacityPrimitives.o32;

  /// 40%.
  static const double O40 = DievasOpacityPrimitives.o40;

  /// 48%.
  static const double O48 = DievasOpacityPrimitives.o48;

  /// 56%.
  static const double O56 = DievasOpacityPrimitives.o56;

  /// 64%.
  static const double O64 = DievasOpacityPrimitives.o64;

  /// 72%.
  static const double O72 = DievasOpacityPrimitives.o72;

  /// 80%.
  static const double O80 = DievasOpacityPrimitives.o80;

  /// 88%.
  static const double O88 = DievasOpacityPrimitives.o88;

  /// 96%.
  static const double O96 = DievasOpacityPrimitives.o96;

  /// 100%.
  static const double O100 = DievasOpacityPrimitives.o100;
}
