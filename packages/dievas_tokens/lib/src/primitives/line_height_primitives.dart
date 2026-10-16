/// Raw line height primitives for the Dievas typography system.
///
/// Values are unitless multipliers (1.0 = 100% of font size).
abstract final class DievasLineHeightPrimitives {
  /// 1.0 (100%).
  static const double none = 1.0;

  /// 1.25 (125%).
  static const double tight = 1.25;

  /// 1.375 (137.5%).
  static const double snug = 1.375;

  /// 1.5 (150%). Default body leading.
  static const double normal = 1.5;

  /// 1.625 (162.5%).
  static const double relaxed = 1.625;

  /// 2.0 (200%).
  static const double loose = 2.0;
}
