// Offset primitives — shadow offset values.
//
// Raw double values representing logical pixel offsets for shadow positioning.
// No Flutter dependency - Offset construction happens in the dievas Flutter package.

/// Raw offset values for shadow positioning.
abstract final class DievasOffsetPrimitives {
  /// 0px horizontal, 1px vertical — subtle drop shadow.
  static const double y1 = 1.0;

  /// 0px horizontal, 2px vertical — small elevation.
  static const double y2 = 2.0;

  /// 0px horizontal, 4px vertical — medium elevation.
  static const double y4 = 4.0;

  /// 0px horizontal, 8px vertical — large elevation.
  static const double y8 = 8.0;

  /// 0px horizontal, 16px vertical — extra-large elevation.
  static const double y16 = 16.0;
}