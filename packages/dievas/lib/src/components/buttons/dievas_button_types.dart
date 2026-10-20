import 'package:meta/meta.dart';

/// Available sizes for Dievas button components.
///
/// Maps to the `sm / md / lg` keys in [DievasButtonThemeValue].
enum DievasButtonSize {
  /// 32px height — compact contexts, toolbars.
  sm,

  /// 40px height — default for most surfaces.
  md,

  /// 48px height — prominent CTAs, hero sections.
  lg,
}

/// Interaction states for Dievas button components.
enum DievasButtonState {
  /// Default resting state — button is interactive.
  idle,

  /// Async operation in progress — button shows a loading indicator
  /// and ignores tap events.
  loading,

  /// Button is non-interactive — tap events are ignored.
  disabled,
}

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
  /// Neutral border and primary foreground.
  primary,

  /// Error-red border and foreground.
  destructive,
}

/// Controls how a leading or trailing icon's colour behaves during interaction.
enum DievasButtonIconStyleBehavior {
  /// The icon colour follows the button's foreground state colour.
  ///
  /// This is the default. Suitable for monochrome icon assets.
  inheritFromState,

  /// The icon renders with its own intrinsic colour unchanged.
  ///
  /// Use this for multi-colour icons that should not be tinted.
  maintainOriginal,
}

/// Visual style variants for [DievasTextButton].
enum DievasTextButtonStyle {
  /// Secondary foreground — primary inline action.
  primary,

  /// Error-red foreground — destructive inline action.
  destructive,
}

/// Visual style variants for [DievasIconButton].
///
/// The variants differ only by container: [ghost] is transparent, [tinted] sits
/// on a subtle surface fill. Both share the same icon colour.
enum DievasIconButtonStyle {
  /// Transparent background — icon only.
  ghost,

  /// Subtle surface fill behind the icon.
  tinted,
}
