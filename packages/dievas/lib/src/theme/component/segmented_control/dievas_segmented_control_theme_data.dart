import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/animation.dart';

/// Theme data for [DievasSegmentedControl].
///
/// Token-derived by the component mapper. The widget reads this from
/// [DievasComponentThemeData.segmentedControl].
final class DievasSegmentedControlThemeData extends Equatable {
  const DievasSegmentedControlThemeData({
    required this.labelStyle,
    required this.selectedLabelStyle,
    required this.borderRadius,
    required this.padding,
    required this.bgColour,
    required this.selectedBgColour,
    required this.borderColour,
    required this.textColour,
    required this.selectedTextColour,
    required this.disabledOpacity,
    required this.animationDuration,
    required this.minSegmentWidth,
    required this.minHeight,
    this.segmentBorderRadius,
    this.containerPadding = .zero,
    this.gap = 0,
    this.animationCurve,
    this.sizes,
  });

  /// Unselected label text style.
  final TextStyle labelStyle;

  /// Selected label text style.
  final TextStyle selectedLabelStyle;

  /// Container corner radius.
  final BorderRadiusGeometry borderRadius;

  /// Inner padding for each segment.
  final EdgeInsetsGeometry padding;

  /// Background colour for unselected segments.
  final Color bgColour;

  /// Background colour for the selected segment.
  final Color selectedBgColour;

  /// Optional container outline colour. Defaults to transparent.
  final Color borderColour;

  /// Label colour for unselected segments.
  final Color textColour;

  /// Label colour for the selected segment.
  final Color selectedTextColour;

  /// Opacity multiplier when disabled.
  final double disabledOpacity;

  /// Duration of the selected-segment transition.
  final Duration animationDuration;

  /// Minimum width per segment (dp).
  final double minSegmentWidth;

  /// Overall control height when a legacy theme supplies no size presets.
  final double minHeight;

  final BorderRadiusGeometry? segmentBorderRadius;
  final EdgeInsetsGeometry containerPadding;
  final double gap;
  final Curve? animationCurve;

  /// Size specific geometry. Null preserves the legacy padding/height fields.
  final ({DievasSegmentedControlSizeData sm, DievasSegmentedControlSizeData md})? sizes;

  DievasSegmentedControlThemeData copyWith({
    TextStyle? labelStyle,
    TextStyle? selectedLabelStyle,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
    Color? bgColour,
    Color? selectedBgColour,
    Color? borderColour,
    Color? textColour,
    Color? selectedTextColour,
    double? disabledOpacity,
    Duration? animationDuration,
    double? minSegmentWidth,
    double? minHeight,
    BorderRadiusGeometry? segmentBorderRadius,
    EdgeInsetsGeometry? containerPadding,
    double? gap,
    Curve? animationCurve,
    ({DievasSegmentedControlSizeData sm, DievasSegmentedControlSizeData md})? sizes,
  }) => DievasSegmentedControlThemeData(
    labelStyle: labelStyle ?? this.labelStyle,
    selectedLabelStyle: selectedLabelStyle ?? this.selectedLabelStyle,
    borderRadius: borderRadius ?? this.borderRadius,
    padding: padding ?? this.padding,
    bgColour: bgColour ?? this.bgColour,
    selectedBgColour: selectedBgColour ?? this.selectedBgColour,
    borderColour: borderColour ?? this.borderColour,
    textColour: textColour ?? this.textColour,
    selectedTextColour: selectedTextColour ?? this.selectedTextColour,
    disabledOpacity: disabledOpacity ?? this.disabledOpacity,
    animationDuration: animationDuration ?? this.animationDuration,
    minSegmentWidth: minSegmentWidth ?? this.minSegmentWidth,
    minHeight: minHeight ?? this.minHeight,
    segmentBorderRadius: segmentBorderRadius ?? this.segmentBorderRadius,
    containerPadding: containerPadding ?? this.containerPadding,
    gap: gap ?? this.gap,
    animationCurve: animationCurve ?? this.animationCurve,
    sizes: sizes ?? this.sizes,
  );

  @override
  List<Object?> get props => [
    labelStyle,
    selectedLabelStyle,
    borderRadius,
    padding,
    bgColour,
    selectedBgColour,
    borderColour,
    textColour,
    selectedTextColour,
    disabledOpacity,
    animationDuration,
    minSegmentWidth,
    minHeight,
    segmentBorderRadius,
    containerPadding,
    gap,
    animationCurve,
    sizes,
  ];
}

/// Layout values for a segmented-control size preset.
final class DievasSegmentedControlSizeData extends Equatable {
  const DievasSegmentedControlSizeData({
    required this.height,
    required this.iconSize,
    required this.padding,
    required this.gap,
    required this.borderRadius,
  });

  final double height;
  final double iconSize;
  final EdgeInsetsGeometry padding;
  final double gap;
  final BorderRadiusGeometry borderRadius;

  DievasSegmentedControlSizeData copyWith({
    double? height,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    double? gap,
    BorderRadiusGeometry? borderRadius,
  }) => DievasSegmentedControlSizeData(
    height: height ?? this.height,
    iconSize: iconSize ?? this.iconSize,
    padding: padding ?? this.padding,
    gap: gap ?? this.gap,
    borderRadius: borderRadius ?? this.borderRadius,
  );

  @override
  List<Object?> get props => [height, iconSize, padding, gap, borderRadius];
}
