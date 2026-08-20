import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

import 'package:dievas/src/theme/component/dievas_input_theme_value.dart';

/// Theme data for [DievasTextInput] and [DievasTextArea].
///
/// All layout, colour, and typography values are token-derived by the
/// component mapper. The widget reads this from
/// [DievasComponentThemeData.textInput].
final class DievasTextInputThemeData extends Equatable {
  const DievasTextInputThemeData({
    required this.inputStyle,
    required this.labelStyle,
    required this.helperStyle,
    required this.errorStyle,
    required this.placeholderStyle,
    required this.height,
    required this.contentPadding,
    required this.borderRadius,
    required this.strokeWidth,
    required this.strokeWidthFocused,
    required this.bgColour,
    required this.borderColour,
    required this.borderColourFocused,
    required this.borderColourError,
    required this.borderColourWarning,
    required this.iconColour,
    required this.iconSize,
    required this.iconSpacing,
    required this.labelSpacing,
    required this.helperSpacing,
    required this.disabledOpacity,
  });

  /// Input value text style — per size variant.
  final DievasInputThemeValue<TextStyle> inputStyle;

  /// Floating label text style (always the same size regardless of input size).
  final TextStyle labelStyle;

  /// Helper / hint text style below the input.
  final TextStyle helperStyle;

  /// Error message text style below the input.
  final TextStyle errorStyle;

  /// Placeholder (hint) text style inside the input.
  final DievasInputThemeValue<TextStyle> placeholderStyle;

  /// Container height per size variant (dp).
  final DievasInputThemeValue<double> height;

  /// Inner content padding per size variant.
  final DievasInputThemeValue<EdgeInsets> contentPadding;

  /// Container corner radius (same across all sizes).
  final BorderRadius borderRadius;

  /// Default border stroke width (dp).
  final double strokeWidth;

  /// Border stroke width when focused (dp).
  final double strokeWidthFocused;

  /// Input surface background colour.
  final Color bgColour;

  /// Default border colour (resting state).
  final Color borderColour;

  /// Border colour when focused.
  final Color borderColourFocused;

  /// Border colour in error state.
  final Color borderColourError;

  /// Border colour in warning state.
  final Color borderColourWarning;

  /// Leading / trailing icon colour.
  final Color iconColour;

  /// Leading / trailing icon size (dp).
  final double iconSize;

  /// Gap between icon and text (dp).
  final double iconSpacing;

  /// Gap between the label and the input container (dp).
  final double labelSpacing;

  /// Gap between the input container and helper / error text (dp).
  final double helperSpacing;

  /// Opacity multiplier applied when disabled.
  final double disabledOpacity;

  /// Creates a copy of this [DievasTextInputThemeData] with the given fields replaced.
  DievasTextInputThemeData copyWith({
    DievasInputThemeValue<TextStyle>? inputStyle,
    TextStyle? labelStyle,
    TextStyle? helperStyle,
    TextStyle? errorStyle,
    DievasInputThemeValue<TextStyle>? placeholderStyle,
    DievasInputThemeValue<double>? height,
    DievasInputThemeValue<EdgeInsets>? contentPadding,
    BorderRadius? borderRadius,
    double? strokeWidth,
    double? strokeWidthFocused,
    Color? bgColour,
    Color? borderColour,
    Color? borderColourFocused,
    Color? borderColourError,
    Color? borderColourWarning,
    Color? iconColour,
    double? iconSize,
    double? iconSpacing,
    double? labelSpacing,
    double? helperSpacing,
    double? disabledOpacity,
  }) => DievasTextInputThemeData(
    inputStyle: inputStyle ?? this.inputStyle,
    labelStyle: labelStyle ?? this.labelStyle,
    helperStyle: helperStyle ?? this.helperStyle,
    errorStyle: errorStyle ?? this.errorStyle,
    placeholderStyle: placeholderStyle ?? this.placeholderStyle,
    height: height ?? this.height,
    contentPadding: contentPadding ?? this.contentPadding,
    borderRadius: borderRadius ?? this.borderRadius,
    strokeWidth: strokeWidth ?? this.strokeWidth,
    strokeWidthFocused: strokeWidthFocused ?? this.strokeWidthFocused,
    bgColour: bgColour ?? this.bgColour,
    borderColour: borderColour ?? this.borderColour,
    borderColourFocused: borderColourFocused ?? this.borderColourFocused,
    borderColourError: borderColourError ?? this.borderColourError,
    borderColourWarning: borderColourWarning ?? this.borderColourWarning,
    iconColour: iconColour ?? this.iconColour,
    iconSize: iconSize ?? this.iconSize,
    iconSpacing: iconSpacing ?? this.iconSpacing,
    labelSpacing: labelSpacing ?? this.labelSpacing,
    helperSpacing: helperSpacing ?? this.helperSpacing,
    disabledOpacity: disabledOpacity ?? this.disabledOpacity,
  );

  @override
  List<Object?> get props => [
    inputStyle,
    labelStyle,
    helperStyle,
    errorStyle,
    placeholderStyle,
    height,
    contentPadding,
    borderRadius,
    strokeWidth,
    strokeWidthFocused,
    bgColour,
    borderColour,
    borderColourFocused,
    borderColourError,
    borderColourWarning,
    iconColour,
    iconSize,
    iconSpacing,
    labelSpacing,
    helperSpacing,
    disabledOpacity,
  ];
}
