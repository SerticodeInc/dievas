import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:equatable/equatable.dart';

/// Component sizing tokens — heights, icon sizes, and avatar dimensions.
///
/// These are the canonical sizes that components render at. Tokens here are
/// the source of truth; individual component theme data structs will reference
/// these rather than duplicating values.
final class DievasSizingThemeData extends Equatable {
  const DievasSizingThemeData({
    this.buttonHeightXs = DievasSizingSemantic.buttonHeightXs,
    this.buttonHeightSm = DievasSizingSemantic.buttonHeightSm,
    this.buttonHeightMd = DievasSizingSemantic.buttonHeightMd,
    this.buttonHeightLg = DievasSizingSemantic.buttonHeightLg,
    this.inputHeightSm = DievasSizingSemantic.inputHeightSm,
    this.inputHeightMd = DievasSizingSemantic.inputHeightMd,
    this.inputHeightLg = DievasSizingSemantic.inputHeightLg,
    this.iconXs = DievasSizingSemantic.iconXs,
    this.iconSm = DievasSizingSemantic.iconSm,
    this.iconMd = DievasSizingSemantic.iconMd,
    this.iconLg = DievasSizingSemantic.iconLg,
    this.iconXl = DievasSizingSemantic.iconXl,
    this.avatarXs = DievasSizingSemantic.avatarXs,
    this.avatarSm = DievasSizingSemantic.avatarSm,
    this.avatarMd = DievasSizingSemantic.avatarMd,
    this.avatarLg = DievasSizingSemantic.avatarLg,
    this.avatarXl = DievasSizingSemantic.avatarXl,
    this.touchTargetMin = DievasSizingSemantic.touchTargetMin,
  });

  final double buttonHeightXs;
  final double buttonHeightSm;
  final double buttonHeightMd;
  final double buttonHeightLg;

  final double inputHeightSm;
  final double inputHeightMd;
  final double inputHeightLg;

  final double iconXs;
  final double iconSm;
  final double iconMd;
  final double iconLg;
  final double iconXl;

  final double avatarXs;
  final double avatarSm;
  final double avatarMd;
  final double avatarLg;
  final double avatarXl;

  /// Minimum touch target dimension per WCAG 2.5.5. Applied to all interactive widgets.
  final double touchTargetMin;

  DievasSizingThemeData copyWith({
    double? buttonHeightXs,
    double? buttonHeightSm,
    double? buttonHeightMd,
    double? buttonHeightLg,
    double? inputHeightSm,
    double? inputHeightMd,
    double? inputHeightLg,
    double? iconXs,
    double? iconSm,
    double? iconMd,
    double? iconLg,
    double? iconXl,
    double? avatarXs,
    double? avatarSm,
    double? avatarMd,
    double? avatarLg,
    double? avatarXl,
    double? touchTargetMin,
  }) => DievasSizingThemeData(
    buttonHeightXs: buttonHeightXs ?? this.buttonHeightXs,
    buttonHeightSm: buttonHeightSm ?? this.buttonHeightSm,
    buttonHeightMd: buttonHeightMd ?? this.buttonHeightMd,
    buttonHeightLg: buttonHeightLg ?? this.buttonHeightLg,
    inputHeightSm: inputHeightSm ?? this.inputHeightSm,
    inputHeightMd: inputHeightMd ?? this.inputHeightMd,
    inputHeightLg: inputHeightLg ?? this.inputHeightLg,
    iconXs: iconXs ?? this.iconXs,
    iconSm: iconSm ?? this.iconSm,
    iconMd: iconMd ?? this.iconMd,
    iconLg: iconLg ?? this.iconLg,
    iconXl: iconXl ?? this.iconXl,
    avatarXs: avatarXs ?? this.avatarXs,
    avatarSm: avatarSm ?? this.avatarSm,
    avatarMd: avatarMd ?? this.avatarMd,
    avatarLg: avatarLg ?? this.avatarLg,
    avatarXl: avatarXl ?? this.avatarXl,
    touchTargetMin: touchTargetMin ?? this.touchTargetMin,
  );

  @override
  List<Object?> get props => [
    buttonHeightXs,
    buttonHeightSm,
    buttonHeightMd,
    buttonHeightLg,
    inputHeightSm,
    inputHeightMd,
    inputHeightLg,
    iconXs,
    iconSm,
    iconMd,
    iconLg,
    iconXl,
    avatarXs,
    avatarSm,
    avatarMd,
    avatarLg,
    avatarXl,
    touchTargetMin,
  ];
}
