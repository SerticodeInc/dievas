import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasLoader] — a standalone full-surface loading widget.
final class DievasLoaderThemeData extends Equatable {
  const DievasLoaderThemeData({
    required this.spinnerSizeSM,
    required this.spinnerSizeMD,
    required this.spinnerSizeLG,
    required this.strokeWidth,
    required this.color,
    required this.trackColour,
    required this.labelStyle,
    required this.labelSpacing,
    required this.animationDuration,
  });

  /// Spinner diameter for [DievasLoaderSize.SM].
  final double spinnerSizeSM;

  /// Spinner diameter for [DievasLoaderSize.MD].
  final double spinnerSizeMD;

  /// Spinner diameter for [DievasLoaderSize.LG].
  final double spinnerSizeLG;

  /// Stroke width of the spinning arc.
  final double strokeWidth;

  /// Colour of the active spinning arc.
  final Color color;

  /// Colour of the background track arc.
  final Color trackColour;

  /// Text style for the optional label shown below the spinner.
  final TextStyle labelStyle;

  /// Vertical gap between the spinner and the label.
  final double labelSpacing;

  /// Duration of one full spinner rotation cycle.
  final Duration animationDuration;

  @override
  List<Object?> get props => [
    spinnerSizeSM,
    spinnerSizeMD,
    spinnerSizeLG,
    strokeWidth,
    color,
    trackColour,
    labelStyle,
    labelSpacing,
    animationDuration,
  ];
}
