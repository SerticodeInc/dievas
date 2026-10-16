/// Raw font family primitives for the Dievas typography system.
abstract final class DievasFontFamilyPrimitives {
  /// Martian Mono, used for body, label, title, and UI copy.
  /// Font files are registered in packages/dievas/pubspec.yaml under fonts:.
  static const String sans = 'MartianMono';

  /// Martian Mono, used for display and heading styles.
  /// Same family as sans; weight is selected via typography tokens.
  static const String sansExtended = 'MartianMono';

  /// Cascadia Code, used for code snippets, inline code, and monospaced output.
  /// For Flutter: drop .ttf/.otf in packages/dievas/assets/fonts/ and register
  /// family: "Cascadia Code" in pubspec.yaml. For web: Google Fonts serves it.
  static const String mono = 'Cascadia Code';
}
