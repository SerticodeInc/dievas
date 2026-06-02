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
    required this.displayLg,
    required this.displayMd,
    required this.displaySm,
    // Heading
    required this.headingXl,
    required this.headingLg,
    required this.headingMd,
    required this.headingSm,
    required this.headingXs,
    // Title
    required this.titleLg,
    required this.titleMd,
    required this.titleSm,
    required this.titleXsm,
    // Body
    required this.bodyLg,
    required this.bodyMd,
    required this.bodySm,
    required this.bodyXs,
    // Label
    required this.labelLg,
    required this.labelMd,
    required this.labelSm,
    required this.labelXs,
    // Code
    required this.codeMd,
    required this.codeSm,
  });

  /// Display large — hero headings, marketing splash copy.
  final TextStyle displayLg;

  /// Display medium.
  final TextStyle displayMd;

  /// Display small.
  final TextStyle displaySm;

  /// Heading XL — page-level section titles.
  final TextStyle headingXl;

  /// Heading large.
  final TextStyle headingLg;

  /// Heading medium — card titles, modal headings.
  final TextStyle headingMd;

  /// Heading small.
  final TextStyle headingSm;

  /// Heading XS — section dividers, list group labels.
  final TextStyle headingXs;

  /// Title large — section headings inside cards, drawer titles, sheet headers.
  final TextStyle titleLg;

  /// Title medium — list group headers, tab labels, sub-section titles.
  final TextStyle titleMd;

  /// Title small — compact sub-headings, sidebar labels, dense list headers.
  final TextStyle titleSm;

  /// Title extra small — compact sub-headings, sidebar labels, dense list headers.
  final TextStyle titleXsm;

  /// Body large — long-form reading content.
  final TextStyle bodyLg;

  /// Body medium — default paragraph / list item text.
  final TextStyle bodyMd;

  /// Body small — secondary descriptions, supporting copy.
  final TextStyle bodySm;

  /// Body XS — fine print, timestamps, footnotes.
  final TextStyle bodyXs;

  /// Label large — button text (large), prominent tags.
  final TextStyle labelLg;

  /// Label medium — default button text, input labels, nav labels.
  final TextStyle labelMd;

  /// Label small — small button text, chip labels, compact badges.
  final TextStyle labelSm;

  /// Label XS — overline, eyebrow text, micro-labels above inputs.
  final TextStyle labelXs;

  /// Code medium — inline code blocks, code editors, shell output.
  final TextStyle codeMd;

  /// Code small — compact code snippets, token labels.
  final TextStyle codeSm;

  static DievasTypographyThemeData lerp(DievasTypographyThemeData a, DievasTypographyThemeData b, double t) =>
      DievasTypographyThemeData(
        displayLg: TextStyle.lerp(a.displayLg, b.displayLg, t)!,
        displayMd: TextStyle.lerp(a.displayMd, b.displayMd, t)!,
        displaySm: TextStyle.lerp(a.displaySm, b.displaySm, t)!,
        headingXl: TextStyle.lerp(a.headingXl, b.headingXl, t)!,
        headingLg: TextStyle.lerp(a.headingLg, b.headingLg, t)!,
        headingMd: TextStyle.lerp(a.headingMd, b.headingMd, t)!,
        headingSm: TextStyle.lerp(a.headingSm, b.headingSm, t)!,
        headingXs: TextStyle.lerp(a.headingXs, b.headingXs, t)!,
        titleLg: TextStyle.lerp(a.titleLg, b.titleLg, t)!,
        titleMd: TextStyle.lerp(a.titleMd, b.titleMd, t)!,
        titleSm: TextStyle.lerp(a.titleSm, b.titleSm, t)!,
        titleXsm: TextStyle.lerp(a.titleXsm, b.titleXsm, t)!,
        bodyLg: TextStyle.lerp(a.bodyLg, b.bodyLg, t)!,
        bodyMd: TextStyle.lerp(a.bodyMd, b.bodyMd, t)!,
        bodySm: TextStyle.lerp(a.bodySm, b.bodySm, t)!,
        bodyXs: TextStyle.lerp(a.bodyXs, b.bodyXs, t)!,
        labelLg: TextStyle.lerp(a.labelLg, b.labelLg, t)!,
        labelMd: TextStyle.lerp(a.labelMd, b.labelMd, t)!,
        labelSm: TextStyle.lerp(a.labelSm, b.labelSm, t)!,
        labelXs: TextStyle.lerp(a.labelXs, b.labelXs, t)!,
        codeMd: TextStyle.lerp(a.codeMd, b.codeMd, t)!,
        codeSm: TextStyle.lerp(a.codeSm, b.codeSm, t)!,
      );

  @override
  List<Object?> get props => [
    displayLg,
    displayMd,
    displaySm,
    headingXl,
    headingLg,
    headingMd,
    headingSm,
    headingXs,
    titleLg,
    titleMd,
    titleSm,
    bodyLg,
    bodyMd,
    bodySm,
    bodyXs,
    labelLg,
    labelMd,
    labelSm,
    labelXs,
    codeMd,
    codeSm,
  ];
}
