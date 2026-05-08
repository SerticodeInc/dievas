import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Surface and background colour roles, from scaffold base to elevated overlays.
final class BackgroundColours extends Equatable {
  const BackgroundColours({
    required this.bgBase,
    required this.bgSubtle,
    required this.bgElevated,
    required this.bgOverlay,
  });

  /// Page / scaffold background. The base layer.
  final Color bgBase;

  /// Card / surface background. One level above [bgBase].
  final Color bgSubtle;

  /// Elevated surfaces: modals, bottom sheets, popovers.
  final Color bgElevated;

  /// Scrim / overlay colour behind modals and bottom sheets.
  final Color bgOverlay;

  BackgroundColours copyWith({Color? bgBase, Color? bgSubtle, Color? bgElevated, Color? bgOverlay}) =>
      BackgroundColours(
        bgBase: bgBase ?? this.bgBase,
        bgSubtle: bgSubtle ?? this.bgSubtle,
        bgElevated: bgElevated ?? this.bgElevated,
        bgOverlay: bgOverlay ?? this.bgOverlay,
      );

  static BackgroundColours lerp(BackgroundColours a, BackgroundColours b, double t) => BackgroundColours(
    bgBase: Color.lerp(a.bgBase, b.bgBase, t)!,
    bgSubtle: Color.lerp(a.bgSubtle, b.bgSubtle, t)!,
    bgElevated: Color.lerp(a.bgElevated, b.bgElevated, t)!,
    bgOverlay: Color.lerp(a.bgOverlay, b.bgOverlay, t)!,
  );

  @override
  List<Object?> get props => [bgBase, bgSubtle, bgElevated, bgOverlay];
}
