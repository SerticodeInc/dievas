// Semantic elevation tokens: named aliases over DievasElevationPrimitives,
// following the same primitives to semantic contract as the other families.
// BoxShadow construction happens in the dievas Flutter package.

import 'package:dievas_tokens/src/primitives/colour_primitives.dart';
import 'package:dievas_tokens/src/primitives/elevation_primitives.dart';
import 'package:dievas_tokens/src/primitives/opacity_primitives.dart';

/// Semantic elevation tokens for the Dievas design system. Blur sizes reference
/// [DievasElevationPrimitives], shadow ink [DievasColourPrimitives], and layer
/// tints [DievasOpacityPrimitives].
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

  /// Extra large shadow. Modal, bottom sheet, popover.
  static const double xl = DievasElevationPrimitives.e5;

  /// 0xFF171717: base ink for every shadow layer. A soft near black, so depth
  /// reads as a gentle halo instead of weight. Scoped to elevation only, never
  /// a general colour role.
  static const int shadowColour = DievasColourPrimitives.neutral900;
}

/// One shadow layer: the blur radius and the tint opacity applied to it when
/// the dievas Flutter package constructs the corresponding BoxShadow.
typedef DievasElevationShadow = ({double blur, double tint});

/// Shadow layers per elevation tier, ordered tight first then diffuse. Every
/// layer is painted centred with no vertical offset, so elevation reads as a
/// soft halo around the surface rather than a drop shadow underneath it.
abstract final class DievasElevationShadowLayer {
  /// Elevation xs: single diffuse layer.
  static const List<DievasElevationShadow> xs = [
    (blur: DievasElevationPrimitives.e1, tint: DievasOpacityPrimitives.o12),
  ];

  /// Elevation sm: tight ambient layer then diffuse layer.
  static const List<DievasElevationShadow> sm = [
    (blur: DievasElevationPrimitives.e1, tint: DievasOpacityPrimitives.o8),
    (blur: DievasElevationPrimitives.e2, tint: DievasOpacityPrimitives.o12),
  ];

  /// Elevation md: tight ambient layer then diffuse layer.
  static const List<DievasElevationShadow> md = [
    (blur: DievasElevationPrimitives.e2, tint: DievasOpacityPrimitives.o8),
    (blur: DievasElevationPrimitives.e3, tint: DievasOpacityPrimitives.o20),
  ];

  /// Elevation lg: tight ambient layer then diffuse layer.
  static const List<DievasElevationShadow> lg = [
    (blur: DievasElevationPrimitives.e3, tint: DievasOpacityPrimitives.o8),
    (blur: DievasElevationPrimitives.e4, tint: DievasOpacityPrimitives.o20),
  ];

  /// Elevation xl: tight ambient layer then diffuse layer.
  static const List<DievasElevationShadow> xl = [
    (blur: DievasElevationPrimitives.e4, tint: DievasOpacityPrimitives.o8),
    (blur: DievasElevationPrimitives.e5, tint: DievasOpacityPrimitives.o24),
  ];
}
