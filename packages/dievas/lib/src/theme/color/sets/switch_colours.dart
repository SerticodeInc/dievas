import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Colour roles for the toggle switch component.
final class SwitchColours extends Equatable {
  const SwitchColours({
    required this.switchTrackOn,
    required this.switchTrackOff,
    required this.switchThumbOn,
    required this.switchThumbOff,
    required this.switchBorder,
  });

  /// Track colour when the switch is in the ON state.
  final Color switchTrackOn;

  /// Track colour when the switch is in the OFF state.
  final Color switchTrackOff;

  /// Thumb (knob) colour when the switch is ON.
  final Color switchThumbOn;

  /// Thumb (knob) colour when the switch is OFF.
  final Color switchThumbOff;

  /// Track border for the outlined switch variant.
  final Color switchBorder;

  SwitchColours copyWith({
    Color? switchTrackOn,
    Color? switchTrackOff,
    Color? switchThumbOn,
    Color? switchThumbOff,
    Color? switchBorder,
  }) => SwitchColours(
    switchTrackOn: switchTrackOn ?? this.switchTrackOn,
    switchTrackOff: switchTrackOff ?? this.switchTrackOff,
    switchThumbOn: switchThumbOn ?? this.switchThumbOn,
    switchThumbOff: switchThumbOff ?? this.switchThumbOff,
    switchBorder: switchBorder ?? this.switchBorder,
  );

  static SwitchColours lerp(SwitchColours a, SwitchColours b, double t) => SwitchColours(
    switchTrackOn: Color.lerp(a.switchTrackOn, b.switchTrackOn, t) ?? a.switchTrackOn,
    switchTrackOff: Color.lerp(a.switchTrackOff, b.switchTrackOff, t) ?? a.switchTrackOff,
    switchThumbOn: Color.lerp(a.switchThumbOn, b.switchThumbOn, t) ?? a.switchThumbOn,
    switchThumbOff: Color.lerp(a.switchThumbOff, b.switchThumbOff, t) ?? a.switchThumbOff,
    switchBorder: Color.lerp(a.switchBorder, b.switchBorder, t) ?? a.switchBorder,
  );

  @override
  List<Object?> get props => [switchTrackOn, switchTrackOff, switchThumbOn, switchThumbOff, switchBorder];
}
