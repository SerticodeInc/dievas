import 'package:meta/meta.dart';

/// Sealed base for all Dievas button style discriminators.
///
/// Button variant widgets accept a concrete subtype:
/// - [DievasFilledButton] → [DievasFilledButtonStyle]
/// - [DievasOutlinedButton] → [DievasOutlinedButtonStyle]
///
/// The internal [DievasButton] base widget takes [DievasButtonStyle] and
/// dispatches to the correct [DievasComponentThemeData] slot.
sealed class DievasButtonStyle implements Enum {
  @visibleForTesting
  static const List<DievasButtonStyle> values = [
    ...DievasFilledButtonStyle.values,
    ...DievasOutlinedButtonStyle.values,
  ];
}

/// Visual style variants for [DievasFilledButton].
enum DievasFilledButtonStyle implements DievasButtonStyle {
  /// Brand-colour background — primary call to action.
  primary,

  /// Subdued background — secondary action.
  secondary,

  /// Error-red background — destructive or irreversible action.
  destructive,
}

/// Visual style variants for [DievasOutlinedButton].
enum DievasOutlinedButtonStyle implements DievasButtonStyle {
  /// Brand-coloured border and foreground.
  primary,

  /// Error-red border and foreground.
  destructive,
}
