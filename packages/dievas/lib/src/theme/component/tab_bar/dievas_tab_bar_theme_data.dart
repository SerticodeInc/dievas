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
    this.smallHeight,
    this.smallTabPadding,
    this.slotGap,
    this.smallSlotGap,
    this.borderRadius,
    this.smallBorderRadius,
    this.iconSize,
    this.pillSelectedColour,
    this.pillSelectedTextColour,
    this.gap = 4,
    this.showDivider = false,
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

  final double? smallHeight;
  final EdgeInsetsGeometry? smallTabPadding;
  final double? slotGap;
  final double? smallSlotGap;
  final BorderRadiusGeometry? borderRadius;
  final BorderRadiusGeometry? smallBorderRadius;
  final double? iconSize;
  final Color? pillSelectedColour;
  final Color? pillSelectedTextColour;
  final double gap;
  final bool showDivider;

  DievasTabBarThemeData copyWith({
    TextStyle? labelStyle,
    TextStyle? selectedLabelStyle,
    Color? indicatorColour,
    double? indicatorHeight,
    Color? dividerColour,
    EdgeInsets? tabPadding,
    Duration? animationDuration,
    double? disabledOpacity,
    double? minTabWidth,
    double? height,
    double? smallHeight,
    EdgeInsetsGeometry? smallTabPadding,
    double? slotGap,
    double? smallSlotGap,
    BorderRadiusGeometry? borderRadius,
    BorderRadiusGeometry? smallBorderRadius,
    double? iconSize,
    Color? pillSelectedColour,
    Color? pillSelectedTextColour,
    double? gap,
    bool? showDivider,
  }) => DievasTabBarThemeData(
    labelStyle: labelStyle ?? this.labelStyle,
    selectedLabelStyle: selectedLabelStyle ?? this.selectedLabelStyle,
    indicatorColour: indicatorColour ?? this.indicatorColour,
    indicatorHeight: indicatorHeight ?? this.indicatorHeight,
    dividerColour: dividerColour ?? this.dividerColour,
    tabPadding: tabPadding ?? this.tabPadding,
    animationDuration: animationDuration ?? this.animationDuration,
    disabledOpacity: disabledOpacity ?? this.disabledOpacity,
    minTabWidth: minTabWidth ?? this.minTabWidth,
    height: height ?? this.height,
    smallHeight: smallHeight ?? this.smallHeight,
    smallTabPadding: smallTabPadding ?? this.smallTabPadding,
    slotGap: slotGap ?? this.slotGap,
    smallSlotGap: smallSlotGap ?? this.smallSlotGap,
    borderRadius: borderRadius ?? this.borderRadius,
    smallBorderRadius: smallBorderRadius ?? this.smallBorderRadius,
    iconSize: iconSize ?? this.iconSize,
    pillSelectedColour: pillSelectedColour ?? this.pillSelectedColour,
    pillSelectedTextColour: pillSelectedTextColour ?? this.pillSelectedTextColour,
    gap: gap ?? this.gap,
    showDivider: showDivider ?? this.showDivider,
  );

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
    smallHeight,
    smallTabPadding,
    slotGap,
    smallSlotGap,
    borderRadius,
    smallBorderRadius,
    iconSize,
    pillSelectedColour,
    pillSelectedTextColour,
    gap,
    showDivider,
  ];
}
