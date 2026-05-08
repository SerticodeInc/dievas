import 'package:flutter/widgets.dart';

import '../theme.dart';

/// Flat [BuildContext] extension for accessing Dievas theme sub-systems.
///
/// Each getter is aspect-scoped — only the widget that reads a specific
/// sub-system rebuilds when that sub-system changes.
///
/// Usage inside a widget's [build] method:
/// ```dart
/// final color = context.colors.action.actionPrimary;
/// final style = context.typography.labelMd;
/// final gap   = context.spacing.md;
/// ```
extension DievasThemeContextExtension on BuildContext {
  /// The complete colour sub-system for the current theme.
  DievasColourThemeData get colors => DievasTheme.colorsOf(this);

  /// The complete typography sub-system — the full type ramp as [TextStyle] objects.
  DievasTypographyThemeData get typography => DievasTheme.typographyOf(this);

  /// The spacing sub-system — 4pt-grid spacing tokens.
  DievasSpacingThemeData get spacing => DievasTheme.spacingOf(this);

  /// The sizing sub-system — component heights, icon sizes, avatar dimensions.
  DievasSizingThemeData get sizing => DievasTheme.sizingOf(this);

  /// The border sub-system — radius and stroke-width tokens.
  DievasBorderThemeData get border => DievasTheme.borderOf(this);

  /// The elevation sub-system — [BoxShadow] lists per level.
  DievasElevationThemeData get elevation => DievasTheme.elevationOf(this);

  /// The opacity sub-system — fractional opacity values.
  DievasOpacityThemeData get opacity => DievasTheme.opacityOf(this);

  /// The component-level theme data sub-system.
  DievasComponentThemeData get components => DievasTheme.componentsOf(this);
}
