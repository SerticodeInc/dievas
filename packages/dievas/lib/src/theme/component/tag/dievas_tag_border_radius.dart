import 'package:flutter/painting.dart';

/// Defines the border radius shape for [DievasTag].
///
/// Use [DievasTagBorderRadius.pill] for fully rounded (pill-shaped) tags,
/// or [DievasTagBorderRadius.rounded] for a specific [BorderRadius].
sealed class DievasTagBorderRadius {
  const DievasTagBorderRadius._();

  /// Fully rounded pill shape — radius is half the container height.
  static const DievasTagBorderRadius pill = _PillTagBorderRadius();

  /// A specific [BorderRadius].
  const factory DievasTagBorderRadius.rounded(BorderRadius radius) =
      _RoundedTagBorderRadius;

  /// Resolves to a concrete [BorderRadius] for the given container height.
  BorderRadius resolve(double containerHeight) => switch (this) {
    _PillTagBorderRadius() =>
      BorderRadius.circular(containerHeight / 2),
    _RoundedTagBorderRadius(:final radius) => radius,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DievasTagBorderRadius) return false;
    return switch ((this, other)) {
      (_PillTagBorderRadius(), _PillTagBorderRadius()) => true,
      (_RoundedTagBorderRadius(radius: var r1), _RoundedTagBorderRadius(radius: var r2)) => r1 == r2,
      _ => false,
    };
  }

  @override
  int get hashCode => switch (this) {
    _PillTagBorderRadius() => 0,
    _RoundedTagBorderRadius(:final radius) => radius.hashCode,
  };
}

final class _PillTagBorderRadius extends DievasTagBorderRadius {
  const _PillTagBorderRadius() : super._();
}

final class _RoundedTagBorderRadius extends DievasTagBorderRadius {
  const _RoundedTagBorderRadius(this.radius) : super._();

  final BorderRadius radius;
}
