import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:equatable/equatable.dart';

/// The animation sub-system for a Dievas theme.
///
/// Durations are organized by motion speed intent — components reference
/// the semantic name that matches their transition character rather than
/// hardcoding millisecond values.
final class DievasAnimationThemeData extends Equatable {
  const DievasAnimationThemeData({
    this.instant = DievasAnimationSemantic.instant,
    this.quick = DievasAnimationSemantic.quick,
    this.fast = DievasAnimationSemantic.fast,
    this.standard = DievasAnimationSemantic.standard,
    this.moderate = DievasAnimationSemantic.moderate,
    this.emphasized = DievasAnimationSemantic.emphasized,
    this.slow = DievasAnimationSemantic.slow,
    this.xSlow = DievasAnimationSemantic.xSlow,
    this.loader = DievasAnimationSemantic.loader,
    this.tooltipShow = DievasAnimationSemantic.tooltipShow,
    this.snackbarDismiss = DievasAnimationSemantic.snackbarDismiss,
  });

  /// 50ms — micro-interactions, ripple, press feedback.
  final Duration instant;

  /// 100ms — quick fades, very brief transitions.
  final Duration quick;

  /// 150ms — colour shifts, subtle state transitions.
  final Duration fast;

  /// 200ms — standard UI transitions (toggle, accordion, popover).
  final Duration standard;

  /// 250ms — moderate transitions (drawer slide, panel reveal).
  final Duration moderate;

  /// 300ms — emphasised transitions (modal entry, snackbar, bottom sheet).
  final Duration emphasized;

  /// 400ms — leisurely transitions (hero animations).
  final Duration slow;

  /// 500ms — tooltip wait, brief feedback pauses.
  final Duration xSlow;

  /// 800ms — loader spinner rotation cycle.
  final Duration loader;

  /// 2s — tooltip visible duration.
  final Duration tooltipShow;

  /// 3s — snackbar auto-dismiss.
  final Duration snackbarDismiss;

  DievasAnimationThemeData copyWith({
    Duration? instant,
    Duration? quick,
    Duration? fast,
    Duration? standard,
    Duration? moderate,
    Duration? emphasized,
    Duration? slow,
    Duration? xSlow,
    Duration? loader,
    Duration? tooltipShow,
    Duration? snackbarDismiss,
  }) => DievasAnimationThemeData(
    instant: instant ?? this.instant,
    quick: quick ?? this.quick,
    fast: fast ?? this.fast,
    standard: standard ?? this.standard,
    moderate: moderate ?? this.moderate,
    emphasized: emphasized ?? this.emphasized,
    slow: slow ?? this.slow,
    xSlow: xSlow ?? this.xSlow,
    loader: loader ?? this.loader,
    tooltipShow: tooltipShow ?? this.tooltipShow,
    snackbarDismiss: snackbarDismiss ?? this.snackbarDismiss,
  );

  @override
  List<Object?> get props => [
    instant,
    quick,
    fast,
    standard,
    moderate,
    emphasized,
    slow,
    xSlow,
    loader,
    tooltipShow,
    snackbarDismiss,
  ];
}
