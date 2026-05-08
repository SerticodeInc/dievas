import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Text colour roles across all contrast levels and surface types.
final class TextColours extends Equatable {
  const TextColours({
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.textInverse,
    required this.textOnBrand,
  });

  /// Highest-contrast body text. Headlines, labels, primary copy.
  final Color textPrimary;

  /// Secondary / supporting copy. Subtitles, captions, metadata.
  final Color textSecondary;

  /// Tertiary / placeholder-level text. Hints, helper copy.
  final Color textTertiary;

  /// Text on disabled interactive elements.
  final Color textDisabled;

  /// Text on dark / inverted surfaces (overlays, toasts).
  final Color textInverse;

  /// Text placed directly on a brand-coloured background.
  final Color textOnBrand;

  TextColours copyWith({
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textDisabled,
    Color? textInverse,
    Color? textOnBrand,
  }) => TextColours(
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    textTertiary: textTertiary ?? this.textTertiary,
    textDisabled: textDisabled ?? this.textDisabled,
    textInverse: textInverse ?? this.textInverse,
    textOnBrand: textOnBrand ?? this.textOnBrand,
  );

  static TextColours lerp(TextColours a, TextColours b, double t) => TextColours(
    textPrimary: Color.lerp(a.textPrimary, b.textPrimary, t)!,
    textSecondary: Color.lerp(a.textSecondary, b.textSecondary, t)!,
    textTertiary: Color.lerp(a.textTertiary, b.textTertiary, t)!,
    textDisabled: Color.lerp(a.textDisabled, b.textDisabled, t)!,
    textInverse: Color.lerp(a.textInverse, b.textInverse, t)!,
    textOnBrand: Color.lerp(a.textOnBrand, b.textOnBrand, t)!,
  );

  @override
  List<Object?> get props => [textPrimary, textSecondary, textTertiary, textDisabled, textInverse, textOnBrand];
}
