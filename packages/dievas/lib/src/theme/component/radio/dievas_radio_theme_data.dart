import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasRadio].
///
/// Token-derived dimensions and colours. Widget reads this from
/// [DievasComponentThemeData.radio].
final class DievasRadioThemeData extends Equatable {
  const DievasRadioThemeData({
    required this.size,
    required this.strokeWidth,
    required this.dotSize,
    required this.colourSelected,
    required this.colourUnselected,
    required this.colourDisabled,
    required this.borderColourUnselected,
    required this.borderColourDisabled,
    required this.dotColour,
    required this.disabledOpacity,
    required this.labelStyle,
    required this.labelSpacing,
  });

  /// Outer circle diameter (dp).
  final double size;

  /// Ring stroke width (dp) in unselected state.
  final double strokeWidth;

  /// Inner dot diameter (dp) in selected state.
  final double dotSize;

  /// Outer ring fill / border colour when selected.
  final Color colourSelected;

  /// Outer ring border colour when unselected (transparent fill).
  final Color colourUnselected;

  /// Outer ring colour when disabled.
  final Color colourDisabled;

  /// Border colour when unselected.
  final Color borderColourUnselected;

  /// Border colour when disabled.
  final Color borderColourDisabled;

  /// Inner dot fill colour when selected.
  final Color dotColour;

  /// Opacity multiplier applied to the whole widget when disabled.
  final double disabledOpacity;

  /// Text style for the optional label.
  final TextStyle labelStyle;

  /// Gap between the radio circle and the label (dp).
  final double labelSpacing;

  @override
  List<Object?> get props => [
    size,
    strokeWidth,
    dotSize,
    colourSelected,
    colourUnselected,
    colourDisabled,
    borderColourUnselected,
    borderColourDisabled,
    dotColour,
    disabledOpacity,
    labelStyle,
    labelSpacing,
  ];
}
