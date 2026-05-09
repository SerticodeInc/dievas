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
