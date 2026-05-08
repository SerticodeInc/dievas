import 'package:flutter/material.dart' show ThemeData;

import 'border/dievas_border_theme_data.dart';
import 'color/dievas_colour_theme_data.dart';
import 'component/dievas_component_theme_data.dart';
import 'elevation/dievas_elevation_theme_data.dart';
import 'opacity/dievas_opacity_theme_data.dart';
import 'sizing/dievas_sizing_theme_data.dart';
import 'spacing/dievas_spacing_theme_data.dart';
import 'typography/dievas_typography_theme_data.dart';

/// The Dievas theme contract.
///
/// Every concrete theme — whether a default Dievas theme or a consumer app's
/// brand theme — must implement this interface. It defines the getter surface
/// that all components and the InheritedModel depend on.
///
/// Consuming apps create their brand theme by extending [DievasGlobalThemeData],
/// not by implementing this interface directly.
///
/// ```dart
/// // In a consuming app:
/// class CadenceLightThemeData extends DievasGlobalThemeData { ... }
/// ```
abstract interface class DievasThemeData {
  /// The Dart package name. Used for asset resolution.
  static const String packageName = 'dievas';

  /// Complete colour sub-system — colour sets for all semantic domains.
  DievasColourThemeData get colors;

  /// Complete typography sub-system — the full type ramp as [TextStyle] objects.
  DievasTypographyThemeData get typography;

  /// Elevation sub-system — [BoxShadow] lists for each elevation level.
  DievasElevationThemeData get elevation;

  /// Opacity sub-system — fractional values for disabled, overlay, hover states.
  DievasOpacityThemeData get opacity;

  /// Sizing sub-system — component heights, icon sizes, avatar dimensions.
  DievasSizingThemeData get sizing;

  /// Spacing sub-system — 4pt-grid spacing tokens.
  DievasSpacingThemeData get spacing;

  /// Border sub-system — radius and stroke-width tokens.
  DievasBorderThemeData get border;

  /// Component-level theme data — derived from all token sub-systems.
  DievasComponentThemeData get components;

  /// Flutter [ThemeData] bridge — for Material widget compatibility.
  ThemeData get material;

  /// Returns a copy of this theme with the given component overrides applied.
  DievasThemeData copyWith({DievasComponentThemeData? components});
}
