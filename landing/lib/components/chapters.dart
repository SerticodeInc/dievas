import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

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

  /// Section backdrop — a brand-tinted gradient, a reactive dot matrix on
  /// canvas, a handful of miniature Dievas components adrift, and some
  /// twinkling geometry. Decorative only: `aria-hidden`, and pointer events
  /// are off in CSS so it never eats a click.
  Component _backdrop() => div(
    classes: 'chapters-backdrop',
    attributes: const {'aria-hidden': 'true'},
    [
      RawText('<canvas class="chapters-matrix" data-chapter-matrix></canvas>'),
      for (final m in _minis) _mini(m),
      for (final s in _sparks) _sparkle(s),
    ],
  );

  /// A miniature Dievas component — button, switch, tabs, dots — drifting
  /// behind the chapters. Shape only: it reads as UI, not as text to parse.
  Component _mini(_Mini m) => div(
    classes: 'mini mini-${m.kind}',
    attributes: {
      'style':
          '${m.pos};animation-duration:${m.dur};animation-delay:${m.delay};',
    },
    [
      if (m.kind == 'tabs')
        for (var i = 0; i < 3; i++)
          span(classes: i == 1 ? 'mtab on' : 'mtab', []),
      if (m.kind == 'dots')
        for (var i = 0; i < 3; i++)
          span(classes: i == 0 ? 'mdot on' : 'mdot', []),
    ],
  );

  Component _sparkle(_Spark s) => span(
    classes: s.brand ? 'sparkle is-brand' : 'sparkle',
    attributes: {
      'style':
          '${s.pos};font-size:${s.size};animation-duration:${s.dur};animation-delay:${s.delay};',
    },
    [Component.text(s.char)],
  );

  static const _minis = <_Mini>[
    _Mini(kind: 'btn', pos: 'top:7%;left:4%', dur: '21s', delay: '0s'),
    _Mini(kind: 'switch', pos: 'top:13%;right:6%', dur: '24s', delay: '-5s'),
    _Mini(kind: 'tabs', pos: 'top:29%;left:2%', dur: '22s', delay: '-9s'),
    _Mini(kind: 'dots', pos: 'top:37%;right:4%', dur: '19s', delay: '-3s'),
    _Mini(kind: 'badge', pos: 'top:55%;left:6%', dur: '23s', delay: '-12s'),
    _Mini(kind: 'field', pos: 'top:63%;right:2%', dur: '20s', delay: '-7s'),
    _Mini(kind: 'chip', pos: 'top:81%;left:4%', dur: '25s', delay: '-15s'),
    _Mini(kind: 'dots', pos: 'top:21%;left:9%', dur: '20s', delay: '-8s'),
    _Mini(kind: 'chip', pos: 'top:44%;right:12%', dur: '22s', delay: '-17s'),
    _Mini(kind: 'switch', pos: 'top:71%;left:3%', dur: '23s', delay: '-10s'),
    _Mini(kind: 'tabs', pos: 'top:88%;right:7%', dur: '21s', delay: '-19s'),
    _Mini(kind: 'field', pos: 'top:97%;left:11%', dur: '24s', delay: '-13s'),
  ];

  static const _sparks = <_Spark>[
    _Spark(
      char: '✦',
      pos: 'top:5%;left:15%',
      size: '24px',
      dur: '5s',
      delay: '0s',
      brand: true,
    ),
    _Spark(
      char: '○',
      pos: 'top:19%;right:13%',
      size: '17px',
      dur: '7s',
      delay: '-2s',
    ),
    _Spark(
      char: '+',
      pos: 'top:27%;left:11%',
      size: '20px',
      dur: '6s',
      delay: '-4s',
    ),
    _Spark(
      char: '◇',
      pos: 'top:43%;right:9%',
      size: '19px',
      dur: '8s',
      delay: '-1s',
      brand: true,
    ),
    _Spark(
      char: '·',
      pos: 'top:51%;left:19%',
      size: '30px',
      dur: '5.5s',
      delay: '-3s',
    ),
    _Spark(
      char: '✦',
      pos: 'top:67%;right:17%',
      size: '21px',
      dur: '6.5s',
      delay: '-5s',
    ),
    _Spark(
      char: '○',
      pos: 'top:75%;left:9%',
      size: '15px',
      dur: '7.5s',
      delay: '-2.5s',
    ),
    _Spark(
      char: '◇',
      pos: 'top:85%;right:11%',
      size: '16px',
      dur: '6s',
      delay: '-6s',
      brand: true,
    ),
    _Spark(
      char: '+',
      pos: 'top:93%;left:17%',
      size: '18px',
      dur: '8s',
      delay: '-1.5s',
    ),
    _Spark(
      char: '✦',
      pos: 'top:11%;right:4%',
      size: '19px',
      dur: '6.8s',
      delay: '-3.5s',
    ),
    _Spark(
      char: '◇',
      pos: 'top:34%;right:17%',
      size: '22px',
      dur: '5.8s',
      delay: '-2s',
      brand: true,
    ),
    _Spark(
      char: '○',
      pos: 'top:59%;left:13%',
      size: '14px',
      dur: '7.2s',
      delay: '-4.5s',
    ),
    _Spark(
      char: '+',
      pos: 'top:79%;right:21%',
      size: '21px',
      dur: '6.2s',
      delay: '-1.2s',
    ),
    _Spark(
      char: '·',
      pos: 'top:96%;right:29%',
      size: '26px',
      dur: '5.4s',
      delay: '-3.2s',
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
      attributes: const {'data-brand-demo': '', 'data-brand': 'indigo'},
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

/// A miniature component silhouette drifting behind the chapters.
class _Mini {
  const _Mini({
    required this.kind,
    required this.pos,
    required this.dur,
    required this.delay,
  });

  /// One of: btn, switch, tabs, dots, badge, field, chip.
  final String kind;

  /// CSS positioning fragment, e.g. `top:7%;left:4%`.
  final String pos;
  final String dur;
  final String delay;
}

/// A twinkle — a small geometric mark pulsing in the backdrop.
class _Spark {
  const _Spark({
    required this.char,
    required this.pos,
    required this.size,
    required this.dur,
    required this.delay,
    this.brand = false,
  });

  final String char;
  final String pos;
  final String size;
  final String dur;
  final String delay;
  final bool brand;
}
