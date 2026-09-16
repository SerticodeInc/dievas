import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasMenuItem].
///
/// Token-derived by the component mapper. The widget reads this from
/// [DievasComponentThemeData.menuItem].
final class DievasMenuItemThemeData extends Equatable {
  const DievasMenuItemThemeData({
    required this.textStyle,
    required this.subtitleStyle,
    required this.iconSize,
    required this.iconSpacing,
    required this.padding,
    required this.densePadding,
    required this.borderRadius,
    required this.textColour,
    required this.textColourDisabled,
    required this.subtitleColour,
    required this.subtitleColourDisabled,
    required this.iconColour,
    required this.iconColourDisabled,
    required this.disabledOpacity,
  });

  /// Label text style.
  final TextStyle textStyle;

  /// Subtitle text style.
  final TextStyle subtitleStyle;

  /// Leading icon size (dp).
  final double iconSize;

  /// Gap between leading icon and label (dp).
  final double iconSpacing;

  /// Standard item padding.
  final EdgeInsets padding;

  /// Dense item padding — smaller vertical inset.
  final EdgeInsets densePadding;

  /// Container corner radius.
  final BorderRadius borderRadius;

  /// Label colour when enabled.
  final Color textColour;

  /// Label colour when disabled.
  final Color textColourDisabled;

  /// Subtitle colour when enabled.
  final Color subtitleColour;

  /// Subtitle colour when disabled.
  final Color subtitleColourDisabled;

  /// Leading icon colour when enabled.
  final Color iconColour;

  /// Leading icon colour when disabled.
  final Color iconColourDisabled;

  /// Opacity multiplier applied when disabled.
  final double disabledOpacity;

  @override
  List<Object?> get props => [
    textStyle,
    subtitleStyle,
    iconSize,
    iconSpacing,
    padding,
    densePadding,
    borderRadius,
    textColour,
    textColourDisabled,
    subtitleColour,
    subtitleColourDisabled,
    iconColour,
    iconColourDisabled,
    disabledOpacity,
  ];
}
