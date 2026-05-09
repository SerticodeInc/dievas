import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'dievas_button_theme_data.dart';

/// Aggregates the per-style [DievasIconButtonThemeData] variants.
///
/// Consumed by the component mapper and read by [DievasIconButton] via
/// `DievasTheme.componentsOf(context).iconButton`.
@immutable
final class DievasIconButtonGroupThemeData extends Equatable with Diagnosticable {
  const DievasIconButtonGroupThemeData({
    required this.ghost,
    required this.tinted,
  });

  /// No background — icon only. Default style.
  final DievasIconButtonThemeData ghost;

  /// Tinted background matching the action primary surface.
  final DievasIconButtonThemeData tinted;

  @override
  List<Object?> get props => [ghost, tinted];

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('ghost', ghost))
      ..add(DiagnosticsProperty('tinted', tinted));
  }
}
