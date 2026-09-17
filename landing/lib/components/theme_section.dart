import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

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
        h2(classes: 'theme-title sr sr-s', [
          Component.text('Two sheets, '),
          span(classes: 'theme-title-accent', [Component.text('One token model.')]),
        ]),
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
      ]),
      div(classes: 'sheet-roles', [
        _roleChip('Brand', '--dv-brand'),
        _roleChip('Text', '--dv-text-hi'),
        _roleChip('Base background', '--dv-bg-base'),
        _roleChip('Subtle background', '--dv-bg-subtle'),
        _roleChip('Code surface', '--dv-surface-code'),
        _roleChip('Border', '--dv-border'),
      ]),
      div(classes: 'sheet-note', [Component.text(values.note)]),
    ],
  );

  Component _roleChip(String label, String prop) => button(
    type: ButtonType.button,
    classes: 'role-chip',
    attributes: {'data-di-copy': prop, 'title': 'Copy resolved value'},
    [
      span(classes: 'dot', attributes: {'style': '--chip: var($prop);'}, []),
      span(classes: 'role-text', [
        span(classes: 'role-label', [Component.text(label)]),
        span(classes: 'role-var', [Component.text(prop)]),
      ]),
    ],
  );

  static const _sunSvg =
      '''<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3.6"/><path d="M12 2.5v2M12 19.5v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2.5 12h2M19.5 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>''';

  static const _moonSvg =
      '''<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 13.5A8 8 0 0 1 10.5 4 8 8 0 1 0 20 13.5Z"/></svg>''';
}

/// Light + dark sheet identities for the two wall cards.
class _SheetValues {
  const _SheetValues({
    required this.theme,
    required this.name,
    required this.note,
  });

  final String theme;
  final String name;
  final String note;
}

final Map<String, _SheetValues> _sheetValues = {
  'light': const _SheetValues(
    theme: 'light',
    name: 'Light sheet',
    note: 'DievasLightThemeData()',
  ),
  'dark': const _SheetValues(
    theme: 'dark',
    name: 'Dark sheet',
    note: 'DievasDarkThemeData()',
  ),
};
