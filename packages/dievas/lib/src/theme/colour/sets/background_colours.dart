import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Colours named by the element, variant or state, and painted property.
final class BackgroundColours extends Equatable {
  const BackgroundColours({
    required this.pageBackground,
    required this.cardBackground,
    required this.dialogBackground,
    required this.modalBarrierBackground,
    required this.bottomSheetBackground,
    required this.tooltipBackground,
    required this.drawerBackground,
    required this.menuBackground,
    required this.popoverBackground,
    required this.snackbarBackground,
    required this.tagBackground,
    required this.badgeNeutralFilledBackground,
    required this.iconButtonFocusedBackground,
    required this.listItemSelectedBackground,
    required this.badgeNeutralTintedBackground,
    required this.iconButtonBackground,
    required this.progressTrack,
    required this.segmentedControlBackground,
  });

  final Color pageBackground;
  final Color cardBackground;
  final Color dialogBackground;
  final Color modalBarrierBackground;
  final Color bottomSheetBackground;
  final Color tooltipBackground;
  final Color drawerBackground;
  final Color menuBackground;
  final Color popoverBackground;
  final Color snackbarBackground;
  final Color tagBackground;
  final Color badgeNeutralFilledBackground;
  final Color iconButtonFocusedBackground;
  final Color listItemSelectedBackground;
  final Color badgeNeutralTintedBackground;
  final Color iconButtonBackground;
  final Color progressTrack;
  final Color segmentedControlBackground;

  BackgroundColours copyWith({
    Color? pageBackground,
    Color? cardBackground,
    Color? dialogBackground,
    Color? modalBarrierBackground,
    Color? bottomSheetBackground,
    Color? tooltipBackground,
    Color? drawerBackground,
    Color? menuBackground,
    Color? popoverBackground,
    Color? snackbarBackground,
    Color? tagBackground,
    Color? badgeNeutralFilledBackground,
    Color? iconButtonFocusedBackground,
    Color? listItemSelectedBackground,
    Color? badgeNeutralTintedBackground,
    Color? iconButtonBackground,
    Color? progressTrack,
    Color? segmentedControlBackground,
  }) => BackgroundColours(
    pageBackground: pageBackground ?? this.pageBackground,
    cardBackground: cardBackground ?? this.cardBackground,
    dialogBackground: dialogBackground ?? this.dialogBackground,
    modalBarrierBackground: modalBarrierBackground ?? this.modalBarrierBackground,
    bottomSheetBackground: bottomSheetBackground ?? this.bottomSheetBackground,
    tooltipBackground: tooltipBackground ?? this.tooltipBackground,
    drawerBackground: drawerBackground ?? this.drawerBackground,
    menuBackground: menuBackground ?? this.menuBackground,
    popoverBackground: popoverBackground ?? this.popoverBackground,
    snackbarBackground: snackbarBackground ?? this.snackbarBackground,
    tagBackground: tagBackground ?? this.tagBackground,
    badgeNeutralFilledBackground: badgeNeutralFilledBackground ?? this.badgeNeutralFilledBackground,
    iconButtonFocusedBackground: iconButtonFocusedBackground ?? this.iconButtonFocusedBackground,
    listItemSelectedBackground: listItemSelectedBackground ?? this.listItemSelectedBackground,
    badgeNeutralTintedBackground: badgeNeutralTintedBackground ?? this.badgeNeutralTintedBackground,
    iconButtonBackground: iconButtonBackground ?? this.iconButtonBackground,
    progressTrack: progressTrack ?? this.progressTrack,
    segmentedControlBackground: segmentedControlBackground ?? this.segmentedControlBackground,
  );

  static BackgroundColours lerp(BackgroundColours a, BackgroundColours b, double t) => BackgroundColours(
    pageBackground: Color.lerp(a.pageBackground, b.pageBackground, t) as Color,
    cardBackground: Color.lerp(a.cardBackground, b.cardBackground, t) as Color,
    dialogBackground: Color.lerp(a.dialogBackground, b.dialogBackground, t) as Color,
    modalBarrierBackground: Color.lerp(a.modalBarrierBackground, b.modalBarrierBackground, t) as Color,
    bottomSheetBackground: Color.lerp(a.bottomSheetBackground, b.bottomSheetBackground, t) as Color,
    tooltipBackground: Color.lerp(a.tooltipBackground, b.tooltipBackground, t) as Color,
    drawerBackground: Color.lerp(a.drawerBackground, b.drawerBackground, t) as Color,
    menuBackground: Color.lerp(a.menuBackground, b.menuBackground, t) as Color,
    popoverBackground: Color.lerp(a.popoverBackground, b.popoverBackground, t) as Color,
    snackbarBackground: Color.lerp(a.snackbarBackground, b.snackbarBackground, t) as Color,
    tagBackground: Color.lerp(a.tagBackground, b.tagBackground, t) as Color,
    badgeNeutralFilledBackground:
        Color.lerp(a.badgeNeutralFilledBackground, b.badgeNeutralFilledBackground, t) as Color,
    iconButtonFocusedBackground: Color.lerp(a.iconButtonFocusedBackground, b.iconButtonFocusedBackground, t) as Color,
    listItemSelectedBackground: Color.lerp(a.listItemSelectedBackground, b.listItemSelectedBackground, t) as Color,
    badgeNeutralTintedBackground:
        Color.lerp(a.badgeNeutralTintedBackground, b.badgeNeutralTintedBackground, t) as Color,
    iconButtonBackground: Color.lerp(a.iconButtonBackground, b.iconButtonBackground, t) as Color,
    progressTrack: Color.lerp(a.progressTrack, b.progressTrack, t) as Color,
    segmentedControlBackground: Color.lerp(a.segmentedControlBackground, b.segmentedControlBackground, t) as Color,
  );

  @override
  List<Object?> get props => [
    pageBackground,
    cardBackground,
    dialogBackground,
    modalBarrierBackground,
    bottomSheetBackground,
    tooltipBackground,
    drawerBackground,
    menuBackground,
    popoverBackground,
    snackbarBackground,
    tagBackground,
    badgeNeutralFilledBackground,
    iconButtonFocusedBackground,
    listItemSelectedBackground,
    badgeNeutralTintedBackground,
    iconButtonBackground,
    progressTrack,
    segmentedControlBackground,
  ];
}
