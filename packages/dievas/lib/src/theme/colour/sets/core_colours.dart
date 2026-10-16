import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Primary palette identity and the tinted primary badge background.
final class CoreColours extends Equatable {
  const CoreColours({required this.primary, required this.badgePrimaryTintedBackground});

  /// Palette identity. Use component roles when styling a component.
  final Color primary;
  final Color badgePrimaryTintedBackground;

  CoreColours copyWith({Color? primary, Color? badgePrimaryTintedBackground}) => CoreColours(
    primary: primary ?? this.primary,
    badgePrimaryTintedBackground: badgePrimaryTintedBackground ?? this.badgePrimaryTintedBackground,
  );

  static CoreColours lerp(CoreColours a, CoreColours b, double t) => CoreColours(
    primary: Color.lerp(a.primary, b.primary, t) as Color,
    badgePrimaryTintedBackground:
        Color.lerp(a.badgePrimaryTintedBackground, b.badgePrimaryTintedBackground, t) as Color,
  );

  @override
  List<Object?> get props => [primary, badgePrimaryTintedBackground];
}
