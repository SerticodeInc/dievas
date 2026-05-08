import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// The border radius and stroke-width sub-system for a Dievas theme.
///
/// Radius values are exposed as [BorderRadius] objects ready for use
/// in widget decoration. Stroke widths are raw [double] values.
final class DievasBorderThemeData extends Equatable {
  const DievasBorderThemeData({
    this.none = .zero,
    this.xs = const .all(.circular(DievasRadiusSemantic.xs)),
    this.sm = const .all(.circular(DievasRadiusSemantic.sm)),
    this.md = const .all(.circular(DievasRadiusSemantic.md)),
    this.lg = const .all(.circular(DievasRadiusSemantic.lg)),
    this.xl = const .all(.circular(DievasRadiusSemantic.xl)),
    this.x2l = const .all(.circular(DievasRadiusSemantic.x2l)),
    this.x3l = const .all(.circular(DievasRadiusSemantic.x3l)),
    this.full = const .all(.circular(DievasRadiusSemantic.full)),
    this.strokeThin = 1.0,
    this.strokeDefault = 1.5,
    this.strokeThick = 2.0,
  });

  /// 0px — sharp corners.
  final BorderRadius none;

  /// 2px — subtle rounding. Tags, small chips.
  final BorderRadius xs;

  /// 4px — compact inputs, small buttons, tooltips.
  final BorderRadius sm;

  /// 8px — default rounding. Cards, modals, standard buttons, text fields.
  final BorderRadius md;

  /// 12px — large cards, elevated panels.
  final BorderRadius lg;

  /// 16px — prominent surfaces, bottom sheets.
  final BorderRadius xl;

  /// 20px — extra-large overlays, feature cards.
  final BorderRadius x2l;

  /// 24px — hero cards.
  final BorderRadius x3l;

  /// 9999px — pill shape. Badges, chips, fully rounded buttons.
  final BorderRadius full;

  /// 1px — dividers, subtle borders.
  final double strokeThin;

  /// 1.5px — default input and card borders.
  final double strokeDefault;

  /// 2px — focus rings, selected borders.
  final double strokeThick;

  DievasBorderThemeData copyWith({
    BorderRadius? none,
    BorderRadius? xs,
    BorderRadius? sm,
    BorderRadius? md,
    BorderRadius? lg,
    BorderRadius? xl,
    BorderRadius? x2l,
    BorderRadius? x3l,
    BorderRadius? full,
    double? strokeThin,
    double? strokeDefault,
    double? strokeThick,
  }) => DievasBorderThemeData(
    none: none ?? this.none,
    xs: xs ?? this.xs,
    sm: sm ?? this.sm,
    md: md ?? this.md,
    lg: lg ?? this.lg,
    xl: xl ?? this.xl,
    x2l: x2l ?? this.x2l,
    x3l: x3l ?? this.x3l,
    full: full ?? this.full,
    strokeThin: strokeThin ?? this.strokeThin,
    strokeDefault: strokeDefault ?? this.strokeDefault,
    strokeThick: strokeThick ?? this.strokeThick,
  );

  @override
  List<Object?> get props => [none, xs, sm, md, lg, xl, x2l, x3l, full, strokeThin, strokeDefault, strokeThick];
}
