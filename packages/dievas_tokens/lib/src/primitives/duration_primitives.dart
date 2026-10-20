/// Raw duration primitives for the Dievas motion system. Pure Dart, no Flutter.
/// Millisecond values carry no semantic meaning on their own; semantic
/// animation tokens alias them into roles.
abstract final class DievasDurationPrimitives {
  /// 50ms micro interactions, ripples, press feedback.
  static const Duration d50 = Duration(milliseconds: 50);

  /// 100ms very quick transitions, state changes.
  static const Duration d100 = Duration(milliseconds: 100);

  /// 150ms subtle fades, colour shifts.
  static const Duration d150 = Duration(milliseconds: 150);

  /// 200ms standard UI transitions (toggle, accordion, popover).
  static const Duration d200 = Duration(milliseconds: 200);

  /// 250ms moderate transitions (drawer slide, panel reveal).
  static const Duration d250 = Duration(milliseconds: 250);

  /// 300ms emphasized transitions (modal entry, page transitions).
  static const Duration d300 = Duration(milliseconds: 300);

  /// 400ms leisurely transitions (hero animations, large elements).
  static const Duration d400 = Duration(milliseconds: 400);

  /// 500ms tooltip wait, brief feedback pauses.
  static const Duration d500 = Duration(milliseconds: 500);

  /// 800ms extended motion.
  static const Duration d800 = Duration(milliseconds: 800);

  /// 1000ms / 1s noticeable delays and auto dismiss timers.
  static const Duration d1000 = Duration(milliseconds: 1000);

  /// 2000ms / 2s tooltip show duration, longer feedback pauses.
  static const Duration d2000 = Duration(milliseconds: 2000);

  /// 2222ms relaxed loader rotation, matching Moon circular loader timing.
  static const Duration d2222 = Duration(milliseconds: 2222);

  /// 3000ms / 3s snackbar auto dismiss, temporary notifications.
  static const Duration d3000 = Duration(milliseconds: 3000);

  /// 5000ms / 5s lengthy auto dismiss timers.
  static const Duration d5000 = Duration(milliseconds: 5000);
}
