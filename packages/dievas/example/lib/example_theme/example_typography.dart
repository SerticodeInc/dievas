part of 'example_theme.dart';

/// Builds the Example App typography scale from Dievas semantic tokens.
///
/// The Dievas type ramp is expressed as [DievasTypographySemantic] records
/// (raw doubles/ints).
///
/// This function wraps them into [TextStyle] objects with the brand font
/// families and a baked-in text colour; the same colour that is passed by
/// [ExampleLightThemeData] / [ExampleDarkThemeData] so components never need
/// to pass a colour to [Text].
///
/// The brand voice mirrors the landing's: a warm grotesque for display and
/// body ([ExampleFonts.hankenGrotesk], standing in for the landing's
/// MaisonNeue) and the landing's own DM Mono for code. Pass the font
/// arguments to use your own typefaces.
DievasTypographyThemeData buildExampleTypography({
  required Color textColor,
  String? displayFont,
  String? bodyFont,
  String? codeFont,
}) {
  final resolvedDisplay = displayFont ?? ExampleFonts.hankenGrotesk;
  final resolvedBody = bodyFont ?? ExampleFonts.hankenGrotesk;
  final resolvedCode = codeFont ?? ExampleFonts.dmMono;

  return DievasTypographyThemeData(
    // Display
    displayLG: _exampleStyle(DievasTypographySemantic.displayLG, resolvedDisplay, textColor),
    displayMD: _exampleStyle(DievasTypographySemantic.displayMD, resolvedDisplay, textColor),
    displaySM: _exampleStyle(DievasTypographySemantic.displaySM, resolvedDisplay, textColor),
    // Heading
    headingXL: _exampleStyle(DievasTypographySemantic.headingXL, resolvedDisplay, textColor),
    headingLG: _exampleStyle(DievasTypographySemantic.headingLG, resolvedDisplay, textColor),
    headingMD: _exampleStyle(DievasTypographySemantic.headingMD, resolvedDisplay, textColor),
    headingSM: _exampleStyle(DievasTypographySemantic.headingSM, resolvedDisplay, textColor),
    headingXS: _exampleStyle(DievasTypographySemantic.headingXS, resolvedDisplay, textColor),
    // Title
    titleLG: _exampleStyle(DievasTypographySemantic.titleLG, resolvedDisplay, textColor),
    titleMD: _exampleStyle(DievasTypographySemantic.titleMD, resolvedDisplay, textColor),
    titleSM: _exampleStyle(DievasTypographySemantic.titleSM, resolvedDisplay, textColor),
    titleXS: _exampleStyle(DievasTypographySemantic.titleXS, resolvedDisplay, textColor),
    // Body
    bodyLG: _exampleStyle(DievasTypographySemantic.bodyLG, resolvedBody, textColor),
    bodyMD: _exampleStyle(DievasTypographySemantic.bodyMD, resolvedBody, textColor),
    bodySM: _exampleStyle(DievasTypographySemantic.bodySM, resolvedBody, textColor),
    bodyXS: _exampleStyle(DievasTypographySemantic.bodyXS, resolvedBody, textColor),
    // Label: the brand pushes labels to semibold. Dievas ships them at medium;
    // the extra weight is what makes a peach button label read as deliberate
    // rather than washed out.
    labelLG: _exampleLabelStyle(DievasTypographySemantic.labelLG, resolvedBody, textColor),
    labelMD: _exampleLabelStyle(DievasTypographySemantic.labelMD, resolvedBody, textColor),
    labelSM: _exampleLabelStyle(DievasTypographySemantic.labelSM, resolvedBody, textColor),
    labelXS: _exampleLabelStyle(DievasTypographySemantic.labelXS, resolvedBody, textColor),
    // Code
    codeMD: _exampleStyle(DievasTypographySemantic.codeMD, resolvedCode, textColor),
    codeSM: _exampleStyle(DievasTypographySemantic.codeSM, resolvedCode, textColor),
  );
}

FontWeight _exampleWeight(int w) => switch (w) {
  DievasFontWeightPrimitives.thin => .w100,
  DievasFontWeightPrimitives.extraLight => .w200,
  DievasFontWeightPrimitives.light => .w300,
  DievasFontWeightPrimitives.regular => .w400,
  DievasFontWeightPrimitives.medium => .w500,
  DievasFontWeightPrimitives.semiBold => .w600,
  DievasFontWeightPrimitives.bold => .w700,
  DievasFontWeightPrimitives.extraBold => .w800,
  DievasFontWeightPrimitives.black => .w900,
  _ => .w400,
};

TextStyle _exampleStyle(DievasTextStyleToken token, String fontFamily, Color color) => TextStyle(
  fontSize: token.fontSize,
  fontWeight: _exampleWeight(token.fontWeight),
  letterSpacing: token.letterSpacing,
  height: token.lineHeight,
  fontFamily: fontFamily,
  color: color,
);

TextStyle _exampleLabelStyle(DievasTextStyleToken token, String fontFamily, Color color) =>
    _exampleStyle(token, fontFamily, color).copyWith(fontWeight: .w600);
