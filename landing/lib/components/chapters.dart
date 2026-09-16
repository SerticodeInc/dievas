import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

/// "How it's built" — five numbered evidence chapters, each ending
/// in a live demonstrator (running control or an honest code strip).
class Chapters extends StatelessComponent {
  const Chapters({super.key});

  @override
  Component build(
    BuildContext context,
  ) => section(id: 'chapters', classes: 'chapters relative', [
    _backdrop(),
    div(classes: 'shell-narrow', [
      div(classes: 'chapters-intro', [
        h2(classes: 'chapters-title sr sr-s', [
          Component.text('Compiled, not composed.'),
        ]),
        p(classes: 'chapters-lede sr sr-l', [
          Component.text(
            'Five layers, one source of truth. Nothing to reconcile, nothing to drift. Each chapter ends in something that runs.',
          ),
        ]),
      ]),

      _chapter(
        num: '01',
        meta: 'Tokens · dievas_tokens',
        heading: 'One source of truth.',
        body:
            'Primitives become semantic roles become context. The page you\'re reading is themed by the same chain your app will use, from raw int to runtime colour. No special cases.',
        demo: _tokenChainDemo(),
      ),

      _chapter(
        num: '02',
        meta: 'Aspects · InheritedModel',
        heading: 'Rebuild what changed, nothing more.',
        body:
            'Ten typed aspects ride an InheritedModel. A single text change rebuilds only the dependents that read text, never the layout and never the whole tree.',
        demo: _aspectDemo(),
      ),

      _chapter(
        num: '03',
        meta: 'Components · Moon catalogue',
        heading: 'One catalogue, fifty states, today.',
        body:
            'Buttons, switches, inputs and more behave identically from first commit. Focus, disabled, and motion handling are baked into the component, not bolted on by you.',
        demo: _componentsDemo(),
      ),

      _chapter(
        num: '04',
        meta: 'Multi-brand · DievasScope',
        heading: 'One app, every brand.',
        body:
            'DievasScope retimes and recolours a running tree with zero code paths and zero restarts. Tap a brand, and the card that follows rebinds to its tokens on the spot.',
        demo: _brandDemo(),
      ),

      _chapter(
        num: '05',
        meta: 'Gallery · Widgetbook',
        heading: 'Every permutation, running.',
        body:
            'Every component, every state, exercised in a live Widgetbook gallery against the real token set, in your browser and not a screenshot.',
        demo: _galleryDemo(),
      ),
    ]),
  ]);

  /// Section backdrop — a brand-tinted gradient, a film-grain noise tile,
  /// and a few slow-drifting code glyphs. Decorative only: `aria-hidden`,
  /// and pointer events are off in CSS so it never eats a click.
  Component _backdrop() => div(
    classes: 'chapters-backdrop',
    attributes: const {'aria-hidden': 'true'},
    [for (final g in _ghosts) _ghost(g), div(classes: 'chapters-grain', [])],
  );

  Component _ghost(_Ghost g) => span(
    classes: g.brand ? 'ghost-char is-brand' : 'ghost-char',
    attributes: {
      'style':
          '${g.pos};font-size:${g.size};animation-duration:${g.dur};animation-delay:${g.delay};',
    },
    [Component.text(g.text)],
  );

  static const _ghosts = <_Ghost>[
    _Ghost(
      text: '{ }',
      pos: 'top:4%;left:2%',
      size: '96px',
      dur: '19s',
      delay: '0s',
    ),
    _Ghost(
      text: '0xFF6366F1',
      pos: 'top:9%;right:1%',
      size: '34px',
      dur: '23s',
      delay: '-4s',
      brand: true,
    ),
    _Ghost(
      text: 'context.colours',
      pos: 'top:26%;left:-1%',
      size: '30px',
      dur: '21s',
      delay: '-7s',
    ),
    _Ghost(
      text: 'InheritedModel',
      pos: 'top:34%;right:0%',
      size: '30px',
      dur: '25s',
      delay: '-2s',
    ),
    _Ghost(
      text: '→',
      pos: 'top:52%;left:3%',
      size: '74px',
      dur: '17s',
      delay: '-11s',
      brand: true,
    ),
    _Ghost(
      text: 'DievasScope',
      pos: 'top:60%;right:2%',
      size: '30px',
      dur: '22s',
      delay: '-9s',
    ),
    _Ghost(
      text: '10 aspects',
      pos: 'top:76%;left:1%',
      size: '26px',
      dur: '20s',
      delay: '-5s',
    ),
    _Ghost(
      text: ';',
      pos: 'top:88%;right:4%',
      size: '110px',
      dur: '24s',
      delay: '-14s',
    ),
  ];

