import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

final class DievasAccordionThemeData extends Equatable {
  const DievasAccordionThemeData({
    required this.headerStyle,
    required this.contentStyle,
    required this.padding,
    required this.contentPadding,
    required this.borderRadius,
    required this.borderWidth,
    required this.iconSize,
    required this.iconSpacing,
    required this.dividerIndent,
    required this.animationDuration,
    required this.shadows,
  });

  final TextStyle headerStyle;
  final TextStyle contentStyle;
  final EdgeInsets padding;
  final EdgeInsets contentPadding;
  final BorderRadius borderRadius;
  final double borderWidth;
  final double iconSize;
  final double iconSpacing;
  final double dividerIndent;
  final Duration animationDuration;
  final List<BoxShadow> shadows;

  @override
  List<Object?> get props => [
    headerStyle,
    contentStyle,
    padding,
    contentPadding,
    borderRadius,
    borderWidth,
    iconSize,
    iconSpacing,
    dividerIndent,
    animationDuration,
    shadows,
  ];
}
