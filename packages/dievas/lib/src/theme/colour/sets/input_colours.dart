import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Colour roles specific to text input fields across all states.
final class InputColours extends Equatable {
  const InputColours({
    required this.inputBackground,
    required this.inputBorder,
    required this.inputFocusedBorder,
    required this.inputErrorBorder,
    required this.inputWarningBorder,
    required this.inputText,
    required this.inputPlaceholderText,
  });

  /// Input field background surface.
  final Color inputBackground;

  /// Default input border (resting state).
  final Color inputBorder;

  /// Input border when focused.
  final Color inputFocusedBorder;

  /// Input border in error state.
  final Color inputErrorBorder;

  /// Input border in warning state.
  final Color inputWarningBorder;

  /// Input text colour (typed value).
  final Color inputText;

  /// Input placeholder / hint text colour.
  final Color inputPlaceholderText;

  InputColours copyWith({
    Color? inputBackground,
    Color? inputBorder,
    Color? inputFocusedBorder,
    Color? inputErrorBorder,
    Color? inputWarningBorder,
    Color? inputText,
    Color? inputPlaceholderText,
  }) => InputColours(
    inputBackground: inputBackground ?? this.inputBackground,
    inputBorder: inputBorder ?? this.inputBorder,
    inputFocusedBorder: inputFocusedBorder ?? this.inputFocusedBorder,
    inputErrorBorder: inputErrorBorder ?? this.inputErrorBorder,
    inputWarningBorder: inputWarningBorder ?? this.inputWarningBorder,
    inputText: inputText ?? this.inputText,
    inputPlaceholderText: inputPlaceholderText ?? this.inputPlaceholderText,
  );

  static InputColours lerp(InputColours a, InputColours b, double t) => InputColours(
    inputBackground: Color.lerp(a.inputBackground, b.inputBackground, t)!,
    inputBorder: Color.lerp(a.inputBorder, b.inputBorder, t)!,
    inputFocusedBorder: Color.lerp(a.inputFocusedBorder, b.inputFocusedBorder, t)!,
    inputErrorBorder: Color.lerp(a.inputErrorBorder, b.inputErrorBorder, t)!,
    inputWarningBorder: Color.lerp(a.inputWarningBorder, b.inputWarningBorder, t)!,
    inputText: Color.lerp(a.inputText, b.inputText, t)!,
    inputPlaceholderText: Color.lerp(a.inputPlaceholderText, b.inputPlaceholderText, t)!,
  );

  @override
  List<Object?> get props => [
    inputBackground,
    inputBorder,
    inputFocusedBorder,
    inputErrorBorder,
    inputWarningBorder,
    inputText,
    inputPlaceholderText,
  ];
}
