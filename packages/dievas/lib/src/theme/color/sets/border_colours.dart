import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Border and divider colour roles.
final class BorderColours extends Equatable {
  const BorderColours({
    required this.borderDefault,
    required this.borderStrong,
    required this.borderDisabled,
    required this.borderFocus,
    required this.borderBrand,
  });

  /// Default dividers and container strokes.
  final Color borderDefault;

  /// High-emphasis borders. Active input outlines, selected containers.
  final Color borderStrong;

  /// Borders on disabled inputs and containers.
  final Color borderDisabled;

  /// Focus ring — applied on keyboard focus.
  final Color borderFocus;

  /// Brand-coloured border. Selected states, brand highlights.
  final Color borderBrand;

  BorderColours copyWith({
    Color? borderDefault,
    Color? borderStrong,
    Color? borderDisabled,
    Color? borderFocus,
    Color? borderBrand,
  }) => BorderColours(
    borderDefault: borderDefault ?? this.borderDefault,
    borderStrong: borderStrong ?? this.borderStrong,
    borderDisabled: borderDisabled ?? this.borderDisabled,
    borderFocus: borderFocus ?? this.borderFocus,
    borderBrand: borderBrand ?? this.borderBrand,
  );

  static BorderColours lerp(BorderColours a, BorderColours b, double t) => BorderColours(
    borderDefault: Color.lerp(a.borderDefault, b.borderDefault, t)!,
    borderStrong: Color.lerp(a.borderStrong, b.borderStrong, t)!,
    borderDisabled: Color.lerp(a.borderDisabled, b.borderDisabled, t)!,
    borderFocus: Color.lerp(a.borderFocus, b.borderFocus, t)!,
    borderBrand: Color.lerp(a.borderBrand, b.borderBrand, t)!,
  );

  @override
  List<Object?> get props => [borderDefault, borderStrong, borderDisabled, borderFocus, borderBrand];
}
