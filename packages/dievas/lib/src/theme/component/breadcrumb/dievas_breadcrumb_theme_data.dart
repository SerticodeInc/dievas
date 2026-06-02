import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Theme data for [DievasBreadcrumb].
///
/// Token-derived by the component mapper. The widget reads this from
/// [DievasComponentThemeData.breadcrumb].
@immutable
final class DievasBreadcrumbThemeData extends Equatable {
  const DievasBreadcrumbThemeData({
    required this.itemStyle,
    required this.activeItemStyle,
    required this.separatorStyle,
    required this.separatorSpacing,
    required this.iconSize,
    required this.iconSpacing,
    required this.minHitHeight,
    required this.disabledOpacity,
  });

  /// Default breadcrumb item text style.
  final TextStyle itemStyle;

  /// Text style for the currently-selected breadcrumb item.
  final TextStyle activeItemStyle;

  /// Separator icon / text style.
  final TextStyle separatorStyle;

  /// Horizontal gap around the separator (dp).
  final double separatorSpacing;

  /// Home / leading icon size (dp).
  final double iconSize;

  /// Gap between leading icon and item text (dp).
  final double iconSpacing;

  /// Minimum tap target height for each item (dp).
  final double minHitHeight;

  /// Opacity multiplier applied when disabled.
  final double disabledOpacity;

  @override
  List<Object?> get props => [
    itemStyle,
    activeItemStyle,
    separatorStyle,
    separatorSpacing,
    iconSize,
    iconSpacing,
    minHitHeight,
    disabledOpacity,
  ];
}
