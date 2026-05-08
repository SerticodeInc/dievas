import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:equatable/equatable.dart';

/// The spacing sub-system for a Dievas theme.
///
/// All values are in logical pixels, based on a 4pt base grid.
/// Fields mirror [DievasSpacingSemantic] names so token → theme data
/// is a 1-to-1 read.
final class DievasSpacingThemeData extends Equatable {
  const DievasSpacingThemeData({
    this.none = DievasSpacingSemantic.none,
    this.xs = DievasSpacingSemantic.xs,
    this.sm = DievasSpacingSemantic.sm,
    this.smPlus = DievasSpacingSemantic.smPlus,
    this.md = DievasSpacingSemantic.md,
    this.mdPlus = DievasSpacingSemantic.mdPlus,
    this.lg = DievasSpacingSemantic.lg,
    this.lgPlus = DievasSpacingSemantic.lgPlus,
    this.xl = DievasSpacingSemantic.xl,
    this.xlPlus = DievasSpacingSemantic.xlPlus,
    this.x2l = DievasSpacingSemantic.x2l,
    this.x2lPlus = DievasSpacingSemantic.x2lPlus,
    this.x3l = DievasSpacingSemantic.x3l,
    this.x4l = DievasSpacingSemantic.x4l,
    this.x5l = DievasSpacingSemantic.x5l,
  });

  /// 0px
  final double none;

  /// 4px — tight inline gaps, icon-to-label spacing.
  final double xs;

  /// 8px — compact list item padding, small gutters.
  final double sm;

  /// 12px — small component internal padding.
  final double smPlus;

  /// 16px — default internal padding for cards, inputs, buttons.
  final double md;

  /// 20px — comfortable section gaps.
  final double mdPlus;

  /// 24px — component group separation, card-to-card gap.
  final double lg;

  /// 28px — slightly wider section separation.
  final double lgPlus;

  /// 32px — page section padding (vertical rhythm on mobile).
  final double xl;

  /// 40px — generous section breathing room.
  final double xlPlus;

  /// 48px — large section breaks, modal padding.
  final double x2l;

  /// 56px — prominent feature spacing.
  final double x2lPlus;

  /// 64px — page-level vertical padding on tablet.
  final double x3l;

  /// 80px — hero section spacing.
  final double x4l;

  /// 96px — wide-screen layout gutters.
  final double x5l;

  DievasSpacingThemeData copyWith({
    double? none,
    double? xs,
    double? sm,
    double? smPlus,
    double? md,
    double? mdPlus,
    double? lg,
    double? lgPlus,
    double? xl,
    double? xlPlus,
    double? x2l,
    double? x2lPlus,
    double? x3l,
    double? x4l,
    double? x5l,
  }) => DievasSpacingThemeData(
    none: none ?? this.none,
    xs: xs ?? this.xs,
    sm: sm ?? this.sm,
    smPlus: smPlus ?? this.smPlus,
    md: md ?? this.md,
    mdPlus: mdPlus ?? this.mdPlus,
    lg: lg ?? this.lg,
    lgPlus: lgPlus ?? this.lgPlus,
    xl: xl ?? this.xl,
    xlPlus: xlPlus ?? this.xlPlus,
    x2l: x2l ?? this.x2l,
    x2lPlus: x2lPlus ?? this.x2lPlus,
    x3l: x3l ?? this.x3l,
    x4l: x4l ?? this.x4l,
    x5l: x5l ?? this.x5l,
  );

  @override
  List<Object?> get props => [none, xs, sm, smPlus, md, mdPlus, lg, lgPlus, xl, xlPlus, x2l, x2lPlus, x3l, x4l, x5l];
}
