import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../token_css.dart';

/// The Component Stage — the hero's self-themed app window.
///
/// A live, DOM-rendered Dievas preview. Three tabs walk the same chain
/// the package ships: primitives (raw values), semantics (named aliases),
/// components (widgets that read those aliases off context). The window
/// carries its own scoped `data-theme` through the stage toggle, which
/// proves token scoping; the site-level toggle re-themes everything,
/// stage included.
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
        _semanticsPanel(),
        _componentsPanel(),
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

  static const _tabs = ['primitives', 'semantics', 'components'];

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
      div(classes: 'token-rows', [
        _tokenFamily('colour', [
          _colourCard('indigo500', DievasColourPrimitives.indigo500),
          _colourCard('slate900', DievasColourPrimitives.slate900),
          _colourCard('slate50', DievasColourPrimitives.slate50),
        ]),
        _tokenFamily('elevation', [
          _elevationCard('e2', DievasElevationPrimitives.e2),
          _elevationCard('e3', DievasElevationPrimitives.e3),
          _elevationCard('e5', DievasElevationPrimitives.e5),
        ]),
        _tokenFamily('radius', [
          _radiusCard('sm', DievasRadiusPrimitives.sm),
          _radiusCard('md', DievasRadiusPrimitives.md),
          _radiusCard('x3l', DievasRadiusPrimitives.x3l),
        ]),
        _tokenFamily('spacing', [
          _spacingCard('s2', DievasSpacingPrimitives.s2),
          _spacingCard('s4', DievasSpacingPrimitives.s4),
          _spacingCard('s8', DievasSpacingPrimitives.s8),
        ]),
      ]),
      div(classes: 'rail-code', [
        pre(classes: 'codestrip', [
          span(classes: 'tok-c', [Component.text('// primitives · raw values, no Flutter dependency\n')]),
          Component.text('DievasColourPrimitives.indigo500   '),
          span(classes: 'tok-c', [Component.text('// 0xFF6366F1\n')]),
          Component.text('DievasRadiusPrimitives.md          '),
          span(classes: 'tok-c', [Component.text('// 8.0\n')]),
          Component.text('DievasSpacingPrimitives.s4         '),
          span(classes: 'tok-c', [Component.text('// 16.0')]),
        ]),
      ]),
    ],
  );

  // ── Panel · Semantics ───────────────────────────────────────

  Component _semanticsPanel() => section(
    classes: 'stage-panel',
    attributes: const {
      'role': 'tabpanel',
      'id': 'stage-panel-semantics',
      'aria-label': 'Semantic aliases',
      'data-stage-panel': 'semantics',
      'hidden': '',
    },
    [
      div(classes: 'token-rows', [
        _tokenFamily('colour', [
          _aliasChip('brand', 'context.colours.core.brand', tokenRgba(DievasColourSemanticLight.brand), 'indigo500'),
          _aliasChip(
            'textPrimary',
            'context.colours.text.textPrimary',
            tokenRgba(DievasColourSemanticLight.textPrimary),
            'slate900',
          ),
          _aliasChip(
            'bgBase',
            'context.colours.background.bgBase',
            tokenRgba(DievasColourSemanticLight.bgBase),
            'slate50',
          ),
        ]),
        _tokenFamily('elevation', [
          _aliasChip('sm', 'context.elevation.sm', '4.0', 'e2'),
          _aliasChip('md', 'context.elevation.md', '8.0', 'e3'),
          _aliasChip('xl', 'context.elevation.xl', '24.0', 'e5'),
        ]),
        _tokenFamily('radius', [
          _aliasChip('sm', 'context.border.sm', '4.0', 'sm'),
          _aliasChip('md', 'context.border.md', '8.0', 'md'),
          _aliasChip('x3l', 'context.border.x3l', '24.0', 'x3l'),
        ]),
        _tokenFamily('spacing', [
          _aliasChip('sm', 'context.spacing.sm', '8.0', 's2'),
          _aliasChip('md', 'context.spacing.md', '16.0', 's4'),
          _aliasChip('xl', 'context.spacing.xl', '32.0', 's8'),
        ]),
      ]),
      div(classes: 'rail-code', [
        pre(classes: 'codestrip', [
          span(classes: 'tok-c', [Component.text('// read the alias at the leaf, never a hex\n')]),
          Component.text('final brand = '),
          span(classes: 'tok-k', [Component.text('context.colours.core.brand')]),
          Component.text(';   '),
          span(classes: 'tok-c', [Component.text('// indigo500\n')]),
          Component.text('final radii = '),
          span(classes: 'tok-k', [Component.text('context.border.md')]),
          Component.text(';          '),
          span(classes: 'tok-c', [Component.text('// 8.0\n')]),
          Component.text('final pad   = '),
          span(classes: 'tok-k', [Component.text('context.spacing.md')]),
          Component.text(';          '),
          span(classes: 'tok-c', [Component.text('// 16.0')]),
        ]),
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
        _compCluster('DievasFilledButton', div(classes: 'comp-row', [
          button(type: ButtonType.button, classes: 'dbtn dbtn-primary press', [Component.text('Filled')]),
          button(type: ButtonType.button, classes: 'dbtn dbtn-outlined press', [Component.text('Outlined')]),
          button(type: ButtonType.button, classes: 'dbtn dbtn-text press', [Component.text('Text')]),
        ])),
        _compCluster('DievasSwitch', div(classes: 'toggle-cluster', [
          _switch('Wi-Fi', true),
          _switch('Bluetooth', false),
        ])),
        _compCluster('DievasAccordion', _accordion()),
        _compCluster('DievasBreadcrumb', _breadcrumb()),
        _compCluster('DievasDotIndicator', _dotIndicator()),
      ]),
      div(classes: 'rail-code', [
        pre(classes: 'codestrip', [
          span(classes: 'tok-c', [Component.text('// the button reads the alias, you pass nothing\n')]),
          Component.text('DievasFilledButton(\n  style: '),
          span(classes: 'tok-k', [Component.text('.primary')]),
          Component.text(',\n  size: '),
          span(classes: 'tok-k', [Component.text('.lg')]),
          Component.text(',\n  label: '),
          span(classes: 'tok-s', [Component.text('\'Continue\'')]),
          Component.text(',\n  foregroundColor: '),
          span(classes: 'tok-k', [Component.text('context.colours.core.brand')]),
          Component.text(',\n  onPressed: () {},\n)'),
        ]),
      ]),
    ],
  );

  // ── Shared token rows ───────────────────────────────────────

  Component _tokenFamily(String name, List<Component> items) => div(classes: 'token-family', [
    span(classes: 'token-family-name', [Component.text(name)]),
    div(classes: 'token-family-items', items),
  ]);

  Component _colourCard(String name, int argb) => div(
    classes: 'swatch-card',
    [
      div(classes: 'swatch', attributes: {'style': 'background: ${tokenRgba(argb)};'}, []),
      div(classes: 'swatch-label', [
        b([Component.text(name)]),
        span([Component.text(_hex(argb))]),
      ]),
    ],
  );

  /// Renders the elevation primitive as the shadow itself: offset is half
  /// the blur, matching how the package builds its BoxShadow layers.
  Component _elevationCard(String name, double blur) => div(
    classes: 'shape-card',
    [
      div(
        classes: 'shape-sample elev-sample',
        attributes: {
          'style': 'box-shadow: 0 ${_px(blur / 2)} ${_px(blur)} rgba(15, 23, 42, 0.20);',
        },
        [],
      ),
      div(classes: 'swatch-label', [
        b([Component.text(name)]),
        span([Component.text(_px(blur))]),
      ]),
    ],
  );

  /// Renders the radius primitive as the corner curve on the sample.
  Component _radiusCard(String name, double radius) => div(
    classes: 'shape-card',
    [
      div(
        classes: 'shape-sample',
        attributes: {'style': 'border-radius: ${_px(radius)};'},
        [],
      ),
      div(classes: 'swatch-label', [
        b([Component.text(name)]),
        span([Component.text(_px(radius))]),
      ]),
    ],
  );

  /// Renders the spacing primitive as a bar of that width on the 4pt grid.
  Component _spacingCard(String name, double width) => div(
    classes: 'shape-card',
    [
      div(classes: 'shape-sample spacing-track', [
        span(classes: 'spacing-bar', attributes: {'style': 'width: ${_px(width)};'}, []),
      ]),
      div(classes: 'swatch-label', [
        b([Component.text(name)]),
        span([Component.text(_px(width))]),
      ]),
    ],
  );

  Component _aliasChip(String name, String accessor, String resolved, String from) => button(
    type: ButtonType.button,
    classes: 'alias-chip',
    attributes: {
      'data-di-copy': accessor,
      'title': 'Copy resolved value',
    },
    [
      span(classes: 'alias-name', [Component.text(name)]),
      span(classes: 'alias-accessor', [Component.text(accessor)]),
      span(classes: 'alias-value', [Component.text('$resolved · from $from')]),
    ],
  );

  // ── Component samples ───────────────────────────────────────

  Component _compCluster(String name, Component preview) => div(classes: 'comp-cluster', [
    span(classes: 'comp-name', [Component.text(name)]),
    div(classes: 'comp-preview', [preview]),
  ]);

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

  Component _accordion() => div(classes: 'acc', [
    button(
      type: ButtonType.button,
      classes: 'acc-head press',
      attributes: const {'data-acc-head': '', 'aria-expanded': 'true'},
      [
        span([Component.text('What is a semantic token?')]),
        span(classes: 'acc-arrow', [Component.text('⌄')]),
      ],
    ),
    div(classes: 'acc-body', [
      Component.text('A named alias over a primitive. Move the primitive and every alias, and every widget reading it, moves with it.'),
    ]),
  ]);

  Component _breadcrumb() => nav(
    classes: 'crumbs',
    attributes: const {'aria-label': 'Breadcrumb'},
    [
      button(type: ButtonType.button, classes: 'crumb press', [Component.text('Home')]),
      span(classes: 'crumb-sep', [Component.text('/')]),
      button(type: ButtonType.button, classes: 'crumb press', [Component.text('Library')]),
      span(classes: 'crumb-sep', [Component.text('/')]),
      span(classes: 'crumb is-current', attributes: const {'aria-current': 'page'}, [Component.text('Components')]),
    ],
  );

  Component _dotIndicator() => div(
    classes: 'dots',
    attributes: const {'role': 'tablist', 'aria-label': 'Onboarding step'},
    [
      for (var i = 0; i < _dotCount; i++)
        button(
          type: ButtonType.button,
          classes: 'dot press${i == 0 ? ' is-active' : ''}',
          attributes: {
            'data-di-dot': '',
            'aria-current': i == 0 ? 'true' : 'false',
            'aria-label': 'Step ${i + 1}',
          },
          [],
        ),
    ],
  );

  static const _dotCount = 4;

  static const _flutterInheritedModel =
      'https://api.flutter.dev/flutter/widgets/InheritedModel-class.html';

  // ── Footer readout ──────────────────────────────────────────

  /// Mirrors the `craft-inline-link` treatment from CraftSection, so the
  /// stage copy matches the page's other anchored symbols.
  Component _foot() => div(classes: 'stage-foot', [
    a(
      href: _flutterInheritedModel,
      classes: 'craft-inline-link stage-foot-link',
      attributes: const {'target': '_blank', 'rel': 'noopener'},
      [
        Component.text('InheritedModel · 10 typed aspects'),
        RawText(_arrowUpRightSvg),
      ],
    ),
    span(classes: 'readout', attributes: const {'data-stage-label': ''}, [
      Component.text('idle, nothing rebuilt'),
    ]),
  ]);

  // ── Helpers ─────────────────────────────────────────────────

  static String _px(double v) => v.truncateToDouble() == v ? '${v.toInt()}px' : '${v}px';

  static String _hex(int argb) =>
      '#${argb.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';

  static const _arrowUpRightSvg =
      '''<svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M7 17L17 7"/><path d="M7 7h10v10"/></svg>''';
}

const _themeIconSvg =
    '''<svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>''';
