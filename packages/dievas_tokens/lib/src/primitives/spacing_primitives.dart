// Spacing primitives — all values on a 4pt base grid.
// Used for padding, margin, gap, and positional offsets.
// Named by multiplier: s1 = 1×4pt = 4.0, s2 = 2×4pt = 8.0, etc.

abstract final class DievasSpacingPrimitives {
  /// none
  static const double s0 = 0.0;

  /// xs
  static const double s1 = 4.0;

  /// sm
  static const double s2 = 8.0;
  static const double s3 = 12.0;

  /// md (base unit)
  static const double s4 = 16.0;
  static const double s5 = 20.0;

  /// lg
  static const double s6 = 24.0;
  static const double s7 = 28.0;

  /// xl
  static const double s8 = 32.0;
  static const double s10 = 40.0;

  /// 2xl
  static const double s12 = 48.0;
  static const double s14 = 56.0;

  /// 3xl
  static const double s16 = 64.0;
  static const double s20 = 80.0;

  /// 4xl & more
  static const double s24 = 96.0;
  static const double s32 = 128.0;
  static const double s40 = 160.0;
  static const double s48 = 192.0;
  static const double s64 = 256.0;
}
