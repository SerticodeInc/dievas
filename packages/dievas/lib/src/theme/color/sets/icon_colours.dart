import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Icon colour roles.
final class IconColours extends Equatable {
  const IconColours({
    required this.iconPrimary,
    required this.iconSecondary,
    required this.iconDisabled,
    required this.iconOnBrand,
  });

  /// Default icon fill on the current surface.
  final Color iconPrimary;

  /// Muted / secondary icons.
  final Color iconSecondary;

  /// Icons on disabled controls.
  final Color iconDisabled;

  /// Icons placed on a brand-coloured surface.
  final Color iconOnBrand;

  IconColours copyWith({Color? iconPrimary, Color? iconSecondary, Color? iconDisabled, Color? iconOnBrand}) =>
      IconColours(
        iconPrimary: iconPrimary ?? this.iconPrimary,
        iconSecondary: iconSecondary ?? this.iconSecondary,
        iconDisabled: iconDisabled ?? this.iconDisabled,
        iconOnBrand: iconOnBrand ?? this.iconOnBrand,
      );

  static IconColours lerp(IconColours a, IconColours b, double t) => IconColours(
    iconPrimary: Color.lerp(a.iconPrimary, b.iconPrimary, t)!,
    iconSecondary: Color.lerp(a.iconSecondary, b.iconSecondary, t)!,
    iconDisabled: Color.lerp(a.iconDisabled, b.iconDisabled, t)!,
    iconOnBrand: Color.lerp(a.iconOnBrand, b.iconOnBrand, t)!,
  );

  @override
  List<Object?> get props => [iconPrimary, iconSecondary, iconDisabled, iconOnBrand];
}
