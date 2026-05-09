// Semantic elevation tokens.
//
// Pure Dart. No Flutter dependency.
// Named aliases over DievasElevationPrimitives — follows the same
// primitives → semantic contract as all other token families.
//
// BoxShadow construction (which needs Flutter's Color and Offset) happens
// in the dievas Flutter package's elevation theme data.

import '../primitives/elevation_primitives.dart';
import 'opacity_semantic.dart';
import 'offset_semantic.dart';

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

/// Concrete shadow layer definitions for elevation tiers.
///
/// Each tier is a record containing the blur radius and y-offset for
/// each shadow layer. Opacity is controlled via [DievasOpacitySemantic]shadow*]
/// constants — these are applied at the point of BoxShadow construction
/// in the dievas Flutter package.
///
/// Layer structure: ({double blur, double offsetY})
abstract final class DievasElevationShadowLayer {
  /// Elevation xs — single-layer subtle shadow.
  static const ({double blur, double offsetY}) xs = (
    blur: DievasElevationPrimitives.e1,
    offsetY: DievasOffsetSemantic.xs,
  );

  /// Elevation sm — two-layer shadow (upper + lower).
  static const ({double blur, double offsetY}) smUpper = (
    blur: DievasElevationPrimitives.e1,
    offsetY: DievasOffsetSemantic.xs,
  );

  static const ({double blur, double offsetY}) smLower = (
    blur: DievasElevationPrimitives.e2,
    offsetY: DievasOffsetSemantic.sm,
  );

  /// Elevation md — two-layer shadow.
  static const ({double blur, double offsetY}) mdUpper = (
    blur: DievasElevationPrimitives.e2,
    offsetY: DievasOffsetSemantic.sm,
  );

  static const ({double blur, double offsetY}) mdLower = (
    blur: DievasElevationPrimitives.e3,
    offsetY: DievasOffsetSemantic.md,
  );

  /// Elevation lg — two-layer shadow.
  static const ({double blur, double offsetY}) lgUpper = (
    blur: DievasElevationPrimitives.e3,
    offsetY: DievasOffsetSemantic.md,
  );

  static const ({double blur, double offsetY}) lgLower = (
    blur: DievasElevationPrimitives.e4,
    offsetY: DievasOffsetSemantic.lg,
  );

  /// Elevation xl — two-layer shadow.
  static const ({double blur, double offsetY}) xlUpper = (
    blur: DievasElevationPrimitives.e4,
    offsetY: DievasOffsetSemantic.lg,
  );

  static const ({double blur, double offsetY}) xlLower = (
    blur: DievasElevationPrimitives.e5,
    offsetY: DievasOffsetSemantic.xl,
  );
}
