import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasCheckbox].
///
/// All dimensions and colours are token-derived. The widget reads this from
/// [DievasComponentThemeData.checkbox] — never constructed directly in widget code.
final class DievasCheckboxThemeData extends Equatable {
  const DievasCheckboxThemeData({
    required this.size,
    required this.borderRadius,
    required this.strokeWidth,
    required this.colourChecked,
    required this.colourUnchecked,
    required this.colourDisabled,
    required this.borderColourUnchecked,
    required this.borderColourDisabled,
    required this.checkColour,
    required this.disabledOpacity,
    required this.labelStyle,
    required this.labelSpacing,
  });

  /// Width and height of the checkbox box (dp).
  final double size;

  /// Corner radius of the checkbox box.
  final BorderRadius borderRadius;

  /// Stroke width of the check-mark path (dp).
  final double strokeWidth;

  /// Fill colour when checked or indeterminate.
  final Color colourChecked;

  /// Fill colour when unchecked (transparent — border-only).
  final Color colourUnchecked;

  /// Fill colour when disabled.
  final Color colourDisabled;

  /// Border colour when unchecked.
  final Color borderColourUnchecked;

  /// Border colour when disabled.
  final Color borderColourDisabled;

  /// Check-mark / indeterminate dash colour.
  final Color checkColour;

  /// Opacity multiplier applied to the whole widget when disabled.
  final double disabledOpacity;

  /// Text style for the optional label.
  final TextStyle labelStyle;

  /// Gap between the box and the label (dp).
  final double labelSpacing;

  @override
  List<Object?> get props => [
    size,
    borderRadius,
    strokeWidth,
    colourChecked,
    colourUnchecked,
    colourDisabled,
    borderColourUnchecked,
    borderColourDisabled,
    checkColour,
    disabledOpacity,
    labelStyle,
    labelSpacing,
  ];
}
