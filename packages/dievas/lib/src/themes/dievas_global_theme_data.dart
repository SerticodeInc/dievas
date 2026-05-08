part of '../themes.dart';

/// Sealed abstract base for all Dievas theme implementations.
///
/// Subclassing [DievasGlobalThemeData] is the contract for both the built-in
/// default themes and consumer app brand themes. Subclasses provide:
/// - [colors] — the full colour token set for their brand / mode
/// - [border] — optional border radius overrides (defaults work for most brands)
///
/// Everything else — typography, component theme data, Material bridge — is
/// derived automatically inside the constructor.
///
/// ```dart
/// // In a consuming app:
/// class CadenceLightThemeData extends DievasGlobalThemeData {
///   CadenceLightThemeData({super.components})
///     : super(
///         colors: const DievasColourThemeData(...),
///         border: const DievasBorderThemeData(),
///       );
///
///   @override
///   DievasThemeData copyWith({DievasComponentThemeData? components}) =>
///       CadenceLightThemeData(components: components ?? this.components);
/// }
/// ```
sealed class DievasGlobalThemeData implements DievasThemeData {
  DievasGlobalThemeData({
    required DievasColourThemeData colors,
    DievasBorderThemeData border = const DievasBorderThemeData(),
    DievasSpacingThemeData spacing = const DievasSpacingThemeData(),
    DievasSizingThemeData sizing = const DievasSizingThemeData(),
    DievasElevationThemeData? elevation,
    DievasOpacityThemeData opacity = const DievasOpacityThemeData(),
    DievasComponentThemeData? components,
  }) : _colors = colors,
       _border = border,
       _spacing = spacing,
       _sizing = sizing,
       _opacity = opacity {
    _typography = _createTypographyData(colors.text.textPrimary);
    _elevation = elevation ?? _buildDefaultElevation(colors);
    _components = _deriveDievasComponentThemeData(colors, _typography, spacing, sizing, border, components);
    _material = _buildMaterial(colors);
  }

  final DievasColourThemeData _colors;
  final DievasBorderThemeData _border;
  final DievasSpacingThemeData _spacing;
  final DievasSizingThemeData _sizing;
  final DievasOpacityThemeData _opacity;
  late final DievasTypographyThemeData _typography;
  late final DievasElevationThemeData _elevation;
  late final DievasComponentThemeData _components;
  late final ThemeData _material;

  @override
  DievasColourThemeData get colors => _colors;

  @override
  DievasTypographyThemeData get typography => _typography;

  @override
  DievasElevationThemeData get elevation => _elevation;

  @override
  DievasOpacityThemeData get opacity => _opacity;

  @override
  DievasSizingThemeData get sizing => _sizing;

  @override
  DievasSpacingThemeData get spacing => _spacing;

  @override
  DievasBorderThemeData get border => _border;

  @override
  DievasComponentThemeData get components => _components;

  @override
  ThemeData get material => _material;

  static DievasElevationThemeData _buildDefaultElevation(DievasColourThemeData colors) {
    // Shadow colour: always derived from the overlay base — not the brand colour.
    final shadow = colors.staticColours.staticBlack;

    return DievasElevationThemeData(
      none: const [],
      xs: [BoxShadow(color: shadow.withAlpha(13), blurRadius: 1, offset: const Offset(0, 1))],
      sm: [
        BoxShadow(color: shadow.withAlpha(10), blurRadius: 2, offset: const Offset(0, 1)),
        BoxShadow(color: shadow.withAlpha(15), blurRadius: 4, offset: const Offset(0, 2)),
      ],
      md: [
        BoxShadow(color: shadow.withAlpha(10), blurRadius: 4, offset: const Offset(0, 2)),
        BoxShadow(color: shadow.withAlpha(20), blurRadius: 8, offset: const Offset(0, 4)),
      ],
      lg: [
        BoxShadow(color: shadow.withAlpha(8), blurRadius: 8, offset: const Offset(0, 4)),
        BoxShadow(color: shadow.withAlpha(20), blurRadius: 16, offset: const Offset(0, 8)),
      ],
      xl: [
        BoxShadow(color: shadow.withAlpha(8), blurRadius: 16, offset: const Offset(0, 8)),
        BoxShadow(color: shadow.withAlpha(25), blurRadius: 32, offset: const Offset(0, 16)),
      ],
    );
  }

  static ThemeData _buildMaterial(DievasColourThemeData colors) {
    final brightness = colors.brightness;
    final seedColor = colors.action.actionPrimary;
    final scaffoldBg = colors.background.bgBase;

    return ThemeData(
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(seedColor: seedColor, brightness: brightness),
      scaffoldBackgroundColor: scaffoldBg,
      useMaterial3: true,
    );
  }
}
