import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'dievas_button_theme_data.dart';

/// Aggregates the per-style [DievasTextButtonThemeData] variants.
///
/// Consumed by the component mapper and read by [DievasTextButton] via
/// `DievasTheme.componentsOf(context).textButton`.
@immutable
final class DievasTextButtonGroupThemeData extends Equatable with Diagnosticable {
  const DievasTextButtonGroupThemeData({
    required this.primary,
    required this.destructive,
  });

  /// Primary text action — brand foreground colour.
  final DievasTextButtonThemeData primary;

  /// Destructive text action — error foreground colour.
  final DievasTextButtonThemeData destructive;

  @override
  List<Object?> get props => [primary, destructive];

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('destructive', destructive));
  }
}
