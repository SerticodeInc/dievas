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
    this.xl2 = const .all(.circular(DievasRadiusSemantic.xl2)),
    this.xl3 = const .all(.circular(DievasRadiusSemantic.xl3)),
    this.r28 = const .all(.circular(DievasRadiusSemantic.r28)),
    this.r32 = const .all(.circular(DievasRadiusSemantic.r32)),
    this.r36 = const .all(.circular(DievasRadiusSemantic.r36)),
    this.r40 = const .all(.circular(DievasRadiusSemantic.r40)),
    this.r48 = const .all(.circular(DievasRadiusSemantic.r48)),
    this.r56 = const .all(.circular(DievasRadiusSemantic.r56)),
    this.r64 = const .all(.circular(DievasRadiusSemantic.r64)),
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
  final BorderRadius xl2;

  /// 24px — hero cards.
  final BorderRadius xl3;

  /// 28px radius.
  final BorderRadius r28;

  /// 32px radius.
  final BorderRadius r32;

  /// 36px radius.
  final BorderRadius r36;

  /// 40px radius.
  final BorderRadius r40;

  /// 48px radius.
  final BorderRadius r48;

  /// 56px radius.
  final BorderRadius r56;

  /// 64px radius.
  final BorderRadius r64;

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
    BorderRadius? xl2,
    BorderRadius? xl3,
    BorderRadius? r28,
    BorderRadius? r32,
    BorderRadius? r36,
    BorderRadius? r40,
    BorderRadius? r48,
    BorderRadius? r56,
    BorderRadius? r64,
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
    xl2: xl2 ?? this.xl2,
    xl3: xl3 ?? this.xl3,
    r28: r28 ?? this.r28,
    r32: r32 ?? this.r32,
    r36: r36 ?? this.r36,
    r40: r40 ?? this.r40,
    r48: r48 ?? this.r48,
    r56: r56 ?? this.r56,
    r64: r64 ?? this.r64,
    full: full ?? this.full,
    strokeThin: strokeThin ?? this.strokeThin,
    strokeDefault: strokeDefault ?? this.strokeDefault,
    strokeThick: strokeThick ?? this.strokeThick,
  );

  @override
  List<Object?> get props => [
    none,
    xs,
    sm,
    md,
    lg,
    xl,
    xl2,
    xl3,
    r28,
    r32,
    r36,
    r40,
    r48,
    r56,
    r64,
    full,
    strokeThin,
    strokeDefault,
    strokeThick,
  ];
}
