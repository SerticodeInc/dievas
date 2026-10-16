import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// The border radius and stroke-width sub-system for a Dievas theme.
///
/// Radius values are exposed as [BorderRadius] objects ready for use
/// in widget decoration. Stroke widths are raw [double] values.
final class DievasBorderThemeData extends Equatable {
  const DievasBorderThemeData({
    this.NONE = .zero,
    this.XS = const .all(.circular(DievasRadiusSemantic.XS)),
    this.SM = const .all(.circular(DievasRadiusSemantic.SM)),
    this.MD = const .all(.circular(DievasRadiusSemantic.MD)),
    this.LG = const .all(.circular(DievasRadiusSemantic.LG)),
    this.XL = const .all(.circular(DievasRadiusSemantic.XL)),
    this.XL2 = const .all(.circular(DievasRadiusSemantic.XL2)),
    this.XL3 = const .all(.circular(DievasRadiusSemantic.XL3)),
    this.FULL = const .all(.circular(DievasRadiusSemantic.FULL)),
    this.strokeThin = 1.0,
    this.strokeDefault = 1.5,
    this.strokeThick = 2.0,
  });

  /// 0px — sharp corners.
  final BorderRadius NONE;

  /// 2px — subtle rounding. Tags, small chips.
  final BorderRadius XS;

  /// 4px — compact inputs, small buttons, tooltips.
  final BorderRadius SM;

  /// 8px — default rounding. Cards, modals, standard buttons, text fields.
  final BorderRadius MD;

  /// 12px — large cards, elevated panels.
  final BorderRadius LG;

  /// 16px — prominent surfaces, bottom sheets.
  final BorderRadius XL;

  /// 20px — extra-large overlays, feature cards.
  final BorderRadius XL2;

  /// 24px — hero cards.
  final BorderRadius XL3;

  /// 9999px — pill shape. Badges, chips, fully rounded buttons.
  final BorderRadius FULL;

  /// 1px — dividers, subtle borders.
  final double strokeThin;

  /// 1.5px — default input and card borders.
  final double strokeDefault;

  /// 2px — focus rings, selected borders.
  final double strokeThick;

  DievasBorderThemeData copyWith({
    BorderRadius? NONE,
    BorderRadius? XS,
    BorderRadius? SM,
    BorderRadius? MD,
    BorderRadius? LG,
    BorderRadius? XL,
    BorderRadius? XL2,
    BorderRadius? XL3,
    BorderRadius? FULL,
    double? strokeThin,
    double? strokeDefault,
    double? strokeThick,
  }) => DievasBorderThemeData(
    NONE: NONE ?? this.NONE,
    XS: XS ?? this.XS,
    SM: SM ?? this.SM,
    MD: MD ?? this.MD,
    LG: LG ?? this.LG,
    XL: XL ?? this.XL,
    XL2: XL2 ?? this.XL2,
    XL3: XL3 ?? this.XL3,
    FULL: FULL ?? this.FULL,
    strokeThin: strokeThin ?? this.strokeThin,
    strokeDefault: strokeDefault ?? this.strokeDefault,
    strokeThick: strokeThick ?? this.strokeThick,
  );

  @override
  List<Object?> get props => [NONE, XS, SM, MD, LG, XL, XL2, XL3, FULL, strokeThin, strokeDefault, strokeThick];
}
