part of '../themes.dart';

/// Derives [DievasTypographyThemeData] from a token record and a text colour.
///
/// This mapper is the single place where [DievasTypographySemantic] token records
/// are converted into Flutter [TextStyle] objects. The [textColor] is baked into
/// every style — components never pass a colour to [Text] directly.
DievasTypographyThemeData _createTypographyData(Color textColor) {
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
    color: textColor,
  );

  return DievasTypographyThemeData(
    displayLg: style(DievasTypographySemantic.displayLg),
    displayMd: style(DievasTypographySemantic.displayMd),
    displaySm: style(DievasTypographySemantic.displaySm),
    headingXl: style(DievasTypographySemantic.headingXl),
    headingLg: style(DievasTypographySemantic.headingLg),
    headingMd: style(DievasTypographySemantic.headingMd),
    headingSm: style(DievasTypographySemantic.headingSm),
    headingXs: style(DievasTypographySemantic.headingXs),
    titleLg: style(DievasTypographySemantic.titleLg),
    titleMd: style(DievasTypographySemantic.titleMd),
    titleSm: style(DievasTypographySemantic.titleSm),
    bodyLg: style(DievasTypographySemantic.bodyLg),
    bodyMd: style(DievasTypographySemantic.bodyMd),
    bodySm: style(DievasTypographySemantic.bodySm),
    bodyXs: style(DievasTypographySemantic.bodyXs),
    labelLg: style(DievasTypographySemantic.labelLg),
    labelMd: style(DievasTypographySemantic.labelMd),
    labelSm: style(DievasTypographySemantic.labelSm),
    labelXs: style(DievasTypographySemantic.labelXs),
    codeMd: style(DievasTypographySemantic.codeMd),
    codeSm: style(DievasTypographySemantic.codeSm),
  );
}
