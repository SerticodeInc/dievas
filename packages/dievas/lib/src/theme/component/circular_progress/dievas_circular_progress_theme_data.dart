import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasCircularProgress].
///
/// Holds the size, stroke, and colour tokens consumed by the widget.
/// Derived by the component mapper from the token sub-systems — not
/// constructed directly in widget code.
final class DievasCircularProgressThemeData extends Equatable {
  const DievasCircularProgressThemeData({
    required this.sizeSm,
    required this.sizeMd,
    required this.sizeLg,
    required this.strokeWidth,
    required this.colourPrimary,
    required this.colourOnBrand,
    required this.trackColour,
  });

  /// Diameter for [DievasCircularProgressSize.sm] (dp).
  final double sizeSm;

  /// Diameter for [DievasCircularProgressSize.md] (dp).
  final double sizeMd;

  /// Diameter for [DievasCircularProgressSize.lg] (dp).
  final double sizeLg;

  /// Arc stroke width (dp).
  final double strokeWidth;

  /// Arc colour for the `primary` style variant.
  final Color colourPrimary;

  /// Arc colour for the `onBrand` style variant — white on brand surfaces.
  final Color colourOnBrand;

  /// Background ring colour (the unfilled track).
  final Color trackColour;

  @override
  List<Object?> get props => [sizeSm, sizeMd, sizeLg, strokeWidth, colourPrimary, colourOnBrand, trackColour];
}
