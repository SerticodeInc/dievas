import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasBadge].
///
/// Holds layout and typography tokens. Colour is resolved dynamically in the
/// widget from [DievasColourThemeData] based on the badge's [DievasBadgeStyle]
/// and [DievasBadgeTone] — pre-baking 15 colour combinations into the mapper
/// would add noise without architectural benefit.
final class DievasBadgeThemeData extends Equatable {
  const DievasBadgeThemeData({
    required this.textStyle,
    required this.borderRadius,
    required this.padding,
    required this.iconSize,
    required this.iconSpacing,
  });

  /// Label text style — typically [DievasTypographyThemeData.labelXs].
  final TextStyle textStyle;

  /// Container corner radius — pill shape for badges.
  final BorderRadius borderRadius;

  /// Inner padding applied to the badge container.
  final EdgeInsets padding;

  /// Leading icon size (dp).
  final double iconSize;

  /// Gap between leading icon and label text (dp).
  final double iconSpacing;

  @override
  List<Object?> get props => [textStyle, borderRadius, padding, iconSize, iconSpacing];
}
