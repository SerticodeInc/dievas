import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

/// Fixed glass pill navigation.
///
/// Left: wordmark · Center: links (hidden below md) · Right: theme
/// toggle + pub.dev CTA. The pill is the site's sole glass artifact
/// (float rule). Server-rendered; scroll compactness + hide-on-scroll
/// handled by `app.dart` scripts via `is-scrolled` / `is-hidden`.
class Nav extends StatelessComponent {
  const Nav({super.key});

  @override
  Component build(BuildContext context) => header(
    id: 'site-nav',
    classes: 'site-nav',
    [
      nav(classes: 'nav-pill', [
        // ── Wordmark ────────────────────────────────────────────────
        a(
          href: '/',
          classes: 'logo-mark',
          attributes: const {'aria-label': 'Dievas — home'},
          [
            Component.text('die'),
            span(classes: 'lg-v', [Component.text('v')]),
            Component.text('as'),
          ],
        ),

        // ── Center links (desktop) ───────────────────────────────────
        div(classes: 'nav-links', [
          for (final it in _links)
            a(
              href: it.$2,
              classes: 'nav-link',
              attributes: {if (it.$3) 'target': '_blank', if (it.$3) 'rel': 'noopener'},
              [Component.text(it.$1)],
            ),
        ]),

        // ── Right cluster ────────────────────────────────────────────
        div(classes: 'nav-cluster', [
          button(
            type: ButtonType.button,
            classes: 'theme-toggle press',
            attributes: const {'data-theme-toggle': '', 'aria-label': 'Switch colour theme'},
            [
              span(classes: 'ti ti-sun', [RawText(_sunSvg)]),
              span(classes: 'ti ti-moon', [RawText(_moonSvg)]),
            ],
          ),
          a(
            href: DievasUrls.dievasPubDevURL,
            classes: 'nav-cta press',
            attributes: const {'target': '_blank', 'rel': 'noopener'},
            [Component.text('pub.dev'), Component.text(' →')],
          ),
        ]),
      ]),
    ],
  );

  static const _links = [
    ('Experience', '#experience', false),
    ('How it\'s built', '#chapters', false),
    ('Gallery', DievasUrls.gallery, true),
  ];

  static const _sunSvg =
      '''<svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="4.2"/><path d="M12 2.5v2.2M12 19.3v2.2M4.9 4.9l1.6 1.6M17.5 17.5l1.6 1.6M2.5 12h2.2M19.3 12h2.2M4.9 19.1l1.6-1.6M17.5 6.5l1.6-1.6"/></svg>''';

  static const _moonSvg =
      '''<svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M20 13.5A8 8 0 0 1 10.5 4 8 8 0 1 0 20 13.5Z"/></svg>''';
}