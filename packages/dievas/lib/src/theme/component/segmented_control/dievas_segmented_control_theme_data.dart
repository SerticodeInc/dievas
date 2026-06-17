import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasSegmentedControl].
///
/// Token-derived by the component mapper. The widget reads this from
/// [DievasComponentThemeData.segmentedControl].
final class DievasSegmentedControlThemeData extends Equatable {
  const DievasSegmentedControlThemeData({
    required this.labelStyle,
    required this.selectedLabelStyle,
    required this.borderRadius,
    required this.padding,
    required this.bgColor,
    required this.selectedBgColor,
    required this.borderColor,
    required this.textColor,
    required this.selectedTextColor,
    required this.disabledOpacity,
    required this.animationDuration,
    required this.minSegmentWidth,
    required this.minHeight,
  });

  /// Unselected label text style.
  final TextStyle labelStyle;

  /// Selected label text style.
  final TextStyle selectedLabelStyle;

  /// Container corner radius.
  final BorderRadius borderRadius;

  /// Inner padding for each segment.
  final EdgeInsets padding;

  /// Background colour for unselected segments.
  final Color bgColor;

  /// Background colour for the selected segment.
  final Color selectedBgColor;

  /// Border colour for unselected segments (applied as container border).
  final Color borderColor;

  /// Label colour for unselected segments.
  final Color textColor;

  /// Label colour for the selected segment.
  final Color selectedTextColor;

  /// Opacity multiplier when disabled.
  final double disabledOpacity;

  /// Duration of the selected-segment transition.
  final Duration animationDuration;

  /// Minimum width per segment (dp).
  final double minSegmentWidth;

  /// Minimum height of the control (dp).
  final double minHeight;

  @override
  List<Object?> get props => [
    labelStyle,
    selectedLabelStyle,
    borderRadius,
    padding,
    bgColor,
    selectedBgColor,
    borderColor,
    textColor,
    selectedTextColor,
    disabledOpacity,
    animationDuration,
    minSegmentWidth,
    minHeight,
  ];
}
