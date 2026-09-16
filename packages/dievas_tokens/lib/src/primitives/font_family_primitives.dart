/// Raw font-family primitives for the Dievas typography system.
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
