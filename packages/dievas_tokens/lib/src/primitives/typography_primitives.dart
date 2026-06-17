abstract final class DievasFontSizePrimitives {
  static const double xs = 11.0;
  static const double sm = 12.0;
  static const double md = 14.0;
  static const double base = 16.0;
  static const double lg = 18.0;
  static const double xl = 20.0;
  static const double x2l = 24.0;
  static const double x3l = 28.0;
  static const double x4l = 32.0;
  static const double x5l = 36.0;
  static const double x6l = 48.0;
  static const double x7l = 60.0;
  static const double x8l = 72.0;
}

abstract final class DievasLineHeightPrimitives {
  static const double none = 1.0;
  static const double tight = 1.25;
  static const double snug = 1.375;
  static const double normal = 1.5;
  static const double relaxed = 1.625;
  static const double loose = 2.0;
}

abstract final class DievasFontWeightPrimitives {
  static const int thin = 100;
  static const int extraLight = 200;
  static const int light = 300;
  static const int regular = 400;
  static const int medium = 500;
  static const int semiBold = 600;
  static const int bold = 700;
  static const int extraBold = 800;
  static const int black = 900;
}

abstract final class DievasLetterSpacingPrimitives {
  static const double tighter = -0.8;
  static const double tight = -0.4;
  static const double normal = 0.0;
  static const double wide = 0.4;
  static const double wider = 0.8;
  static const double widest = 1.6;
}

abstract final class DievasFontFamilyPrimitives {
  /// Martian Mono — body, label, title, and UI copy.
  /// Font files registered in packages/dievas/pubspec.yaml under flutter: fonts:.
  static const String sans = 'MartianMono';

  /// Martian Mono — display and heading styles.
  /// Same family; weight selected via typography tokens.
  static const String sansExtended = 'MartianMono';

  /// Cascadia Code — code snippets, inline code, and monospaced output.
  ///
  /// For Flutter: download .ttf/.otf, drop in packages/dievas/assets/fonts/,
  /// then register with family: "Cascadia Code" in packages/dievas/pubspec.yaml.
  ///
  /// For web: Google Fonts serves this family directly.
  static const String mono = 'Cascadia Code';
}
