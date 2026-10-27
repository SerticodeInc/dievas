import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/animation.dart';

/// Theme data for [DievasMenuItem].
///
/// Token-derived by the component mapper. The widget reads this from
/// [DievasComponentThemeData.menuItem].
final class DievasMenuItemThemeData extends Equatable {
  const DievasMenuItemThemeData({
    this.backgroundColour = const Color(0x00000000),
    this.hoverEffectColour = const Color(0x00000000),
    this.minHeight = 40,
    this.verticalGap = 2,
    this.hoverEffectDuration = const Duration(milliseconds: 200),
    this.hoverEffectCurve = Curves.easeInOut,
    required this.textStyle,
    required this.subtitleStyle,
    required this.iconSize,
    required this.iconSpacing,
    required this.padding,
    required this.densePadding,
    required this.borderRadius,
    required this.textColour,
    required this.textColourDisabled,
    required this.subtitleColour,
    required this.subtitleColourDisabled,
    required this.iconColour,
    required this.iconColourDisabled,
    required this.disabledOpacity,
  });

  final Color backgroundColour;
  final Color hoverEffectColour;
  final double minHeight;
  final double verticalGap;
  final Duration hoverEffectDuration;
  final Curve hoverEffectCurve;

  /// Label text style.
  final TextStyle textStyle;

  /// Subtitle text style.
  final TextStyle subtitleStyle;

  /// Leading icon size (dp).
  final double iconSize;

  /// Gap between leading icon and label (dp).
  final double iconSpacing;

  /// Standard item padding.
  final EdgeInsets padding;

  /// Dense item padding — smaller vertical inset.
  final EdgeInsets densePadding;

  /// Container corner radius.
  final BorderRadius borderRadius;

  /// Label colour when enabled.
  final Color textColour;

  /// Label colour when disabled.
  final Color textColourDisabled;

  /// Subtitle colour when enabled.
  final Color subtitleColour;

  /// Subtitle colour when disabled.
  final Color subtitleColourDisabled;

  /// Leading icon colour when enabled.
  final Color iconColour;

  /// Leading icon colour when disabled.
  final Color iconColourDisabled;

  /// Opacity multiplier applied when disabled.
  final double disabledOpacity;

  /// Copy this theme with explicit component overrides.
  DievasMenuItemThemeData copyWith({
    Color? backgroundColour,
    Color? hoverEffectColour,
    double? minHeight,
    double? verticalGap,
    Duration? hoverEffectDuration,
    Curve? hoverEffectCurve,
    TextStyle? textStyle,
    TextStyle? subtitleStyle,
    double? iconSize,
    double? iconSpacing,
    EdgeInsets? padding,
    EdgeInsets? densePadding,
    BorderRadius? borderRadius,
    Color? textColour,
    Color? textColourDisabled,
    Color? subtitleColour,
    Color? subtitleColourDisabled,
    Color? iconColour,
    Color? iconColourDisabled,
    double? disabledOpacity,
  }) => DievasMenuItemThemeData(
    backgroundColour: backgroundColour ?? this.backgroundColour,
    hoverEffectColour: hoverEffectColour ?? this.hoverEffectColour,
    minHeight: minHeight ?? this.minHeight,
    verticalGap: verticalGap ?? this.verticalGap,
    hoverEffectDuration: hoverEffectDuration ?? this.hoverEffectDuration,
    hoverEffectCurve: hoverEffectCurve ?? this.hoverEffectCurve,
    textStyle: textStyle ?? this.textStyle,
    subtitleStyle: subtitleStyle ?? this.subtitleStyle,
    iconSize: iconSize ?? this.iconSize,
    iconSpacing: iconSpacing ?? this.iconSpacing,
    padding: padding ?? this.padding,
    densePadding: densePadding ?? this.densePadding,
    borderRadius: borderRadius ?? this.borderRadius,
    textColour: textColour ?? this.textColour,
    textColourDisabled: textColourDisabled ?? this.textColourDisabled,
    subtitleColour: subtitleColour ?? this.subtitleColour,
    subtitleColourDisabled: subtitleColourDisabled ?? this.subtitleColourDisabled,
    iconColour: iconColour ?? this.iconColour,
    iconColourDisabled: iconColourDisabled ?? this.iconColourDisabled,
    disabledOpacity: disabledOpacity ?? this.disabledOpacity,
  );

  @override
  List<Object?> get props => [
    backgroundColour,
    hoverEffectColour,
    minHeight,
    verticalGap,
    hoverEffectDuration,
    hoverEffectCurve,
    textStyle,
    subtitleStyle,
    iconSize,
    iconSpacing,
    padding,
    densePadding,
    borderRadius,
    textColour,
    textColourDisabled,
    subtitleColour,
    subtitleColourDisabled,
    iconColour,
    iconColourDisabled,
    disabledOpacity,
  ];
}
