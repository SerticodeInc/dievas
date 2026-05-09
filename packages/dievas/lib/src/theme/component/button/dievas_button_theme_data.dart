import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'dievas_button_theme_state_style.dart';
import 'dievas_button_theme_style.dart';
import 'dievas_button_theme_value.dart';

// Base
/// Sealed base for all Dievas button theme data classes.
///
/// Holds the size-keyed layout tokens shared by filled and outlined buttons.
/// The generic [T] is the concrete [DievasButtonThemeStyle] subtype for this variant.
@immutable
sealed class DievasButtonThemeData<T extends DievasButtonThemeStyle> extends Equatable with Diagnosticable {
  const DievasButtonThemeData({
    required this.textStyle,
    required this.height,
    required this.iconSize,
    required this.iconSpacing,
    required this.radius,
    required this.padding,
    required this.disabledOpacity,
    required this.style,
  });

  /// Per-size text styles — colours are baked in by the typography mapper.
  final DievasButtonThemeValue<TextStyle> textStyle;

  /// Per-size button heights in logical pixels.
  final DievasButtonThemeValue<double> height;

  /// Per-size icon sizes in logical pixels.
  final DievasButtonThemeValue<double> iconSize;

  /// Horizontal gap between icon and label text in logical pixels.
  final DievasButtonThemeValue<double> iconSpacing;

  /// Corner radii — `({Radius square, Radius pill})` per size.
  final DievasButtonThemeValue<({Radius square, Radius pill})> radius;

  /// Horizontal padding applied to the button content.
  final DievasButtonThemeValue<EdgeInsets> padding;

  /// Opacity applied to the entire button when disabled.
  final double disabledOpacity;

  /// Idle and focused style resolved from the colour token set.
  final DievasButtonThemeStateStyle<T> style;

  @override
  List<Object?> get props => [textStyle, height, iconSize, iconSpacing, radius, padding, disabledOpacity, style];

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('height', height))
      ..add(DiagnosticsProperty('iconSize', iconSize))
      ..add(DiagnosticsProperty('iconSpacing', iconSpacing))
      ..add(DiagnosticsProperty('radius', radius))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('disabledOpacity', disabledOpacity))
      ..add(DiagnosticsProperty('style', style));
  }
}

// Filled
/// Theme data for [DievasFilledButton].
@immutable
final class DievasFilledButtonThemeData extends DievasButtonThemeData<DievasFilledButtonThemeStyle> {
  const DievasFilledButtonThemeData({
    required super.textStyle,
    required super.height,
    required super.iconSize,
    required super.iconSpacing,
    required super.radius,
    required super.padding,
    required super.disabledOpacity,
    required super.style,
  });
}

// Outlined
/// Theme data for [DievasOutlinedButton].
@immutable
final class DievasOutlinedButtonThemeData extends DievasButtonThemeData<DievasOutlinedButtonThemeStyle> {
  const DievasOutlinedButtonThemeData({
    required super.textStyle,
    required super.height,
    required super.iconSize,
    required super.iconSpacing,
    required super.radius,
    required super.padding,
    required super.disabledOpacity,
    required super.style,
  });
}

// Text
/// Theme data for [DievasTextButton].
///
/// Simpler than filled/outlined — no height, padding, or radius tokens since
/// the text button sizes itself to its content.
@immutable
final class DievasTextButtonThemeData extends Equatable with Diagnosticable {
  const DievasTextButtonThemeData({
    required this.textStyle,
    required this.iconSize,
    required this.iconSpacing,
    required this.disabledOpacity,
    required this.style,
  });

  /// Per-size text styles.
  final DievasButtonThemeValue<TextStyle> textStyle;

  /// Per-size icon sizes.
  final DievasButtonThemeValue<double> iconSize;

  /// Gap between icon and label.
  final DievasButtonThemeValue<double> iconSpacing;

  /// Opacity when disabled.
  final double disabledOpacity;

  /// Idle and focused foreground colours.
  final DievasTextButtonThemeStateStyle style;

  @override
  List<Object?> get props => [textStyle, iconSize, iconSpacing, disabledOpacity, style];

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('iconSize', iconSize))
      ..add(DiagnosticsProperty('iconSpacing', iconSpacing))
      ..add(DoubleProperty('disabledOpacity', disabledOpacity))
      ..add(DiagnosticsProperty('style', style));
  }
}

// Icon Button
/// Theme data for [DievasIconButton].
@immutable
final class DievasIconButtonThemeData extends Equatable with Diagnosticable {
  const DievasIconButtonThemeData({
    required this.size,
    required this.iconSize,
    required this.radius,
    required this.disabledOpacity,
    required this.style,
  });

  /// Per-size container dimensions (width = height).
  final DievasButtonThemeValue<double> size;

  /// Per-size icon sizes.
  final DievasButtonThemeValue<double> iconSize;

  /// Per-size corner radii.
  final DievasButtonThemeValue<Radius> radius;

  /// Opacity when disabled.
  final double disabledOpacity;

  /// Idle and focused style.
  final DievasIconButtonThemeStateStyle style;

  @override
  List<Object?> get props => [size, iconSize, radius, disabledOpacity, style];

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('size', size))
      ..add(DiagnosticsProperty('iconSize', iconSize))
      ..add(DiagnosticsProperty('radius', radius))
      ..add(DoubleProperty('disabledOpacity', disabledOpacity))
      ..add(DiagnosticsProperty('style', style));
  }
}
