import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// The elevation sub-system for a Dievas theme.
///
/// Each level is a [List<BoxShadow>] ready to apply directly to
/// [BoxDecoration.boxShadow]. The shadow colour is baked in at construction
/// time so components never need to compute it.
final class DievasElevationThemeData extends Equatable {
  const DievasElevationThemeData({
    required this.NONE,
    required this.XS,
    required this.SM,
    required this.MD,
    required this.LG,
    required this.XL,
  });

  /// No shadow — flat surface flush with the page.
  final List<BoxShadow> NONE;

  /// Hairline shadow — subtle card lift on a light background.
  final List<BoxShadow> XS;

  /// Small shadow — default card, chip, badge.
  final List<BoxShadow> SM;

  /// Medium shadow — hovered card, dropdown, tooltip.
  final List<BoxShadow> MD;

  /// Large shadow — floating action button, sticky header.
  final List<BoxShadow> LG;

  /// Extra-large shadow — modal, bottom sheet, popover.
  final List<BoxShadow> XL;

  DievasElevationThemeData copyWith({
    List<BoxShadow>? NONE,
    List<BoxShadow>? XS,
    List<BoxShadow>? SM,
    List<BoxShadow>? MD,
    List<BoxShadow>? LG,
    List<BoxShadow>? XL,
  }) => DievasElevationThemeData(
    NONE: NONE ?? this.NONE,
    XS: XS ?? this.XS,
    SM: SM ?? this.SM,
    MD: MD ?? this.MD,
    LG: LG ?? this.LG,
    XL: XL ?? this.XL,
  );

  @override
  List<Object?> get props => [NONE, XS, SM, MD, LG, XL];
}
