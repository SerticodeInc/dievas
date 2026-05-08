import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Interactive element colour roles across all states and semantic intents.
final class ActionColours extends Equatable {
  const ActionColours({
    required this.actionPrimary,
    required this.actionPrimaryHover,
    required this.actionPrimaryActive,
    required this.actionPrimaryDisabled,
    required this.actionSecondary,
    required this.actionSecondaryHover,
    required this.actionError,
    required this.actionErrorHover,
    required this.actionSuccess,
  });

  /// Primary CTA background (filled button, active toggle resting state).
  final Color actionPrimary;

  /// Hover state of [actionPrimary].
  final Color actionPrimaryHover;

  /// Pressed / active state of [actionPrimary].
  final Color actionPrimaryActive;

  /// Disabled primary action surface.
  final Color actionPrimaryDisabled;

  /// Secondary action background (outlined / ghost button resting surface).
  final Color actionSecondary;

  /// Hover state of [actionSecondary].
  final Color actionSecondaryHover;

  /// Destructive / error action surface.
  final Color actionError;

  /// Hover state of [actionError].
  final Color actionErrorHover;

  /// Success / constructive action surface.
  final Color actionSuccess;

  ActionColours copyWith({
    Color? actionPrimary,
    Color? actionPrimaryHover,
    Color? actionPrimaryActive,
    Color? actionPrimaryDisabled,
    Color? actionSecondary,
    Color? actionSecondaryHover,
    Color? actionError,
    Color? actionErrorHover,
    Color? actionSuccess,
  }) => ActionColours(
    actionPrimary: actionPrimary ?? this.actionPrimary,
    actionPrimaryHover: actionPrimaryHover ?? this.actionPrimaryHover,
    actionPrimaryActive: actionPrimaryActive ?? this.actionPrimaryActive,
    actionPrimaryDisabled: actionPrimaryDisabled ?? this.actionPrimaryDisabled,
    actionSecondary: actionSecondary ?? this.actionSecondary,
    actionSecondaryHover: actionSecondaryHover ?? this.actionSecondaryHover,
    actionError: actionError ?? this.actionError,
    actionErrorHover: actionErrorHover ?? this.actionErrorHover,
    actionSuccess: actionSuccess ?? this.actionSuccess,
  );

  static ActionColours lerp(ActionColours a, ActionColours b, double t) => ActionColours(
    actionPrimary: Color.lerp(a.actionPrimary, b.actionPrimary, t)!,
    actionPrimaryHover: Color.lerp(a.actionPrimaryHover, b.actionPrimaryHover, t)!,
    actionPrimaryActive: Color.lerp(a.actionPrimaryActive, b.actionPrimaryActive, t)!,
    actionPrimaryDisabled: Color.lerp(a.actionPrimaryDisabled, b.actionPrimaryDisabled, t)!,
    actionSecondary: Color.lerp(a.actionSecondary, b.actionSecondary, t)!,
    actionSecondaryHover: Color.lerp(a.actionSecondaryHover, b.actionSecondaryHover, t)!,
    actionError: Color.lerp(a.actionError, b.actionError, t)!,
    actionErrorHover: Color.lerp(a.actionErrorHover, b.actionErrorHover, t)!,
    actionSuccess: Color.lerp(a.actionSuccess, b.actionSuccess, t)!,
  );

  @override
  List<Object?> get props => [
    actionPrimary,
    actionPrimaryHover,
    actionPrimaryActive,
    actionPrimaryDisabled,
    actionSecondary,
    actionSecondaryHover,
    actionError,
    actionErrorHover,
    actionSuccess,
  ];
}
