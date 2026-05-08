import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// The elevation sub-system for a Dievas theme.
///
/// Each level is a [List<BoxShadow>] ready to apply directly to
/// [BoxDecoration.boxShadow]. The shadow colour is baked in at construction
/// time so components never need to compute it.
final class DievasElevationThemeData extends Equatable {
  const DievasElevationThemeData({
    required this.none,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  /// No shadow — flat surface flush with the page.
  final List<BoxShadow> none;

  /// Hairline shadow — subtle card lift on a light background.
  final List<BoxShadow> xs;

  /// Small shadow — default card, chip, badge.
  final List<BoxShadow> sm;

  /// Medium shadow — hovered card, dropdown, tooltip.
  final List<BoxShadow> md;

  /// Large shadow — floating action button, sticky header.
  final List<BoxShadow> lg;

  /// Extra-large shadow — modal, bottom sheet, popover.
  final List<BoxShadow> xl;

  DievasElevationThemeData copyWith({
    List<BoxShadow>? none,
    List<BoxShadow>? xs,
    List<BoxShadow>? sm,
    List<BoxShadow>? md,
    List<BoxShadow>? lg,
    List<BoxShadow>? xl,
  }) => DievasElevationThemeData(
    none: none ?? this.none,
    xs: xs ?? this.xs,
    sm: sm ?? this.sm,
    md: md ?? this.md,
    lg: lg ?? this.lg,
    xl: xl ?? this.xl,
  );

  @override
  List<Object?> get props => [none, xs, sm, md, lg, xl];
}
