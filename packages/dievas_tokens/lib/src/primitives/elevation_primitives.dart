/// Raw elevation scale for the Dievas design system. Pure Dart, no Flutter.
/// Atomic shadow blur radius values on a geometric scale from e0 (flat) to
/// e5 (highest); consume DievasElevationSemantic instead of these directly.
abstract final class DievasElevationPrimitives {
  /// 0px no shadow.
  static const double e0 = 0.0;

  /// 2px hairline shadow.
  static const double e1 = 2.0;

  /// 4px subtle lift.
  static const double e2 = 4.0;

  /// 8px medium raise.
  static const double e3 = 8.0;

  /// 16px prominent float.
  static const double e4 = 16.0;

  /// 24px maximum depth. Modals, bottom sheets.
  static const double e5 = 24.0;
}
