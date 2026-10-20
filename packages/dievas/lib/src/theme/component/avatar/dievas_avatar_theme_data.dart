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
    required this.sizeXs,
    required this.sizeSm,
    required this.sizeMd,
    required this.sizeLg,
    required this.sizeXl,
    required this.borderRadiusSquare,
    required this.initialsStyleXs,
    required this.initialsStyleSm,
    required this.initialsStyleMd,
    required this.initialsStyleLg,
    required this.initialsStyleXl,
    required this.backgroundColour,
    required this.initialsColour,
    required this.placeholderColour,
    this.sizeXl2 = DievasSizingPrimitives.s80,
    this.initialsStyleXl2,
    this.badgeColour,
    this.badgeSizeFactor = 0.2,
    this.badgeMarginFactor = 0.05,
  });

  /// Extra-large profile dimension; the default maps to the 80 dp size token.
  final double sizeXl2;

  /// Falls back to the xl text style in existing custom themes.
  final TextStyle? initialsStyleXl2;

  /// Status colour; null resolves the active theme’s success icon colour.
  final Color? badgeColour;

  /// Badge diameter as a fraction of the avatar’s shorter side.
  final double badgeSizeFactor;

  /// Transparent badge gap as a fraction of the avatar’s shorter side.
  final double badgeMarginFactor;

  /// Container size for [DievasAvatarSize.xs] — 24 dp.
  final double sizeXs;

  /// Container size for [DievasAvatarSize.sm] — 32 dp.
  final double sizeSm;

  /// Container size for [DievasAvatarSize.md] — 40 dp.
  final double sizeMd;

  /// Container size for [DievasAvatarSize.lg] — 48 dp.
  final double sizeLg;

  /// Container size for [DievasAvatarSize.xl] — 64 dp.
  final double sizeXl;

  /// Corner radius used when [DievasAvatarShape.square] is selected.
  final BorderRadius borderRadiusSquare;

  /// Initials text style at [DievasAvatarSize.xs].
  final TextStyle initialsStyleXs;

  /// Initials text style at [DievasAvatarSize.sm].
  final TextStyle initialsStyleSm;

  /// Initials text style at [DievasAvatarSize.md].
  final TextStyle initialsStyleMd;

  /// Initials text style at [DievasAvatarSize.lg].
  final TextStyle initialsStyleLg;

  /// Initials text style at [DievasAvatarSize.xl].
  final TextStyle initialsStyleXl;

  /// Fallback container background (used when no image is provided).
  final Color backgroundColour;

  /// Initials / placeholder icon colour.
  final Color initialsColour;

  /// Placeholder icon colour when neither image nor initials are provided.
  final Color placeholderColour;

  /// Creates a copy of this [DievasAvatarThemeData] with the given fields replaced.
  DievasAvatarThemeData copyWith({
    double? sizeXs,
    double? sizeSm,
    double? sizeMd,
    double? sizeLg,
    double? sizeXl,
    BorderRadius? borderRadiusSquare,
    TextStyle? initialsStyleXs,
    TextStyle? initialsStyleSm,
    TextStyle? initialsStyleMd,
    TextStyle? initialsStyleLg,
    TextStyle? initialsStyleXl,
    Color? backgroundColour,
    Color? initialsColour,
    Color? placeholderColour,
    double? sizeXl2,
    TextStyle? initialsStyleXl2,
    Color? badgeColour,
    double? badgeSizeFactor,
    double? badgeMarginFactor,
  }) => DievasAvatarThemeData(
    sizeXs: sizeXs ?? this.sizeXs,
    sizeSm: sizeSm ?? this.sizeSm,
    sizeMd: sizeMd ?? this.sizeMd,
    sizeLg: sizeLg ?? this.sizeLg,
    sizeXl: sizeXl ?? this.sizeXl,
    borderRadiusSquare: borderRadiusSquare ?? this.borderRadiusSquare,
    initialsStyleXs: initialsStyleXs ?? this.initialsStyleXs,
    initialsStyleSm: initialsStyleSm ?? this.initialsStyleSm,
    initialsStyleMd: initialsStyleMd ?? this.initialsStyleMd,
    initialsStyleLg: initialsStyleLg ?? this.initialsStyleLg,
    initialsStyleXl: initialsStyleXl ?? this.initialsStyleXl,
    backgroundColour: backgroundColour ?? this.backgroundColour,
    initialsColour: initialsColour ?? this.initialsColour,
    placeholderColour: placeholderColour ?? this.placeholderColour,
    sizeXl2: sizeXl2 ?? this.sizeXl2,
    initialsStyleXl2: initialsStyleXl2 ?? this.initialsStyleXl2,
    badgeColour: badgeColour ?? this.badgeColour,
    badgeSizeFactor: badgeSizeFactor ?? this.badgeSizeFactor,
    badgeMarginFactor: badgeMarginFactor ?? this.badgeMarginFactor,
  );

  @override
  List<Object?> get props => [
    sizeXl2,
    initialsStyleXl2,
    badgeColour,
    badgeSizeFactor,
    badgeMarginFactor,
    sizeXs,
    sizeSm,
    sizeMd,
    sizeLg,
    sizeXl,
    borderRadiusSquare,
    initialsStyleXs,
    initialsStyleSm,
    initialsStyleMd,
    initialsStyleLg,
    initialsStyleXl,
    backgroundColour,
    initialsColour,
    placeholderColour,
  ];
}
