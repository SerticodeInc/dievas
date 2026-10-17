part of '../themes.dart';

/// Sealed abstract base for all Dievas theme implementations.
///
/// Sub classing [DievasGlobalThemeData] is the contract for both the built-in
/// default themes and consumer app brand themes. Subclasses provide:
/// - [colours] — the full colour token set for their brand / mode
/// - [brandPalette] — optional brand palette; when supplied, every
///   brand-derived colour role is re-resolved from it (see
///   [applyBrandPalette]) on top of [colours]
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
    DievasBrandPalette? brandPalette,
    DievasAnimationThemeData animation = const DievasAnimationThemeData(),
    DievasBorderThemeData border = const DievasBorderThemeData(),
    DievasSpacingThemeData spacing = const DievasSpacingThemeData(),
    DievasSizingThemeData sizing = const DievasSizingThemeData(),
    DievasElevationThemeData? elevation,
    DievasZIndexThemeData zIndex = const DievasZIndexThemeData(),
    DievasOpacityThemeData opacity = const DievasOpacityThemeData(),
    DievasComponentThemeData? components,
    DievasTypographyThemeData? typography,
  }) : _animation = animation,
       _colours = brandPalette == null ? colours : applyBrandPalette(colours, brandPalette),
       _border = border,
       _spacing = spacing,
       _sizing = sizing,
       _zIndex = zIndex,
       _opacity = opacity {
    _typography = typography ?? _createTypographyData(_colours.text.textPrimary);
    _elevation = elevation ?? _buildDefaultElevation();
    _components = _deriveDievasComponentThemeData(
      _colours,
      _typography,
      spacing,
      sizing,
      border,
      animation,
      _elevation,
      components,
    );
    _material = _buildMaterial(_colours, _typography);
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
    required DievasZIndexThemeData zIndex,
    required DievasOpacityThemeData opacity,
  }) : _animation = animation,
       _colours = colours,
       _border = border,
       _spacing = spacing,
       _sizing = sizing,
       _zIndex = zIndex,
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
  final DievasZIndexThemeData _zIndex;
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
  DievasZIndexThemeData get zIndex => _zIndex;

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
      zIndex: _zIndex,
      opacity: _opacity,
      typography: newTypography,
      components: newComponents,
      material: _material,
    );
  }

  static DievasElevationThemeData _buildDefaultElevation() {
    // Shadow ink: a soft near-black, scoped to elevation. Deliberately not
    // the pure staticBlack, which reads heavy on surfaces.
    final shadow = Color(DievasElevationSemantic.shadowColour);

    // Layers are painted centred — no vertical offset — so depth reads as a
    // soft halo around the surface rather than a drop shadow underneath it.
    List<BoxShadow> stack(List<DievasElevationShadow> layers) => [
      for (final layer in layers)
        BoxShadow(color: shadow.withAlpha((layer.tint * 255).round()), blurRadius: layer.blur),
    ];

    return DievasElevationThemeData(
      NONE: const [],
      XS: stack(DievasElevationShadowLayer.XS),
      SM: stack(DievasElevationShadowLayer.SM),
      MD: stack(DievasElevationShadowLayer.MD),
      LG: stack(DievasElevationShadowLayer.LG),
      XL: stack(DievasElevationShadowLayer.XL),
    );
  }

  static ThemeData _buildMaterial(DievasColourThemeData colours, DievasTypographyThemeData typography) {
    final brightness = colours.brightness;
    final seedColour = colours.action.buttonPrimaryBackground;
    final scaffoldBg = colours.background.pageBackground;
    final textColour = colours.text.textPrimary;
    final baseFont = typography.bodyMD.fontFamily ?? DievasFontFamilyPrimitives.sans;
    final displayFont = typography.displaySM.fontFamily ?? DievasFontFamilyPrimitives.sansExtended;

    final base = ThemeData(
      brightness: brightness,
      colorScheme: .fromSeed(
        seedColor: seedColour,
        brightness: brightness,
        primary: colours.core.primary,
        onPrimary: colours.text.buttonPrimaryText,
      ),
      scaffoldBackgroundColor: scaffoldBg,
      useMaterial3: true,
      fontFamily: baseFont,
    );

    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        displayLarge: base.textTheme.displayLarge?.copyWith(fontFamily: displayFont, color: textColour),
        displayMedium: base.textTheme.displayMedium?.copyWith(fontFamily: displayFont, color: textColour),
        displaySmall: base.textTheme.displaySmall?.copyWith(fontFamily: displayFont, color: textColour),
        headlineLarge: base.textTheme.headlineLarge?.copyWith(fontFamily: displayFont, color: textColour),
        headlineMedium: base.textTheme.headlineMedium?.copyWith(fontFamily: displayFont, color: textColour),
        headlineSmall: base.textTheme.headlineSmall?.copyWith(fontFamily: displayFont, color: textColour),
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
        displayLarge: base.primaryTextTheme.displayLarge?.copyWith(fontFamily: displayFont),
        displayMedium: base.primaryTextTheme.displayMedium?.copyWith(fontFamily: displayFont),
        displaySmall: base.primaryTextTheme.displaySmall?.copyWith(fontFamily: displayFont),
        headlineLarge: base.primaryTextTheme.headlineLarge?.copyWith(fontFamily: displayFont),
        headlineMedium: base.primaryTextTheme.headlineMedium?.copyWith(fontFamily: displayFont),
        headlineSmall: base.primaryTextTheme.headlineSmall?.copyWith(fontFamily: displayFont),
      ),
    );
  }
}
