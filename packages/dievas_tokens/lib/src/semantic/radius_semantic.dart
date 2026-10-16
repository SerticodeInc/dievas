// Semantic border radius tokens.
//
// Pure Dart. No Flutter dependency.
// Named aliases over DievasRadiusPrimitives for consistent corner rounding
// across containers, buttons, inputs, and overlays.

import 'package:dievas_tokens/src/primitives/radius_primitives.dart';

/// Semantic border radius tokens for the Dievas design system.
///
/// References [DievasRadiusPrimitives] exclusively.
abstract final class DievasRadiusSemantic {
  /// 0px — sharp corners. Used for full-bleed banners and dividers.
  static const double NONE = DievasRadiusPrimitives.NONE;

  /// 2px — subtle rounding. Tags, small chips.
  static const double XS = DievasRadiusPrimitives.XS;

  /// 4px — compact inputs, small buttons, tooltips.
  static const double SM = DievasRadiusPrimitives.SM;

  /// 8px — default rounding. Cards, modals, standard buttons, text fields.
  static const double MD = DievasRadiusPrimitives.MD;

  /// 12px — large cards, elevated panels.
  static const double LG = DievasRadiusPrimitives.LG;

  /// 16px — prominent surfaces, bottom sheets.
  static const double XL = DievasRadiusPrimitives.XL;

  /// 20px — extra-large overlays, feature cards.
  static const double XL2 = DievasRadiusPrimitives.XL2;

  /// 24px — maximum before pill. Hero cards.
  static const double XL3 = DievasRadiusPrimitives.XL3;

  /// 9999px — pill shape. Badges, chips, fully rounded buttons, avatars.
  static const double FULL = DievasRadiusPrimitives.FULL;
}
