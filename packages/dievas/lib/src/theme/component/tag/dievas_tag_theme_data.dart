import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

import 'dievas_tag_border_radius.dart';

/// Theme data for [DievasTag].
///
/// Holds layout, typography, and optional colour tokens. When colour fields
/// are `null` the widget resolves colours dynamically from
/// [DievasColourThemeData] based on [DievasTagStyle].
final class DievasTagThemeData extends Equatable {
  const DievasTagThemeData({
    required this.textStyle,
    required this.borderRadius,
    required this.padding,
    required this.iconSize,
    required this.iconSpacing,
    required this.removeIconSize,
    required this.removeIconSpacing,
    required this.minHeight,
    required this.borderWidth,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  });

  /// Label text style — typically [DievasTypographyThemeData.labelSm].
  final TextStyle textStyle;

  /// Container corner radius — pill or custom.
  final DievasTagBorderRadius borderRadius;

  /// Inner padding applied to the tag container.
  final EdgeInsets padding;

  /// Leading icon size (dp).
  final double iconSize;

  /// Gap between leading icon and label (dp).
  final double iconSpacing;

  /// Remove (×) icon size (dp).
  final double removeIconSize;

  /// Gap between label and remove icon (dp).
  final double removeIconSpacing;

  /// Minimum container height (dp).
  final double minHeight;

  /// Border stroke width (dp). Kept consistent across all [DievasTagStyle]s so toggling `.filled` ↔ `.outlined` does not change visual footprint.
  final double borderWidth;

  /// Global override for tag background colour.
  final Color? backgroundColor;

  /// Global override for tag text and icon colour.
  final Color? foregroundColor;

  /// Global override for tag border colour.
  final Color? borderColor;

  /// Creates a copy of this [DievasTagThemeData] with the given fields replaced.
  DievasTagThemeData copyWith({
    TextStyle? textStyle,
    DievasTagBorderRadius? borderRadius,
    EdgeInsets? padding,
    double? iconSize,
    double? iconSpacing,
    double? removeIconSize,
    double? removeIconSpacing,
    double? minHeight,
    double? borderWidth,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    bool clearBackgroundColor = false,
    bool clearForegroundColor = false,
    bool clearBorderColor = false,
  }) => DievasTagThemeData(
    textStyle: textStyle ?? this.textStyle,
    borderRadius: borderRadius ?? this.borderRadius,
    padding: padding ?? this.padding,
    iconSize: iconSize ?? this.iconSize,
    iconSpacing: iconSpacing ?? this.iconSpacing,
    removeIconSize: removeIconSize ?? this.removeIconSize,
    removeIconSpacing: removeIconSpacing ?? this.removeIconSpacing,
    minHeight: minHeight ?? this.minHeight,
    borderWidth: borderWidth ?? this.borderWidth,
    backgroundColor: clearBackgroundColor ? null : backgroundColor ?? this.backgroundColor,
    foregroundColor: clearForegroundColor ? null : foregroundColor ?? this.foregroundColor,
    borderColor: clearBorderColor ? null : borderColor ?? this.borderColor,
  );

  @override
  List<Object?> get props => [
    textStyle,
    borderRadius,
    padding,
    iconSize,
    iconSpacing,
    removeIconSize,
    removeIconSpacing,
    minHeight,
    borderWidth,
    backgroundColor,
    foregroundColor,
    borderColor,
  ];
}
