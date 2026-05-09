// Opacity primitives — used for disabled states, overlays, and ghost effects.
// Named by percentage: o0 = 0%, o100 = 100%.

abstract final class DievasOpacityPrimitives {
  static const double o0 = 0.00;
  static const double o5 = 0.05;
  static const double o8 = 0.08;
  static const double o10 = 0.10;
  static const double o13 = 0.13;
  static const double o15 = 0.15;
  static const double o16 = 0.16;
  static const double o20 = 0.20;
  static const double o24 = 0.24;
  static const double o25 = 0.25;
  static const double o32 = 0.32;
  static const double o40 = 0.40;
  static const double o48 = 0.48;
  static const double o56 = 0.56;
  static const double o64 = 0.64;
  static const double o72 = 0.72;
  static const double o80 = 0.80;
  static const double o88 = 0.88;
  static const double o96 = 0.96;
  static const double o100 = 1.00;

  /// Semantic aliases (used directly in component definitions)
  /// disabled interactive elements
  static const double disabled = o40;

  /// modal / bottom sheet scrim
  static const double overlay = o56;

  /// ghost hover states
  static const double ghost = o8;
}
