// Semantic typography tokens.
//
// Pure Dart. No Flutter dependency. No TextStyle — only raw doubles and ints.
// TextStyle construction happens in the dievas Flutter package's typography
// mapper using these values.
//
// Each named style is a record: ({double fontSize, int fontWeight, double lineHeight,
// double letterSpacing, String fontFamily}).

import '../primitives/typography_primitives.dart';

/// A lightweight record describing a single named text style.
///
/// Consumed by the typography mapper in the `dievas` package to construct
/// Flutter [TextStyle] objects.
typedef DievasTextStyleToken = ({
  double fontSize,
  int fontWeight,
  double lineHeight,
  double letterSpacing,
  String fontFamily,
});

/// Semantic typography tokens for the Dievas design system.
///
/// Scale groups mirror Moon Design System's type ramp. All values reference
/// [DievasFontSizePrimitives], [DievasFontWeightPrimitives],
/// [DievasLineHeightPrimitives], and [DievasLetterSpacingPrimitives].
abstract final class DievasTypographySemantic {
  // Display

  /// Display large. Hero headings, marketing splash copy.
  static const DievasTextStyleToken displayLg = (
    fontSize: DievasFontSizePrimitives.x8l,
    fontWeight: DievasFontWeightPrimitives.bold,
    lineHeight: DievasLineHeightPrimitives.tight,
    letterSpacing: DievasLetterSpacingPrimitives.tighter,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  /// Display medium.
  static const DievasTextStyleToken displayMd = (
    fontSize: DievasFontSizePrimitives.x7l,
    fontWeight: DievasFontWeightPrimitives.bold,
    lineHeight: DievasLineHeightPrimitives.tight,
    letterSpacing: DievasLetterSpacingPrimitives.tighter,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  /// Display small.
  static const DievasTextStyleToken displaySm = (
    fontSize: DievasFontSizePrimitives.x6l,
    fontWeight: DievasFontWeightPrimitives.bold,
    lineHeight: DievasLineHeightPrimitives.tight,
    letterSpacing: DievasLetterSpacingPrimitives.tight,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  // Heading

  /// Heading XL. Page-level section titles.
  static const DievasTextStyleToken headingXl = (
    fontSize: DievasFontSizePrimitives.x5l,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.tight,
    letterSpacing: DievasLetterSpacingPrimitives.tight,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  /// Heading large.
  static const DievasTextStyleToken headingLg = (
    fontSize: DievasFontSizePrimitives.x4l,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.tight,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  /// Heading medium. Card titles, modal headings.
  static const DievasTextStyleToken headingMd = (
    fontSize: DievasFontSizePrimitives.x3l,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  /// Heading small.
  static const DievasTextStyleToken headingSm = (
    fontSize: DievasFontSizePrimitives.x2l,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  /// Heading XS. Section dividers, list group labels.
  static const DievasTextStyleToken headingXs = (
    fontSize: DievasFontSizePrimitives.xl,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  // Title

  /// Title large. Section headings inside cards, drawer titles, sheet headers.
  /// Same size as [bodyLg] but semiBold — title vs body is a weight distinction.
  static const DievasTextStyleToken titleLg = (
    fontSize: DievasFontSizePrimitives.lg,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Title medium. List group headers, tab labels, sub-section titles.
  static const DievasTextStyleToken titleMd = (
    fontSize: DievasFontSizePrimitives.base,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Title small. Compact sub-headings, sidebar labels, dense list headers.
  static const DievasTextStyleToken titleSm = (
    fontSize: DievasFontSizePrimitives.md,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Title small. Compact sub-headings, sidebar labels, dense list headers.
  static const DievasTextStyleToken titleXsm = (
    fontSize: DievasFontSizePrimitives.sm,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  // Body

  /// Body large. Long-form reading content.
  static const DievasTextStyleToken bodyLg = (
    fontSize: DievasFontSizePrimitives.lg,
    fontWeight: DievasFontWeightPrimitives.regular,
    lineHeight: DievasLineHeightPrimitives.relaxed,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Body medium. Default paragraph / list item text.
  static const DievasTextStyleToken bodyMd = (
    fontSize: DievasFontSizePrimitives.base,
    fontWeight: DievasFontWeightPrimitives.regular,
    lineHeight: DievasLineHeightPrimitives.normal,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Body small. Secondary descriptions, supporting copy.
  static const DievasTextStyleToken bodySm = (
    fontSize: DievasFontSizePrimitives.md,
    fontWeight: DievasFontWeightPrimitives.regular,
    lineHeight: DievasLineHeightPrimitives.normal,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Body XS. Fine print, timestamps, footnotes.
  static const DievasTextStyleToken bodyXs = (
    fontSize: DievasFontSizePrimitives.sm,
    fontWeight: DievasFontWeightPrimitives.regular,
    lineHeight: DievasLineHeightPrimitives.normal,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  // Label

  /// Label large. Button text (large), prominent tags.
  static const DievasTextStyleToken labelLg = (
    fontSize: DievasFontSizePrimitives.base,
    fontWeight: DievasFontWeightPrimitives.medium,
    lineHeight: DievasLineHeightPrimitives.none,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Label medium. Default button text, input labels, nav labels.
  static const DievasTextStyleToken labelMd = (
    fontSize: DievasFontSizePrimitives.md,
    fontWeight: DievasFontWeightPrimitives.medium,
    lineHeight: DievasLineHeightPrimitives.none,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Label small. Small button text, chip labels, compact badges.
  static const DievasTextStyleToken labelSm = (
    fontSize: DievasFontSizePrimitives.sm,
    fontWeight: DievasFontWeightPrimitives.medium,
    lineHeight: DievasLineHeightPrimitives.none,
    letterSpacing: DievasLetterSpacingPrimitives.wide,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Label XS. Overline, eyebrow text, micro-labels above inputs.
  static const DievasTextStyleToken labelXs = (
    fontSize: DievasFontSizePrimitives.xs,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.none,
    letterSpacing: DievasLetterSpacingPrimitives.wider,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  // Code

  /// Code medium. Inline code blocks, code editors, shell output.
  static const DievasTextStyleToken codeMd = (
    fontSize: DievasFontSizePrimitives.md,
    fontWeight: DievasFontWeightPrimitives.regular,
    lineHeight: DievasLineHeightPrimitives.relaxed,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.mono,
  );

  /// Code small. Compact code snippets, token labels.
  static const DievasTextStyleToken codeSm = (
    fontSize: DievasFontSizePrimitives.sm,
    fontWeight: DievasFontWeightPrimitives.regular,
    lineHeight: DievasLineHeightPrimitives.relaxed,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.mono,
  );
}
