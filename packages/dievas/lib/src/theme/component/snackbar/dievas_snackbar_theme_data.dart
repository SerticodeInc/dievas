import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Theme data for [DievasSnackbar].
final class DievasSnackbarThemeData extends Equatable {
  const DievasSnackbarThemeData({
    required this.messageStyle,
    required this.actionStyle,
    required this.iconSize,
    required this.iconSpacing,
    required this.padding,
    required this.borderRadius,
    required this.minWidth,
    required this.maxWidth,
    required this.bottomInset,
  });

  /// Text style for the snackbar message.
  final TextStyle messageStyle;

  /// Text style for the optional action label.
  final TextStyle actionStyle;

  /// Size of the optional leading icon.
  final double iconSize;

  /// Gap between icon and message.
  final double iconSpacing;

  /// Inner padding of the snackbar surface.
  final EdgeInsets padding;

  /// Corner radius of the snackbar container.
  final BorderRadius borderRadius;

  /// Minimum width of the snackbar.
  final double minWidth;

  /// Maximum width the snackbar may grow to before clipping.
  final double maxWidth;

  /// Distance from the bottom edge of the viewport.
  final double bottomInset;

  @override
  List<Object?> get props => [
    messageStyle,
    actionStyle,
    iconSize,
    iconSpacing,
    padding,
    borderRadius,
    minWidth,
    maxWidth,
    bottomInset,
  ];
}
