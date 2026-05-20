import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasBottomSheet].
final class DievasBottomSheetThemeData extends Equatable {
  const DievasBottomSheetThemeData({
    required this.borderRadius,
    required this.handleWidth,
    required this.handleHeight,
    required this.handleRadius,
    required this.handleTopInset,
    required this.backgroundColor,
    required this.barrierColor,
    required this.elevation,
  });

  /// Corner radius applied to the top edge of the sheet.
  final BorderRadius borderRadius;

  /// Width of the drag handle pill.
  final double handleWidth;

  /// Height of the drag handle pill.
  final double handleHeight;

  /// Corner radius of the drag handle pill.
  final BorderRadius handleRadius;

  /// Spacing above the drag handle (between sheet top edge and handle).
  final double handleTopInset;

  /// Background colour of the sheet surface.
  final Color backgroundColor;

  /// Colour of the modal barrier behind the sheet.
  final Color barrierColor;

  /// Shadow elevation of the sheet.
  final double elevation;

  @override
  List<Object?> get props => [
    borderRadius,
    handleWidth,
    handleHeight,
    handleRadius,
    handleTopInset,
    backgroundColor,
    barrierColor,
    elevation,
  ];
}
