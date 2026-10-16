// ignore_for_file: avoid_print

// Dievas design tokens — pure Dart example.
//
// Run with:
//   dart run packages/dievas_tokens/example/dievas_tokens_example.dart
//
// The example resolves every token family and prints one labelled report:
// colour primitives and semantics, brand palette reskinning, typography,
// spacing, radius, sizing, elevation, opacity, motion, breakpoints, and
// stacking order.

import 'package:dievas_tokens/dievas_tokens.dart';

typedef _Entry = ({String label, Object value});
typedef _Section = ({String title, List<_Entry> entries});

void main() {
  final sections = <_Section>[
    _colourPrimitives(),
    _colourSemantics(),
    _brandPalettes(),
    _typography(),
    _spacing(),
    _radius(),
    _sizing(),
    _elevation(),
    _opacity(),
    _motion(),
    _layout(),
  ];

  for (final (:title, :entries) in sections) {
    print('\n$title');
    for (final (:label, :value) in entries) {
      print('  ${label.padRight(34)} $value');
    }
  }
}

_Section _colourPrimitives() => (
  title: 'Colour primitives (0xAARRGGBB)',
  entries: [
    (label: 'indigo500', value: _hex(DievasColourPrimitives.indigo500)),
    (label: 'indigo950', value: _hex(DievasColourPrimitives.indigo950)),
    (label: 'amber500', value: _hex(DievasColourPrimitives.amber500)),
    (label: 'green500', value: _hex(DievasColourPrimitives.green500)),
    (label: 'slate500', value: _hex(DievasColourPrimitives.slate500)),
    (label: 'white', value: _hex(DievasColourPrimitives.white)),
    (label: 'black', value: _hex(DievasColourPrimitives.black)),
    (label: 'transparent', value: _hex(DievasColourPrimitives.transparent)),
  ],
);

_Section _colourSemantics() => (
  title: 'Colour semantics — light / dark / static',
  entries: [
    (label: 'light.pageBackground', value: _hex(DievasColourSemanticLight.pageBackground)),
    (label: 'light.textPrimary', value: _hex(DievasColourSemanticLight.textPrimary)),
    (label: 'light.buttonPrimaryBackground', value: _hex(DievasColourSemanticLight.buttonPrimaryBackground)),
    (label: 'light.alertErrorIcon', value: _hex(DievasColourSemanticLight.alertErrorIcon)),
    (label: 'dark.pageBackground', value: _hex(DievasColourSemanticDark.pageBackground)),
    (label: 'dark.textPrimary', value: _hex(DievasColourSemanticDark.textPrimary)),
    (label: 'dark.buttonPrimaryBackground', value: _hex(DievasColourSemanticDark.buttonPrimaryBackground)),
    (label: 'dark.alertErrorIcon', value: _hex(DievasColourSemanticDark.alertErrorIcon)),
    (label: 'static.transparent', value: _hex(DievasColourSemanticLight.staticTransparent)),
  ],
);

_Section _brandPalettes() {
  final entries = <_Entry>[];
  for (final palette in DievasBrandPalettes.all.values) {
    final light = palette.rolesForLight();
    final dark = palette.rolesForDark();
    entries.add((
      label: palette.name,
      value:
          'light ${_hex(light.buttonPrimaryBackground)} on '
          '${_hex(light.buttonPrimaryText)} · '
          'dark ${_hex(dark.buttonPrimaryBackground)} on '
          '${_hex(dark.buttonPrimaryText)}',
    ));
  }
  return (title: 'Brand palettes — primary / contrast per brightness', entries: entries);
}

_Section _typography() => (
  title: 'Typography — named text styles',
  entries: [
    (label: 'displayLG', value: _style(DievasTypographySemantic.displayLG)),
    (label: 'headingXL', value: _style(DievasTypographySemantic.headingXL)),
    (label: 'titleLG', value: _style(DievasTypographySemantic.titleLG)),
    (label: 'bodyMD', value: _style(DievasTypographySemantic.bodyMD)),
    (label: 'labelSM', value: _style(DievasTypographySemantic.labelSM)),
    (label: 'codeMD', value: _style(DievasTypographySemantic.codeMD)),
  ],
);

