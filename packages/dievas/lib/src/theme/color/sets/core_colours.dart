import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Brand-identity colours.
///
/// These sit above the neutral axis and define the primary brand expression
/// across interactive elements, CTAs, and selected states.
final class CoreColours extends Equatable {
  const CoreColours({required this.brand, required this.brandSubtle, required this.onBrand});

  /// Primary brand colour. Interactive elements, CTAs, selected states.
  final Color brand;

  /// Subtle brand tint. Backgrounds behind brand-coloured icons or badges.
  final Color brandSubtle;

  /// Text or icons placed on top of [brand] surfaces.
  final Color onBrand;

  CoreColours copyWith({Color? brand, Color? brandSubtle, Color? onBrand}) => CoreColours(
    brand: brand ?? this.brand,
    brandSubtle: brandSubtle ?? this.brandSubtle,
    onBrand: onBrand ?? this.onBrand,
  );

  static CoreColours lerp(CoreColours a, CoreColours b, double t) => CoreColours(
    brand: Color.lerp(a.brand, b.brand, t)!,
    brandSubtle: Color.lerp(a.brandSubtle, b.brandSubtle, t)!,
    onBrand: Color.lerp(a.onBrand, b.onBrand, t)!,
  );

  @override
  List<Object?> get props => [brand, brandSubtle, onBrand];
}
