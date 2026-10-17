import 'package:equatable/equatable.dart';
import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasAvatar].
///
/// Holds per-size dimensions, foreground styles, surface colours, and badge
/// proportions. The theme mapper resolves the defaults from Dievas tokens.
/// Optional additions preserve existing custom theme constructors.
final class DievasAvatarThemeData extends Equatable {
  const DievasAvatarThemeData({
    required this.sizeXS,
    required this.sizeSM,
    required this.sizeMD,
    required this.sizeLG,
    required this.sizeXL,
    required this.borderRadiusSquare,
    required this.initialsStyleXS,
    required this.initialsStyleSM,
    required this.initialsStyleMD,
    required this.initialsStyleLG,
    required this.initialsStyleXL,
    required this.backgroundColour,
    required this.initialsColour,
    required this.placeholderColour,
    this.sizeXL2 = DievasSizingPrimitives.s80,
    this.initialsStyleXL2,
    this.badgeColour,
    this.badgeSizeFactor = 0.2,
    this.badgeMarginFactor = 0.05,
  });

  /// Extra-large profile dimension; the default maps to the 80 dp size token.
  final double sizeXL2;

  /// Falls back to the XL text style in existing custom themes.
  final TextStyle? initialsStyleXL2;

  /// Status colour; null resolves the active theme’s success icon colour.
  final Color? badgeColour;

  /// Badge diameter as a fraction of the avatar’s shorter side.
  final double badgeSizeFactor;

  /// Transparent badge gap as a fraction of the avatar’s shorter side.
  final double badgeMarginFactor;

  /// Container size for [DievasAvatarSize.XS] — 24 dp.
  final double sizeXS;

  /// Container size for [DievasAvatarSize.SM] — 32 dp.
  final double sizeSM;

  /// Container size for [DievasAvatarSize.MD] — 40 dp.
  final double sizeMD;

  /// Container size for [DievasAvatarSize.LG] — 48 dp.
  final double sizeLG;

  /// Container size for [DievasAvatarSize.XL] — 64 dp.
  final double sizeXL;

  /// Corner radius used when [DievasAvatarShape.square] is selected.
  final BorderRadius borderRadiusSquare;

  /// Initials text style at [DievasAvatarSize.XS].
  final TextStyle initialsStyleXS;

  /// Initials text style at [DievasAvatarSize.SM].
  final TextStyle initialsStyleSM;

  /// Initials text style at [DievasAvatarSize.MD].
  final TextStyle initialsStyleMD;

  /// Initials text style at [DievasAvatarSize.LG].
  final TextStyle initialsStyleLG;

  /// Initials text style at [DievasAvatarSize.XL].
  final TextStyle initialsStyleXL;

  /// Fallback container background (used when no image is provided).
  final Color backgroundColour;

  /// Initials / placeholder icon colour.
  final Color initialsColour;

  /// Placeholder icon colour when neither image nor initials are provided.
  final Color placeholderColour;

  /// Creates a copy of this [DievasAvatarThemeData] with the given fields replaced.
  DievasAvatarThemeData copyWith({
    double? sizeXS,
    double? sizeSM,
    double? sizeMD,
    double? sizeLG,
    double? sizeXL,
    BorderRadius? borderRadiusSquare,
    TextStyle? initialsStyleXS,
    TextStyle? initialsStyleSM,
    TextStyle? initialsStyleMD,
    TextStyle? initialsStyleLG,
    TextStyle? initialsStyleXL,
    Color? backgroundColour,
    Color? initialsColour,
    Color? placeholderColour,
    double? sizeXL2,
    TextStyle? initialsStyleXL2,
    Color? badgeColour,
    double? badgeSizeFactor,
    double? badgeMarginFactor,
  }) => DievasAvatarThemeData(
    sizeXS: sizeXS ?? this.sizeXS,
    sizeSM: sizeSM ?? this.sizeSM,
    sizeMD: sizeMD ?? this.sizeMD,
    sizeLG: sizeLG ?? this.sizeLG,
    sizeXL: sizeXL ?? this.sizeXL,
    borderRadiusSquare: borderRadiusSquare ?? this.borderRadiusSquare,
    initialsStyleXS: initialsStyleXS ?? this.initialsStyleXS,
    initialsStyleSM: initialsStyleSM ?? this.initialsStyleSM,
    initialsStyleMD: initialsStyleMD ?? this.initialsStyleMD,
    initialsStyleLG: initialsStyleLG ?? this.initialsStyleLG,
    initialsStyleXL: initialsStyleXL ?? this.initialsStyleXL,
    backgroundColour: backgroundColour ?? this.backgroundColour,
    initialsColour: initialsColour ?? this.initialsColour,
    placeholderColour: placeholderColour ?? this.placeholderColour,
    sizeXL2: sizeXL2 ?? this.sizeXL2,
    initialsStyleXL2: initialsStyleXL2 ?? this.initialsStyleXL2,
    badgeColour: badgeColour ?? this.badgeColour,
    badgeSizeFactor: badgeSizeFactor ?? this.badgeSizeFactor,
    badgeMarginFactor: badgeMarginFactor ?? this.badgeMarginFactor,
  );

  @override
  List<Object?> get props => [
    sizeXL2,
    initialsStyleXL2,
    badgeColour,
    badgeSizeFactor,
    badgeMarginFactor,
    sizeXS,
    sizeSM,
    sizeMD,
    sizeLG,
    sizeXL,
    borderRadiusSquare,
    initialsStyleXS,
    initialsStyleSM,
    initialsStyleMD,
    initialsStyleLG,
    initialsStyleXL,
    backgroundColour,
    initialsColour,
    placeholderColour,
  ];
}