_Section _spacing() => (
  title: 'Spacing — logical pixels on a 4pt grid',
  entries: [
    (label: 'XS', value: DievasSpacingSemantic.XS),
    (label: 'SM', value: DievasSpacingSemantic.SM),
    (label: 'MD', value: DievasSpacingSemantic.MD),
    (label: 'LG', value: DievasSpacingSemantic.LG),
    (label: 'XL3', value: DievasSpacingSemantic.XL3),
    (label: 'XL5', value: DievasSpacingSemantic.XL5),
  ],
);

_Section _radius() => (
  title: 'Radius — logical pixels',
  entries: [
    (label: 'NONE', value: DievasRadiusSemantic.NONE),
    (label: 'SM', value: DievasRadiusSemantic.SM),
    (label: 'MD', value: DievasRadiusSemantic.MD),
    (label: 'LG', value: DievasRadiusSemantic.LG),
    (label: 'FULL', value: DievasRadiusSemantic.FULL),
  ],
);

_Section _sizing() => (
  title: 'Sizing — logical pixels',
  entries: [
    (label: 'buttonHeightMD', value: DievasSizingSemantic.buttonHeightMD),
    (label: 'inputHeightMD', value: DievasSizingSemantic.inputHeightMD),
    (label: 'iconMD', value: DievasSizingSemantic.iconMD),
    (label: 'avatarLG', value: DievasSizingSemantic.avatarLG),
    (label: 'touchMin', value: DievasSizingSemantic.touchMin),
    (label: 'height256', value: DievasSizingSemantic.height256),
    (label: 'width256', value: DievasSizingSemantic.width256),
  ],
);

_Section _elevation() => (
  title: 'Elevation — blur radii and shadow layers',
  entries: [
    (label: 'NONE', value: DievasElevationSemantic.NONE),
    (label: 'SM', value: DievasElevationSemantic.SM),
    (label: 'MD', value: DievasElevationSemantic.MD),
    (label: 'XL', value: DievasElevationSemantic.XL),
    (label: 'SM layers', value: DievasElevationShadowLayer.SM.length),
    (label: 'XL layers', value: DievasElevationShadowLayer.XL.length),
    (label: 'shadowColour', value: _hex(DievasElevationSemantic.shadowColour)),
  ],
);

_Section _opacity() => (
  title: 'Opacity — role alphas and endpoints',
  entries: [
    (label: 'transparent', value: DievasOpacitySemantic.transparent),
    (label: 'disabled', value: DievasOpacitySemantic.disabled),
    (label: 'hoverGhost', value: DievasOpacitySemantic.hoverGhost),
    (label: 'focusRing', value: DievasOpacitySemantic.focusRing),
    (label: 'overlay', value: DievasOpacitySemantic.overlay),
    (label: 'opaque', value: DievasOpacitySemantic.opaque),
  ],
);

_Section _motion() => (
  title: 'Motion — durations and easing curves',
  entries: [
    (label: 'instant', value: DievasAnimationSemantic.instant),
    (label: 'standard', value: DievasAnimationSemantic.standard),
    (label: 'emphasized', value: DievasAnimationSemantic.emphasized),
    (label: 'snackbarDismiss', value: DievasAnimationSemantic.snackbarDismiss),
    (label: 'easing.standard', value: _curve(DievasEasingSemantic.standard)),
    (label: 'easing.enter', value: _curve(DievasEasingSemantic.enter)),
    (label: 'easing.exit', value: _curve(DievasEasingSemantic.exit)),
  ],
);

_Section _layout() => (
  title: 'Layout — breakpoints and stacking order',
  entries: [
    (label: 'breakpoint.XS', value: DievasBreakpointSemantic.XS),
    (label: 'breakpoint.MD', value: DievasBreakpointSemantic.MD),
    (label: 'breakpoint.XL', value: DievasBreakpointSemantic.XL),
    (label: 'zIndex.dropdown', value: DievasZIndexSemantic.dropdown),
    (label: 'zIndex.modal', value: DievasZIndexSemantic.modal),
    (label: 'zIndex.toast', value: DievasZIndexSemantic.toast),
  ],
);

String _hex(int argb) => '#${argb.toRadixString(16).padLeft(8, '0').toUpperCase()}';

String _style(DievasTextStyleToken style) =>
    '${style.fontSize}px · w${style.fontWeight} · '
    'lh ${style.lineHeight} · ls ${style.letterSpacing} · ${style.fontFamily}';

String _curve(DievasEasingCurve curve) => 'cubic(${curve.x1}, ${curve.y1}, ${curve.x2}, ${curve.y2})';
