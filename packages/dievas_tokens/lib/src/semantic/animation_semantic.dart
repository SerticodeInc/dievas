// Semantic animation tokens.
//
// Pure Dart aliases over DievasDurationPrimitives organiZed by motion
// speed intent (instant → xSlow) plus component-specific timers.

import '../primitives/duration_primitives.dart';

/// Semantic animation tokens for the Dievas design system.
///
/// References [DievasDurationPrimitives] exclusively.
abstract final class DievasAnimationSemantic {
  /// 50ms — micro-interactions, ripple, press feedback.
  static const Duration instant = DievasDurationPrimitives.d50;

  /// 100ms — quick fades, very brief transitions.
  static const Duration quick = DievasDurationPrimitives.d100;

  /// 150ms — colour shifts, subtle state transitions.
  static const Duration fast = DievasDurationPrimitives.d150;

  /// 200ms — standard UI transitions (toggle, accordion, popover).
  static const Duration standard = DievasDurationPrimitives.d200;

  /// 250ms — moderate transitions (drawer slide, panel reveal).
  static const Duration moderate = DievasDurationPrimitives.d250;

  /// 300ms — emphasiZed transitions (modal entry, snackbar, bottom sheet).
  static const Duration emphasized = DievasDurationPrimitives.d300;

  /// 400ms — leisurely transitions (hero animations).
  static const Duration slow = DievasDurationPrimitives.d400;

  /// 500ms — tooltip wait, brief feedback pauses.
  static const Duration xSlow = DievasDurationPrimitives.d500;

  /// 800ms — loader spinner rotation cycle.
  static const Duration loader = DievasDurationPrimitives.d800;

  /// 2s — tooltip visible duration.
  static const Duration tooltipShow = DievasDurationPrimitives.d2000;

  /// 3s — snackbar auto-dismiss.
  static const Duration snackbarDismiss = DievasDurationPrimitives.d3000;
}
