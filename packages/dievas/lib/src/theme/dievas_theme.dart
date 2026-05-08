import 'package:flutter/widgets.dart';

import 'border/dievas_border_theme_data.dart';
import 'color/dievas_colour_theme_data.dart';
import 'component/dievas_component_theme_data.dart';
import 'dievas_theme_data.dart';
import 'elevation/dievas_elevation_theme_data.dart';
import 'opacity/dievas_opacity_theme_data.dart';
import 'sizing/dievas_sizing_theme_data.dart';
import 'spacing/dievas_spacing_theme_data.dart';
import 'typography/dievas_typography_theme_data.dart';

/// Named aspects of the Dievas theme — used by [DievasTheme] (InheritedModel)
/// to scope rebuilds to only the widgets that depend on a changed aspect.
///
/// Example: a widget that reads only [DievasThemeAspect.colors] will not
/// rebuild when [DievasThemeAspect.spacing] changes.
enum DievasThemeAspect { border, colors, components, elevation, opacity, sizing, spacing, typography }

/// The Dievas InheritedModel — the single source of truth for theme data
/// in the widget tree.
///
/// [DievasScope] inserts [DievasTheme] into the tree. Components read from it
/// via the static accessors or the [BuildContext] extension (preferred).
///
/// Aspect-scoped reading — only the changed sub-system triggers a rebuild:
/// ```dart
/// // Granular: rebuilds only when colors change
/// DievasTheme.colorsOf(context);
///
/// // Full theme (rare — prefer granular access)
/// DievasTheme.of(context);
/// ```
class DievasTheme extends InheritedModel<DievasThemeAspect> {
  const DievasTheme({super.key, required this.data, required super.child});

  /// The full theme data at this point in the tree.
  final DievasThemeData data;

  /// Returns the full [DievasThemeData] from the nearest [DievasTheme] ancestor.
  ///
  /// Triggers a rebuild on any theme aspect change. Prefer the granular
  /// accessors (e.g. [colorsOf]) when only one sub-system is needed.
  static DievasThemeData of(BuildContext context) {
    final theme = InheritedModel.inheritFrom<DievasTheme>(context);
    assert(theme != null, 'No DievasTheme found in the widget tree. Wrap your app in DievasScope.');
    return theme!.data;
  }

  /// Returns only the [DievasColourThemeData]. Rebuilds when colours change.
  static DievasColourThemeData colorsOf(BuildContext context) =>
      InheritedModel.inheritFrom<DievasTheme>(context, aspect: DievasThemeAspect.colors)!.data.colors;

  /// Returns only the [DievasTypographyThemeData]. Rebuilds when typography changes.
  static DievasTypographyThemeData typographyOf(BuildContext context) =>
      InheritedModel.inheritFrom<DievasTheme>(context, aspect: DievasThemeAspect.typography)!.data.typography;

  /// Returns only the [DievasSpacingThemeData]. Rebuilds when spacing changes.
  static DievasSpacingThemeData spacingOf(BuildContext context) =>
      InheritedModel.inheritFrom<DievasTheme>(context, aspect: DievasThemeAspect.spacing)!.data.spacing;

  /// Returns only the [DievasSizingThemeData]. Rebuilds when sizing changes.
  static DievasSizingThemeData sizingOf(BuildContext context) =>
      InheritedModel.inheritFrom<DievasTheme>(context, aspect: DievasThemeAspect.sizing)!.data.sizing;

  /// Returns only the [DievasBorderThemeData]. Rebuilds when border changes.
  static DievasBorderThemeData borderOf(BuildContext context) =>
      InheritedModel.inheritFrom<DievasTheme>(context, aspect: DievasThemeAspect.border)!.data.border;

  /// Returns only the [DievasElevationThemeData]. Rebuilds when elevation changes.
  static DievasElevationThemeData elevationOf(BuildContext context) =>
      InheritedModel.inheritFrom<DievasTheme>(context, aspect: DievasThemeAspect.elevation)!.data.elevation;

  /// Returns only the [DievasOpacityThemeData]. Rebuilds when opacity changes.
  static DievasOpacityThemeData opacityOf(BuildContext context) =>
      InheritedModel.inheritFrom<DievasTheme>(context, aspect: DievasThemeAspect.opacity)!.data.opacity;

  /// Returns only the [DievasComponentThemeData]. Rebuilds when components change.
  static DievasComponentThemeData componentsOf(BuildContext context) =>
      InheritedModel.inheritFrom<DievasTheme>(context, aspect: DievasThemeAspect.components)!.data.components;

  @override
  bool updateShouldNotify(DievasTheme oldWidget) => data != oldWidget.data;

  @override
  bool updateShouldNotifyDependent(DievasTheme oldWidget, Set<DievasThemeAspect> dependencies) => dependencies.any(
    (aspect) => switch (aspect) {
      .colors => data.colors != oldWidget.data.colors,
      .typography => data.typography != oldWidget.data.typography,
      .spacing => data.spacing != oldWidget.data.spacing,
      .sizing => data.sizing != oldWidget.data.sizing,
      .border => data.border != oldWidget.data.border,
      .elevation => data.elevation != oldWidget.data.elevation,
      .opacity => data.opacity != oldWidget.data.opacity,
      .components => data.components != oldWidget.data.components,
    },
  );
}
