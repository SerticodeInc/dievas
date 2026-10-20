import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

/// Default layout and motion for carousels. Item surfaces belong to the caller.
final class DievasCarouselThemeData extends Equatable {
  const DievasCarouselThemeData({
    this.gap = DievasSpacingSemantic.sm,
    this.autoPlayDelay = DievasDurationPrimitives.d3000,
    this.transitionDuration = DievasDurationPrimitives.d800,
    this.transitionCurve = Curves.fastOutSlowIn,
    this.textStyle = const TextStyle(),
  });

  final double gap;
  final Duration autoPlayDelay;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final TextStyle textStyle;

  DievasCarouselThemeData copyWith({
    double? gap,
    Duration? autoPlayDelay,
    Duration? transitionDuration,
    Curve? transitionCurve,
    TextStyle? textStyle,
  }) => DievasCarouselThemeData(
    gap: gap ?? this.gap,
    autoPlayDelay: autoPlayDelay ?? this.autoPlayDelay,
    transitionDuration: transitionDuration ?? this.transitionDuration,
    transitionCurve: transitionCurve ?? this.transitionCurve,
    textStyle: textStyle ?? this.textStyle,
  );

  @override
  List<Object?> get props => [gap, autoPlayDelay, transitionDuration, transitionCurve, textStyle];
}
