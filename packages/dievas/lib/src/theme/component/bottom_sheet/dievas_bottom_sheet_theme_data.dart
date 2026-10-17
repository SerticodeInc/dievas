import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/animation.dart' show Curve;

/// Theme data for [DievasBottomSheet].
final class DievasBottomSheetThemeData extends Equatable {
  const DievasBottomSheetThemeData({
    required this.borderRadius,
    required this.handleWidth,
    required this.handleHeight,
    required this.handleRadius,
    required this.handleTopInset,
    required this.backgroundColour,
    required this.barrierColour,
    this.closeProgressThreshold = 0.6,
    this.transitionDuration,
    this.transitionCurve,
    this.handleColour,
  }) : assert(closeProgressThreshold > 0 && closeProgressThreshold < 1);

  /// Remaining visible fraction below which a released drag closes the sheet.
  final double closeProgressThreshold;

  /// Null uses the active Dievas standard animation duration.
  final Duration? transitionDuration;

  /// Null uses the active Dievas entrance curve.
  final Curve? transitionCurve;

  /// Null uses the active divider colour.
  final Color? handleColour;

  DievasBottomSheetThemeData copyWith({
    BorderRadius? borderRadius,
    double? handleWidth,
    double? handleHeight,
    BorderRadius? handleRadius,
    double? handleTopInset,
    Color? backgroundColour,
    Color? barrierColour,
    double? closeProgressThreshold,
    Duration? transitionDuration,
    Curve? transitionCurve,
    Color? handleColour,
  }) => DievasBottomSheetThemeData(
    borderRadius: borderRadius ?? this.borderRadius,
    handleWidth: handleWidth ?? this.handleWidth,
    handleHeight: handleHeight ?? this.handleHeight,
    handleRadius: handleRadius ?? this.handleRadius,
    handleTopInset: handleTopInset ?? this.handleTopInset,
    backgroundColour: backgroundColour ?? this.backgroundColour,
    barrierColour: barrierColour ?? this.barrierColour,
    closeProgressThreshold: closeProgressThreshold ?? this.closeProgressThreshold,
    transitionDuration: transitionDuration ?? this.transitionDuration,
    transitionCurve: transitionCurve ?? this.transitionCurve,
    handleColour: handleColour ?? this.handleColour,
  );

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
  final Color backgroundColour;

  /// Colour of the modal barrier behind the sheet.
  final Color barrierColour;

  @override
  List<Object?> get props => [
    closeProgressThreshold,
    transitionDuration,
    transitionCurve,
    handleColour,
    borderRadius,
    handleWidth,
    handleHeight,
    handleRadius,
    handleTopInset,
    backgroundColour,
    barrierColour,
  ];
}
