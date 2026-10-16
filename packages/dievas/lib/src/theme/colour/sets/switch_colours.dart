import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Colour roles for the toggle switch component.
final class SwitchColours extends Equatable {
  const SwitchColours({
    required this.switchOnTrack,
    required this.switchOffTrack,
    required this.switchOnThumb,
    required this.switchOffThumb,
  });

  /// Track colour when the switch is in the ON state.
  final Color switchOnTrack;

  /// Track colour when the switch is in the OFF state.
  final Color switchOffTrack;

  /// Thumb (knob) colour when the switch is ON.
  final Color switchOnThumb;

  /// Thumb (knob) colour when the switch is OFF.
  final Color switchOffThumb;

  SwitchColours copyWith({Color? switchOnTrack, Color? switchOffTrack, Color? switchOnThumb, Color? switchOffThumb}) =>
      SwitchColours(
        switchOnTrack: switchOnTrack ?? this.switchOnTrack,
        switchOffTrack: switchOffTrack ?? this.switchOffTrack,
        switchOnThumb: switchOnThumb ?? this.switchOnThumb,
        switchOffThumb: switchOffThumb ?? this.switchOffThumb,
      );

  static SwitchColours lerp(SwitchColours a, SwitchColours b, double t) => SwitchColours(
    switchOnTrack: Color.lerp(a.switchOnTrack, b.switchOnTrack, t) ?? a.switchOnTrack,
    switchOffTrack: Color.lerp(a.switchOffTrack, b.switchOffTrack, t) ?? a.switchOffTrack,
    switchOnThumb: Color.lerp(a.switchOnThumb, b.switchOnThumb, t) ?? a.switchOnThumb,
    switchOffThumb: Color.lerp(a.switchOffThumb, b.switchOffThumb, t) ?? a.switchOffThumb,
  );

  @override
  List<Object?> get props => [switchOnTrack, switchOffTrack, switchOnThumb, switchOffThumb];
}
