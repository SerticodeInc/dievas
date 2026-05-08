// Semantic border radius tokens.
//
// Pure Dart. No Flutter dependency.
// Named aliases over DievasRadiusPrimitives for consistent corner rounding
// across containers, buttons, inputs, and overlays.

import '../primitives/radius_primitives.dart';

/// Semantic border radius tokens for the Dievas design system.
///
/// References [DievasRadiusPrimitives] exclusively.
abstract final class DievasRadiusSemantic {
  /// 0px — sharp corners. Used for full-bleed banners and dividers.
  static const double none = DievasRadiusPrimitives.none;

  /// 2px — subtle rounding. Tags, small chips.
  static const double xs = DievasRadiusPrimitives.xs;

  /// 4px — compact inputs, small buttons, tooltips.
  static const double sm = DievasRadiusPrimitives.sm;

  /// 8px — default rounding. Cards, modals, standard buttons, text fields.
  static const double md = DievasRadiusPrimitives.md;

  /// 12px — large cards, elevated panels.
  static const double lg = DievasRadiusPrimitives.lg;

  /// 16px — prominent surfaces, bottom sheets.
  static const double xl = DievasRadiusPrimitives.xl;

  /// 20px — extra-large overlays, feature cards.
  static const double x2l = DievasRadiusPrimitives.x2l;

  /// 24px — maximum before pill. Hero cards.
  static const double x3l = DievasRadiusPrimitives.x3l;

  /// 9999px — pill shape. Badges, chips, fully rounded buttons, avatars.
  static const double full = DievasRadiusPrimitives.full;
}
