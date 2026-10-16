part of '../themes.dart';

/// Derives [DievasTypographyThemeData] from a token record and a text colour.
///
/// This mapper is the single place where [DievasTypographySemantic] token records
/// are converted into Flutter [TextStyle] objects. The [textColour] is baked into
/// every style — components never pass a colour to [Text] directly.
DievasTypographyThemeData _createTypographyData(Color textColour) {
  FontWeight weight(int weight) => switch (weight) {
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

  TextStyle style(DievasTextStyleToken token) => TextStyle(
    fontSize: token.fontSize,
    fontWeight: weight(token.fontWeight),
    height: token.lineHeight,
    letterSpacing: token.letterSpacing,
    fontFamily: token.fontFamily,
    color: textColour,
  );

  return DievasTypographyThemeData(
    displayLG: style(DievasTypographySemantic.displayLG),
    displayMD: style(DievasTypographySemantic.displayMD),
    displaySM: style(DievasTypographySemantic.displaySM),
    headingXL: style(DievasTypographySemantic.headingXL),
    headingLG: style(DievasTypographySemantic.headingLG),
    headingMD: style(DievasTypographySemantic.headingMD),
    headingSM: style(DievasTypographySemantic.headingSM),
    headingXS: style(DievasTypographySemantic.headingXS),
    titleLG: style(DievasTypographySemantic.titleLG),
    titleMD: style(DievasTypographySemantic.titleMD),
    titleSM: style(DievasTypographySemantic.titleSM),
    titleXS: style(DievasTypographySemantic.titleXS),
    bodyLG: style(DievasTypographySemantic.bodyLG),
    bodyMD: style(DievasTypographySemantic.bodyMD),
    bodySM: style(DievasTypographySemantic.bodySM),
    bodyXS: style(DievasTypographySemantic.bodyXS),
    labelLG: style(DievasTypographySemantic.labelLG),
    labelMD: style(DievasTypographySemantic.labelMD),
    labelSM: style(DievasTypographySemantic.labelSM),
    labelXS: style(DievasTypographySemantic.labelXS),
    codeMD: style(DievasTypographySemantic.codeMD),
    codeSM: style(DievasTypographySemantic.codeSM),
  );
}
