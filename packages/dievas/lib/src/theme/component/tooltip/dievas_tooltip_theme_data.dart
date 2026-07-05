import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasTooltip].
final class DievasTooltipThemeData extends Equatable {
  const DievasTooltipThemeData({
    required this.textStyle,
    required this.backgroundColour,
    required this.borderRadius,
    required this.padding,
    required this.verticalOffset,
    required this.waitDuration,
    required this.showDuration,
  });

  /// Text style for the tooltip label.
  final TextStyle textStyle;

  /// Background colour of the tooltip bubble.
  final Color backgroundColour;

  /// Corner radius of the tooltip bubble.
  final BorderRadius borderRadius;

  /// Inner padding of the tooltip bubble.
  final EdgeInsets padding;

  /// Vertical distance between the target widget and the tooltip bubble.
  final double verticalOffset;

  /// Delay before the tooltip appears on long-press / hover.
  final Duration waitDuration;

  /// Duration the tooltip remains visible after appearing.
  final Duration showDuration;

  @override
  List<Object?> get props => [
    textStyle,
    backgroundColour,
    borderRadius,
    padding,
    verticalOffset,
    waitDuration,
    showDuration,
  ];
}
