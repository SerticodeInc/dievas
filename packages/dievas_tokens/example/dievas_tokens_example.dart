// ignore_for_file: avoid_print

// Dievas design tokens — pure Dart example.
// Run: dart run packages/dievas_tokens/example/dievas_tokens_example.dart
// Prints one report covering every token family.

import 'package:dievas_tokens/dievas_tokens.dart';

void main() {
  for (final section in const _TokenReport().sections) {
    print('\n${section.title}');
    for (final entry in section.entries) {
      print('  ${entry.label.padRight(34)} ${entry.value}');
    }
  }
}

final class _Entry {
  const _Entry(this.label, this.value);

  final String label;
  final Object value;
}

final class _Section {
  const _Section(this.title, this.entries);

  final String title;
  final List<_Entry> entries;
}

final class _TokenReport {
  const _TokenReport();

  List<_Section> get sections => [
    _colourPrimitives,
    _colourSemantics,
    _brandPalettes,
    _typography,
    _spacing,
    _radius,
    _sizing,
    _elevation,
    _opacity,
    _motion,
    _layout,
  ];

  _Section get _colourPrimitives => _Section('Colour primitives (0xAARRGGBB)', [
    _Entry('indigo500', _hex(DievasColourPrimitives.indigo500)),
    _Entry('indigo950', _hex(DievasColourPrimitives.indigo950)),
    _Entry('amber500', _hex(DievasColourPrimitives.amber500)),
    _Entry('green500', _hex(DievasColourPrimitives.green500)),
    _Entry('slate500', _hex(DievasColourPrimitives.slate500)),
    _Entry('white', _hex(DievasColourPrimitives.white)),
    _Entry('black', _hex(DievasColourPrimitives.black)),
    _Entry('transparent', _hex(DievasColourPrimitives.transparent)),
  ]);

  _Section get _colourSemantics => _Section('Colour semantics — light / dark / static', [
    _Entry('light.pageBackground', _hex(DievasColourSemanticLight.pageBackground)),
    _Entry('light.textPrimary', _hex(DievasColourSemanticLight.textPrimary)),
    _Entry('light.buttonPrimaryBackground', _hex(DievasColourSemanticLight.buttonPrimaryBackground)),
    _Entry('light.alertErrorIcon', _hex(DievasColourSemanticLight.alertErrorIcon)),
    _Entry('dark.pageBackground', _hex(DievasColourSemanticDark.pageBackground)),
    _Entry('dark.textPrimary', _hex(DievasColourSemanticDark.textPrimary)),
    _Entry('dark.buttonPrimaryBackground', _hex(DievasColourSemanticDark.buttonPrimaryBackground)),
    _Entry('dark.alertErrorIcon', _hex(DievasColourSemanticDark.alertErrorIcon)),
    _Entry('static.transparent', _hex(DievasColourSemanticLight.staticTransparent)),
  ]);

  _Section get _brandPalettes {
    final entries = <_Entry>[];
    for (final palette in DievasBrandPalettes.all.values) {
      final light = palette.rolesForLight();
      final dark = palette.rolesForDark();
      entries.add(
        _Entry(
          palette.name,
          'light ${_hex(light.buttonPrimaryBackground)} on ${_hex(light.buttonPrimaryText)} · '
          'dark ${_hex(dark.buttonPrimaryBackground)} on ${_hex(dark.buttonPrimaryText)}',
        ),
      );
    }
    return _Section('Brand palettes — primary / contrast per brightness', entries);
  }

  _Section get _typography => _Section('Typography — named text styles', [
    _Entry('displayLG', _style(DievasTypographySemantic.displayLG)),
    _Entry('headingXL', _style(DievasTypographySemantic.headingXL)),
    _Entry('titleLG', _style(DievasTypographySemantic.titleLG)),
    _Entry('bodyMD', _style(DievasTypographySemantic.bodyMD)),
    _Entry('labelSM', _style(DievasTypographySemantic.labelSM)),
    _Entry('codeMD', _style(DievasTypographySemantic.codeMD)),
  ]);

