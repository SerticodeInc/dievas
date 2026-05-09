part of '../themes.dart';

/// Sealed abstract base for all Dievas theme implementations.
///
/// Sub classing [DievasGlobalThemeData] is the contract for both the built-in
/// default themes and consumer app brand themes. Subclasses provide:
/// - [colors] — the full colour token set for their brand / mode
/// - [border] — optional border radius overrides (defaults work for most brands)
///
/// Everything else — typography, component theme data, Material bridge — is
/// derived automatically inside the constructor.
///
/// ```dart
/// In a consuming app:
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

    // Helper to construct BoxShadow from tokens.
    BoxShadow layer({required double blur, required double offsetY, required double opacity}) =>
        BoxShadow(color: shadow.withAlpha((opacity * 255).round()), blurRadius: blur, offset: Offset(0, offsetY));

    return DievasElevationThemeData(
      none: const [],
      xs: [
        layer(
          blur: DievasElevationShadowLayer.xs.blur,
          offsetY: DievasElevationShadowLayer.xs.offsetY,
          opacity: DievasOpacitySemantic.shadow1,
        ),
      ],
      sm: [
        layer(
          blur: DievasElevationShadowLayer.smUpper.blur,
          offsetY: DievasElevationShadowLayer.smUpper.offsetY,
          opacity: DievasOpacitySemantic.shadow2Upper,
        ),
        layer(
          blur: DievasElevationShadowLayer.smLower.blur,
          offsetY: DievasElevationShadowLayer.smLower.offsetY,
          opacity: DievasOpacitySemantic.shadow2Lower,
        ),
      ],
      md: [
        layer(
          blur: DievasElevationShadowLayer.mdUpper.blur,
          offsetY: DievasElevationShadowLayer.mdUpper.offsetY,
          opacity: DievasOpacitySemantic.shadow2Upper,
        ),
        layer(
          blur: DievasElevationShadowLayer.mdLower.blur,
          offsetY: DievasElevationShadowLayer.mdLower.offsetY,
          opacity: DievasOpacitySemantic.shadow2,
        ),
      ],
      lg: [
        layer(
          blur: DievasElevationShadowLayer.lgUpper.blur,
          offsetY: DievasElevationShadowLayer.lgUpper.offsetY,
          opacity: DievasOpacitySemantic.shadow1Light,
        ),
        layer(
          blur: DievasElevationShadowLayer.lgLower.blur,
          offsetY: DievasElevationShadowLayer.lgLower.offsetY,
          opacity: DievasOpacitySemantic.shadow2,
        ),
      ],
      xl: [
        layer(
          blur: DievasElevationShadowLayer.xlUpper.blur,
          offsetY: DievasElevationShadowLayer.xlUpper.offsetY,
          opacity: DievasOpacitySemantic.shadow1Light,
        ),
        layer(
          blur: DievasElevationShadowLayer.xlLower.blur,
          offsetY: DievasElevationShadowLayer.xlLower.offsetY,
          opacity: DievasOpacitySemantic.shadow2Heavy,
        ),
      ],
    );
  }

  static ThemeData _buildMaterial(DievasColourThemeData colors) {
    final brightness = colors.brightness;
    final seedColor = colors.action.actionPrimary;
    final scaffoldBg = colors.background.bgBase;

    return ThemeData(
      brightness: brightness,
      colorScheme: .fromSeed(seedColor: seedColor, brightness: brightness),
      scaffoldBackgroundColor: scaffoldBg,
      useMaterial3: true,
    );
  }
}
