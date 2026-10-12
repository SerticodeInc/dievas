import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:equatable/equatable.dart';

/// The spacing sub-system for a Dievas theme.
///
/// All values are in logical pixels, based on a 4pt base grid.
/// Fields mirror [DievasSpacingSemantic] names so token → theme data
/// is a 1-to-1 read.
final class DievasSpacingThemeData extends Equatable {
  const DievasSpacingThemeData({
    this.NONE = DievasSpacingSemantic.NONE,
    this.XS = DievasSpacingSemantic.XS,
    this.SM = DievasSpacingSemantic.SM,
    this.SMPlus = DievasSpacingSemantic.SMPlus,
    this.MD = DievasSpacingSemantic.MD,
    this.MDPlus = DievasSpacingSemantic.MDPlus,
    this.LG = DievasSpacingSemantic.LG,
    this.LGPlus = DievasSpacingSemantic.LGPlus,
    this.XL = DievasSpacingSemantic.XL,
    this.XLPlus = DievasSpacingSemantic.XLPlus,
    this.XL2 = DievasSpacingSemantic.XL2,
    this.XL2Plus = DievasSpacingSemantic.XL2Plus,
    this.XL3 = DievasSpacingSemantic.XL3,
    this.XL4 = DievasSpacingSemantic.XL4,
    this.XL5 = DievasSpacingSemantic.XL5,
  });

  /// 0px
  final double NONE;

  /// 4px — tight inline gaps, icon-to-label spacing.
  final double XS;

  /// 8px — compact list item padding, small gutters.
  final double SM;

  /// 12px — small component internal padding.
  final double SMPlus;

  /// 16px — default internal padding for cards, inputs, buttons.
  final double MD;

  /// 20px — comfortable section gaps.
  final double MDPlus;

  /// 24px — component group separation, card-to-card gap.
  final double LG;

  /// 28px — slightly wider section separation.
  final double LGPlus;

  /// 32px — page section padding (vertical rhythm on mobile).
  final double XL;

  /// 40px — generous section breathing room.
  final double XLPlus;

  /// 48px — large section breaks, modal padding.
  final double XL2;

  /// 56px — prominent feature spacing.
  final double XL2Plus;

  /// 64px — page-level vertical padding on tablet.
  final double XL3;

  /// 80px — hero section spacing.
  final double XL4;

  /// 96px — wide-screen layout gutters.
  final double XL5;

  DievasSpacingThemeData copyWith({
    double? NONE,
    double? XS,
    double? SM,
    double? SMPlus,
    double? MD,
    double? MDPlus,
    double? LG,
    double? LGPlus,
    double? XL,
    double? XLPlus,
    double? XL2,
    double? XL2Plus,
    double? XL3,
    double? XL4,
    double? XL5,
  }) => DievasSpacingThemeData(
    NONE: NONE ?? this.NONE,
    XS: XS ?? this.XS,
    SM: SM ?? this.SM,
    SMPlus: SMPlus ?? this.SMPlus,
    MD: MD ?? this.MD,
    MDPlus: MDPlus ?? this.MDPlus,
    LG: LG ?? this.LG,
    LGPlus: LGPlus ?? this.LGPlus,
    XL: XL ?? this.XL,
    XLPlus: XLPlus ?? this.XLPlus,
    XL2: XL2 ?? this.XL2,
    XL2Plus: XL2Plus ?? this.XL2Plus,
    XL3: XL3 ?? this.XL3,
    XL4: XL4 ?? this.XL4,
    XL5: XL5 ?? this.XL5,
  );

  @override
  List<Object?> get props => [NONE, XS, SM, SMPlus, MD, MDPlus, LG, LGPlus, XL, XLPlus, XL2, XL2Plus, XL3, XL4, XL5];
}
