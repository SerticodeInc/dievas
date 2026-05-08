// Semantic sizing tokens.
//
// Pure Dart aliases over DievasSizingPrimitives for component heights,
// icon sizes, avatar dimensions, and minimum touch targets.

import '../primitives/sizing_primitives.dart';

/// Semantic sizing tokens for the Dievas design system.
///
/// References [DievasSizingPrimitives] exclusively.
abstract final class DievasSizingSemantic {
  /// Extra-small button height.
  static const double buttonHeightXs = DievasSizingPrimitives.s28;

  /// Small button height.
  static const double buttonHeightSm = DievasSizingPrimitives.s32;

  /// Medium button height.
  static const double buttonHeightMd = DievasSizingPrimitives.s40;

  /// Large button height.
  static const double buttonHeightLg = DievasSizingPrimitives.s48;

  /// Small input height.
  static const double inputHeightSm = DievasSizingPrimitives.s36;

  /// Medium input height.
  static const double inputHeightMd = DievasSizingPrimitives.s44;

  /// Large input height.
  static const double inputHeightLg = DievasSizingPrimitives.s52;

  /// Extra-small icon size.
  static const double iconXs = DievasSizingPrimitives.s12;

  /// Small icon size.
  static const double iconSm = DievasSizingPrimitives.s16;

  /// Medium icon size.
  static const double iconMd = DievasSizingPrimitives.s20;

  /// Large icon size.
  static const double iconLg = DievasSizingPrimitives.s24;

  /// Extra-large icon size.
  static const double iconXl = DievasSizingPrimitives.s32;

  /// Extra-small avatar size.
  static const double avatarXs = DievasSizingPrimitives.s24;

  /// Small avatar size.
  static const double avatarSm = DievasSizingPrimitives.s32;

  /// Medium avatar size.
  static const double avatarMd = DievasSizingPrimitives.s40;

  /// Large avatar size.
  static const double avatarLg = DievasSizingPrimitives.s48;

  /// Extra-large avatar size.
  static const double avatarXl = DievasSizingPrimitives.s64;

  /// Minimum touch target dimension.
  static const double touchTargetMin = DievasSizingPrimitives.s44;
}
