import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Border and divider colour roles.
final class BorderColours extends Equatable {
  const BorderColours({
    required this.dividerColour,
    required this.inputActiveBorder,
    required this.inputDisabledBorder,
    required this.focusIndicatorColour,
    required this.selectionBorder,
  });

  /// Default dividers and container strokes.
  final Color dividerColour;

  /// High-emphasis borders. Active input outlines, selected containers.
  final Color inputActiveBorder;

  /// Borders on disabled inputs and containers.
  final Color inputDisabledBorder;

  /// Focus ring — applied on keyboard focus.
  final Color focusIndicatorColour;

  /// Brand-coloured border. Selected states, brand highlights.
  final Color selectionBorder;

  BorderColours copyWith({
    Color? dividerColour,
    Color? inputActiveBorder,
    Color? inputDisabledBorder,
    Color? focusIndicatorColour,
    Color? selectionBorder,
  }) => BorderColours(
    dividerColour: dividerColour ?? this.dividerColour,
    inputActiveBorder: inputActiveBorder ?? this.inputActiveBorder,
    inputDisabledBorder: inputDisabledBorder ?? this.inputDisabledBorder,
    focusIndicatorColour: focusIndicatorColour ?? this.focusIndicatorColour,
    selectionBorder: selectionBorder ?? this.selectionBorder,
  );

  static BorderColours lerp(BorderColours a, BorderColours b, double t) => BorderColours(
    dividerColour: Color.lerp(a.dividerColour, b.dividerColour, t)!,
    inputActiveBorder: Color.lerp(a.inputActiveBorder, b.inputActiveBorder, t)!,
    inputDisabledBorder: Color.lerp(a.inputDisabledBorder, b.inputDisabledBorder, t)!,
    focusIndicatorColour: Color.lerp(a.focusIndicatorColour, b.focusIndicatorColour, t)!,
    selectionBorder: Color.lerp(a.selectionBorder, b.selectionBorder, t)!,
  );

  @override
  List<Object?> get props => [
    dividerColour,
    inputActiveBorder,
    inputDisabledBorder,
    focusIndicatorColour,
    selectionBorder,
  ];
}
