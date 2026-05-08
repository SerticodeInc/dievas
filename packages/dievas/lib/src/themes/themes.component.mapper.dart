part of '../themes.dart';

/// Derives [DievasComponentThemeData] from all token sub-systems.
///
/// This mapper is the single place where component-level theme objects are
/// constructed. It accepts the full token sub-system set and an optional
/// [override] from [DievasThemeData.copyWith].
///
/// As components are built in Milestone 3 and 4, their theme constructors
/// are called here — this file grows with the component library.
DievasComponentThemeData _deriveDievasComponentThemeData(
  DievasColourThemeData colors,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
  DievasComponentThemeData? override,
) {
  // Skeleton — will be populated as components land in M3/M4.
  final derived = const DievasComponentThemeData();

  if (override == null) return derived;
  return derived.copyWith();
}
