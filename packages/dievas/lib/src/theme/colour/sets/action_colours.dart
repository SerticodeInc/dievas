import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Colours named by the element, variant or state, and painted property.
final class ActionColours extends Equatable {
  const ActionColours({
    required this.buttonPrimaryBackground,
    required this.buttonPrimaryHoveredBackground,
    required this.buttonPrimaryPressedBackground,
    required this.buttonPrimaryDisabledBackground,
    required this.buttonSecondaryBackground,
    required this.buttonSecondaryHoveredBackground,
    required this.buttonDestructiveBackground,
    required this.buttonDestructiveHoveredBackground,
    required this.buttonSuccessBackground,
    required this.badgePrimaryBackground,
    required this.badgePrimaryTintedText,
    required this.checkboxCheckedBackground,
    required this.radioSelectedBackground,
    required this.progressIndicator,
    required this.sliderActiveTrack,
    required this.inputCursor,
    required this.segmentedControlSelectedBackground,
    required this.tabSelectedIndicator,
    required this.checkboxDisabledBackground,
    required this.radioDisabledBackground,
    required this.badgePrimaryText,
    required this.checkboxCheckmark,
    required this.radioDot,
    required this.progressOnPrimaryIndicator,
    required this.segmentedControlSelectedText,
  });

  final Color buttonPrimaryBackground;
  final Color buttonPrimaryHoveredBackground;
  final Color buttonPrimaryPressedBackground;
  final Color buttonPrimaryDisabledBackground;
  final Color buttonSecondaryBackground;
  final Color buttonSecondaryHoveredBackground;
  final Color buttonDestructiveBackground;
  final Color buttonDestructiveHoveredBackground;
  final Color buttonSuccessBackground;
  final Color badgePrimaryBackground;
  final Color badgePrimaryTintedText;
  final Color checkboxCheckedBackground;
  final Color radioSelectedBackground;
  final Color progressIndicator;
  final Color sliderActiveTrack;
  final Color inputCursor;
  final Color segmentedControlSelectedBackground;
  final Color tabSelectedIndicator;
  final Color checkboxDisabledBackground;
  final Color radioDisabledBackground;
  final Color badgePrimaryText;
  final Color checkboxCheckmark;
  final Color radioDot;
  final Color progressOnPrimaryIndicator;
  final Color segmentedControlSelectedText;

  ActionColours copyWith({
    Color? buttonPrimaryBackground,
    Color? buttonPrimaryHoveredBackground,
    Color? buttonPrimaryPressedBackground,
    Color? buttonPrimaryDisabledBackground,
    Color? buttonSecondaryBackground,
    Color? buttonSecondaryHoveredBackground,
    Color? buttonDestructiveBackground,
    Color? buttonDestructiveHoveredBackground,
    Color? buttonSuccessBackground,
    Color? badgePrimaryBackground,
    Color? badgePrimaryTintedText,
    Color? checkboxCheckedBackground,
    Color? radioSelectedBackground,
    Color? progressIndicator,
    Color? sliderActiveTrack,
    Color? inputCursor,
    Color? segmentedControlSelectedBackground,
    Color? tabSelectedIndicator,
    Color? checkboxDisabledBackground,
    Color? radioDisabledBackground,
    Color? badgePrimaryText,
    Color? checkboxCheckmark,
    Color? radioDot,
    Color? progressOnPrimaryIndicator,
    Color? segmentedControlSelectedText,
  }) => ActionColours(
    buttonPrimaryBackground: buttonPrimaryBackground ?? this.buttonPrimaryBackground,
    buttonPrimaryHoveredBackground: buttonPrimaryHoveredBackground ?? this.buttonPrimaryHoveredBackground,
    buttonPrimaryPressedBackground: buttonPrimaryPressedBackground ?? this.buttonPrimaryPressedBackground,
    buttonPrimaryDisabledBackground: buttonPrimaryDisabledBackground ?? this.buttonPrimaryDisabledBackground,
    buttonSecondaryBackground: buttonSecondaryBackground ?? this.buttonSecondaryBackground,
    buttonSecondaryHoveredBackground: buttonSecondaryHoveredBackground ?? this.buttonSecondaryHoveredBackground,
    buttonDestructiveBackground: buttonDestructiveBackground ?? this.buttonDestructiveBackground,
    buttonDestructiveHoveredBackground: buttonDestructiveHoveredBackground ?? this.buttonDestructiveHoveredBackground,
    buttonSuccessBackground: buttonSuccessBackground ?? this.buttonSuccessBackground,
    badgePrimaryBackground: badgePrimaryBackground ?? this.badgePrimaryBackground,
    badgePrimaryTintedText: badgePrimaryTintedText ?? this.badgePrimaryTintedText,
    checkboxCheckedBackground: checkboxCheckedBackground ?? this.checkboxCheckedBackground,
    radioSelectedBackground: radioSelectedBackground ?? this.radioSelectedBackground,
    progressIndicator: progressIndicator ?? this.progressIndicator,
    sliderActiveTrack: sliderActiveTrack ?? this.sliderActiveTrack,
    inputCursor: inputCursor ?? this.inputCursor,
    segmentedControlSelectedBackground: segmentedControlSelectedBackground ?? this.segmentedControlSelectedBackground,
    tabSelectedIndicator: tabSelectedIndicator ?? this.tabSelectedIndicator,
    checkboxDisabledBackground: checkboxDisabledBackground ?? this.checkboxDisabledBackground,
    radioDisabledBackground: radioDisabledBackground ?? this.radioDisabledBackground,
    badgePrimaryText: badgePrimaryText ?? this.badgePrimaryText,
    checkboxCheckmark: checkboxCheckmark ?? this.checkboxCheckmark,
    radioDot: radioDot ?? this.radioDot,
    progressOnPrimaryIndicator: progressOnPrimaryIndicator ?? this.progressOnPrimaryIndicator,
    segmentedControlSelectedText: segmentedControlSelectedText ?? this.segmentedControlSelectedText,
  );

