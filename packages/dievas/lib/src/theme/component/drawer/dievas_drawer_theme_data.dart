import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

final class DievasDrawerThemeData extends Equatable {
  const DievasDrawerThemeData({
    required this.backgroundColor,
    required this.width,
    required this.borderRadius,
    required this.barrierColor,
    required this.animationDuration,
    required this.elevation,
  });

  final Color backgroundColor;
  final double width;
  final BorderRadius borderRadius;
  final Color barrierColor;
  final Duration animationDuration;
  final double elevation;

  @override
  List<Object?> get props => [backgroundColor, width, borderRadius, barrierColor, animationDuration, elevation];
}
