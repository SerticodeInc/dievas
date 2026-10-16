import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasCircularProgress].
///
/// Holds the size, stroke, and colour tokens consumed by the widget.
/// Derived by the component mapper from the token sub-systems — not
/// constructed directly in widget code.
final class DievasCircularProgressThemeData extends Equatable {
  const DievasCircularProgressThemeData({
    required this.sizeSM,
    required this.sizeMD,
    required this.sizeLG,
    required this.strokeWidth,
    required this.colourPrimary,
    required this.colourOnBrand,
    required this.trackColour,
  });

  /// Diameter for [DievasCircularProgressSize.SM] (dp).
  final double sizeSM;

  /// Diameter for [DievasCircularProgressSize.MD] (dp).
  final double sizeMD;

  /// Diameter for [DievasCircularProgressSize.LG] (dp).
  final double sizeLG;

  /// Arc stroke width (dp).
  final double strokeWidth;

  /// Arc colour for the `primary` style variant.
  final Color colourPrimary;

  /// Arc colour for the `onPrimary` style variant — white on brand surfaces.
  final Color colourOnBrand;

  /// Background ring colour (the unfilled track).
  final Color trackColour;

  @override
  List<Object?> get props => [sizeSM, sizeMD, sizeLG, strokeWidth, colourPrimary, colourOnBrand, trackColour];
}
