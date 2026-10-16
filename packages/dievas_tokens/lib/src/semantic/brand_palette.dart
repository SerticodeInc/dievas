// Brand palette selection for the Dievas design system. A palette is a full
// 11 tint colour ramp plus a contrast colour, so an app can reskin its entire
// brand by picking one family. Defaults to [DievasBrandPalettes.indigo].

import 'package:dievas_tokens/src/primitives/colour_primitives.dart';

/// The concrete brand derived colour roles produced by a palette at a given
/// brightness. Values are ARGB ints; the `dievas` Flutter package wraps them
/// in `Color` objects.
typedef DievasBrandRoleColours = ({
  int badgePrimaryBackground,
  int badgePrimaryTintedText,
  int checkboxCheckedBackground,
  int radioSelectedBackground,
  int progressIndicator,
  int sliderActiveTrack,
  int inputCursor,
  int segmentedControlSelectedBackground,
  int tabSelectedIndicator,
  int badgePrimaryText,
  int checkboxCheckmark,
  int radioDot,
  int progressOnPrimaryIndicator,
  int segmentedControlSelectedText,

  int primary,
  int badgePrimaryTintedBackground,
  int buttonPrimaryText,
  int buttonPrimaryBackground,
  int buttonPrimaryHoveredBackground,
  int buttonPrimaryPressedBackground,
  int buttonSecondaryBackground,
  int buttonSecondaryHoveredBackground,
  int selectionBorder,
  int focusIndicatorColour,
  int inputFocusedBorder,
  int switchOnTrack,
});

/// A selectable brand palette: the full tint ramp for one colour family. Light
/// surfaces want mid or deep tints for contrast; dark surfaces want lighter
/// tints (see [rolesForLight] and [rolesForDark]).
final class DievasBrandPalette {
  const DievasBrandPalette({
    required this.name,
    required this.s50,
    required this.s100,
    required this.s200,
    required this.s300,
    required this.s400,
    required this.s500,
    required this.s600,
    required this.s700,
    required this.s800,
    required this.s900,
    required this.s950,
    this.buttonPrimaryText = DievasColourPrimitives.white,
  });

  /// Human readable palette name (matches the source colour family).
  final String name;

  final int s50;
  final int s100;
  final int s200;
  final int s300;
  final int s400;
  final int s500;
  final int s600;
  final int s700;
  final int s800;
  final int s900;
  final int s950;

  /// Text / icon colour placed on top of a [s500] based brand surface.
  final int buttonPrimaryText;

  /// Brand derived roles for light surfaces.
  DievasBrandRoleColours rolesForLight() => (
    badgePrimaryBackground: s500,
    badgePrimaryTintedText: s500,
    checkboxCheckedBackground: s500,
    radioSelectedBackground: s500,
    progressIndicator: s500,
    sliderActiveTrack: s500,
    inputCursor: s500,
    segmentedControlSelectedBackground: s500,
    tabSelectedIndicator: s500,
    badgePrimaryText: buttonPrimaryText,
    checkboxCheckmark: buttonPrimaryText,
    radioDot: buttonPrimaryText,
    progressOnPrimaryIndicator: buttonPrimaryText,
    segmentedControlSelectedText: buttonPrimaryText,

    primary: s500,
    badgePrimaryTintedBackground: s200,
    buttonPrimaryText: buttonPrimaryText,
    buttonPrimaryBackground: s500,
    buttonPrimaryHoveredBackground: s600,
    buttonPrimaryPressedBackground: s700,
    buttonSecondaryBackground: s50,
    buttonSecondaryHoveredBackground: s100,
    selectionBorder: s500,
    focusIndicatorColour: s500,
    inputFocusedBorder: s500,
    switchOnTrack: s500,
  );

