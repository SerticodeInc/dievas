// Semantic sizing tokens: named aliases over DievasSizingPrimitives for
// component heights, icon sizes, avatar dimensions, minimum touch targets, and
// the full height and width dimension scale.

import 'package:dievas_tokens/src/primitives/sizing_primitives.dart';

/// Semantic sizing tokens for the Dievas design system. References
/// [DievasSizingPrimitives] exclusively. Role tokens cover component heights
/// and dimensions; the `height<px>` and `width<px>` scales expose every sizing
/// primitive for boxes, constraints, and arbitrary width or height.
abstract final class DievasSizingSemantic {
  // Component roles

  /// Extra small button height.
  static const double buttonHeightXs = DievasSizingPrimitives.s40;

  /// Small button height.
  static const double buttonHeightSm = DievasSizingPrimitives.s44;

  /// Medium button height.
  static const double buttonHeightMd = DievasSizingPrimitives.s48;

  /// Large button height.
  static const double buttonHeightLg = DievasSizingPrimitives.s52;

  /// Small input height.
  static const double inputHeightSm = DievasSizingPrimitives.s52;

  /// Medium input height.
  static const double inputHeightMd = DievasSizingPrimitives.s56;

  /// Large input height.
  static const double inputHeightLg = DievasSizingPrimitives.s60;

  /// Extra small icon size.
  static const double iconXs = DievasSizingPrimitives.s12;

  /// Small icon size.
  static const double iconSm = DievasSizingPrimitives.s16;

  /// Medium icon size.
  static const double iconMd = DievasSizingPrimitives.s20;

  /// Large icon size.
  static const double iconLg = DievasSizingPrimitives.s24;

  /// Extra large icon size.
  static const double iconXl = DievasSizingPrimitives.s32;

  /// Extra small avatar size.
  static const double avatarXs = DievasSizingPrimitives.s24;

  /// Small avatar size.
  static const double avatarSm = DievasSizingPrimitives.s32;

  /// Medium avatar size.
  static const double avatarMd = DievasSizingPrimitives.s40;

  /// Large avatar size.
  static const double avatarLg = DievasSizingPrimitives.s48;

  /// Extra large avatar size.
  static const double avatarXl = DievasSizingPrimitives.s64;

  /// Minimum touch target dimension.
  static const double touchMin = DievasSizingPrimitives.s44;

  // Height scale

  /// 4px height.
  static const double height4 = DievasSizingPrimitives.s4;

  /// 8px height.
  static const double height8 = DievasSizingPrimitives.s8;

  /// 10px height.
  static const double height10 = DievasSizingPrimitives.s10;

  /// 12px height.
  static const double height12 = DievasSizingPrimitives.s12;

  /// 14px height.
  static const double height14 = DievasSizingPrimitives.s14;

  /// 16px height.
  static const double height16 = DievasSizingPrimitives.s16;

  /// 18px height.
  static const double height18 = DievasSizingPrimitives.s18;

  /// 20px height.
  static const double height20 = DievasSizingPrimitives.s20;

  /// 24px height.
  static const double height24 = DievasSizingPrimitives.s24;

  /// 28px height.
  static const double height28 = DievasSizingPrimitives.s28;

  /// 32px height.
  static const double height32 = DievasSizingPrimitives.s32;

  /// 36px height.
  static const double height36 = DievasSizingPrimitives.s36;

  /// 40px height.
  static const double height40 = DievasSizingPrimitives.s40;

  /// 44px height.
  static const double height44 = DievasSizingPrimitives.s44;

  /// 48px height.
  static const double height48 = DievasSizingPrimitives.s48;

  /// 52px height.
  static const double height52 = DievasSizingPrimitives.s52;

  /// 56px height.
  static const double height56 = DievasSizingPrimitives.s56;

  /// 60px height.
  static const double height60 = DievasSizingPrimitives.s60;

  /// 64px height.
  static const double height64 = DievasSizingPrimitives.s64;

  /// 80px height.
  static const double height80 = DievasSizingPrimitives.s80;

  /// 96px height.
  static const double height96 = DievasSizingPrimitives.s96;

  /// 128px height.
  static const double height128 = DievasSizingPrimitives.s128;

  /// 160px height.
  static const double height160 = DievasSizingPrimitives.s160;

  /// 192px height.
  static const double height192 = DievasSizingPrimitives.s192;

  /// 256px height.
  static const double height256 = DievasSizingPrimitives.s256;

  // Width scale

  /// 4px width.
  static const double width4 = DievasSizingPrimitives.s4;

  /// 8px width.
  static const double width8 = DievasSizingPrimitives.s8;

  /// 10px width.
  static const double width10 = DievasSizingPrimitives.s10;

  /// 12px width.
  static const double width12 = DievasSizingPrimitives.s12;

  /// 14px width.
  static const double width14 = DievasSizingPrimitives.s14;

  /// 16px width.
  static const double width16 = DievasSizingPrimitives.s16;

  /// 18px width.
  static const double width18 = DievasSizingPrimitives.s18;

  /// 20px width.
  static const double width20 = DievasSizingPrimitives.s20;

  /// 24px width.
  static const double width24 = DievasSizingPrimitives.s24;

  /// 28px width.
  static const double width28 = DievasSizingPrimitives.s28;

  /// 32px width.
  static const double width32 = DievasSizingPrimitives.s32;

  /// 36px width.
  static const double width36 = DievasSizingPrimitives.s36;

  /// 40px width.
  static const double width40 = DievasSizingPrimitives.s40;

  /// 44px width.
  static const double width44 = DievasSizingPrimitives.s44;

  /// 48px width.
  static const double width48 = DievasSizingPrimitives.s48;

  /// 52px width.
  static const double width52 = DievasSizingPrimitives.s52;

  /// 56px width.
  static const double width56 = DievasSizingPrimitives.s56;

  /// 60px width.
  static const double width60 = DievasSizingPrimitives.s60;

  /// 64px width.
  static const double width64 = DievasSizingPrimitives.s64;

  /// 80px width.
  static const double width80 = DievasSizingPrimitives.s80;

  /// 96px width.
  static const double width96 = DievasSizingPrimitives.s96;

  /// 128px width.
  static const double width128 = DievasSizingPrimitives.s128;

  /// 160px width.
  static const double width160 = DievasSizingPrimitives.s160;

  /// 192px width.
  static const double width192 = DievasSizingPrimitives.s192;

  /// 256px width.
  static const double width256 = DievasSizingPrimitives.s256;
}
