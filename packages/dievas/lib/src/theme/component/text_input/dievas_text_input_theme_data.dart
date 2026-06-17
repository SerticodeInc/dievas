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
    required this.bgColor,
    required this.borderColor,
    required this.borderColorFocused,
    required this.borderColorError,
    required this.iconColor,
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
  final Color bgColor;

  /// Default border colour (resting state).
  final Color borderColor;

  /// Border colour when focused.
  final Color borderColorFocused;

  /// Border colour in error state.
  final Color borderColorError;

  /// Leading / trailing icon colour.
  final Color iconColor;

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
    bgColor,
    borderColor,
    borderColorFocused,
    borderColorError,
    iconColor,
    iconSize,
    iconSpacing,
    labelSpacing,
    helperSpacing,
    disabledOpacity,
  ];
}
