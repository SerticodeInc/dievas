import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Theme data for [DievasDivider].
///
/// Token-derived by the component mapper. The widget reads this from
/// [DievasComponentThemeData.divider].
@immutable
final class DievasDividerThemeData extends Equatable {
  const DievasDividerThemeData({
    required this.thickness,
    required this.colour,
  });

  /// Divider stroke thickness (dp).
  final double thickness;

  /// Divider colour.
  final Color colour;

  /// Creates a copy of this [DievasDividerThemeData] with the given fields replaced.
  DievasDividerThemeData copyWith({
    double? thickness,
    Color? colour,
  }) => DievasDividerThemeData(
    thickness: thickness ?? this.thickness,
    colour: colour ?? this.colour,
  );

  @override
  List<Object?> get props => [thickness, colour];
}
