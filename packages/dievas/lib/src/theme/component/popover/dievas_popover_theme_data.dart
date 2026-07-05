import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

final class DievasPopoverThemeData extends Equatable {
  const DievasPopoverThemeData({
    required this.backgroundColour,
    required this.textStyle,
    required this.borderRadius,
    required this.padding,
    required this.verticalOffset,
    required this.horizontalOffset,
    required this.arrowSize,
    required this.barrierColour,
    required this.animationDuration,
    required this.elevation,
    required this.maxWidth,
  });

  final Color backgroundColour;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final double verticalOffset;
  final double horizontalOffset;
  final double arrowSize;
  final Color barrierColour;
  final Duration animationDuration;
  final double elevation;

  /// Maximum width constraint for the popover content area.
  final double maxWidth;

  @override
  List<Object?> get props => [
    backgroundColour,
    textStyle,
    borderRadius,
    padding,
    verticalOffset,
    horizontalOffset,
    arrowSize,
    barrierColour,
    animationDuration,
    elevation,
    maxWidth,
  ];
}
