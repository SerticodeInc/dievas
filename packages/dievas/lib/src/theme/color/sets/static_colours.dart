import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme-invariant colours that never flip between light and dark mode.
///
/// Use these when you need an absolute value that must remain stable
/// regardless of which theme is active — e.g. animation start/end states,
/// hard overlays, or cross-theme brand elements.
final class StaticColours extends Equatable {
  const StaticColours({required this.staticWhite, required this.staticBlack, required this.staticTransparent});

  /// Pure white. Theme-invariant — does not flip in dark mode.
  final Color staticWhite;

  /// Pure black. Theme-invariant.
  final Color staticBlack;

  /// Fully transparent. Useful for animation start/end states.
  final Color staticTransparent;

  StaticColours copyWith({Color? staticWhite, Color? staticBlack, Color? staticTransparent}) => StaticColours(
    staticWhite: staticWhite ?? this.staticWhite,
    staticBlack: staticBlack ?? this.staticBlack,
    staticTransparent: staticTransparent ?? this.staticTransparent,
  );

  static StaticColours lerp(StaticColours a, StaticColours b, double t) => StaticColours(
    staticWhite: Color.lerp(a.staticWhite, b.staticWhite, t)!,
    staticBlack: Color.lerp(a.staticBlack, b.staticBlack, t)!,
    staticTransparent: Color.lerp(a.staticTransparent, b.staticTransparent, t)!,
  );

  @override
  List<Object?> get props => [staticWhite, staticBlack, staticTransparent];
}
