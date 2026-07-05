import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasDropdown].
///
/// Token-derived by the component mapper. The widget reads this from
/// [DievasComponentThemeData.dropdown].
final class DievasDropdownThemeData extends Equatable {
  const DievasDropdownThemeData({
    required this.triggerStyle,
    required this.hintStyle,
    required this.labelStyle,
    required this.labelSpacing,
    required this.triggerBgColour,
    required this.triggerBorderColour,
    required this.triggerBorderColourFocused,
    required this.borderRadius,
    required this.triggerPadding,
    required this.iconSize,
    required this.iconColour,
    required this.overlayBgColour,
    required this.overlayBorderColour,
    required this.overlayBorderRadius,
    required this.overlayElevation,
    required this.optionStyle,
    required this.optionSelectedColour,
    required this.optionTextColour,
    required this.optionTextColourDisabled,
    required this.optionPadding,
    required this.disabledOpacity,
    required this.animationDuration,
    required this.minHeight,
  });

  /// Text style for the selected value.
  final TextStyle triggerStyle;

  /// Text style when no value is selected.
  final TextStyle hintStyle;

  /// Text style for the optional label above the trigger.
  final TextStyle labelStyle;

  /// Gap between label and trigger (dp).
  final double labelSpacing;

  /// Background colour of the trigger.
  final Color triggerBgColour;

  /// Default border colour of the trigger.
  final Color triggerBorderColour;

  /// Border colour when the dropdown is open.
  final Color triggerBorderColourFocused;

  /// Corner radius for trigger and overlay.
  final BorderRadius borderRadius;

  /// Internal padding of the trigger.
  final EdgeInsets triggerPadding;

  /// Chevron icon size (dp).
  final double iconSize;

  /// Chevron icon colour.
  final Color iconColour;

  /// Background colour of the dropdown overlay.
  final Color overlayBgColour;

  /// Border colour of the dropdown overlay.
  final Color overlayBorderColour;

  /// Corner radius of the overlay.
  final BorderRadius overlayBorderRadius;

  /// Shadow list for the overlay.
  final List<BoxShadow> overlayElevation;

  /// Text style for option labels.
  final TextStyle optionStyle;

  /// Background colour for the selected (or hovered) option.
  final Color optionSelectedColour;

  /// Option label colour.
  final Color optionTextColour;

  /// Disabled option label colour.
  final Color optionTextColourDisabled;

  /// Internal padding for each option row.
  final EdgeInsets optionPadding;

  /// Opacity multiplier when disabled.
  final double disabledOpacity;

  /// Duration for overlay transitions.
  final Duration animationDuration;

  /// Minimum height of the trigger (dp).
  final double minHeight;

  @override
  List<Object?> get props => [
    triggerStyle,
    hintStyle,
    labelStyle,
    labelSpacing,
    triggerBgColour,
    triggerBorderColour,
    triggerBorderColourFocused,
    borderRadius,
    triggerPadding,
    iconSize,
    iconColour,
    overlayBgColour,
    overlayBorderColour,
    overlayBorderRadius,
    overlayElevation,
    optionStyle,
    optionSelectedColour,
    optionTextColour,
    optionTextColourDisabled,
    optionPadding,
    disabledOpacity,
    animationDuration,
    minHeight,
  ];
}
