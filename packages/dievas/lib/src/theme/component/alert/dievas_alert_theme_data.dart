import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasAlert].
///
/// Controls layout, typography, and icon sizing. Colour is resolved dynamically
/// from the active [DievasColourThemeData] based on the alert tone.
final class DievasAlertThemeData extends Equatable {
  const DievasAlertThemeData({
    required this.titleStyle,
    required this.bodyStyle,
    required this.iconSize,
    required this.iconSpacing,
    required this.padding,
    required this.borderRadius,
    required this.borderWidth,
    required this.dismissIconSize,
  });

  /// Text style for the alert title.
  final TextStyle titleStyle;

  /// Text style for the alert body / description.
  final TextStyle bodyStyle;

  /// Size of the leading tone icon.
  final double iconSize;

  /// Horizontal gap between the tone icon and the text column.
  final double iconSpacing;

  /// Inner padding of the alert surface.
  final EdgeInsets padding;

  /// Corner radius of the alert container.
  final BorderRadius borderRadius;

  /// Width of the alert border stroke.
  final double borderWidth;

  /// Size of the dismiss (×) icon button.
  final double dismissIconSize;

  @override
  List<Object?> get props => [
    titleStyle,
    bodyStyle,
    iconSize,
    iconSpacing,
    padding,
    borderRadius,
    borderWidth,
    dismissIconSize,
  ];
}
