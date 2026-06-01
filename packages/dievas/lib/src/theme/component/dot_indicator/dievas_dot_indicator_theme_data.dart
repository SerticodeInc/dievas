import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Theme data for [DievasDotIndicator].
///
/// Token-derived by the component mapper. The widget reads this from
/// [DievasComponentThemeData.dotIndicator].
@immutable
final class DievasDotIndicatorThemeData extends Equatable {
  const DievasDotIndicatorThemeData({
    required this.dotSize,
    required this.activeDotSize,
    required this.dotSpacing,
    required this.colorActive,
    required this.colorInactive,
    required this.animationDuration,
    required this.disabledOpacity,
  });

  /// Inactive dot diameter (dp).
  final double dotSize;

  /// Active dot diameter (dp) — slightly larger for emphasis.
  final double activeDotSize;

  /// Edge-to-edge gap between adjacent dots (dp).
  final double dotSpacing;

  /// Active dot fill colour.
  final Color colorActive;

  /// Inactive dot fill colour.
  final Color colorInactive;

  /// Duration of the size/colour transition when active index changes.
  final Duration animationDuration;

  /// Opacity multiplier applied when disabled.
  final double disabledOpacity;

  @override
  List<Object?> get props => [
    dotSize,
    activeDotSize,
    dotSpacing,
    colorActive,
    colorInactive,
    animationDuration,
    disabledOpacity,
  ];
}
