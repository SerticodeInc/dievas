// Semantic border radius tokens: named aliases over DievasRadiusPrimitives for
// consistent corner rounding across containers, buttons, inputs, and overlays.

import 'package:dievas_tokens/src/primitives/radius_primitives.dart';

/// Semantic border radius tokens for the Dievas design system.
///
/// References [DievasRadiusPrimitives] exclusively.
abstract final class DievasRadiusSemantic {
  /// 0px: sharp corners. Used for full bleed banners and dividers.
  static const double none = DievasRadiusPrimitives.none;

  /// 2px: subtle rounding. Tags, small chips.
  static const double xs = DievasRadiusPrimitives.xs;

  /// 4px: compact inputs, small buttons, tooltips.
  static const double sm = DievasRadiusPrimitives.sm;

  /// 8px: default rounding. Cards, modals, standard buttons, text fields.
  static const double md = DievasRadiusPrimitives.md;

  /// 12px: large cards, elevated panels.
  static const double lg = DievasRadiusPrimitives.lg;

  /// 16px: prominent surfaces, bottom sheets.
  static const double xl = DievasRadiusPrimitives.xl;

  /// 20px: extra large overlays, feature cards.
  static const double xl2 = DievasRadiusPrimitives.xl2;

  /// 24px: hero cards.
  static const double xl3 = DievasRadiusPrimitives.r24;

  /// 28px: large hero surfaces.
  static const double r28 = DievasRadiusPrimitives.r28;

  /// 32px: feature panels.
  static const double r32 = DievasRadiusPrimitives.r32;

  /// 36px: oversized feature surfaces.
  static const double r36 = DievasRadiusPrimitives.r36;

  /// 40px: prominent sheets and panels.
  static const double r40 = DievasRadiusPrimitives.r40;

  /// 48px: large decorative surfaces.
  static const double r48 = DievasRadiusPrimitives.r48;

  /// 56px: very large surfaces.
  static const double r56 = DievasRadiusPrimitives.r56;

  /// 64px: extra large surfaces.
  static const double r64 = DievasRadiusPrimitives.r64;

  /// 9999px: pill shape. Badges, chips, fully rounded buttons, avatars.
  static const double full = DievasRadiusPrimitives.full;
}
