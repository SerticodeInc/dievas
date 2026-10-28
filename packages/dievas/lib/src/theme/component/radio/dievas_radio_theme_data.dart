import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/animation.dart';

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
    this.animationDuration,
    this.animationCurve,
  });

  /// Outer circle diameter (dp).
  final double size;

  /// Ring stroke width (dp) in both selection states.
  final double strokeWidth;

  /// Inner dot diameter (dp) in selected state.
  final double dotSize;

  /// Outer ring colour when selected.
  final Color colourSelected;

  /// Background inside the ring in both selection states.
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

  final Duration? animationDuration;
  final Curve? animationCurve;

  DievasRadioThemeData copyWith({
    double? size,
    double? strokeWidth,
    double? dotSize,
    Color? colourSelected,
    Color? colourUnselected,
    Color? colourDisabled,
    Color? borderColourUnselected,
    Color? borderColourDisabled,
    Color? dotColour,
    double? disabledOpacity,
    TextStyle? labelStyle,
    double? labelSpacing,
    Duration? animationDuration,
    Curve? animationCurve,
  }) => DievasRadioThemeData(
    size: size ?? this.size,
    strokeWidth: strokeWidth ?? this.strokeWidth,
    dotSize: dotSize ?? this.dotSize,
    colourSelected: colourSelected ?? this.colourSelected,
    colourUnselected: colourUnselected ?? this.colourUnselected,
    colourDisabled: colourDisabled ?? this.colourDisabled,
    borderColourUnselected: borderColourUnselected ?? this.borderColourUnselected,
    borderColourDisabled: borderColourDisabled ?? this.borderColourDisabled,
    dotColour: dotColour ?? this.dotColour,
    disabledOpacity: disabledOpacity ?? this.disabledOpacity,
    labelStyle: labelStyle ?? this.labelStyle,
    labelSpacing: labelSpacing ?? this.labelSpacing,
    animationDuration: animationDuration ?? this.animationDuration,
    animationCurve: animationCurve ?? this.animationCurve,
  );

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
    animationDuration,
    animationCurve,
  ];
}