  /// Brand derived roles for dark surfaces.
  DievasBrandRoleColours rolesForDark() => (
    badgePrimaryBackground: s500,
    badgePrimaryTintedText: s500,
    checkboxCheckedBackground: s500,
    radioSelectedBackground: s500,
    progressIndicator: s500,
    sliderActiveTrack: s500,
    inputCursor: s500,
    segmentedControlSelectedBackground: s500,
    tabSelectedIndicator: s500,
    badgePrimaryText: buttonPrimaryText,
    checkboxCheckmark: buttonPrimaryText,
    radioDot: buttonPrimaryText,
    progressOnPrimaryIndicator: buttonPrimaryText,
    segmentedControlSelectedText: buttonPrimaryText,

    primary: s400,
    badgePrimaryTintedBackground: s950,
    buttonPrimaryText: buttonPrimaryText,
    buttonPrimaryBackground: s500,
    buttonPrimaryHoveredBackground: s400,
    buttonPrimaryPressedBackground: s300,
    buttonSecondaryBackground: s950,
    buttonSecondaryHoveredBackground: s900,
    selectionBorder: s400,
    focusIndicatorColour: s400,
    inputFocusedBorder: s400,
    switchOnTrack: s500,
  );
}

/// The selectable brand palettes shipped with Dievas. Each wraps an existing
/// `DievasColourPrimitives` family. [indigo] is the default and reproduces the
/// built in reference themes exactly.
abstract final class DievasBrandPalettes {
  /// Default Dievas brand: the reference palette.
  static const DievasBrandPalette indigo = DievasBrandPalette(
    name: 'indigo',
    s50: DievasColourPrimitives.indigo50,
    s100: DievasColourPrimitives.indigo100,
    s200: DievasColourPrimitives.indigo200,
    s300: DievasColourPrimitives.indigo300,
    s400: DievasColourPrimitives.indigo400,
    s500: DievasColourPrimitives.indigo500,
    s600: DievasColourPrimitives.indigo600,
    s700: DievasColourPrimitives.indigo700,
    s800: DievasColourPrimitives.indigo800,
    s900: DievasColourPrimitives.indigo900,
    s950: DievasColourPrimitives.indigo950,
  );

  static const DievasBrandPalette sky = DievasBrandPalette(
    name: 'sky',
    s50: DievasColourPrimitives.sky50,
    s100: DievasColourPrimitives.sky100,
    s200: DievasColourPrimitives.sky200,
    s300: DievasColourPrimitives.sky300,
    s400: DievasColourPrimitives.sky400,
    s500: DievasColourPrimitives.sky500,
    s600: DievasColourPrimitives.sky600,
    s700: DievasColourPrimitives.sky700,
    s800: DievasColourPrimitives.sky800,
    s900: DievasColourPrimitives.sky900,
    s950: DievasColourPrimitives.sky950,
  );

  static const DievasBrandPalette green = DievasBrandPalette(
    name: 'green',
    s50: DievasColourPrimitives.green50,
    s100: DievasColourPrimitives.green100,
    s200: DievasColourPrimitives.green200,
    s300: DievasColourPrimitives.green300,
    s400: DievasColourPrimitives.green400,
    s500: DievasColourPrimitives.green500,
    s600: DievasColourPrimitives.green600,
    s700: DievasColourPrimitives.green700,
    s800: DievasColourPrimitives.green800,
    s900: DievasColourPrimitives.green900,
    s950: DievasColourPrimitives.green950,
  );

  static const DievasBrandPalette violet = DievasBrandPalette(
    name: 'violet',
    s50: DievasColourPrimitives.violet50,
    s100: DievasColourPrimitives.violet100,
    s200: DievasColourPrimitives.violet200,
    s300: DievasColourPrimitives.violet300,
    s400: DievasColourPrimitives.violet400,
    s500: DievasColourPrimitives.violet500,
    s600: DievasColourPrimitives.violet600,
    s700: DievasColourPrimitives.violet700,
    s800: DievasColourPrimitives.violet800,
    s900: DievasColourPrimitives.violet900,
    s950: DievasColourPrimitives.violet950,
  );

  static const DievasBrandPalette red = DievasBrandPalette(
    name: 'red',
    s50: DievasColourPrimitives.red50,
    s100: DievasColourPrimitives.red100,
    s200: DievasColourPrimitives.red200,
    s300: DievasColourPrimitives.red300,
    s400: DievasColourPrimitives.red400,
    s500: DievasColourPrimitives.red500,
    s600: DievasColourPrimitives.red600,
    s700: DievasColourPrimitives.red700,
    s800: DievasColourPrimitives.red800,
    s900: DievasColourPrimitives.red900,
    s950: DievasColourPrimitives.red950,
  );