  Component _chapter({
    required String num,
    required String meta,
    required String heading,
    required String body,
    required Component demo,
  }) => article(classes: 'chapter sr', [
    div(classes: 'chapter-side', [
      div(classes: 'chapter-num', [Component.text(num)]),
      div(classes: 'chapter-meta', [Component.text(meta)]),
    ]),
    div(classes: 'chapter-main', [
      h3(classes: 'chapter-heading', [Component.text(heading)]),
      p(classes: 'chapter-body', [Component.text(body)]),
      div(classes: 'chapter-demo', [demo]),
    ]),
  ]);

  // ── 01 · Token chain ────────────────────────────────────────

  Component _tokenChainDemo() => div(classes: 'chain', [
    div(classes: 'chain-step', [
      b([Component.text('primitive')]),
      Component.text(' · 0xFF6366F1'),
    ]),
    span(classes: 'chain-arrow', [Component.text('→')]),
    div(classes: 'chain-step sr-step', [
      b([Component.text('semantic')]),
      Component.text(' · CoreColours.brand'),
    ]),
    span(classes: 'chain-arrow', [Component.text('→')]),
    div(classes: 'chain-step', [
      b([Component.text('context')]),
      Component.text(' · colours.core.brand'),
    ]),
  ]);

  // ── 02 · Aspect rebuild readout ─────────────────────────────

  Component _aspectDemo() => div(classes: 'rebuild-well', [
    div(classes: 'aspect-picker', [
      for (final aspect in _aspectRows)
        button(
          type: ButtonType.button,
          classes: 'aspect-btn press',
          attributes: {
            'data-aspect-trigger': aspect.$1,
            'aria-pressed': aspect.$1 == 'text' ? 'true' : 'false',
          },
          [Component.text(aspect.$1)],
        ),
    ]),
    for (final row in _aspectRows)
      div(
        classes: 'rebuild-item',
        attributes: {'data-rebuild-count': row.$1},
        [
          span([Component.text(row.$1)]),
          span(
            attributes: const {
              'style':
                  'display:flex;align-items:center;gap:10px;font-variant-numeric:tabular-nums;',
            },
            [
              span(classes: 'liv', [Component.text('rebuilt · ')]),
              b([Component.text(row.$2)]),
            ],
          ),
        ],
      ),
    div(classes: 'touch-control', [
      button(
        type: ButtonType.button,
        classes: 'dbtn dbtn-secondary press',
        attributes: const {'data-di-touch': ''},
        [Component.text('Touch the theme →')],
      ),
    ]),
  ]);

  static const _aspectRows = [('text', '0'), ('layout', '0'), ('spacing', '0')];

  // ── 03 · Component states ───────────────────────────────────

  Component _componentsDemo() => div(classes: 'comp-demo', [
    div(classes: 'state-picker', [
      for (final state in _states)
        button(
          type: ButtonType.button,
          classes: 'state-btn press',
          attributes: {
            'data-state-trigger': state.$1,
            'aria-pressed': state.$1 == 'default' ? 'true' : 'false',
          },
          [Component.text(state.$2)],
        ),
    ]),
    div(
      classes: 'state-demo',
      attributes: const {'data-state-demo': '', 'data-state': 'default'},
      [
        div(classes: 'comp-row', [
          button(type: ButtonType.button, classes: 'dbtn dbtn-primary press', [
            Component.text('Primary'),
          ]),
          button(
            type: ButtonType.button,
            classes: 'dbtn dbtn-secondary press',
            [Component.text('Secondary')],
          ),
          button(type: ButtonType.button, classes: 'dbtn dbtn-text press', [
            Component.text('Text'),
          ]),
          button(type: ButtonType.button, classes: 'dbtn dbtn-ghost press', [
            Component.text('Ghost'),
          ]),
        ]),
        div(classes: 'toggle-cluster', [
          _switch('Wi-Fi', true),
          _switch('Bluetooth', false),
        ]),
      ],
    ),
  ]);

