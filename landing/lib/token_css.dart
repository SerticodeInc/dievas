/// Renders a Dievas ARGB token int as a CSS `rgba()` string.
///
/// Mirrors the logic in `tool/generate_theme.dart` so server-rendered
/// value readouts match the generated stylesheets exactly.
String tokenRgba(int argb) {
  final a = (argb >> 24) & 0xFF;
  final r = (argb >> 16) & 0xFF;
  final g = (argb >> 8) & 0xFF;
  final b = argb & 0xFF;
  final alpha = a == 0xFF ? '1' : (a / 255).toStringAsFixed(3);
  return 'rgba($r, $g, $b, $alpha)';
}