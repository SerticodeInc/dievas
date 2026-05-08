// Elevation primitives — shadow blur radii on a geometric scale.
//
// Each value is a raw double representing a shadow blur radius in logical
// pixels. No Flutter dependency. BoxShadow construction (which needs
// dart:ui Color and Offset) happens in the dievas Flutter package.
//
// Scale naming: e0 (flat) → e5 (highest). Steps are chosen to produce
// perceptually even shadow jumps across the range 0–24px.

/// Raw elevation scale for the Dievas design system.
///
/// These are the atomic blur-radius values. Nothing in the app references
/// them directly — consume [DievasElevationSemantic] instead.
abstract final class DievasElevationPrimitives {
  /// 0px — no shadow.
  static const double e0 = 0.0;

  /// 2px — hairline shadow.
  static const double e1 = 2.0;

  /// 4px — subtle lift.
  static const double e2 = 4.0;

  /// 8px — medium raise.
  static const double e3 = 8.0;

  /// 16px — prominent float.
  static const double e4 = 16.0;

  /// 24px — maximum depth. Modals, bottom sheets.
  static const double e5 = 24.0;
}
