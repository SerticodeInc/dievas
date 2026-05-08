// Semantic spacing tokens.
//
// Pure Dart. No Flutter dependency.
// Named aliases over DievasSpacingPrimitives for use in padding, gap,
// margin, and positional offsets throughout the system.

import '../primitives/spacing_primitives.dart';

/// Semantic spacing tokens for the Dievas design system.
///
/// References [DievasSpacingPrimitives] exclusively.
/// The 4pt base grid means: 1 unit = 4.0 logical pixels.
abstract final class DievasSpacingSemantic {
  /// No spacing.
  static const double none = DievasSpacingPrimitives.s0;

  /// 4px — tight inline gaps, icon-to-label spacing.
  static const double xs = DievasSpacingPrimitives.s1;

  /// 8px — compact list item padding, small gutters.
  static const double sm = DievasSpacingPrimitives.s2;

  /// 12px — small component internal padding.
  static const double smPlus = DievasSpacingPrimitives.s3;

  /// 16px — default internal padding for cards, inputs, buttons.
  static const double md = DievasSpacingPrimitives.s4;

  /// 20px — comfortable section gaps.
  static const double mdPlus = DievasSpacingPrimitives.s5;

  /// 24px — component group separation, card-to-card gap.
  static const double lg = DievasSpacingPrimitives.s6;

  /// 28px — slightly wider section separation.
  static const double lgPlus = DievasSpacingPrimitives.s7;

  /// 32px — page section padding (vertical rhythm on mobile).
  static const double xl = DievasSpacingPrimitives.s8;

  /// 40px — generous section breathing room.
  static const double xlPlus = DievasSpacingPrimitives.s10;

  /// 48px — large section breaks, modal padding.
  static const double x2l = DievasSpacingPrimitives.s12;

  /// 56px — prominent feature spacing.
  static const double x2lPlus = DievasSpacingPrimitives.s14;

  /// 64px — page-level vertical padding on tablet.
  static const double x3l = DievasSpacingPrimitives.s16;

  /// 80px — hero section spacing.
  static const double x4l = DievasSpacingPrimitives.s20;

  /// 96px — wide-screen layout gutters.
  static const double x5l = DievasSpacingPrimitives.s24;
}
