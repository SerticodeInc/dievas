// Semantic border radius tokens: named aliases over DievasRadiusPrimitives for
// consistent corner rounding across containers, buttons, inputs, and overlays.

import 'package:dievas_tokens/src/primitives/radius_primitives.dart';

/// Semantic border radius tokens for the Dievas design system.
///
/// References [DievasRadiusPrimitives] exclusively.
abstract final class DievasRadiusSemantic {
  /// 0px: sharp corners. Used for full bleed banners and dividers.
  static const double NONE = DievasRadiusPrimitives.none;

  /// 2px: subtle rounding. Tags, small chips.
  static const double XS = DievasRadiusPrimitives.xs;

  /// 4px: compact inputs, small buttons, tooltips.
  static const double SM = DievasRadiusPrimitives.sm;

  /// 8px: default rounding. Cards, modals, standard buttons, text fields.
  static const double MD = DievasRadiusPrimitives.md;

  /// 12px: large cards, elevated panels.
  static const double LG = DievasRadiusPrimitives.lg;

  /// 16px: prominent surfaces, bottom sheets.
  static const double XL = DievasRadiusPrimitives.xl;

  /// 20px: extra large overlays, feature cards.
  static const double XL2 = DievasRadiusPrimitives.xl2;

  /// 24px: hero cards.
  static const double XL3 = DievasRadiusPrimitives.r24;

  /// 9999px: pill shape. Badges, chips, fully rounded buttons, avatars.
  static const double FULL = DievasRadiusPrimitives.full;
}
