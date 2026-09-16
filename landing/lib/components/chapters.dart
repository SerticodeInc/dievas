import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

/// "How it's built" — five numbered evidence chapters, each ending
/// in a live demonstrator (running control or an honest code strip).
class Chapters extends StatelessComponent {
  const Chapters({super.key});

  @override
  Component build(BuildContext context) => section(
    id: 'chapters',
    classes: 'chapters shell-narrow relative',
    [
      div(classes: 'chapters-intro', [
        div(classes: 'eyebrow sr', [Component.text('How it\'s built')]),
        h2(classes: 'chapters-title sr sr-s', [Component.text('Compiled, not composed.')]),
        p(
          classes: 'chapters-lede sr sr-l',
          [
            Component.text('Five layers, one source of truth. Nothing to reconcile, nothing to drift. Each chapter ends in something that runs.'),
          ],
        ),
      ]),

      _chapter(
        num: '01',
        meta: 'Tokens · dievas_tokens',
        heading: 'One source of truth.',
        body: 'Primitives become semantic roles become context. The page you\'re reading is themed by the same three-hop chain your app will use. No landing-only colours, no special cases.',
        demo: _tokenChainDemo(),
      ),

      _chapter(
        num: '02',
        meta: 'Aspects · InheritedModel',
        heading: 'Rebuild what changed, nothing more.',
        body: 'Nine typed aspects ride an InheritedModel. A single text change rebuilds only the dependents that read text, never the layout and never the whole tree.',
        demo: _aspectDemo(),
      ),

      _chapter(
        num: '03',
        meta: 'Components · Moon catalogue',
        heading: 'One catalogue, fifty states, today.',
        body: 'Buttons, switches, inputs and more behave identically from first commit. Focus, disabled, and reduced-motion handling are baked into the component, not bolted on by you.',
        demo: _componentsDemo(),
      ),

      _chapter(
        num: '04',
        meta: 'Multi-brand · DievasScope',
        heading: 'One app, every brand.',
        body: 'DievasScope re-themes a running tree with zero code paths and zero restarts. Tap a brand, and the card that follows rebinds to its tokens on the spot.',
        demo: _brandDemo(),
      ),

      _chapter(
        num: '05',
        meta: 'Gallery · Widgetbook',
        heading: 'Every permutation, running.',
        body: 'Every component, every state, exercised in a live Widgetbook gallery against the real token set, in your browser and not a screenshot.',
        demo: _galleryDemo(),
      ),
    ],
  );

  Component _chapter({
    required String num,
    required String meta,
    required String heading,
    required String body,
    required Component demo,
  }) =>
      article(
        classes: 'chapter sr',
        [
          div(classes: 'chapter-side', [
            div(classes: 'chapter-num', [Component.text(num)]),
            div(classes: 'chapter-meta', [Component.text(meta)]),
          ]),
          div(classes: 'chapter-main', [
            h3(classes: 'chapter-heading', [Component.text(heading)]),
            p(classes: 'chapter-body', [Component.text(body)]),
            div(classes: 'chapter-demo', [demo]),
          ]),
        ],
      );

  // ── 01 · Token chain ────────────────────────────────────────

  Component _tokenChainDemo() => div(classes: 'chain', [
    div(classes: 'chain-step', [b([Component.text('primitive')]), Component.text(' · indigo500')]),
    span(classes: 'chain-arrow', [Component.text('→')]),
    div(classes: 'chain-step sr-step', [b([Component.text('semantic')]), Component.text(' · brand')]),
    span(classes: 'chain-arrow', [Component.text('→')]),
    div(classes: 'chain-step', [b([Component.text('context')]), Component.text(' · DievasScope')]),
  ]);

  // ── 02 · Aspect rebuild readout ─────────────────────────────

  Component _aspectDemo() => div(classes: 'rebuild-well', [
    for (final row in _aspectRows)
      div(classes: 'rebuild-item', [
        span([Component.text(row.$1)]),
        span(
          attributes: const {'style': 'display:flex;align-items:center;gap:10px;font-variant-numeric:tabular-nums;'},
          [
            span(classes: 'liv', [Component.text('rebuilt · ')]),
            b(
              attributes: {'data-rebuild-count': row.$1},
              [Component.text(row.$2)],
            ),
          ],
        ),
      ]),
    div(classes: 'touch-control', [
      button(
        type: ButtonType.button,
        classes: 'dbtn dbtn-secondary press',
        attributes: const {'data-di-touch': ''},
        [Component.text('Touch the theme →')],
      ),
    ]),
  ]);

  static const _aspectRows = [
    ('text', '0'),
    ('layout', '0'),
    ('spacing', '0'),
  ];

  // ── 03 · Component states ───────────────────────────────────

  Component _componentsDemo() => div(classes: 'comp-demo', [
    div(classes: 'comp-row', [
      button(type: ButtonType.button, classes: 'dbtn dbtn-primary press', [Component.text('Primary')]),
      button(type: ButtonType.button, classes: 'dbtn dbtn-secondary press', [Component.text('Secondary')]),
      button(type: ButtonType.button, classes: 'dbtn dbtn-text press', [Component.text('Text')]),
      button(type: ButtonType.button, classes: 'dbtn dbtn-ghost press', [Component.text('Ghost')]),
    ]),
    div(classes: 'comp-row', [
      _switchDemo('Hover, press, focus, and disabled states, shipped.'),
    ]),
  ]);

  Component _switchDemo(String label) => button(
    type: ButtonType.button,
    classes: 't-switch press',
    attributes: {'data-di-switch': '', 'aria-pressed': 'false', 'aria-label': 'Toggle demo'},
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
    div(classes: 'brand-demo', attributes: const {'data-brand-demo': ''}, [
      div(classes: 'bd-head', [
        div(classes: 'bd-logo', [Component.text('D')]),
        div(classes: 'bd-name', [Component.text('Sign in to continue')]),
      ]),
      div(classes: 'bd-card', [
        Component.text('Browse the workspace in your brand.'),
        button(type: ButtonType.button, classes: 'bd-btn', [Component.text('Continue')]),
      ]),
    ]),
  ]);

  static const _brands = [
    ('indigo', 'Indigo'),
    ('timber', 'Timber'),
    ('ember', 'Ember'),
  ];

  // ── 05 · Gallery handoff ────────────────────────────────────

  Component _galleryDemo() => div(classes: 'gallery-strip', [
    for (final t in _tiles)
      div(classes: 'gal-tile', [Component.text(t)]),
    a(
      href: DievasUrls.gallery,
      classes: 'cta-ghost press',
      attributes: const {'target': '_blank', 'rel': 'noopener'},
      [Component.text('View the gallery'), span(classes: 'cta-arrow', [Component.text('↗')])],
    ),
  ]);

  static const _tiles = ['Button', 'Switch', 'Field', 'Badge', 'Chip', 'Tabs'];
}