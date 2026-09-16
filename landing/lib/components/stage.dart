import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../token_css.dart';

/// The Component Stage — the hero's self-themed app window.
///
/// A live, DOM-rendered Dievas preview. The window carries its own
/// scoped `data-theme` through the stage toggle (proves token scoping);
/// the site-level toggle re-themes everything, stage included.
///
/// All interaction is driven by `app.dart`'s vanilla JS layer via
/// `data-*` hooks; no @client hydration.
class Stage extends StatelessComponent {
  const Stage({super.key});

  @override
  Component build(BuildContext context) => div(
    classes: 'stage-window',
    attributes: const {
      'aria-label': 'Dievas component stage preview',
      'role': 'group',
      'data-stage': '',
    },
    [
      _titlebar(),
      _tablist(),
      div(classes: 'stage-body', [
        _primitivesPanel(),
        _componentsPanel(),
        _tokensPanel(),
      ]),
      _foot(),
    ],
  );

  // ── Chrome ──────────────────────────────────────────────────

  Component _titlebar() => div(classes: 'stage-titlebar', [
    div(classes: 'stage-dots', [
      span(classes: 'stage-dot d-r', []),
      span(classes: 'stage-dot d-y', []),
      span(classes: 'stage-dot d-g', []),
    ]),
    div(classes: 'stage-title', [Component.text('dievas · component stage')]),
    button(
      type: ButtonType.button,
      classes: 'stage-theme press',
      attributes: const {'data-stage-theme': '', 'aria-label': 'Toggle stage colour theme'},
      [
        RawText(_themeIconSvg),
        Component.text('theme'),
      ],
    ),
  ]);

  Component _tablist() => div(
    classes: 'stage-tabs',
    attributes: const {'role': 'tablist', 'aria-label': 'Stage content'},
    [
      for (final (tab) in _tabs)
        button(
          type: ButtonType.button,
          classes: 'stage-tab press',
          attributes: {
            'role': 'tab',
            'data-stage-tab': tab,
            'aria-selected': tab == 'primitives' ? 'true' : 'false',
            'aria-controls': 'stage-panel-$tab',
          },
          [Component.text(tab)],
        ),
    ],
  );

  static const _tabs = ['primitives', 'components', 'tokens'];

  // ── Panel · Primitives ──────────────────────────────────────

  Component _primitivesPanel() => section(
    classes: 'stage-panel',
    attributes: const {
      'role': 'tabpanel',
      'id': 'stage-panel-primitives',
      'aria-label': 'Primitive values',
      'data-stage-panel': 'primitives',
    },
    [
      div(classes: 'rail', [
        _swatchCard('brand', '--dv-brand', DievasColourSemanticLight.brand),
        _swatchCard('text-hi', '--dv-text-hi', DievasColourSemanticLight.textPrimary),
        _swatchCard('bg-base', '--dv-bg-base', DievasColourSemanticLight.bgBase),
        _swatchCard('action', '--dv-action', DievasColourSemanticLight.actionPrimary),
      ]),
      div(
        classes: 'rail-code',
        [
          pre(classes: 'codestrip', [
            span(classes: 'tok-c', [Component.text('// one token, read at the leaf\n')]),
            Component.text('final brand = '),
            span(classes: 'tok-k', [Component.text('context.colours.core.brand')]),
            Component.text(';\n\n'),
            Component.text('DievasButton(\n  style: '),
            span(classes: 'tok-k', [Component.text('.filledPrimary')]),
            Component.text(',\n  size: '),
            span(classes: 'tok-k', [Component.text('.lg')]),
            Component.text(',\n  label: '),
            span(classes: 'tok-s', [Component.text('\'Continue\'')]),
            Component.text(',\n  foregroundColour: brand,\n  onPressed: () {},\n)'),
          ]),
        ],
      ),
    ],
  );

  Component _swatchCard(String name, String prop, int lightValue) => div(
    classes: 'swatch-card',
    [
      div(classes: 'swatch', attributes: {'style': 'background: var($prop);'}, []),
      div(classes: 'swatch-label', [
        b([Component.text(name)]),
        span(
          attributes: {'data-di-prop': prop},
          [Component.text(tokenRgba(lightValue))],
        ),
      ]),
    ],
  );

  // ── Panel · Components ──────────────────────────────────────

  Component _componentsPanel() => section(
    classes: 'stage-panel',
    attributes: const {
      'role': 'tabpanel',
      'id': 'stage-panel-components',
      'aria-label': 'Live components',
      'data-stage-panel': 'components',
      'hidden': '',
    },
    [
      div(classes: 'comp-demo', [
        div(classes: 'comp-row', [
          button(type: ButtonType.button, classes: 'dbtn dbtn-primary press', [Component.text('Primary')]),
          button(type: ButtonType.button, classes: 'dbtn dbtn-secondary press', [Component.text('Secondary')]),
          button(type: ButtonType.button, classes: 'dbtn dbtn-text press', [Component.text('Text action')]),
          button(type: ButtonType.button, classes: 'dbtn dbtn-ghost press', [Component.text('Ghost')]),
          span(classes: 'dbtn dbtn-disabled', [Component.text('Disabled')]),
        ]),
        div(classes: 'toggle-cluster', [
          _switch('Wi-Fi', true),
          _switch('Bluetooth', false),
        ]),
      ]),
    ],
  );

  Component _switch(String label, bool on) => button(
    type: ButtonType.button,
    classes: on ? 't-switch press is-on' : 't-switch press',
    attributes: {
      'data-di-switch': '',
      'aria-pressed': on ? 'true' : 'false',
      'aria-label': 'Toggle $label',
    },
    [
      span(classes: 'track', [span(classes: 'knob', [])]),
      span(classes: 't-label', [Component.text(label)]),
    ],
  );

  // ── Panel · Tokens ──────────────────────────────────────────

  Component _tokensPanel() => section(
    classes: 'stage-panel',
    attributes: const {
      'role': 'tabpanel',
      'id': 'stage-panel-tokens',
      'aria-label': 'Semantic tokens',
      'data-stage-panel': 'tokens',
      'hidden': '',
    },
    [
      div(classes: 'token-grid', [
        for (final prop in _tokenChips) _tokenChip(prop),
      ]),
    ],
  );

  static const _tokenChips = [
    '--dv-text-hi',
    '--dv-text-mid',
    '--dv-bg-base',
    '--dv-bg-subtle',
    '--dv-surface-code',
    '--dv-border',
    '--dv-border-brand',
    '--dv-brand',
    '--dv-on-brand',
    '--dv-action',
    '--dv-switch-on',
    '--dv-feedback-success-icon',
  ];

  Component _tokenChip(String prop) => button(
    type: ButtonType.button,
    classes: 'token-chip',
    attributes: {
      'data-di-copy': prop,
      'title': 'Copy resolved value',
    },
    [
      span(classes: 'dot', attributes: {'style': '--chip: var($prop);'}, []),
      Component.text(prop),
    ],
  );

  // ── Footer readout ──────────────────────────────────────────

  Component _foot() => div(classes: 'stage-foot', [
    Component.text('InheritedModel · 9 typed aspects'),
    span(classes: 'readout', attributes: const {'data-stage-label': ''}, [
      Component.text('idle, nothing rebuilt'),
    ]),
  ]);
}

const _themeIconSvg =
    '''<svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>''';