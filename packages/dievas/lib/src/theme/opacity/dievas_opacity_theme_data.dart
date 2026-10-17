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
    this.O0 = DievasOpacitySemantic.O0,
    this.O4 = DievasOpacitySemantic.O4,
    this.O8 = DievasOpacitySemantic.O8,
    this.O12 = DievasOpacitySemantic.O12,
    this.O16 = DievasOpacitySemantic.O16,
    this.O20 = DievasOpacitySemantic.O20,
    this.O24 = DievasOpacitySemantic.O24,
    this.O28 = DievasOpacitySemantic.O28,
    this.O32 = DievasOpacitySemantic.O32,
    this.O40 = DievasOpacitySemantic.O40,
    this.O48 = DievasOpacitySemantic.O48,
    this.O56 = DievasOpacitySemantic.O56,
    this.O64 = DievasOpacitySemantic.O64,
    this.O72 = DievasOpacitySemantic.O72,
    this.O80 = DievasOpacitySemantic.O80,
    this.O88 = DievasOpacitySemantic.O88,
    this.O96 = DievasOpacitySemantic.O96,
    this.O100 = DievasOpacitySemantic.O100,
  });

  /// 40% — disabled interactive elements (buttons, inputs, icons).
  final double disabled;

  /// 8% — ghost hover surface tint (icon buttons, list tiles).
  final double hoverGhost;

  /// 16% — pressed / active surface tint.
  final double pressedGhost;

  /// 12% — focus ring fill.
  final double focusRing;

  /// 56% — modal / bottom sheet scrim overlay.
  final double overlay;

  /// 0% — fully transparent. Animation start states.
  final double transparent;

  /// 100% — fully opaque. Animation end states and solid surfaces.
  final double opaque;

  /// 0%.
  final double O0;

  /// 4%.
  final double O4;

  /// 8%.
  final double O8;

  /// 12%.
  final double O12;

  /// 16%.
  final double O16;

  /// 20%.
  final double O20;

  /// 24%.
  final double O24;

  /// 28%.
  final double O28;

  /// 32%.
  final double O32;

  /// 40%.
  final double O40;

  /// 48%.
  final double O48;

  /// 56%.
  final double O56;

  /// 64%.
  final double O64;

  /// 72%.
  final double O72;

  /// 80%.
  final double O80;

  /// 88%.
  final double O88;

  /// 96%.
  final double O96;

  /// 100%.
  final double O100;

  DievasOpacityThemeData copyWith({
    double? disabled,
    double? hoverGhost,
    double? pressedGhost,
    double? focusRing,
    double? overlay,
    double? transparent,
    double? opaque,
    double? O0,
    double? O4,
    double? O8,
    double? O12,
    double? O16,
    double? O20,
    double? O24,
    double? O28,
    double? O32,
    double? O40,
    double? O48,
    double? O56,
    double? O64,
    double? O72,
    double? O80,
    double? O88,
    double? O96,
    double? O100,
  }) => DievasOpacityThemeData(
    disabled: disabled ?? this.disabled,
    hoverGhost: hoverGhost ?? this.hoverGhost,
    pressedGhost: pressedGhost ?? this.pressedGhost,
    focusRing: focusRing ?? this.focusRing,
    overlay: overlay ?? this.overlay,
    transparent: transparent ?? this.transparent,
    opaque: opaque ?? this.opaque,
    O0: O0 ?? this.O0,
    O4: O4 ?? this.O4,
    O8: O8 ?? this.O8,
    O12: O12 ?? this.O12,
    O16: O16 ?? this.O16,
    O20: O20 ?? this.O20,
    O24: O24 ?? this.O24,
    O28: O28 ?? this.O28,
    O32: O32 ?? this.O32,
    O40: O40 ?? this.O40,
    O48: O48 ?? this.O48,
    O56: O56 ?? this.O56,
    O64: O64 ?? this.O64,
    O72: O72 ?? this.O72,
    O80: O80 ?? this.O80,
    O88: O88 ?? this.O88,
    O96: O96 ?? this.O96,
    O100: O100 ?? this.O100,
  );

  @override
  List<Object?> get props => [
    disabled,
    hoverGhost,
    pressedGhost,
    focusRing,
    overlay,
    transparent,
    opaque,
    O0,
    O4,
    O8,
    O12,
    O16,
    O20,
    O24,
    O28,
    O32,
    O40,
    O48,
    O56,
    O64,
    O72,
    O80,
    O88,
    O96,
    O100,
  ];
}
