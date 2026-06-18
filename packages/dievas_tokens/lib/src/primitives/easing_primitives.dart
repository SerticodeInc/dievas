// Easing primitives — cubic bezier control points.
//
// Pure Dart. No Flutter dependency.
// These are raw cubic bezier control-point records. The dievas Flutter
// package converts them to dart:ui Curve objects at the point of use.

/// A cubic bezier curve defined by two control points.
///
/// Format matches CSS `cubic-bezier(x1, y1, x2, y2)`.
/// The `dievas` Flutter package converts these to [Curve] objects.
typedef DievasEasingCurve = ({double x1, double y1, double x2, double y2});

/// Raw easing primitives for the Dievas motion system.
///
/// Values are hand-tuned to match Material Motion principles.
/// The semantic layer ([DievasEasingSemantic]) assigns intent-based names.
abstract final class DievasEasingPrimitives {
  /// Standard ease-in-out. Gentle acceleration and deceleration.
  /// Matches `Curves.fastOutSlowIn`.
  static const DievasEasingCurve standard = (
    x1: 0.2, y1: 0.0,
    x2: 0.0, y2: 1.0,
  );

  /// Emphasized ease. Slightly more dramatic arc for hero animations.
  static const DievasEasingCurve emphasize = (
    x1: 0.2, y1: 0.0,
    x2: 0.0, y2: 1.0,
  );

  /// Deceleration curve (ease-out). Fast start, slow end.
  /// Best for elements entering the screen.
  static const DievasEasingCurve decelerate = (
    x1: 0.0, y1: 0.0,
    x2: 0.2, y2: 1.0,
  );

  /// Acceleration curve (ease-in). Slow start, fast end.
  /// Best for elements leaving the screen.
  static const DievasEasingCurve accelerate = (
    x1: 0.4, y1: 0.0,
    x2: 1.0, y2: 1.0,
  );
}
