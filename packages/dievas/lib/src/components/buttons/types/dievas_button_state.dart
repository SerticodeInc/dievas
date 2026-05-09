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
