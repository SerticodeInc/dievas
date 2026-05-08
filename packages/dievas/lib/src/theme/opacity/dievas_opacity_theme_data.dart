import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:equatable/equatable.dart';

/// The opacity sub-system for a Dievas theme.
///
/// Values are fractions in [0.0, 1.0], consumed by [Opacity] widgets,
/// [Color.withOpacity], and animation curves.
final class DievasOpacityThemeData extends Equatable {
  const DievasOpacityThemeData({
    this.disabled = DievasOpacitySemantic.disabled,
    this.hoverGhost = DievasOpacitySemantic.hoverGhost,
    this.pressedGhost = DievasOpacitySemantic.pressedGhost,
    this.focusRing = DievasOpacitySemantic.focusRing,
    this.overlay = DievasOpacitySemantic.overlay,
    this.transparent = DievasOpacitySemantic.transparent,
    this.opaque = DievasOpacitySemantic.opaque,
  });

  /// 40% — disabled interactive elements (buttons, inputs, icons).
  final double disabled;

  /// 8% — ghost hover surface tint (icon buttons, list tiles).
  final double hoverGhost;

  /// 16% — pressed / active surface tint.
  final double pressedGhost;

  /// 10% — focus ring fill.
  final double focusRing;

  /// 56% — modal / bottom sheet scrim overlay.
  final double overlay;

  /// 0% — fully transparent. Animation start states.
  final double transparent;

  /// 100% — fully opaque. Animation end states and solid surfaces.
  final double opaque;

  DievasOpacityThemeData copyWith({
    double? disabled,
    double? hoverGhost,
    double? pressedGhost,
    double? focusRing,
    double? overlay,
    double? transparent,
    double? opaque,
  }) => DievasOpacityThemeData(
    disabled: disabled ?? this.disabled,
    hoverGhost: hoverGhost ?? this.hoverGhost,
    pressedGhost: pressedGhost ?? this.pressedGhost,
    focusRing: focusRing ?? this.focusRing,
    overlay: overlay ?? this.overlay,
    transparent: transparent ?? this.transparent,
    opaque: opaque ?? this.opaque,
  );

  @override
  List<Object?> get props => [disabled, hoverGhost, pressedGhost, focusRing, overlay, transparent, opaque];
}
