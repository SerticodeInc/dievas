// Semantic typography tokens.
//
// Pure Dart. No Flutter dependency. No TextStyle — only raw doubles and ints.
// TextStyle construction happens in the dievas Flutter package's typography
// mapper using these values.
//
// Each named style is a record: ({double fontSize, int fontWeight, double lineHeight,
// double letterSpacing, String fontFamily}).

import 'package:dievas_tokens/src/primitives/typography_primitives.dart';

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
  static const DievasTextStyleToken displayLG = (
    fontSize: DievasFontSizePrimitives.fs72,
    fontWeight: DievasFontWeightPrimitives.bold,
    lineHeight: DievasLineHeightPrimitives.tight,
    letterSpacing: DievasLetterSpacingPrimitives.tighter,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  /// Display medium.
  static const DievasTextStyleToken displayMD = (
    fontSize: DievasFontSizePrimitives.fs60,
    fontWeight: DievasFontWeightPrimitives.bold,
    lineHeight: DievasLineHeightPrimitives.tight,
    letterSpacing: DievasLetterSpacingPrimitives.tighter,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  /// Display small.
  static const DievasTextStyleToken displaySM = (
    fontSize: DievasFontSizePrimitives.fs48,
    fontWeight: DievasFontWeightPrimitives.bold,
    lineHeight: DievasLineHeightPrimitives.tight,
    letterSpacing: DievasLetterSpacingPrimitives.tight,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  // Heading

  /// Heading XL. Page-level section titles.
  static const DievasTextStyleToken headingXL = (
    fontSize: DievasFontSizePrimitives.fs36,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.tight,
    letterSpacing: DievasLetterSpacingPrimitives.tight,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  /// Heading large.
  static const DievasTextStyleToken headingLG = (
    fontSize: DievasFontSizePrimitives.fs32,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.tight,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  /// Heading medium. Card titles, modal headings.
  static const DievasTextStyleToken headingMD = (
    fontSize: DievasFontSizePrimitives.fs28,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  /// Heading small.
  static const DievasTextStyleToken headingSM = (
    fontSize: DievasFontSizePrimitives.xl2,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  /// Heading XS. Section dividers, list group labels.
  static const DievasTextStyleToken headingXS = (
    fontSize: DievasFontSizePrimitives.xl,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sansExtended,
  );

  // Title

  /// Title large. Section headings inside cards, drawer titles, sheet headers.
  /// Same size as [bodyLG] but semiBold — title vs body is a weight distinction.
  static const DievasTextStyleToken titleLG = (
    fontSize: DievasFontSizePrimitives.lgPlus,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Title medium. List group headers, tab labels, sub-section titles.
  static const DievasTextStyleToken titleMD = (
    fontSize: DievasFontSizePrimitives.base,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Title small. Compact sub-headings, sidebar labels, dense list headers.
  static const DievasTextStyleToken titleSM = (
    fontSize: DievasFontSizePrimitives.base,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Title extra-small. Micro sub-headings, dense metadata labels.
  static const DievasTextStyleToken titleXS = (
    fontSize: DievasFontSizePrimitives.mdPlus,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.snug,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  // Body

  /// Body large. Long-form reading content.
  static const DievasTextStyleToken bodyLG = (
    fontSize: DievasFontSizePrimitives.lgPlus,
    fontWeight: DievasFontWeightPrimitives.regular,
    lineHeight: DievasLineHeightPrimitives.relaxed,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Body medium. Default paragraph / list item text.
  static const DievasTextStyleToken bodyMD = (
    fontSize: DievasFontSizePrimitives.lg,
    fontWeight: DievasFontWeightPrimitives.regular,
    lineHeight: DievasLineHeightPrimitives.normal,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Body small. Secondary descriptions, supporting copy.
  static const DievasTextStyleToken bodySM = (
    fontSize: DievasFontSizePrimitives.base,
    fontWeight: DievasFontWeightPrimitives.regular,
    lineHeight: DievasLineHeightPrimitives.normal,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Body XS. Fine print, timestamps, footnotes.
  static const DievasTextStyleToken bodyXS = (
    fontSize: DievasFontSizePrimitives.mdPlus,
    fontWeight: DievasFontWeightPrimitives.regular,
    lineHeight: DievasLineHeightPrimitives.normal,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  // Label

  /// Label large. Button text (large), prominent tags.
  static const DievasTextStyleToken labelLG = (
    fontSize: DievasFontSizePrimitives.lg,
    fontWeight: DievasFontWeightPrimitives.medium,
    lineHeight: DievasLineHeightPrimitives.none,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Label medium. Default button text, input labels, nav labels.
  static const DievasTextStyleToken labelMD = (
    fontSize: DievasFontSizePrimitives.base,
    fontWeight: DievasFontWeightPrimitives.medium,
    lineHeight: DievasLineHeightPrimitives.none,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Label small. Small button text, chip labels, compact badges.
  static const DievasTextStyleToken labelSM = (
    fontSize: DievasFontSizePrimitives.mdPlus,
    fontWeight: DievasFontWeightPrimitives.medium,
    lineHeight: DievasLineHeightPrimitives.none,
    letterSpacing: DievasLetterSpacingPrimitives.wide,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  /// Label XS. Overline, eyebrow text, micro-labels above inputs.
  static const DievasTextStyleToken labelXS = (
    fontSize: DievasFontSizePrimitives.md,
    fontWeight: DievasFontWeightPrimitives.semiBold,
    lineHeight: DievasLineHeightPrimitives.none,
    letterSpacing: DievasLetterSpacingPrimitives.wider,
    fontFamily: DievasFontFamilyPrimitives.sans,
  );

  // Code

  /// Code medium. Inline code blocks, code editors, shell output.
  static const DievasTextStyleToken codeMD = (
    fontSize: DievasFontSizePrimitives.base,
    fontWeight: DievasFontWeightPrimitives.regular,
    lineHeight: DievasLineHeightPrimitives.relaxed,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.mono,
  );

  /// Code small. Compact code snippets, token labels.
  static const DievasTextStyleToken codeSM = (
    fontSize: DievasFontSizePrimitives.mdPlus,
    fontWeight: DievasFontWeightPrimitives.regular,
    lineHeight: DievasLineHeightPrimitives.relaxed,
    letterSpacing: DievasLetterSpacingPrimitives.normal,
    fontFamily: DievasFontFamilyPrimitives.mono,
  );
}
