// Semantic elevation tokens.
//
// Pure Dart. No Flutter dependency.
// Named aliases over DievasElevationPrimitives — follows the same
// primitives → semantic contract as all other token families.
//
// BoxShadow construction (which needs Flutter's Color and Offset) happens
// in the dievas Flutter package's elevation theme data.

import 'package:dievas_tokens/src/primitives/elevation_primitives.dart';
import 'package:dievas_tokens/src/semantic/offset_semantic.dart';

/// Semantic elevation tokens for the Dievas design system.
///
/// References [DievasElevationPrimitives] exclusively — no raw doubles
/// are permitted in this file.
abstract final class DievasElevationSemantic {
  /// No shadow. Flat surfaces flush with the page.
  static const double NONE = DievasElevationPrimitives.e0;

  /// Hairline shadow. Subtle card lift on a light background.
  static const double XS = DievasElevationPrimitives.e1;

  /// Small shadow. Default card, chip, badge.
  static const double SM = DievasElevationPrimitives.e2;

  /// Medium shadow. Hovered card, dropdown menu, tooltip.
  static const double MD = DievasElevationPrimitives.e3;

  /// Large shadow. Floating action button, sticky header.
  static const double LG = DievasElevationPrimitives.e4;

  /// Extra-large shadow. Modal, bottom sheet, popover.
  static const double XL = DievasElevationPrimitives.e5;
}

/// A single shadow layer consisting of a blur radius and Y-offset.
///
/// Used by [DievasElevationShadowLayer] to define multi-layered
/// Material-style shadows. Opacity is applied at BoxShadow construction
/// time in the `dievas` Flutter package.
typedef DievasElevationShadow = ({double blur, double offsetY});

/// Concrete shadow layer definitions for elevation tiers.
///
/// Each tier is a record containing the blur radius and y-offset for
/// each shadow layer. Shadow tint opacities live on the elevation domain
/// and are applied at the point of BoxShadow construction in the dievas
/// Flutter package.
///
/// Layer structure: [DievasElevationShadow]
abstract final class DievasElevationShadowLayer {
  /// Elevation XS — single-layer subtle shadow.
  static const DievasElevationShadow XS = (blur: DievasElevationPrimitives.e1, offsetY: DievasOffsetSemantic.XS);

  /// Elevation SM — two-layer shadow (upper + lower).
  static const DievasElevationShadow upperSM = (blur: DievasElevationPrimitives.e1, offsetY: DievasOffsetSemantic.XS);

  static const DievasElevationShadow lowerSM = (blur: DievasElevationPrimitives.e2, offsetY: DievasOffsetSemantic.SM);

  /// Elevation MD — two-layer shadow.
  static const DievasElevationShadow upperMD = (blur: DievasElevationPrimitives.e2, offsetY: DievasOffsetSemantic.SM);

  static const DievasElevationShadow lowerMD = (blur: DievasElevationPrimitives.e3, offsetY: DievasOffsetSemantic.MD);

  /// Elevation LG — two-layer shadow.
  static const DievasElevationShadow upperLG = (blur: DievasElevationPrimitives.e3, offsetY: DievasOffsetSemantic.MD);

  static const DievasElevationShadow lowerLG = (blur: DievasElevationPrimitives.e4, offsetY: DievasOffsetSemantic.LG);

  /// Elevation XL — two-layer shadow.
  static const DievasElevationShadow upperXL = (blur: DievasElevationPrimitives.e4, offsetY: DievasOffsetSemantic.LG);

  static const DievasElevationShadow lowerXL = (blur: DievasElevationPrimitives.e5, offsetY: DievasOffsetSemantic.XL);
}
