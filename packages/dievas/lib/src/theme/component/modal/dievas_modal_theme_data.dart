import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasModal].
final class DievasModalThemeData extends Equatable {
  const DievasModalThemeData({
    required this.titleStyle,
    required this.bodyStyle,
    required this.backgroundColor,
    required this.barrierColor,
    required this.borderRadius,
    required this.padding,
    required this.minWidth,
    required this.maxWidth,
    required this.closeIconSize,
    required this.elevation,
  });

  /// Text style for the modal title.
  final TextStyle titleStyle;

  /// Text style for the modal body.
  final TextStyle bodyStyle;

  /// Background colour of the modal card.
  final Color backgroundColor;

  /// Colour of the modal barrier.
  final Color barrierColor;

  /// Corner radius of the modal card.
  final BorderRadius borderRadius;

  /// Inner padding of the modal card.
  final EdgeInsets padding;

  /// Minimum width constraint.
  final double minWidth;

  /// Maximum width the modal card may grow to.
  final double maxWidth;

  /// Size of the close icon button.
  final double closeIconSize;

  /// Shadow elevation of the modal card.
  final double elevation;

  @override
  List<Object?> get props => [
    titleStyle,
    bodyStyle,
    backgroundColor,
    barrierColor,
    borderRadius,
    padding,
    minWidth,
    maxWidth,
    closeIconSize,
    elevation,
  ];
}
