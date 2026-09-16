part of 'example_theme.dart';

/// Raw brand token values for the Example App.
///
/// Pure `int` ARGB values — no `Color` wrapping here. Wrapping happens in the
/// colour sets of [ExampleLightThemeData] / [ExampleDarkThemeData].
///
/// Theme-independent values live on this class; anything that differs per mode
/// lives in the theme files. Values that don't need a brand identity fall back
/// to the Dievas semantic defaults (`DievasColourSemanticLight` / `Dark`).
abstract final class ExampleColours {
  ExampleColours._();

  /// Brand — theme-independent.
  static const int brand = 0xFFC9C3F2; // lavender
  static const int brandSubtle = 0xFFE6A889; // peach
  static const int onBrand = 0xFF100C23; // near-black indigo

  /// Text / icon — one value per mode.
  static const int textDark = 0xFF1E163E;
  static const int textLight = 0xFFC9C3F2;
  static const int textLavender = 0xFF6C609C;

  /// Borders.
  static const int borderBrand = 0xFFC9C3F2;

  /// Actions — light mode.
  static const int actionPrimary = 0xFF1E163E;
  static const int actionPrimaryHover = 0xFF352D57;
  static const int actionPrimaryActive = 0xFF474170;
  static const int actionSecondary = 0xFFE6A889;
  static const int actionSecondaryHover = 0xFFD9977A;

  /// Actions — dark mode.
  static const int actionPrimaryDark = 0xFFC9C3F2;
  static const int actionPrimaryHoverDark = 0xFFB4ADE8;
  static const int actionPrimaryActiveDark = 0xFFA099D8;

  /// Static — theme-independent.
  static const int staticWhite = 0xFFF2F0E8;
  static const int staticBlack = 0xFF171717;
  static const int staticGrey = 0xFFE7E6EE;
  static const int actualWhite = 0xFFFFFFFF;
  static const int warning = 0xFFAD6239;
  static const int warningBG = 0xFFFAE9DF;
  static const int transparent = 0x00000000;

  /// Backgrounds.
  static const int bgLight = brand;
  static const int bgDark = onBrand;
  static const int scaffoldBG = 0xFFF2F0E8;

  /// Plan-card gradients.
  static const int cardProGradientStart = 0xFF1A103B;
  static const int cardProGradientEnd = 0xFF2B1B56;
}

/// Resolved font families for the Example App.
///
/// Uses [GoogleFonts] to bundle Cascadia Code at runtime. The Dievas default
/// themes ship MartianMono; brand apps override typography to use their own
/// typefaces, exactly as shown in [buildExampleTypography].
abstract final class ExampleFonts {
  ExampleFonts._();
  static String? _cachedFont;

  /// Cascadia Code — display, body, and code in this example brand.
  static String get cascadiaCode => _cachedFont ??= GoogleFonts.cascadiaCode().fontFamily ?? 'Cascadia Code';
}