  _Section get _spacing => const _Section('Spacing — logical pixels on a 4pt grid', [
    _Entry('XS', DievasSpacingSemantic.XS),
    _Entry('SM', DievasSpacingSemantic.SM),
    _Entry('MD', DievasSpacingSemantic.MD),
    _Entry('LG', DievasSpacingSemantic.LG),
    _Entry('XL3', DievasSpacingSemantic.XL3),
    _Entry('XL5', DievasSpacingSemantic.XL5),
  ]);

  _Section get _radius => const _Section('Radius — logical pixels', [
    _Entry('NONE', DievasRadiusSemantic.NONE),
    _Entry('SM', DievasRadiusSemantic.SM),
    _Entry('MD', DievasRadiusSemantic.MD),
    _Entry('LG', DievasRadiusSemantic.LG),
    _Entry('FULL', DievasRadiusSemantic.FULL),
  ]);

  _Section get _sizing => const _Section('Sizing — logical pixels', [
    _Entry('buttonHeightMD', DievasSizingSemantic.buttonHeightMD),
    _Entry('inputHeightMD', DievasSizingSemantic.inputHeightMD),
    _Entry('iconMD', DievasSizingSemantic.iconMD),
    _Entry('avatarLG', DievasSizingSemantic.avatarLG),
    _Entry('touchMin', DievasSizingSemantic.touchMin),
    _Entry('height256', DievasSizingSemantic.height256),
    _Entry('width256', DievasSizingSemantic.width256),
  ]);

  _Section get _elevation => _Section('Elevation — blur radii and shadow layers', [
    const _Entry('NONE', DievasElevationSemantic.NONE),
    const _Entry('SM', DievasElevationSemantic.SM),
    const _Entry('MD', DievasElevationSemantic.MD),
    const _Entry('XL', DievasElevationSemantic.XL),
    _Entry('SM layers', DievasElevationShadowLayer.SM.length),
    _Entry('XL layers', DievasElevationShadowLayer.XL.length),
    _Entry('shadowColour', _hex(DievasElevationSemantic.shadowColour)),
  ]);

  _Section get _opacity => const _Section('Opacity — role alphas and endpoints', [
    _Entry('transparent', DievasOpacitySemantic.transparent),
    _Entry('disabled', DievasOpacitySemantic.disabled),
    _Entry('hoverGhost', DievasOpacitySemantic.hoverGhost),
    _Entry('focusRing', DievasOpacitySemantic.focusRing),
    _Entry('overlay', DievasOpacitySemantic.overlay),
    _Entry('opaque', DievasOpacitySemantic.opaque),
  ]);

  _Section get _motion => _Section('Motion — durations and easing curves', [
    const _Entry('instant', DievasAnimationSemantic.instant),
    const _Entry('standard', DievasAnimationSemantic.standard),
    const _Entry('emphasized', DievasAnimationSemantic.emphasized),
    const _Entry('snackbarDismiss', DievasAnimationSemantic.snackbarDismiss),
    _Entry('easing.standard', _curve(DievasEasingSemantic.standard)),
    _Entry('easing.enter', _curve(DievasEasingSemantic.enter)),
    _Entry('easing.exit', _curve(DievasEasingSemantic.exit)),
  ]);

  _Section get _layout => const _Section('Layout — breakpoints and stacking order', [
    _Entry('breakpoint.XS', DievasBreakpointSemantic.XS),
    _Entry('breakpoint.MD', DievasBreakpointSemantic.MD),
    _Entry('breakpoint.XL', DievasBreakpointSemantic.XL),
    _Entry('zIndex.dropdown', DievasZIndexSemantic.dropdown),
    _Entry('zIndex.modal', DievasZIndexSemantic.modal),
    _Entry('zIndex.toast', DievasZIndexSemantic.toast),
  ]);
}

String _hex(int argb) => '#${argb.toRadixString(16).padLeft(8, '0').toUpperCase()}';

String _style(DievasTextStyleToken style) =>
    '${style.fontSize}px · w${style.fontWeight} · lh ${style.lineHeight} · ls ${style.letterSpacing} · ${style.fontFamily}';

String _curve(DievasEasingCurve curve) => 'cubic(${curve.x1}, ${curve.y1}, ${curve.x2}, ${curve.y2})';