  static ActionColours lerp(ActionColours a, ActionColours b, double t) => ActionColours(
    buttonPrimaryBackground: Color.lerp(a.buttonPrimaryBackground, b.buttonPrimaryBackground, t) as Color,
    buttonPrimaryHoveredBackground:
        Color.lerp(a.buttonPrimaryHoveredBackground, b.buttonPrimaryHoveredBackground, t) as Color,
    buttonPrimaryPressedBackground:
        Color.lerp(a.buttonPrimaryPressedBackground, b.buttonPrimaryPressedBackground, t) as Color,
    buttonPrimaryDisabledBackground:
        Color.lerp(a.buttonPrimaryDisabledBackground, b.buttonPrimaryDisabledBackground, t) as Color,
    buttonSecondaryBackground: Color.lerp(a.buttonSecondaryBackground, b.buttonSecondaryBackground, t) as Color,
    buttonSecondaryHoveredBackground:
        Color.lerp(a.buttonSecondaryHoveredBackground, b.buttonSecondaryHoveredBackground, t) as Color,
    buttonDestructiveBackground: Color.lerp(a.buttonDestructiveBackground, b.buttonDestructiveBackground, t) as Color,
    buttonDestructiveHoveredBackground:
        Color.lerp(a.buttonDestructiveHoveredBackground, b.buttonDestructiveHoveredBackground, t) as Color,
    buttonSuccessBackground: Color.lerp(a.buttonSuccessBackground, b.buttonSuccessBackground, t) as Color,
    badgePrimaryBackground: Color.lerp(a.badgePrimaryBackground, b.badgePrimaryBackground, t) as Color,
    badgePrimaryTintedText: Color.lerp(a.badgePrimaryTintedText, b.badgePrimaryTintedText, t) as Color,
    checkboxCheckedBackground: Color.lerp(a.checkboxCheckedBackground, b.checkboxCheckedBackground, t) as Color,
    radioSelectedBackground: Color.lerp(a.radioSelectedBackground, b.radioSelectedBackground, t) as Color,
    progressIndicator: Color.lerp(a.progressIndicator, b.progressIndicator, t) as Color,
    sliderActiveTrack: Color.lerp(a.sliderActiveTrack, b.sliderActiveTrack, t) as Color,
    inputCursor: Color.lerp(a.inputCursor, b.inputCursor, t) as Color,
    segmentedControlSelectedBackground:
        Color.lerp(a.segmentedControlSelectedBackground, b.segmentedControlSelectedBackground, t) as Color,
    tabSelectedIndicator: Color.lerp(a.tabSelectedIndicator, b.tabSelectedIndicator, t) as Color,
    checkboxDisabledBackground: Color.lerp(a.checkboxDisabledBackground, b.checkboxDisabledBackground, t) as Color,
    radioDisabledBackground: Color.lerp(a.radioDisabledBackground, b.radioDisabledBackground, t) as Color,
    badgePrimaryText: Color.lerp(a.badgePrimaryText, b.badgePrimaryText, t) as Color,
    checkboxCheckmark: Color.lerp(a.checkboxCheckmark, b.checkboxCheckmark, t) as Color,
    radioDot: Color.lerp(a.radioDot, b.radioDot, t) as Color,
    progressOnPrimaryIndicator: Color.lerp(a.progressOnPrimaryIndicator, b.progressOnPrimaryIndicator, t) as Color,
    segmentedControlSelectedText:
        Color.lerp(a.segmentedControlSelectedText, b.segmentedControlSelectedText, t) as Color,
  );

  @override
  List<Object?> get props => [
    buttonPrimaryBackground,
    buttonPrimaryHoveredBackground,
    buttonPrimaryPressedBackground,
    buttonPrimaryDisabledBackground,
    buttonSecondaryBackground,
    buttonSecondaryHoveredBackground,
    buttonDestructiveBackground,
    buttonDestructiveHoveredBackground,
    buttonSuccessBackground,
    badgePrimaryBackground,
    badgePrimaryTintedText,
    checkboxCheckedBackground,
    radioSelectedBackground,
    progressIndicator,
    sliderActiveTrack,
    inputCursor,
    segmentedControlSelectedBackground,
    tabSelectedIndicator,
    checkboxDisabledBackground,
    radioDisabledBackground,
    badgePrimaryText,
    checkboxCheckmark,
    radioDot,
    progressOnPrimaryIndicator,
    segmentedControlSelectedText,
  ];
}
