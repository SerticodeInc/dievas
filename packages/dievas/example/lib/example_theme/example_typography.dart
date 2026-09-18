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
    displayLg: _exampleStyle(DievasTypographySemantic.displayLg, resolvedDisplay, textColor),
    displayMd: _exampleStyle(DievasTypographySemantic.displayMd, resolvedDisplay, textColor),
    displaySm: _exampleStyle(DievasTypographySemantic.displaySm, resolvedDisplay, textColor),
    // Heading
    headingXl: _exampleStyle(DievasTypographySemantic.headingXl, resolvedDisplay, textColor),
    headingLg: _exampleStyle(DievasTypographySemantic.headingLg, resolvedDisplay, textColor),
    headingMd: _exampleStyle(DievasTypographySemantic.headingMd, resolvedDisplay, textColor),
    headingSm: _exampleStyle(DievasTypographySemantic.headingSm, resolvedDisplay, textColor),
    headingXs: _exampleStyle(DievasTypographySemantic.headingXs, resolvedDisplay, textColor),
    // Title
    titleLg: _exampleStyle(DievasTypographySemantic.titleLg, resolvedDisplay, textColor),
    titleMd: _exampleStyle(DievasTypographySemantic.titleMd, resolvedDisplay, textColor),
    titleSm: _exampleStyle(DievasTypographySemantic.titleSm, resolvedDisplay, textColor),
    titleXsm: _exampleStyle(DievasTypographySemantic.titleXsm, resolvedDisplay, textColor),
    // Body
    bodyLg: _exampleStyle(DievasTypographySemantic.bodyLg, resolvedBody, textColor),
    bodyMd: _exampleStyle(DievasTypographySemantic.bodyMd, resolvedBody, textColor),
    bodySm: _exampleStyle(DievasTypographySemantic.bodySm, resolvedBody, textColor),
    bodyXs: _exampleStyle(DievasTypographySemantic.bodyXs, resolvedBody, textColor),
    // Label
    labelLg: _exampleStyle(DievasTypographySemantic.labelLg, resolvedBody, textColor),
    labelMd: _exampleStyle(DievasTypographySemantic.labelMd, resolvedBody, textColor),
    labelSm: _exampleStyle(DievasTypographySemantic.labelSm, resolvedBody, textColor),
    labelXs: _exampleStyle(DievasTypographySemantic.labelXs, resolvedBody, textColor),
    // Code
    codeMd: _exampleStyle(DievasTypographySemantic.codeMd, resolvedCode, textColor),
    codeSm: _exampleStyle(DievasTypographySemantic.codeSm, resolvedCode, textColor),
  );
}

FontWeight _exampleWeight(int w) => switch (w) {
  100 => .w100,
  200 => .w200,
  300 => .w300,
  400 => .w400,
  500 => .w500,
  600 => .w600,
  700 => .w700,
  800 => .w800,
  900 => .w900,
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
