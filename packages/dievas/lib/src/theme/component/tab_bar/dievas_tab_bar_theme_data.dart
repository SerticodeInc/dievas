import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasTabBar].
///
/// Token-derived by the component mapper. The widget reads this from
/// [DievasComponentThemeData.tabBar].
final class DievasTabBarThemeData extends Equatable {
  const DievasTabBarThemeData({
    required this.labelStyle,
    required this.selectedLabelStyle,
    required this.indicatorColour,
    required this.indicatorHeight,
    required this.dividerColour,
    required this.tabPadding,
    required this.animationDuration,
    required this.disabledOpacity,
    required this.minTabWidth,
    required this.height,
  });

  /// Label text style for inactive tabs.
  final TextStyle labelStyle;

  /// Label text style for the active tab.
  final TextStyle selectedLabelStyle;

  /// Underline indicator colour for the active tab.
  final Color indicatorColour;

  /// Underline indicator height (dp).
  final double indicatorHeight;

  /// Bottom divider line colour.
  final Color dividerColour;

  /// Internal padding for each tab.
  final EdgeInsets tabPadding;

  /// Duration of the indicator transition.
  final Duration animationDuration;

  /// Opacity multiplier when disabled.
  final double disabledOpacity;

  /// Minimum width per tab (dp).
  final double minTabWidth;

  /// Tab bar height (dp).
  final double height;

  @override
  List<Object?> get props => [
    labelStyle,
    selectedLabelStyle,
    indicatorColour,
    indicatorHeight,
    dividerColour,
    tabPadding,
    animationDuration,
    disabledOpacity,
    minTabWidth,
    height,
  ];
}
