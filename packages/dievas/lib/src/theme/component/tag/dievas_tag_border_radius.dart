import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:flutter/painting.dart';

/// Defines the border radius shape for [DievasTag].
///
/// Use [DievasTagBorderRadius.pill] for fully rounded (pill-shaped) tags,
/// or [DievasTagBorderRadius.rounded] for a specific or directional [BorderRadiusGeometry].
sealed class DievasTagBorderRadius {
  const DievasTagBorderRadius._();

  /// Fully rounded pill shape.
  static const DievasTagBorderRadius pill = _PillTagBorderRadius();

  /// A specific or directional radius, resolved in the tag’s text direction.
  const factory DievasTagBorderRadius.rounded(BorderRadiusGeometry radius) = _RoundedTagBorderRadius;

  /// Resolves to a concrete [BorderRadius].
  BorderRadius resolve([TextDirection direction = TextDirection.ltr]) => switch (this) {
    _PillTagBorderRadius() => BorderRadius.circular(DievasRadiusSemantic.full),
    _RoundedTagBorderRadius(:final radius) => radius.resolve(direction),
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return switch ((this, other)) {
      (_PillTagBorderRadius(), _PillTagBorderRadius()) => true,
      (_RoundedTagBorderRadius(radius: final r1), _RoundedTagBorderRadius(radius: final r2)) => r1 == r2,
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

  final BorderRadiusGeometry radius;
}
