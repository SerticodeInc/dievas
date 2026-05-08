import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Colour roles for the toggle switch component.
final class SwitchColours extends Equatable {
  const SwitchColours({
    required this.switchTrackOn,
    required this.switchTrackOff,
    required this.switchThumb,
    required this.switchBorder,
  });

  /// Track colour when the switch is in the ON state.
  final Color switchTrackOn;

  /// Track colour when the switch is in the OFF state.
  final Color switchTrackOff;

  /// Thumb (knob) colour in both states.
  final Color switchThumb;

  /// Track border for the outlined switch variant.
  final Color switchBorder;

  SwitchColours copyWith({Color? switchTrackOn, Color? switchTrackOff, Color? switchThumb, Color? switchBorder}) =>
      SwitchColours(
        switchTrackOn: switchTrackOn ?? this.switchTrackOn,
        switchTrackOff: switchTrackOff ?? this.switchTrackOff,
        switchThumb: switchThumb ?? this.switchThumb,
        switchBorder: switchBorder ?? this.switchBorder,
      );

  static SwitchColours lerp(SwitchColours a, SwitchColours b, double t) => SwitchColours(
    switchTrackOn: Color.lerp(a.switchTrackOn, b.switchTrackOn, t)!,
    switchTrackOff: Color.lerp(a.switchTrackOff, b.switchTrackOff, t)!,
    switchThumb: Color.lerp(a.switchThumb, b.switchThumb, t)!,
    switchBorder: Color.lerp(a.switchBorder, b.switchBorder, t)!,
  );

  @override
  List<Object?> get props => [switchTrackOn, switchTrackOff, switchThumb, switchBorder];
}
