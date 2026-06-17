import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:dievas/src/theme/component/dievas_input_theme_value.dart';

/// Theme data for [DievasTextInputGroup].
///
/// Token-derived by the component mapper. The widget reads this from
/// [DievasComponentThemeData.textInputGroup].
@immutable
final class DievasTextInputGroupThemeData extends Equatable {
  const DievasTextInputGroupThemeData({
    required this.height,
    required this.contentPadding,
    required this.borderRadius,
    required this.strokeWidth,
    required this.strokeWidthFocused,
    required this.bgColor,
    required this.borderColor,
    required this.borderColorFocused,
    required this.dividerColor,
    required this.dividerWidth,
    required this.disabledOpacity,
  });

  /// Segment container height per size variant.
  final DievasInputThemeValue<double> height;

  /// Inner content padding per size variant.
  final DievasInputThemeValue<EdgeInsets> contentPadding;

  /// Outer group border radius (applied to first and last segment).
  final BorderRadius borderRadius;

  /// Default group border stroke width.
  final double strokeWidth;

  /// Group border stroke width when any child is focused.
  final double strokeWidthFocused;

  /// Segment surface background.
  final Color bgColor;

  /// Default group border colour.
  final Color borderColor;

  /// Group border colour when any child is focused.
  final Color borderColorFocused;

  /// Vertical divider colour between segments.
  final Color dividerColor;

  /// Vertical divider width between segments (dp).
  final double dividerWidth;

  /// Opacity multiplier applied when disabled.
  final double disabledOpacity;

  @override
  List<Object?> get props => [
    height,
    contentPadding,
    borderRadius,
    strokeWidth,
    strokeWidthFocused,
    bgColor,
    borderColor,
    borderColorFocused,
    dividerColor,
    dividerWidth,
    disabledOpacity,
  ];
}
