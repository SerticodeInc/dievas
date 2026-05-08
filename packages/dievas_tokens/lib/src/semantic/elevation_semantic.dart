// Semantic elevation tokens.
//
// Pure Dart. No Flutter dependency.
// Named aliases over DievasElevationPrimitives — follows the same
// primitives → semantic contract as all other token families.
//
// BoxShadow construction (which needs Flutter's Color and Offset) happens
// in the dievas Flutter package's elevation theme data.

import '../primitives/elevation_primitives.dart';

/// Semantic elevation tokens for the Dievas design system.
///
/// References [DievasElevationPrimitives] exclusively — no raw doubles
/// are permitted in this file.
abstract final class DievasElevationSemantic {
  /// No shadow. Flat surfaces flush with the page.
  static const double none = DievasElevationPrimitives.e0;

  /// Hairline shadow. Subtle card lift on a light background.
  static const double xs = DievasElevationPrimitives.e1;

  /// Small shadow. Default card, chip, badge.
  static const double sm = DievasElevationPrimitives.e2;

  /// Medium shadow. Hovered card, dropdown menu, tooltip.
  static const double md = DievasElevationPrimitives.e3;

  /// Large shadow. Floating action button, sticky header.
  static const double lg = DievasElevationPrimitives.e4;

  /// Extra-large shadow. Modal, bottom sheet, popover.
  static const double xl = DievasElevationPrimitives.e5;
}
