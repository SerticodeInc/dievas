import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:equatable/equatable.dart';

/// Component sizing tokens — heights, icon sizes, and avatar dimensions.
///
/// These are the canonical sizes that components render at. Tokens here are
/// the source of truth; individual component theme data structs will reference
/// these rather than duplicating values.
final class DievasSizingThemeData extends Equatable {
  const DievasSizingThemeData({
    this.buttonHeightXS = DievasSizingSemantic.buttonHeightXS,
    this.buttonHeightSM = DievasSizingSemantic.buttonHeightSM,
    this.buttonHeightMD = DievasSizingSemantic.buttonHeightMD,
    this.buttonHeightLG = DievasSizingSemantic.buttonHeightLG,
    this.inputHeightSM = DievasSizingSemantic.inputHeightSM,
    this.inputHeightMD = DievasSizingSemantic.inputHeightMD,
    this.inputHeightLG = DievasSizingSemantic.inputHeightLG,
    this.iconXS = DievasSizingSemantic.iconXS,
    this.iconSM = DievasSizingSemantic.iconSM,
    this.iconMD = DievasSizingSemantic.iconMD,
    this.iconLG = DievasSizingSemantic.iconLG,
    this.iconXL = DievasSizingSemantic.iconXL,
    this.avatarXS = DievasSizingSemantic.avatarXS,
    this.avatarSM = DievasSizingSemantic.avatarSM,
    this.avatarMD = DievasSizingSemantic.avatarMD,
    this.avatarLG = DievasSizingSemantic.avatarLG,
    this.avatarXL = DievasSizingSemantic.avatarXL,
    this.touchMin = DievasSizingSemantic.touchMin,
  });

  final double buttonHeightXS;
  final double buttonHeightSM;
  final double buttonHeightMD;
  final double buttonHeightLG;

  final double inputHeightSM;
  final double inputHeightMD;
  final double inputHeightLG;

  final double iconXS;
  final double iconSM;
  final double iconMD;
  final double iconLG;
  final double iconXL;

  final double avatarXS;
  final double avatarSM;
  final double avatarMD;
  final double avatarLG;
  final double avatarXL;

  /// Minimum touch target dimension per WCAG 2.5.5. Applied to all interactive widgets.
  final double touchMin;

  DievasSizingThemeData copyWith({
    double? buttonHeightXS,
    double? buttonHeightSM,
    double? buttonHeightMD,
    double? buttonHeightLG,
    double? inputHeightSM,
    double? inputHeightMD,
    double? inputHeightLG,
    double? iconXS,
    double? iconSM,
    double? iconMD,
    double? iconLG,
    double? iconXL,
    double? avatarXS,
    double? avatarSM,
    double? avatarMD,
    double? avatarLG,
    double? avatarXL,
    double? touchMin,
  }) => DievasSizingThemeData(
    buttonHeightXS: buttonHeightXS ?? this.buttonHeightXS,
    buttonHeightSM: buttonHeightSM ?? this.buttonHeightSM,
    buttonHeightMD: buttonHeightMD ?? this.buttonHeightMD,
    buttonHeightLG: buttonHeightLG ?? this.buttonHeightLG,
    inputHeightSM: inputHeightSM ?? this.inputHeightSM,
    inputHeightMD: inputHeightMD ?? this.inputHeightMD,
    inputHeightLG: inputHeightLG ?? this.inputHeightLG,
    iconXS: iconXS ?? this.iconXS,
    iconSM: iconSM ?? this.iconSM,
    iconMD: iconMD ?? this.iconMD,
    iconLG: iconLG ?? this.iconLG,
    iconXL: iconXL ?? this.iconXL,
    avatarXS: avatarXS ?? this.avatarXS,
    avatarSM: avatarSM ?? this.avatarSM,
    avatarMD: avatarMD ?? this.avatarMD,
    avatarLG: avatarLG ?? this.avatarLG,
    avatarXL: avatarXL ?? this.avatarXL,
    touchMin: touchMin ?? this.touchMin,
  );

  @override
  List<Object?> get props => [
    buttonHeightXS,
    buttonHeightSM,
    buttonHeightMD,
    buttonHeightLG,
    inputHeightSM,
    inputHeightMD,
    inputHeightLG,
    iconXS,
    iconSM,
    iconMD,
    iconLG,
    iconXL,
    avatarXS,
    avatarSM,
    avatarMD,
    avatarLG,
    avatarXL,
    touchMin,
  ];
}
