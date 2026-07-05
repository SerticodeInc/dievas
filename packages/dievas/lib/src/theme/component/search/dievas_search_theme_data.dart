import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Theme data for [DievasSearchWithList] and [DievasSearchWithDropdown].
///
/// Token-derived by the component mapper. Both search variants share one
/// theme data class since they use identical field decoration and result
/// item styling.
@immutable
final class DievasSearchThemeData extends Equatable {
  const DievasSearchThemeData({
    required this.inputStyle,
    required this.placeholderStyle,
    required this.height,
    required this.borderRadius,
    required this.strokeWidth,
    required this.strokeWidthFocused,
    required this.bgColour,
    required this.borderColour,
    required this.borderColourFocused,
    required this.iconColour,
    required this.iconSize,
    required this.contentPadding,
    required this.resultItemStyle,
    required this.resultItemPadding,
    required this.resultMaxHeight,
    required this.dividerColour,
    required this.dividerIndent,
    required this.disabledOpacity,
  });

  /// Input value text style.
  final TextStyle inputStyle;

  /// Placeholder (hint) text style inside the search field.
  final TextStyle placeholderStyle;

  /// Search field height (dp).
  final double height;

  /// Search field corner radius.
  final BorderRadius borderRadius;

  /// Default border stroke width (dp).
  final double strokeWidth;

  /// Border stroke width when focused (dp).
  final double strokeWidthFocused;

  /// Search field surface background colour.
  final Color bgColour;

  /// Default border colour (resting state).
  final Color borderColour;

  /// Border colour when focused.
  final Color borderColourFocused;

  /// Leading / trailing icon colour.
  final Color iconColour;

  /// Leading / trailing icon size (dp).
  final double iconSize;

  /// Inner content padding for the search field.
  final EdgeInsets contentPadding;

  /// Result list item text style.
  final TextStyle resultItemStyle;

  /// Result list item padding.
  final EdgeInsets resultItemPadding;

  /// Maximum height for the results overlay / inline list (dp).
  final double resultMaxHeight;

  /// Divider colour between result items.
  final Color dividerColour;

  /// Horizontal indent for result dividers (dp).
  final double dividerIndent;

  /// Opacity multiplier applied when disabled.
  final double disabledOpacity;

  @override
  List<Object?> get props => [
    inputStyle,
    placeholderStyle,
    height,
    borderRadius,
    strokeWidth,
    strokeWidthFocused,
    bgColour,
    borderColour,
    borderColourFocused,
    iconColour,
    iconSize,
    contentPadding,
    resultItemStyle,
    resultItemPadding,
    resultMaxHeight,
    dividerColour,
    dividerIndent,
    disabledOpacity,
  ];
}
