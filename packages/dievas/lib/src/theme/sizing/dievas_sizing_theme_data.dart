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
    this.height4 = DievasSizingSemantic.height4,
    this.height8 = DievasSizingSemantic.height8,
    this.height10 = DievasSizingSemantic.height10,
    this.height12 = DievasSizingSemantic.height12,
    this.height14 = DievasSizingSemantic.height14,
    this.height16 = DievasSizingSemantic.height16,
    this.height18 = DievasSizingSemantic.height18,
    this.height20 = DievasSizingSemantic.height20,
    this.height24 = DievasSizingSemantic.height24,
    this.height28 = DievasSizingSemantic.height28,
    this.height32 = DievasSizingSemantic.height32,
    this.height36 = DievasSizingSemantic.height36,
    this.height40 = DievasSizingSemantic.height40,
    this.height44 = DievasSizingSemantic.height44,
    this.height48 = DievasSizingSemantic.height48,
    this.height52 = DievasSizingSemantic.height52,
    this.height56 = DievasSizingSemantic.height56,
    this.height60 = DievasSizingSemantic.height60,
    this.height64 = DievasSizingSemantic.height64,
    this.height80 = DievasSizingSemantic.height80,
    this.height96 = DievasSizingSemantic.height96,
    this.height128 = DievasSizingSemantic.height128,
    this.height160 = DievasSizingSemantic.height160,
    this.height192 = DievasSizingSemantic.height192,
    this.height256 = DievasSizingSemantic.height256,
    this.width4 = DievasSizingSemantic.width4,
    this.width8 = DievasSizingSemantic.width8,
    this.width10 = DievasSizingSemantic.width10,
    this.width12 = DievasSizingSemantic.width12,
    this.width14 = DievasSizingSemantic.width14,
    this.width16 = DievasSizingSemantic.width16,
    this.width18 = DievasSizingSemantic.width18,
    this.width20 = DievasSizingSemantic.width20,
    this.width24 = DievasSizingSemantic.width24,
    this.width28 = DievasSizingSemantic.width28,
    this.width32 = DievasSizingSemantic.width32,
    this.width36 = DievasSizingSemantic.width36,
    this.width40 = DievasSizingSemantic.width40,
    this.width44 = DievasSizingSemantic.width44,
    this.width48 = DievasSizingSemantic.width48,
    this.width52 = DievasSizingSemantic.width52,
    this.width56 = DievasSizingSemantic.width56,
    this.width60 = DievasSizingSemantic.width60,
    this.width64 = DievasSizingSemantic.width64,
    this.width80 = DievasSizingSemantic.width80,
    this.width96 = DievasSizingSemantic.width96,
    this.width128 = DievasSizingSemantic.width128,
    this.width160 = DievasSizingSemantic.width160,
    this.width192 = DievasSizingSemantic.width192,
    this.width256 = DievasSizingSemantic.width256,
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

  /// 4px height.
  final double height4;

  /// 8px height.
  final double height8;

  /// 10px height.
  final double height10;

  /// 12px height.
  final double height12;

  /// 14px height.
  final double height14;

  /// 16px height.
  final double height16;

  /// 18px height.
  final double height18;

  /// 20px height.
  final double height20;

  /// 24px height.
  final double height24;

  /// 28px height.
  final double height28;

  /// 32px height.
  final double height32;

  /// 36px height.
  final double height36;

  /// 40px height.
  final double height40;

  /// 44px height.
  final double height44;

  /// 48px height.
  final double height48;

  /// 52px height.
  final double height52;

  /// 56px height.
  final double height56;

  /// 60px height.
  final double height60;

  /// 64px height.
  final double height64;

  /// 80px height.
  final double height80;

  /// 96px height.
  final double height96;

  /// 128px height.
  final double height128;

  /// 160px height.
  final double height160;

  /// 192px height.
  final double height192;

  /// 256px height.
  final double height256;

  /// 4px width.
  final double width4;

  /// 8px width.
  final double width8;

  /// 10px width.
  final double width10;

  /// 12px width.
  final double width12;

  /// 14px width.
  final double width14;

  /// 16px width.
  final double width16;

  /// 18px width.
  final double width18;

  /// 20px width.
  final double width20;

  /// 24px width.
  final double width24;

  /// 28px width.
  final double width28;

  /// 32px width.
  final double width32;

  /// 36px width.
  final double width36;

  /// 40px width.
  final double width40;

  /// 44px width.
  final double width44;

  /// 48px width.
  final double width48;

  /// 52px width.
  final double width52;

  /// 56px width.
  final double width56;

  /// 60px width.
  final double width60;

  /// 64px width.
  final double width64;

  /// 80px width.
  final double width80;

  /// 96px width.
  final double width96;

  /// 128px width.
  final double width128;

  /// 160px width.
  final double width160;

  /// 192px width.
  final double width192;

  /// 256px width.
  final double width256;

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
    double? height4,
    double? height8,
    double? height10,
    double? height12,
    double? height14,
    double? height16,
    double? height18,
    double? height20,
    double? height24,
    double? height28,
    double? height32,
    double? height36,
    double? height40,
    double? height44,
    double? height48,
    double? height52,
    double? height56,
    double? height60,
    double? height64,
    double? height80,
    double? height96,
    double? height128,
    double? height160,
    double? height192,
    double? height256,
    double? width4,
    double? width8,
    double? width10,
    double? width12,
    double? width14,
    double? width16,
    double? width18,
    double? width20,
    double? width24,
    double? width28,
    double? width32,
    double? width36,
    double? width40,
    double? width44,
    double? width48,
    double? width52,
    double? width56,
    double? width60,
    double? width64,
    double? width80,
    double? width96,
    double? width128,
    double? width160,
    double? width192,
    double? width256,
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
    height4: height4 ?? this.height4,
    height8: height8 ?? this.height8,
    height10: height10 ?? this.height10,
    height12: height12 ?? this.height12,
    height14: height14 ?? this.height14,
    height16: height16 ?? this.height16,
    height18: height18 ?? this.height18,
    height20: height20 ?? this.height20,
    height24: height24 ?? this.height24,
    height28: height28 ?? this.height28,
    height32: height32 ?? this.height32,
    height36: height36 ?? this.height36,
    height40: height40 ?? this.height40,
    height44: height44 ?? this.height44,
    height48: height48 ?? this.height48,
    height52: height52 ?? this.height52,
    height56: height56 ?? this.height56,
    height60: height60 ?? this.height60,
    height64: height64 ?? this.height64,
    height80: height80 ?? this.height80,
    height96: height96 ?? this.height96,
    height128: height128 ?? this.height128,
    height160: height160 ?? this.height160,
    height192: height192 ?? this.height192,
    height256: height256 ?? this.height256,
    width4: width4 ?? this.width4,
    width8: width8 ?? this.width8,
    width10: width10 ?? this.width10,
    width12: width12 ?? this.width12,
    width14: width14 ?? this.width14,
    width16: width16 ?? this.width16,
    width18: width18 ?? this.width18,
    width20: width20 ?? this.width20,
    width24: width24 ?? this.width24,
    width28: width28 ?? this.width28,
    width32: width32 ?? this.width32,
    width36: width36 ?? this.width36,
    width40: width40 ?? this.width40,
    width44: width44 ?? this.width44,
    width48: width48 ?? this.width48,
    width52: width52 ?? this.width52,
    width56: width56 ?? this.width56,
    width60: width60 ?? this.width60,
    width64: width64 ?? this.width64,
    width80: width80 ?? this.width80,
    width96: width96 ?? this.width96,
    width128: width128 ?? this.width128,
    width160: width160 ?? this.width160,
    width192: width192 ?? this.width192,
    width256: width256 ?? this.width256,
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
    height4,
    height8,
    height10,
    height12,
    height14,
    height16,
    height18,
    height20,
    height24,
    height28,
    height32,
    height36,
    height40,
    height44,
    height48,
    height52,
    height56,
    height60,
    height64,
    height80,
    height96,
    height128,
    height160,
    height192,
    height256,
    width4,
    width8,
    width10,
    width12,
    width14,
    width16,
    width18,
    width20,
    width24,
    width28,
    width32,
    width36,
    width40,
    width44,
    width48,
    width52,
    width56,
    width60,
    width64,
    width80,
    width96,
    width128,
    width160,
    width192,
    width256,
  ];
}
