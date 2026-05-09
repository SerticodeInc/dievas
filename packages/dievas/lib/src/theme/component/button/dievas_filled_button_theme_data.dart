import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'dievas_button_theme_data.dart';

/// Aggregates the per-style [DievasFilledButtonThemeData] variants.
///
/// Consumed by the component mapper and read by [DievasButton] via
/// `DievasTheme.componentsOf(context).filledButton`.
@immutable
final class DievasFilledButtonGroupThemeData extends Equatable with Diagnosticable {
  const DievasFilledButtonGroupThemeData({
    required this.primary,
    required this.secondary,
    required this.destructive,
  });

  /// Primary call-to-action — brand colour background.
  final DievasFilledButtonThemeData primary;

  /// Secondary variant — subdued background.
  final DievasFilledButtonThemeData secondary;

  /// Destructive action — error-red background.
  final DievasFilledButtonThemeData destructive;

  @override
  List<Object?> get props => [primary, secondary, destructive];

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('secondary', secondary))
      ..add(DiagnosticsProperty('destructive', destructive));
  }
}
