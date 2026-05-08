import 'package:equatable/equatable.dart';

/// The component-level theme sub-system for a Dievas theme.
///
/// This is the skeleton that gets filled out in Milestone 3 and 4 as
/// components are built. Each component will add its own `ThemeData` field
/// here (e.g. `DievasButtonThemeData buttonTheme`).
///
/// The component mapper (`themes.component.mapper.dart`) derives all fields
/// from the token sub-systems so components read consistent values.
///
/// Example of what a filled-out field looks like:
/// ```dart
/// final DievasButtonThemeData buttonTheme;
/// ```
final class DievasComponentThemeData extends Equatable {
  const DievasComponentThemeData();

  DievasComponentThemeData copyWith() => const DievasComponentThemeData();

  @override
  List<Object?> get props => const [];
}
