// Semantic spacing tokens: named aliases over DievasSpacingPrimitives for use
// in padding, gap, margin, and positional offsets throughout the system.

import 'package:dievas_tokens/src/primitives/spacing_primitives.dart';

/// Semantic spacing tokens for the Dievas design system. References
/// [DievasSpacingPrimitives] exclusively. On the 4pt base grid, 1 unit means
/// 4.0 logical pixels.
abstract final class DievasSpacingSemantic {
  /// No spacing.
  static const double NONE = DievasSpacingPrimitives.s0;

  /// 4px: tight inline gaps, icon to label spacing.
  static const double XS = DievasSpacingPrimitives.s1;

  /// 8px: compact list item padding, small gutters.
  static const double SM = DievasSpacingPrimitives.s2;

  /// 12px: small component internal padding.
  static const double SMPlus = DievasSpacingPrimitives.s3;

  /// 16px: default internal padding for cards, inputs, buttons.
  static const double MD = DievasSpacingPrimitives.s4;

  /// 20px: comfortable section gaps.
  static const double MDPlus = DievasSpacingPrimitives.s5;

  /// 24px: component group separation, card to card gap.
  static const double LG = DievasSpacingPrimitives.s6;

  /// 28px: slightly wider section separation.
  static const double LGPlus = DievasSpacingPrimitives.s7;

  /// 32px: page section padding (vertical rhythm on mobile).
  static const double XL = DievasSpacingPrimitives.s8;

  /// 40px: generous section breathing room.
  static const double XLPlus = DievasSpacingPrimitives.s10;

  /// 48px: large section breaks, modal padding.
  static const double XL2 = DievasSpacingPrimitives.s12;

  /// 56px: prominent feature spacing.
  static const double XL2Plus = DievasSpacingPrimitives.s14;

  /// 64px: page level vertical padding on tablet.
  static const double XL3 = DievasSpacingPrimitives.s16;

  /// 80px: hero section spacing.
  static const double XL4 = DievasSpacingPrimitives.s20;

  /// 96px: wide screen layout gutters.
  static const double XL5 = DievasSpacingPrimitives.s24;
}
