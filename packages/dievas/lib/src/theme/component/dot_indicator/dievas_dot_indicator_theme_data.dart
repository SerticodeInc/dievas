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
    required this.colourActive,
    required this.colourInactive,
    required this.animationDuration,
    required this.disabledOpacity,
    this.transitionCurve = Curves.easeInOutCubic,
  });

  /// Inactive dot diameter (dp).
  final double dotSize;

  /// Active dot diameter (dp). Equal to dotSize in the default theme.
  final double activeDotSize;

  /// Edge-to-edge gap between adjacent dots (dp).
  final double dotSpacing;

  /// Active dot fill colour.
  final Color colourActive;

  /// Inactive dot fill colour.
  final Color colourInactive;

  /// Duration of the size/colour transition when active index changes.
  final Duration animationDuration;

  /// Opacity multiplier applied when disabled.
  final double disabledOpacity;

  final Curve transitionCurve;

  DievasDotIndicatorThemeData copyWith({
    double? dotSize,
    double? activeDotSize,
    double? dotSpacing,
    Color? colourActive,
    Color? colourInactive,
    Duration? animationDuration,
    double? disabledOpacity,
    Curve? transitionCurve,
  }) => DievasDotIndicatorThemeData(
    dotSize: dotSize ?? this.dotSize,
    activeDotSize: activeDotSize ?? this.activeDotSize,
    dotSpacing: dotSpacing ?? this.dotSpacing,
    colourActive: colourActive ?? this.colourActive,
    colourInactive: colourInactive ?? this.colourInactive,
    animationDuration: animationDuration ?? this.animationDuration,
    disabledOpacity: disabledOpacity ?? this.disabledOpacity,
    transitionCurve: transitionCurve ?? this.transitionCurve,
  );

  @override
  List<Object?> get props => [
    dotSize,
    activeDotSize,
    dotSpacing,
    colourActive,
    colourInactive,
    animationDuration,
    disabledOpacity,
    transitionCurve,
  ];
}
