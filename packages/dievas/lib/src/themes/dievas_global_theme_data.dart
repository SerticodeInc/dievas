part of '../themes.dart';

/// Sealed abstract base for all Dievas theme implementations.
///
/// Sub classing [DievasGlobalThemeData] is the contract for both the built-in
/// default themes and consumer app brand themes. Subclasses provide:
/// - [colours] — the full colour token set for their brand / mode
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
///         colours: const DievasColourThemeData(...),
///         border: const DievasBorderThemeData(),
///       );
///
///   @override
///   DievasThemeData copyWith({DievasComponentThemeData? components}) =>
///       CadenceLightThemeData(components: components ?? this.components);
/// }
/// ```
base class DievasGlobalThemeData implements DievasThemeData {
  DievasGlobalThemeData({
    required DievasColourThemeData colours,
    DievasAnimationThemeData animation = const DievasAnimationThemeData(),
    DievasBorderThemeData border = const DievasBorderThemeData(),
    DievasSpacingThemeData spacing = const DievasSpacingThemeData(),
    DievasSizingThemeData sizing = const DievasSizingThemeData(),
    DievasElevationThemeData? elevation,
    DievasOpacityThemeData opacity = const DievasOpacityThemeData(),
    DievasComponentThemeData? components,
    DievasTypographyThemeData? typography,
  }) : _animation = animation,
       _colours = colours,
       _border = border,
       _spacing = spacing,
       _sizing = sizing,
       _opacity = opacity {
    _typography = typography ?? _createTypographyData(colours.text.textPrimary);
    _elevation = elevation ?? _buildDefaultElevation(colours);
    _components = _deriveDievasComponentThemeData(
      colours,
      _typography,
      spacing,
      sizing,
      border,
      animation,
      _elevation,
      components,
    );
    _material = _buildMaterial(colours);
  }

  DievasGlobalThemeData._raw({
    required DievasColourThemeData colours,
    required DievasTypographyThemeData typography,
    required DievasElevationThemeData elevation,
    required DievasComponentThemeData components,
    required ThemeData material,
    required DievasAnimationThemeData animation,
    required DievasBorderThemeData border,
    required DievasSpacingThemeData spacing,
    required DievasSizingThemeData sizing,
    required DievasOpacityThemeData opacity,
  }) : _animation = animation,
       _colours = colours,
       _border = border,
       _spacing = spacing,
       _sizing = sizing,
       _opacity = opacity,
       _typography = typography,
       _elevation = elevation,
       _components = components,
       _material = material;

  final DievasAnimationThemeData _animation;
  final DievasColourThemeData _colours;
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
  DievasColourThemeData get colours => _colours;

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

  @override
  DievasThemeData copyWith({DievasComponentThemeData? components, DievasTypographyThemeData? typography}) {
    final typographyChanged = typography != null;
    final componentsChanged = components != null;
    if (!typographyChanged && !componentsChanged) return this;

    final newTypography = typography ?? _typography;
    final newComponents = _deriveDievasComponentThemeData(
      _colours,
      newTypography,
      _spacing,
      _sizing,
      _border,
      _animation,
      _elevation,
      components,
    );

    return DievasGlobalThemeData._raw(
      colours: _colours,
      animation: _animation,
      border: _border,
      spacing: _spacing,
      sizing: _sizing,
      elevation: _elevation,
      opacity: _opacity,
      typography: newTypography,
      components: newComponents,
      material: _material,
    );
  }

  static DievasElevationThemeData _buildDefaultElevation(DievasColourThemeData colours) {
    // Shadow colour: always derived from the overlay base — not the brand colour.
    final shadow = colours.staticColours.staticBlack;

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

  static ThemeData _buildMaterial(DievasColourThemeData colours) {
    final brightness = colours.brightness;
    final seedColour = colours.action.actionPrimary;
    final scaffoldBg = colours.background.bgBase;
    final textColour = colours.text.textPrimary;

    final base = ThemeData(
      brightness: brightness,
      colorScheme: .fromSeed(seedColor: seedColour, brightness: brightness),
      scaffoldBackgroundColor: scaffoldBg,
      useMaterial3: true,
      fontFamily: DievasFontFamilyPrimitives.sans,
    );

    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        displayLarge: base.textTheme.displayLarge?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
          color: textColour,
        ),
        displayMedium: base.textTheme.displayMedium?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
          color: textColour,
        ),
        displaySmall: base.textTheme.displaySmall?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
          color: textColour,
        ),
        headlineLarge: base.textTheme.headlineLarge?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
          color: textColour,
        ),
        headlineMedium: base.textTheme.headlineMedium?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
          color: textColour,
        ),
        headlineSmall: base.textTheme.headlineSmall?.copyWith(
          fontFamily: DievasFontFamilyPrimitives.sansExtended,
          color: textColour,
        ),
        titleLarge: base.textTheme.titleLarge?.copyWith(color: textColour),
        titleMedium: base.textTheme.titleMedium?.copyWith(color: textColour),
        titleSmall: base.textTheme.titleSmall?.copyWith(color: textColour),
        bodyLarge: base.textTheme.bodyLarge?.copyWith(color: textColour),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(color: textColour),
        bodySmall: base.textTheme.bodySmall?.copyWith(color: textColour),
        labelLarge: base.textTheme.labelLarge?.copyWith(color: textColour),
        labelMedium: base.textTheme.labelMedium?.copyWith(color: textColour),
        labelSmall: base.textTheme.labelSmall?.copyWith(color: textColour),
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
