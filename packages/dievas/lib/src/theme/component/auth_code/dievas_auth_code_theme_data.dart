import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Theme data for [DievasAuthCode].
///
/// Token-derived by the component mapper. The widget reads this from
/// [DievasComponentThemeData.authCode].
@immutable
final class DievasAuthCodeThemeData extends Equatable {
  const DievasAuthCodeThemeData({
    required this.digitStyle,
    required this.height,
    required this.width,
    required this.borderRadius,
    required this.strokeWidth,
    required this.strokeWidthFocused,
    required this.bgColour,
    required this.borderColour,
    required this.borderColourFocused,
    required this.borderColourError,
    required this.cursorColour,
    required this.cursorWidth,
    required this.cursorHeight,
    required this.gap,
    required this.disabledOpacity,
  });

  /// Input digit text style.
  final TextStyle digitStyle;

  /// Digit box height (dp).
  final double height;

  /// Digit box width (dp).
  final double width;

  /// Digit box corner radius.
  final BorderRadius borderRadius;

  /// Default border stroke width (dp).
  final double strokeWidth;

  /// Border stroke width when the box is focused / filled (dp).
  final double strokeWidthFocused;

  /// Digit box surface background colour.
  final Color bgColour;

  /// Default border colour.
  final Color borderColour;

  /// Border colour when the box is focused or filled.
  final Color borderColourFocused;

  /// Border colour in error state.
  final Color borderColourError;

  /// Blinking cursor colour.
  final Color cursorColour;

  /// Cursor width (dp).
  final double cursorWidth;

  /// Cursor height (dp).
  final double cursorHeight;

  /// Horizontal gap between digit boxes (dp).
  final double gap;

  /// Opacity multiplier applied when disabled.
  final double disabledOpacity;

  @override
  List<Object?> get props => [
    digitStyle,
    height,
    width,
    borderRadius,
    strokeWidth,
    strokeWidthFocused,
    bgColour,
    borderColour,
    borderColourFocused,
    borderColourError,
    cursorColour,
    cursorWidth,
    cursorHeight,
    gap,
    disabledOpacity,
  ];
}