  /// Amber's `s500` is light, so on brand text flips to a dark ink.
  static const DievasBrandPalette amber = DievasBrandPalette(
    name: 'amber',
    s50: DievasColourPrimitives.amber50,
    s100: DievasColourPrimitives.amber100,
    s200: DievasColourPrimitives.amber200,
    s300: DievasColourPrimitives.amber300,
    s400: DievasColourPrimitives.amber400,
    s500: DievasColourPrimitives.amber500,
    s600: DievasColourPrimitives.amber600,
    s700: DievasColourPrimitives.amber700,
    s800: DievasColourPrimitives.amber800,
    s900: DievasColourPrimitives.amber900,
    s950: DievasColourPrimitives.amber950,
    buttonPrimaryText: DievasColourPrimitives.slate950,
  );

  static const DievasBrandPalette ocean = DievasBrandPalette(
    name: 'ocean',
    s50: DievasColourPrimitives.ocean50,
    s100: DievasColourPrimitives.ocean100,
    s200: DievasColourPrimitives.ocean200,
    s300: DievasColourPrimitives.ocean300,
    s400: DievasColourPrimitives.ocean400,
    s500: DievasColourPrimitives.ocean500,
    s600: DievasColourPrimitives.ocean600,
    s700: DievasColourPrimitives.ocean700,
    s800: DievasColourPrimitives.ocean800,
    s900: DievasColourPrimitives.ocean900,
    s950: DievasColourPrimitives.ocean950,
  );

  static const DievasBrandPalette forest = DievasBrandPalette(
    name: 'forest',
    s50: DievasColourPrimitives.forest50,
    s100: DievasColourPrimitives.forest100,
    s200: DievasColourPrimitives.forest200,
    s300: DievasColourPrimitives.forest300,
    s400: DievasColourPrimitives.forest400,
    s500: DievasColourPrimitives.forest500,
    s600: DievasColourPrimitives.forest600,
    s700: DievasColourPrimitives.forest700,
    s800: DievasColourPrimitives.forest800,
    s900: DievasColourPrimitives.forest900,
    s950: DievasColourPrimitives.forest950,
  );

  static const DievasBrandPalette berry = DievasBrandPalette(
    name: 'berry',
    s50: DievasColourPrimitives.berry50,
    s100: DievasColourPrimitives.berry100,
    s200: DievasColourPrimitives.berry200,
    s300: DievasColourPrimitives.berry300,
    s400: DievasColourPrimitives.berry400,
    s500: DievasColourPrimitives.berry500,
    s600: DievasColourPrimitives.berry600,
    s700: DievasColourPrimitives.berry700,
    s800: DievasColourPrimitives.berry800,
    s900: DievasColourPrimitives.berry900,
    s950: DievasColourPrimitives.berry950,
  );

  static const DievasBrandPalette dusk = DievasBrandPalette(
    name: 'dusk',
    s50: DievasColourPrimitives.dusk50,
    s100: DievasColourPrimitives.dusk100,
    s200: DievasColourPrimitives.dusk200,
    s300: DievasColourPrimitives.dusk300,
    s400: DievasColourPrimitives.dusk400,
    s500: DievasColourPrimitives.dusk500,
    s600: DievasColourPrimitives.dusk600,
    s700: DievasColourPrimitives.dusk700,
    s800: DievasColourPrimitives.dusk800,
    s900: DievasColourPrimitives.dusk900,
    s950: DievasColourPrimitives.dusk950,
  );

  static const DievasBrandPalette terracotta = DievasBrandPalette(
    name: 'terracotta',
    s50: DievasColourPrimitives.terracotta50,
    s100: DievasColourPrimitives.terracotta100,
    s200: DievasColourPrimitives.terracotta200,
    s300: DievasColourPrimitives.terracotta300,
    s400: DievasColourPrimitives.terracotta400,
    s500: DievasColourPrimitives.terracotta500,
    s600: DievasColourPrimitives.terracotta600,
    s700: DievasColourPrimitives.terracotta700,
    s800: DievasColourPrimitives.terracotta800,
    s900: DievasColourPrimitives.terracotta900,
    s950: DievasColourPrimitives.terracotta950,
  );

  /// Every shipped palette, keyed by [DievasBrandPalette.name].
  static const Map<String, DievasBrandPalette> all = {
    'indigo': indigo,
    'sky': sky,
    'green': green,
    'violet': violet,
    'red': red,
    'amber': amber,
    'ocean': ocean,
    'forest': forest,
    'berry': berry,
    'dusk': dusk,
    'terracotta': terracotta,
  };
}
