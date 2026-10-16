// Semantic sizing tokens.
//
// Pure Dart aliases over DievasSizingPrimitives for component heights,
// icon sizes, avatar dimensions, and minimum touch targets.

import 'package:dievas_tokens/src/primitives/sizing_primitives.dart';

/// Semantic sizing tokens for the Dievas design system.
///
/// References [DievasSizingPrimitives] exclusively.
abstract final class DievasSizingSemantic {
  /// Extra-small button height.
  static const double buttonHeightXS = DievasSizingPrimitives.s40;

  /// Small button height.
  static const double buttonHeightSM = DievasSizingPrimitives.s44;

  /// Medium button height.
  static const double buttonHeightMD = DievasSizingPrimitives.s48;

  /// Large button height.
  static const double buttonHeightLG = DievasSizingPrimitives.s52;

  /// Small input height.
  static const double inputHeightSM = DievasSizingPrimitives.s52;

  /// Medium input height.
  static const double inputHeightMD = DievasSizingPrimitives.s56;

  /// Large input height.
  static const double inputHeightLG = DievasSizingPrimitives.s60;

  /// Extra-small icon size.
  static const double iconXS = DievasSizingPrimitives.s12;

  /// Small icon size.
  static const double iconSM = DievasSizingPrimitives.s16;

  /// Medium icon size.
  static const double iconMD = DievasSizingPrimitives.s20;

  /// Large icon size.
  static const double iconLG = DievasSizingPrimitives.s24;

  /// Extra-large icon size.
  static const double iconXL = DievasSizingPrimitives.s32;

  /// Extra-small avatar size.
  static const double avatarXS = DievasSizingPrimitives.s24;

  /// Small avatar size.
  static const double avatarSM = DievasSizingPrimitives.s32;

  /// Medium avatar size.
  static const double avatarMD = DievasSizingPrimitives.s40;

  /// Large avatar size.
  static const double avatarLG = DievasSizingPrimitives.s48;

  /// Extra-large avatar size.
  static const double avatarXL = DievasSizingPrimitives.s64;

  /// Minimum touch target dimension.
  static const double touchMin = DievasSizingPrimitives.s44;
}
