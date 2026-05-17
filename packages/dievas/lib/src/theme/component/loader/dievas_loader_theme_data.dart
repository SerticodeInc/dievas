import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasLoader] — a standalone full-surface loading widget.
final class DievasLoaderThemeData extends Equatable {
  const DievasLoaderThemeData({
    required this.spinnerSizeSm,
    required this.spinnerSizeMd,
    required this.spinnerSizeLg,
    required this.strokeWidth,
    required this.color,
    required this.trackColor,
    required this.labelStyle,
    required this.labelSpacing,
  });

  /// Spinner diameter for [DievasLoaderSize.sm].
  final double spinnerSizeSm;

  /// Spinner diameter for [DievasLoaderSize.md].
  final double spinnerSizeMd;

  /// Spinner diameter for [DievasLoaderSize.lg].
  final double spinnerSizeLg;

  /// Stroke width of the spinning arc.
  final double strokeWidth;

  /// Colour of the active spinning arc.
  final Color color;

  /// Colour of the background track arc.
  final Color trackColor;

  /// Text style for the optional label shown below the spinner.
  final TextStyle labelStyle;

  /// Vertical gap between the spinner and the label.
  final double labelSpacing;

  @override
  List<Object?> get props => [
    spinnerSizeSm,
    spinnerSizeMd,
    spinnerSizeLg,
    strokeWidth,
    color,
    trackColor,
    labelStyle,
    labelSpacing,
  ];
}
