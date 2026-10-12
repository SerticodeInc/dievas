import 'package:meta/meta.dart';

/// Size-keyed value record for Dievas button theme properties.
///
/// Used to hold per-size variants of any theme value — e.g. `TextStyle`,
/// `double`, `EdgeInsets` — indexed by [DievasButtonSize].
///
/// ```dart
/// final DievasButtonThemeValue<double> height = (SM: 32, MD: 40, LG: 48);
/// ```
@internal
typedef DievasButtonThemeValue<T> = ({T SM, T MD, T LG});
