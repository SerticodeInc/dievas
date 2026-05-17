import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasEmptyState].
final class DievasEmptyStateThemeData extends Equatable {
  const DievasEmptyStateThemeData({
    required this.titleStyle,
    required this.descriptionStyle,
    required this.iconSize,
    required this.iconColor,
    required this.titleSpacing,
    required this.descriptionSpacing,
    required this.actionSpacing,
    required this.padding,
  });

  /// Text style for the empty state title.
  final TextStyle titleStyle;

  /// Text style for the empty state description.
  final TextStyle descriptionStyle;

  /// Size of the optional illustration icon.
  final double iconSize;

  /// Colour of the optional illustration icon.
  final Color iconColor;

  /// Gap between the icon and the title.
  final double titleSpacing;

  /// Gap between the title and the description.
  final double descriptionSpacing;

  /// Gap between the description and the CTA button.
  final double actionSpacing;

  /// Outer padding of the empty state layout.
  final EdgeInsets padding;

  @override
  List<Object?> get props => [
    titleStyle,
    descriptionStyle,
    iconSize,
    iconColor,
    titleSpacing,
    descriptionSpacing,
    actionSpacing,
    padding,
  ];
}
