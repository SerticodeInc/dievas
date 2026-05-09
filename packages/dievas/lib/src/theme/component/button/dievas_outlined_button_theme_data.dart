import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'dievas_button_theme_data.dart';

/// Aggregates the per-style [DievasOutlinedButtonThemeData] variants.
///
/// Consumed by the component mapper and read by [DievasButton] via
/// `DievasTheme.componentsOf(context).outlinedButton`.
@immutable
final class DievasOutlinedButtonGroupThemeData extends Equatable with Diagnosticable {
  const DievasOutlinedButtonGroupThemeData({
    required this.primary,
    required this.destructive,
  });

  /// Primary outlined variant — brand-coloured border and foreground.
  final DievasOutlinedButtonThemeData primary;

  /// Destructive outlined variant — error-coloured border and foreground.
  final DievasOutlinedButtonThemeData destructive;

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
