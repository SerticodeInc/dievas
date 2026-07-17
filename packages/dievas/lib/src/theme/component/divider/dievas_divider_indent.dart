import 'package:dievas_tokens/dievas_tokens.dart';

/// Defines the indent offset for [DievasDivider].
///
/// Use the named constants (e.g. [none], [md], [lg]) for token-aligned
/// spacing on the 4px grid, or [DievasDividerIndent.custom] for a raw value
/// (useful when the exact spacing doesn't match a token).
///
/// If using [custom] for one side, use it for the other side as well
/// to keep both indents consistent.
///
/// ```dart
/// DievasDivider(indent: DievasDividerIndent.md)
/// DievasDivider(indent: DievasDividerIndent.custom(6), endIndent: DievasDividerIndent.custom(6))
/// ```
sealed class DievasDividerIndent {
  const DievasDividerIndent._();

  /// All predefined indent values, ordered smallest to largest.
  static const List<DievasDividerIndent> values = [none, xs, sm, smPlus, md, mdPlus, lg, xl, x2l, x3l];

  /// 0dp.
  static const DievasDividerIndent none = _DievasDividerIndent(DievasSpacingPrimitives.s0);

  /// 4dp.
  static const DievasDividerIndent xs = _DievasDividerIndent(DievasSpacingPrimitives.s1);

  /// 8dp.
  static const DievasDividerIndent sm = _DievasDividerIndent(DievasSpacingPrimitives.s2);

  /// 12dp.
  static const DievasDividerIndent smPlus = _DievasDividerIndent(DievasSpacingPrimitives.s3);

  /// 16dp.
  static const DievasDividerIndent md = _DievasDividerIndent(DievasSpacingPrimitives.s4);

  /// 20dp.
  static const DievasDividerIndent mdPlus = _DievasDividerIndent(DievasSpacingPrimitives.s5);

  /// 24dp.
  static const DievasDividerIndent lg = _DievasDividerIndent(DievasSpacingPrimitives.s6);

  /// 32dp.
  static const DievasDividerIndent xl = _DievasDividerIndent(DievasSpacingPrimitives.s8);

  /// 48dp.
  static const DievasDividerIndent x2l = _DievasDividerIndent(DievasSpacingPrimitives.s12);

  /// 64dp.
  static const DievasDividerIndent x3l = _DievasDividerIndent(DievasSpacingPrimitives.s16);

  /// A custom raw value in logical pixels.
  const factory DievasDividerIndent.custom(double value) = _DievasDividerIndent;

  /// Resolves to the concrete indent value in logical pixels.
  double resolve() => switch (this) {
    _DievasDividerIndent(:final value) => value,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DievasDividerIndent) return false;
    return resolve() == other.resolve();
  }

  @override
  int get hashCode => resolve().hashCode;
}

final class _DievasDividerIndent extends DievasDividerIndent {
  const _DievasDividerIndent(this.value) : super._();

  final double value;
}
