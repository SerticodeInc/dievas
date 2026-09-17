import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../token_css.dart';
import 'theme_toggle.dart';

/// Theme wall — light and dark sheets, side by side, rendered from
/// the same semantic roles. Each card carries a scoped `data-theme`
/// so both sheets are visible regardless of the page theme.
class ThemeSection extends StatelessComponent {
  const ThemeSection({super.key});

  @override
  Component build(BuildContext context) => section(classes: 'theme-wall section', [
    div(classes: 'shell', [
      div(classes: 'theme-head', [
        h2(classes: 'theme-title sr sr-s', [Component.text('Two sheets, One token model.')]),
        p(classes: 'theme-lede sr sr-l', [
          span(classes: 'theme-line', [
            Component.text('The stage, the chapters, and the page you\'re reading all rebind to the same semantic layer. Nothing is themed twice.'),
          ]),
          span(classes: 'theme-line theme-flip', [
            span(classes: 'theme-pill', [
              span(classes: 'theme-pill-label', [Component.text('Flip the toggle')]),
              const ThemeToggle(),
            ]),
            Component.text('.'),
          ]),
        ]),
      ]),
      div(classes: 'sheet-grid sr-stagger', [
        _sheetCard(values: _sheetValues['light']!),
        _sheetCard(values: _sheetValues['dark']!),
      ]),
    ]),
  ]);

  Component _sheetCard({required _SheetValues values}) => div(
    classes: 'sheet-card sr',
    attributes: {'data-theme': values.theme},
    [
      div(classes: 'sheet-meta', [
        span(classes: 'sheet-tag sheet-tag--${values.theme}', [
          RawText(values.theme == 'light' ? _sunSvg : _moonSvg),
          Component.text(values.name),
        ]),
        Component.text(values.meta),
      ]),
      div(classes: 'sheet-roles', [
        _roleChip('brand', '--dv-brand', values.brand),
        _roleChip('textPrimary', '--dv-text-hi', values.textHi),
        _roleChip('bgBase', '--dv-bg-base', values.bgBase),
        _roleChip('bgSubtle', '--dv-bg-subtle', values.bgSubtle),
        _roleChip('surfaceCode', '--dv-surface-code', values.surfaceCode),
        _roleChip('borderDefault', '--dv-border', values.border),
      ]),
      div(classes: 'sheet-note', [Component.text(values.note)]),
    ],
  );

  Component _roleChip(String name, String prop, String value) => button(
    type: ButtonType.button,
    classes: 'role-chip',
    attributes: {'data-di-copy': prop, 'title': 'Copy resolved value'},
    [
      span(classes: 'dot', attributes: {'style': '--chip: var($prop);'}, []),
      span(
        attributes: const {'style': 'display:flex;flex-direction:column;gap:2px;'},
        [Component.text(name), Component.text(value)],
      ),
    ],
  );

  static const _sunSvg =
      '''<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3.6"/><path d="M12 2.5v2M12 19.5v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2.5 12h2M19.5 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>''';

  static const _moonSvg =
      '''<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 13.5A8 8 0 0 1 10.5 4 8 8 0 1 0 20 13.5Z"/></svg>''';
}

/// Light + dark SSR values for the two wall cards (honest: computed
/// from the token package, not the stylesheet).
class _SheetValues {
  const _SheetValues({
    required this.theme,
    required this.name,
    required this.meta,
    required this.brand,
    required this.textHi,
    required this.bgBase,
    required this.bgSubtle,
    required this.surfaceCode,
    required this.border,
    required this.note,
  });

  final String theme;
  final String name;
  final String meta;
  final String brand;
  final String textHi;
  final String bgBase;
  final String bgSubtle;
  final String surfaceCode;
  final String border;
  final String note;
}

final Map<String, _SheetValues> _sheetValues = {
  'light': _SheetValues(
    theme: 'light',
    name: 'Light sheet',
    meta: 'dievas_tokens · indigo',
    note: 'lightTheme: DievasLightThemeData()',
    brand: tokenRgba(DievasColourSemanticLight.brand),
    textHi: tokenRgba(DievasColourSemanticLight.textPrimary),
    bgBase: tokenRgba(DievasColourSemanticLight.bgBase),
    bgSubtle: tokenRgba(DievasColourSemanticLight.bgSubtle),
    surfaceCode: tokenRgba(DievasColourSemanticLight.surfaceCode),
    border: tokenRgba(DievasColourSemanticLight.borderDefault),
  ),
  'dark': _SheetValues(
    theme: 'dark',
    name: 'Dark sheet',
    meta: 'dievas_tokens · indigo',
    note: 'darkTheme: DievasDarkThemeData()',
    brand: tokenRgba(DievasColourSemanticDark.brand),
    textHi: tokenRgba(DievasColourSemanticDark.textPrimary),
    bgBase: tokenRgba(DievasColourSemanticDark.bgBase),
    bgSubtle: tokenRgba(DievasColourSemanticDark.bgSubtle),
    surfaceCode: tokenRgba(DievasColourSemanticDark.surfaceCode),
    border: tokenRgba(DievasColourSemanticDark.borderDefault),
  ),
};
