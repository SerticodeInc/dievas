import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';
import 'theme_toggle.dart';

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
          attributes: const {'aria-label': 'Dievas, home'},
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
          const ThemeToggle(),
          a(
            href: DievasUrls.dievasPubDevURL,
            classes: 'nav-cta press',
            attributes: const {'target': '_blank', 'rel': 'noopener'},
            [
              img(
                src: '/assets/pubdev.png',
                alt: '',
                width: 14,
                height: 14,
                attributes: const {'aria-hidden': 'true'},
              ),
              Component.text('pub.dev'),
              Component.text(' →'),
            ],
          ),
        ]),
      ]),
    ],
  );

  static const _links = [
    ('How it\'s built', '#chapters', false),
    ('Gallery', DievasUrls.gallery, true),
  ];
}