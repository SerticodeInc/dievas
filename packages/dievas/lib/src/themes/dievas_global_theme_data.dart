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
    DievasAnimationThemeData animation = const DievasAnimationThemeData(),
    DievasBorderThemeData border = const DievasBorderThemeData(),
    DievasSpacingThemeData spacing = const DievasSpacingThemeData(),
    DievasSizingThemeData sizing = const DievasSizingThemeData(),
    DievasElevationThemeData? elevation,
    DievasOpacityThemeData opacity = const DievasOpacityThemeData(),
    DievasComponentThemeData? components,
  }) : _animation = animation,
       _colors = colors,
       _border = border,
       _spacing = spacing,
       _sizing = sizing,
       _opacity = opacity {
    _typography = _createTypographyData(colors.text.textPrimary);
    _elevation = elevation ?? _buildDefaultElevation(colors);
    _components = _deriveDievasComponentThemeData(
      colors,
      _typography,
      spacing,
      sizing,
      border,
      animation,
      _elevation,
      components,
    );
    _material = _buildMaterial(colors);
  }

  final DievasAnimationThemeData _animation;
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
  DievasAnimationThemeData get animation => _animation;

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

    // Helper to construct ambient BoxShadow from tokens — centred, no directional offset.
    BoxShadow layer({required double blur, required double opacity}) =>
        BoxShadow(color: shadow.withAlpha((opacity * 255).round()), blurRadius: blur, offset: Offset.zero);

    return DievasElevationThemeData(
      none: const [],
      xs: [layer(blur: DievasElevationShadowLayer.xs.blur, opacity: DievasOpacitySemantic.shadow1)],
      sm: [
        layer(blur: DievasElevationShadowLayer.smUpper.blur, opacity: DievasOpacitySemantic.shadow2Upper),
        layer(blur: DievasElevationShadowLayer.smLower.blur, opacity: DievasOpacitySemantic.shadow2Lower),
      ],
      md: [
        layer(blur: DievasElevationShadowLayer.mdUpper.blur, opacity: DievasOpacitySemantic.shadow2Upper),
        layer(blur: DievasElevationShadowLayer.mdLower.blur, opacity: DievasOpacitySemantic.shadow2),
      ],
      lg: [
        layer(blur: DievasElevationShadowLayer.lgUpper.blur, opacity: DievasOpacitySemantic.shadow1Light),
        layer(blur: DievasElevationShadowLayer.lgLower.blur, opacity: DievasOpacitySemantic.shadow2),
      ],
      xl: [
        layer(blur: DievasElevationShadowLayer.xlUpper.blur, opacity: DievasOpacitySemantic.shadow1Light),
        layer(blur: DievasElevationShadowLayer.xlLower.blur, opacity: DievasOpacitySemantic.shadow2Heavy),
      ],
    );
  }

  static ThemeData _buildMaterial(DievasColourThemeData colors) {
    final brightness = colors.brightness;
    final seedColor = colors.action.actionPrimary;
    final scaffoldBg = colors.background.bgBase;
    final textColor = colors.text.textPrimary;

    final base = ThemeData(
      brightness: brightness,
      colorScheme: .fromSeed(seedColor: seedColor, brightness: brightness),
      scaffoldBackgroundColor: scaffoldBg,
      useMaterial3: true,
      fontFamily: DievasFontFamilyPrimitives.sans,
    );

    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        displayLarge: base.textTheme.displayLarge?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
          color: textColor,
        ),
        displayMedium: base.textTheme.displayMedium?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
          color: textColor,
        ),
        displaySmall: base.textTheme.displaySmall?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
          color: textColor,
        ),
        headlineLarge: base.textTheme.headlineLarge?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
          color: textColor,
        ),
        headlineMedium: base.textTheme.headlineMedium?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
          color: textColor,
        ),
        headlineSmall: base.textTheme.headlineSmall?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
          color: textColor,
        ),
        titleLarge: base.textTheme.titleLarge?.copyWith(color: textColor),
        titleMedium: base.textTheme.titleMedium?.copyWith(color: textColor),
        titleSmall: base.textTheme.titleSmall?.copyWith(color: textColor),
        bodyLarge: base.textTheme.bodyLarge?.copyWith(color: textColor),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(color: textColor),
        bodySmall: base.textTheme.bodySmall?.copyWith(color: textColor),
        labelLarge: base.textTheme.labelLarge?.copyWith(color: textColor),
        labelMedium: base.textTheme.labelMedium?.copyWith(color: textColor),
        labelSmall: base.textTheme.labelSmall?.copyWith(color: textColor),
      ),
      primaryTextTheme: base.primaryTextTheme.copyWith(
        displayLarge: base.primaryTextTheme.displayLarge?.copyWith(fontFamily: DievasFontFamilyPrimitives.sansExtended),
        displayMedium: base.primaryTextTheme.displayMedium?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
        ),
        displaySmall: base.primaryTextTheme.displaySmall?.copyWith(fontFamily: DievasFontFamilyPrimitives.sansExtended),
        headlineLarge: base.primaryTextTheme.headlineLarge?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
        ),
        headlineMedium: base.primaryTextTheme.headlineMedium?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
        ),
        headlineSmall: base.primaryTextTheme.headlineSmall?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
        ),
      ),
    );
  }
}