  static const _states = [
    ('default', 'Default'),
    ('hover', 'Hover'),
    ('pressed', 'Pressed'),
    ('disabled', 'Disabled'),
  ];

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

  // ── 04 · Brand switcher ─────────────────────────────────────

  Component _brandDemo() => Component.fragment([
    div(classes: 'brand-picker', [
      for (final b in _brands)
        button(
          type: ButtonType.button,
          classes: 'brand-btn press',
          attributes: {
            'data-brand-trigger': b.$1,
            'aria-pressed': b.$1 == 'indigo' ? 'true' : 'false',
          },
          [Component.text(b.$2)],
        ),
    ]),
    div(
      classes: 'brand-demo',
      attributes: const {'data-brand-demo': ''},
      [
        div(classes: 'bd-head', [
          div(classes: 'bd-logo', [Component.text('D')]),
          div(classes: 'bd-name', [Component.text('Sign in to continue')]),
        ]),
        div(classes: 'bd-card', [
          Component.text('Browse the workspace in your brand.'),
          button(type: ButtonType.button, classes: 'bd-btn', [
            Component.text('Continue'),
          ]),
        ]),
      ],
    ),
  ]);

  static const _brands = [
    ('indigo', 'Indigo'),
    ('timber', 'Timber'),
    ('ember', 'Ember'),
  ];

  // ── 05 · Gallery handoff ────────────────────────────────────

  Component _galleryDemo() => div(classes: 'gallery-strip', [
    _galTile('Button', _galButton()),
    _galTile('Switch', _galSwitch()),
    _galTile('Field', _galField()),
    _galTile('Badge', _galBadge()),
    _galTile('Chip', _galChip()),
    _galTile('Tabs', _galTabs()),
    a(
      href: DievasUrls.gallery,
      classes: 'cta-ghost press',
      attributes: const {'target': '_blank', 'rel': 'noopener'},
      [
        Component.text('View the gallery'),
        span(classes: 'cta-arrow', [Component.text('↗')]),
      ],
    ),
  ]);

  Component _galTile(String name, Component preview) =>
      div(classes: 'gal-tile', [
        div(classes: 'gal-preview', [preview]),
        span(classes: 'gal-name', [Component.text(name)]),
      ]);

  Component _galButton() =>
      span(classes: 'gp gp-btn', [Component.text('Button')]);
  Component _galSwitch() =>
      span(classes: 'gp gp-switch', [span(classes: 'gp-knob', [])]);
  Component _galField() =>
      span(classes: 'gp gp-field', [Component.text('Placeholder')]);
  Component _galBadge() =>
      span(classes: 'gp gp-badge', [Component.text('New')]);
  Component _galChip() =>
      span(classes: 'gp gp-chip', [Component.text('Filter')]);
  Component _galTabs() => span(classes: 'gp gp-tabs', [
    span(classes: 'gp-tab is-active', [Component.text('A')]),
    span(classes: 'gp-tab', [Component.text('B')]),
    span(classes: 'gp-tab', [Component.text('C')]),
  ]);
}

/// A decorative backdrop glyph — a code symbol drifting behind the chapters.
class _Ghost {
  const _Ghost({
    required this.text,
    required this.pos,
    required this.size,
    required this.dur,
    required this.delay,
    this.brand = false,
  });

  final String text;

  /// CSS positioning fragment, e.g. `top:4%;left:2%`.
  final String pos;
  final String size;
  final String dur;
  final String delay;
  final bool brand;
}
