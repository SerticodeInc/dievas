import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Colour roles specific to text input fields across all states.
final class InputColours extends Equatable {
  const InputColours({
    required this.inputBg,
    required this.inputBorder,
    required this.inputBorderFocus,
    required this.inputBorderError,
    required this.inputText,
    required this.inputPlaceholder,
  });

  /// Input field background surface.
  final Color inputBg;

  /// Default input border (resting state).
  final Color inputBorder;

  /// Input border when focused.
  final Color inputBorderFocus;

  /// Input border in error state.
  final Color inputBorderError;

  /// Input text colour (typed value).
  final Color inputText;

  /// Input placeholder / hint text colour.
  final Color inputPlaceholder;

  InputColours copyWith({
    Color? inputBg,
    Color? inputBorder,
    Color? inputBorderFocus,
    Color? inputBorderError,
    Color? inputText,
    Color? inputPlaceholder,
  }) => InputColours(
    inputBg: inputBg ?? this.inputBg,
    inputBorder: inputBorder ?? this.inputBorder,
    inputBorderFocus: inputBorderFocus ?? this.inputBorderFocus,
    inputBorderError: inputBorderError ?? this.inputBorderError,
    inputText: inputText ?? this.inputText,
    inputPlaceholder: inputPlaceholder ?? this.inputPlaceholder,
  );

  static InputColours lerp(InputColours a, InputColours b, double t) => InputColours(
    inputBg: Color.lerp(a.inputBg, b.inputBg, t)!,
    inputBorder: Color.lerp(a.inputBorder, b.inputBorder, t)!,
    inputBorderFocus: Color.lerp(a.inputBorderFocus, b.inputBorderFocus, t)!,
    inputBorderError: Color.lerp(a.inputBorderError, b.inputBorderError, t)!,
    inputText: Color.lerp(a.inputText, b.inputText, t)!,
    inputPlaceholder: Color.lerp(a.inputPlaceholder, b.inputPlaceholder, t)!,
  );

  @override
  List<Object?> get props => [inputBg, inputBorder, inputBorderFocus, inputBorderError, inputText, inputPlaceholder];
}
