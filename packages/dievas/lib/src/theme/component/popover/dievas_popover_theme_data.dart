import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/animation.dart';

final class DievasPopoverThemeData extends Equatable {
  const DievasPopoverThemeData({
    required this.backgroundColour,
    required this.textStyle,
    required this.borderRadius,
    required this.padding,
    required this.verticalOffset,
    required this.horizontalOffset,
    required this.arrowSize,
    required this.barrierColour,
    required this.animationDuration,
    required this.shadow,
    required this.maxWidth,
    this.borderColour = const Color(0x00000000),
    this.borderWidth = 0,
    this.iconColour,
    this.popoverMargin = 8,
    this.transitionCurve,
  });

  final Color backgroundColour;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final double verticalOffset;
  final double horizontalOffset;

  /// Retained for constructor compatibility. Popovers have no arrow.
  final double arrowSize;

  /// Retained for constructor compatibility. Popovers use nonmodal outside taps.
  final Color barrierColour;
  final Duration animationDuration;

  /// Shadow stack for the popover surface, drawn from the elevation tokens.
  final List<BoxShadow> shadow;

  /// Maximum width constraint for the popover content area.
  final double maxWidth;

  final Color borderColour;
  final double borderWidth;
  final Color? iconColour;
  final double popoverMargin;
  final Curve? transitionCurve;

  DievasPopoverThemeData copyWith({
    Color? backgroundColour,
    TextStyle? textStyle,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    double? verticalOffset,
    double? horizontalOffset,
    double? arrowSize,
    Color? barrierColour,
    Duration? animationDuration,
    List<BoxShadow>? shadow,
    double? maxWidth,
    Color? borderColour,
    double? borderWidth,
    Color? iconColour,
    double? popoverMargin,
    Curve? transitionCurve,
  }) => DievasPopoverThemeData(
    backgroundColour: backgroundColour ?? this.backgroundColour,
    textStyle: textStyle ?? this.textStyle,
    borderRadius: borderRadius ?? this.borderRadius,
    padding: padding ?? this.padding,
    verticalOffset: verticalOffset ?? this.verticalOffset,
    horizontalOffset: horizontalOffset ?? this.horizontalOffset,
    arrowSize: arrowSize ?? this.arrowSize,
    barrierColour: barrierColour ?? this.barrierColour,
    animationDuration: animationDuration ?? this.animationDuration,
    shadow: shadow ?? this.shadow,
    maxWidth: maxWidth ?? this.maxWidth,
    borderColour: borderColour ?? this.borderColour,
    borderWidth: borderWidth ?? this.borderWidth,
    iconColour: iconColour ?? this.iconColour,
    popoverMargin: popoverMargin ?? this.popoverMargin,
    transitionCurve: transitionCurve ?? this.transitionCurve,
  );

  @override
  List<Object?> get props => [
    backgroundColour,
    textStyle,
    borderRadius,
    padding,
    verticalOffset,
    horizontalOffset,
    arrowSize,
    barrierColour,
    animationDuration,
    shadow,
    maxWidth,
    borderColour,
    borderWidth,
    iconColour,
    popoverMargin,
    transitionCurve,
  ];
}
