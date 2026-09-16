// Semantic easing tokens.
//
// Pure Dart. No Flutter dependency.
// Intent-based aliases over DievasEasingPrimitives for animation curves
// used across the design system.

import 'package:dievas_tokens/src/primitives/easing_primitives.dart';

/// Semantic easing tokens for the Dievas design system.
///
/// Maps motion intents to their corresponding cubic bezier curves.
/// References [DievasEasingPrimitives] exclusively.
abstract final class DievasEasingSemantic {
  /// Standard UI transitions — toggles, accordions, popovers.
  static const DievasEasingCurve standard = DievasEasingPrimitives.standard;

  /// Elements entering the screen — modals, sheets, panels.
  static const DievasEasingCurve enter = DievasEasingPrimitives.decelerate;

  /// Elements leaving the screen — dismissals, removals.
  static const DievasEasingCurve exit = DievasEasingPrimitives.accelerate;

  /// Hero animations and emphatic transitions.
  static const DievasEasingCurve emphasize = DievasEasingPrimitives.emphasize;
}
