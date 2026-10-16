import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Icon colour roles.
final class IconColours extends Equatable {
  const IconColours({
    required this.iconPrimary,
    required this.iconSecondary,
    required this.iconDisabled,
    required this.buttonPrimaryIcon,
  });

  /// Default icon fill on the current surface.
  final Color iconPrimary;

  /// Muted / secondary icons.
  final Color iconSecondary;

  /// Icons on disabled controls.
  final Color iconDisabled;

  /// Icons placed on a brand-coloured surface.
  final Color buttonPrimaryIcon;

  IconColours copyWith({Color? iconPrimary, Color? iconSecondary, Color? iconDisabled, Color? buttonPrimaryIcon}) =>
      IconColours(
        iconPrimary: iconPrimary ?? this.iconPrimary,
        iconSecondary: iconSecondary ?? this.iconSecondary,
        iconDisabled: iconDisabled ?? this.iconDisabled,
        buttonPrimaryIcon: buttonPrimaryIcon ?? this.buttonPrimaryIcon,
      );

  static IconColours lerp(IconColours a, IconColours b, double t) => IconColours(
    iconPrimary: Color.lerp(a.iconPrimary, b.iconPrimary, t)!,
    iconSecondary: Color.lerp(a.iconSecondary, b.iconSecondary, t)!,
    iconDisabled: Color.lerp(a.iconDisabled, b.iconDisabled, t)!,
    buttonPrimaryIcon: Color.lerp(a.buttonPrimaryIcon, b.buttonPrimaryIcon, t)!,
  );

  @override
  List<Object?> get props => [iconPrimary, iconSecondary, iconDisabled, buttonPrimaryIcon];
}
