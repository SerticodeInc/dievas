import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasAvatar].
///
/// Holds per-size dimensions, initials text styles, and fallback colours.
/// Colour is resolved from [DievasColourThemeData] in the widget — the
/// background/foreground fields here are the defaults when no image or
/// initials are provided.
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
  });

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

  @override
  List<Object?> get props => [
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
