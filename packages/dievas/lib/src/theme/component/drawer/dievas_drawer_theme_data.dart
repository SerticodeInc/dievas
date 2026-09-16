import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

final class DievasDrawerThemeData extends Equatable {
  const DievasDrawerThemeData({
    required this.backgroundColour,
    required this.width,
    required this.borderRadius,
    required this.barrierColour,
    required this.animationDuration,
    required this.elevation,
  });

  final Color backgroundColour;
  final double width;
  final BorderRadius borderRadius;
  final Color barrierColour;
  final Duration animationDuration;
  final double elevation;

  @override
  List<Object?> get props => [backgroundColour, width, borderRadius, barrierColour, animationDuration, elevation];
}
