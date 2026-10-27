import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/animation.dart' show Curve;

/// Theme data for [DievasModal].
final class DievasModalThemeData extends Equatable {
  const DievasModalThemeData({
    required this.titleStyle,
    required this.bodyStyle,
    required this.backgroundColour,
    required this.barrierColour,
    required this.borderRadius,
    required this.padding,
    required this.minWidth,
    required this.maxWidth,
    required this.closeIconSize,
    required this.shadow,
    this.textColour,
    this.titleColour,
    this.contentColour,
    this.iconColour,
    this.transitionDuration,
    this.transitionCurve,
  });

  /// Text style for the modal title.
  final TextStyle titleStyle;

  /// Text style for the modal body.
  final TextStyle bodyStyle;

  /// Background colour of the modal card.
  final Color backgroundColour;

  /// Colour of the modal barrier.
  final Color barrierColour;

  /// Corner radius of the modal card.
  final BorderRadius borderRadius;

  /// Inner padding of the modal card.
  final EdgeInsets padding;

  /// Minimum width constraint.
  final double minWidth;

  /// Maximum width the modal card may grow to.
  final double maxWidth;

  /// Size of the close icon button.
  final double closeIconSize;

  /// Shadow stack for the modal card, drawn from the elevation tokens.
  final List<BoxShadow> shadow;

  /// Default foregrounds for arbitrary modal content.
  final Color? textColour;

  /// Independent heading foreground; null uses the shared text colour.
  final Color? titleColour;

  /// Independent body foreground; null uses the shared text colour.
  final Color? contentColour;
  final Color? iconColour;

  /// Null motion defaults resolve through the global animation theme.
  final Duration? transitionDuration;
  final Curve? transitionCurve;

  DievasModalThemeData copyWith({
    TextStyle? titleStyle,
    TextStyle? bodyStyle,
    Color? backgroundColour,
    Color? barrierColour,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    double? minWidth,
    double? maxWidth,
    double? closeIconSize,
    List<BoxShadow>? shadow,
    Color? textColour,
    Color? titleColour,
    Color? contentColour,
    Color? iconColour,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) => DievasModalThemeData(
    titleStyle: titleStyle ?? this.titleStyle,
    bodyStyle: bodyStyle ?? this.bodyStyle,
    backgroundColour: backgroundColour ?? this.backgroundColour,
    barrierColour: barrierColour ?? this.barrierColour,
    borderRadius: borderRadius ?? this.borderRadius,
    padding: padding ?? this.padding,
    minWidth: minWidth ?? this.minWidth,
    maxWidth: maxWidth ?? this.maxWidth,
    closeIconSize: closeIconSize ?? this.closeIconSize,
    shadow: shadow ?? this.shadow,
    textColour: textColour ?? this.textColour,
    titleColour: titleColour ?? this.titleColour,
    contentColour: contentColour ?? this.contentColour,
    iconColour: iconColour ?? this.iconColour,
    transitionDuration: transitionDuration ?? this.transitionDuration,
    transitionCurve: transitionCurve ?? this.transitionCurve,
  );

  @override
  List<Object?> get props => [
    titleStyle,
    bodyStyle,
    backgroundColour,
    barrierColour,
    borderRadius,
    padding,
    minWidth,
    maxWidth,
    closeIconSize,
    shadow,
    textColour,
    titleColour,
    contentColour,
    iconColour,
    transitionDuration,
    transitionCurve,
  ];
}
