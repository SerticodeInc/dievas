import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// A value object holding the four colour sub-roles for a single feedback
/// semantic (success, warning, error, or info).
final class FeedbackColour extends Equatable {
  const FeedbackColour({required this.background, required this.border, required this.icon, required this.text});

  /// Alert / toast surface background.
  final Color background;

  /// Container border stroke.
  final Color border;

  /// Icon fill within the alert.
  final Color icon;

  /// Body text within the alert.
  final Color text;

  FeedbackColour copyWith({Color? background, Color? border, Color? icon, Color? text}) => FeedbackColour(
    background: background ?? this.background,
    border: border ?? this.border,
    icon: icon ?? this.icon,
    text: text ?? this.text,
  );

  static FeedbackColour lerp(FeedbackColour a, FeedbackColour b, double t) => FeedbackColour(
    background: Color.lerp(a.background, b.background, t)!,
    border: Color.lerp(a.border, b.border, t)!,
    icon: Color.lerp(a.icon, b.icon, t)!,
    text: Color.lerp(a.text, b.text, t)!,
  );

  @override
  List<Object?> get props => [background, border, icon, text];
}

/// Feedback colour roles — success, warning, error, and info.
///
/// Each semantic variant is a [FeedbackColour] value object with
/// background, border, icon, and text sub-roles.
final class FeedbackColours extends Equatable {
  const FeedbackColours({
    required this.feedbackSuccess,
    required this.feedbackWarning,
    required this.feedbackError,
    required this.feedbackInfo,
  });

  /// Success semantic — positive outcomes, completed actions.
  final FeedbackColour feedbackSuccess;

  /// Warning semantic — caution, reversible risk.
  final FeedbackColour feedbackWarning;

  /// Error semantic — destructive or failed outcomes.
  final FeedbackColour feedbackError;

  /// Informational semantic — neutral context messages.
  final FeedbackColour feedbackInfo;

  FeedbackColours copyWith({
    FeedbackColour? feedbackSuccess,
    FeedbackColour? feedbackWarning,
    FeedbackColour? feedbackError,
    FeedbackColour? feedbackInfo,
  }) => FeedbackColours(
    feedbackSuccess: feedbackSuccess ?? this.feedbackSuccess,
    feedbackWarning: feedbackWarning ?? this.feedbackWarning,
    feedbackError: feedbackError ?? this.feedbackError,
    feedbackInfo: feedbackInfo ?? this.feedbackInfo,
  );

  static FeedbackColours lerp(FeedbackColours a, FeedbackColours b, double t) => FeedbackColours(
    feedbackSuccess: FeedbackColour.lerp(a.feedbackSuccess, b.feedbackSuccess, t),
    feedbackWarning: FeedbackColour.lerp(a.feedbackWarning, b.feedbackWarning, t),
    feedbackError: FeedbackColour.lerp(a.feedbackError, b.feedbackError, t),
    feedbackInfo: FeedbackColour.lerp(a.feedbackInfo, b.feedbackInfo, t),
  );

  @override
  List<Object?> get props => [feedbackSuccess, feedbackWarning, feedbackError, feedbackInfo];
}
