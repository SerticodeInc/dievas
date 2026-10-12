import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// The complete typography sub-system for a Dievas theme.
///
/// Every [TextStyle] here has `color` baked in during construction inside
/// [DievasGlobalThemeData] — components never pass a color to [Text] directly.
/// All styles are derived from [DievasTypographySemantic] via the typography
/// mapper in `themes.typography.mapper.dart`.
///
/// Scale group naming mirrors Moon Design System's type ramp.
final class DievasTypographyThemeData extends Equatable {
  const DievasTypographyThemeData({
    // Display
    required this.displayLG,
    required this.displayMD,
    required this.displaySM,
    // Heading
    required this.headingXL,
    required this.headingLG,
    required this.headingMD,
    required this.headingSM,
    required this.headingXS,
    // Title
    required this.titleLG,
    required this.titleMD,
    required this.titleSM,
    required this.titleXS,
    // Body
    required this.bodyLG,
    required this.bodyMD,
    required this.bodySM,
    required this.bodyXS,
    // Label
    required this.labelLG,
    required this.labelMD,
    required this.labelSM,
    required this.labelXS,
    // Code
    required this.codeMD,
    required this.codeSM,
  });

  /// Display large — hero headings, marketing splash copy.
  final TextStyle displayLG;

  /// Display medium.
  final TextStyle displayMD;

  /// Display small.
  final TextStyle displaySM;

  /// Heading XL — page-level section titles.
  final TextStyle headingXL;

  /// Heading large.
  final TextStyle headingLG;

  /// Heading medium — card titles, modal headings.
  final TextStyle headingMD;

  /// Heading small.
  final TextStyle headingSM;

  /// Heading XS — section dividers, list group labels.
  final TextStyle headingXS;

  /// Title large — section headings inside cards, drawer titles, sheet headers.
  final TextStyle titleLG;

  /// Title medium — list group headers, tab labels, sub-section titles.
  final TextStyle titleMD;

  /// Title small — compact sub-headings, sidebar labels, dense list headers.
  final TextStyle titleSM;

  /// Title extra small — compact sub-headings, sidebar labels, dense list headers.
  final TextStyle titleXS;

  /// Body large — long-form reading content.
  final TextStyle bodyLG;

  /// Body medium — default paragraph / list item text.
  final TextStyle bodyMD;

  /// Body small — secondary descriptions, supporting copy.
  final TextStyle bodySM;

  /// Body XS — fine print, timestamps, footnotes.
  final TextStyle bodyXS;

  /// Label large — button text (large), prominent tags.
  final TextStyle labelLG;

  /// Label medium — default button text, input labels, nav labels.
  final TextStyle labelMD;

  /// Label small — small button text, chip labels, compact badges.
  final TextStyle labelSM;

  /// Label XS — overline, eyebrow text, micro-labels above inputs.
  final TextStyle labelXS;

  /// Code medium — inline code blocks, code editors, shell output.
  final TextStyle codeMD;

  /// Code small — compact code snippets, token labels.
  final TextStyle codeSM;

  static DievasTypographyThemeData lerp(DievasTypographyThemeData a, DievasTypographyThemeData b, double t) =>
      DievasTypographyThemeData(
        displayLG: TextStyle.lerp(a.displayLG, b.displayLG, t)!,
        displayMD: TextStyle.lerp(a.displayMD, b.displayMD, t)!,
        displaySM: TextStyle.lerp(a.displaySM, b.displaySM, t)!,
        headingXL: TextStyle.lerp(a.headingXL, b.headingXL, t)!,
        headingLG: TextStyle.lerp(a.headingLG, b.headingLG, t)!,
        headingMD: TextStyle.lerp(a.headingMD, b.headingMD, t)!,
        headingSM: TextStyle.lerp(a.headingSM, b.headingSM, t)!,
        headingXS: TextStyle.lerp(a.headingXS, b.headingXS, t)!,
        titleLG: TextStyle.lerp(a.titleLG, b.titleLG, t)!,
        titleMD: TextStyle.lerp(a.titleMD, b.titleMD, t)!,
        titleSM: TextStyle.lerp(a.titleSM, b.titleSM, t)!,
        titleXS: TextStyle.lerp(a.titleXS, b.titleXS, t)!,
        bodyLG: TextStyle.lerp(a.bodyLG, b.bodyLG, t)!,
        bodyMD: TextStyle.lerp(a.bodyMD, b.bodyMD, t)!,
        bodySM: TextStyle.lerp(a.bodySM, b.bodySM, t)!,
        bodyXS: TextStyle.lerp(a.bodyXS, b.bodyXS, t)!,
        labelLG: TextStyle.lerp(a.labelLG, b.labelLG, t)!,
        labelMD: TextStyle.lerp(a.labelMD, b.labelMD, t)!,
        labelSM: TextStyle.lerp(a.labelSM, b.labelSM, t)!,
        labelXS: TextStyle.lerp(a.labelXS, b.labelXS, t)!,
        codeMD: TextStyle.lerp(a.codeMD, b.codeMD, t)!,
        codeSM: TextStyle.lerp(a.codeSM, b.codeSM, t)!,
      );

  @override
  List<Object?> get props => [
    displayLG,
    displayMD,
    displaySM,
    headingXL,
    headingLG,
    headingMD,
    headingSM,
    headingXS,
    titleLG,
    titleMD,
    titleSM,
    bodyLG,
    bodyMD,
    bodySM,
    bodyXS,
    labelLG,
    labelMD,
    labelSM,
    labelXS,
    codeMD,
    codeSM,
  ];
}
