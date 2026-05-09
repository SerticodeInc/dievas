import 'package:meta/meta.dart';

/// Size-keyed value record for Dievas button theme properties.
///
/// Used to hold per-size variants of any theme value — e.g. `TextStyle`,
/// `double`, `EdgeInsets` — indexed by [DievasButtonSize].
///
/// ```dart
/// final DievasButtonThemeValue<double> height = (sm: 32, md: 40, lg: 48);
/// ```
@internal
typedef DievasButtonThemeValue<T> = ({T sm, T md, T lg});
