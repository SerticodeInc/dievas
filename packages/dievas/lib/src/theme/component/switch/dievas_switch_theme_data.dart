import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasSwitch].
///
/// Token-derived dimensions and colours. The widget reads this from
/// [DievasComponentThemeData.toggle] — the field is named `toggle` to
/// avoid clashing with the Dart keyword `switch`.
final class DievasSwitchThemeData extends Equatable {
  const DievasSwitchThemeData({
    required this.trackWidth,
    required this.trackHeight,
    required this.trackRadius,
    required this.thumbSize,
    required this.thumbRadius,
    required this.thumbPadding,
    required this.trackColourOn,
    required this.trackColourOff,
    required this.thumbColourOn,
    required this.thumbColourOff,
    required this.disabledOpacity,
    required this.animationDuration,
    required this.labelStyle,
    required this.labelSpacing,
  });

  /// Track container width (dp).
  final double trackWidth;

  /// Track container height (dp).
  final double trackHeight;

  /// Track corner radius (pill).
  final BorderRadius trackRadius;

  /// Thumb (knob) diameter (dp).
  final double thumbSize;

  /// Thumb corner radius (circle).
  final BorderRadius thumbRadius;

  /// Padding between thumb and track edge (dp).
  final double thumbPadding;

  /// Track background when ON.
  final Color trackColourOn;

  /// Track background when OFF.
  final Color trackColourOff;

  /// Thumb fill when ON.
  final Color thumbColourOn;

  /// Thumb fill when OFF.
  final Color thumbColourOff;

  /// Opacity multiplier applied to the whole widget when disabled.
  final double disabledOpacity;

  /// Thumb slide animation duration.
  final Duration animationDuration;

  /// Text style for the optional label.
  final TextStyle labelStyle;

  /// Gap between the track and the label (dp).
  final double labelSpacing;

  DievasSwitchThemeData copyWith({
    double? trackWidth,
    double? trackHeight,
    BorderRadius? trackRadius,
    double? thumbSize,
    BorderRadius? thumbRadius,
    double? thumbPadding,
    Color? trackColourOn,
    Color? trackColourOff,
    Color? thumbColourOn,
    Color? thumbColourOff,
    double? disabledOpacity,
    Duration? animationDuration,
    TextStyle? labelStyle,
    double? labelSpacing,
  }) => DievasSwitchThemeData(
    trackWidth: trackWidth ?? this.trackWidth,
    trackHeight: trackHeight ?? this.trackHeight,
    trackRadius: trackRadius ?? this.trackRadius,
    thumbSize: thumbSize ?? this.thumbSize,
    thumbRadius: thumbRadius ?? this.thumbRadius,
    thumbPadding: thumbPadding ?? this.thumbPadding,
    trackColourOn: trackColourOn ?? this.trackColourOn,
    trackColourOff: trackColourOff ?? this.trackColourOff,
    thumbColourOn: thumbColourOn ?? this.thumbColourOn,
    thumbColourOff: thumbColourOff ?? this.thumbColourOff,
    disabledOpacity: disabledOpacity ?? this.disabledOpacity,
    animationDuration: animationDuration ?? this.animationDuration,
    labelStyle: labelStyle ?? this.labelStyle,
    labelSpacing: labelSpacing ?? this.labelSpacing,
  );

  @override
  List<Object?> get props => [
    trackWidth,
    trackHeight,
    trackRadius,
    thumbSize,
    thumbRadius,
    thumbPadding,
    trackColourOn,
    trackColourOff,
    thumbColourOn,
    thumbColourOff,
    disabledOpacity,
    animationDuration,
    labelStyle,
    labelSpacing,
  ];
}
