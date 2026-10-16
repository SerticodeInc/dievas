/// Raw border radius primitives, applied to containers, cards, buttons,
/// inputs, and overlays. Small sizes use role names, larger sizes use `r<px>`
/// names, and full is used for pill shapes and circular avatars.
abstract final class DievasRadiusPrimitives {
  /// 0px. Square corners.
  static const double none = 0.0;

  /// 2px.
  static const double xs = 2.0;

  /// 4px.
  static const double sm = 4.0;

  /// 8px. Default rounding.
  static const double md = 8.0;

  /// 12px.
  static const double lg = 12.0;

  /// 16px.
  static const double xl = 16.0;

  /// 20px.
  static const double xl2 = 20.0;

  /// 24px.
  static const double r24 = 24.0;

  /// 28px.
  static const double r28 = 28.0;

  /// 32px.
  static const double r32 = 32.0;

  /// 36px.
  static const double r36 = 36.0;

  /// 40px.
  static const double r40 = 40.0;

  /// 48px.
  static const double r48 = 48.0;

  /// 56px.
  static const double r56 = 56.0;

  /// 64px.
  static const double r64 = 64.0;

  /// 9999px. Pill shapes and circular avatars.
  static const double full = 9999.0;
}
