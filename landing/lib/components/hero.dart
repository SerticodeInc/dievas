import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';
import 'stage.dart';

/// Hero section — the whole v1 message.
///
/// One claim (display), one proof line, one action, then the live
/// Component Stage. No gradient mesh, no glass chips — the stage is
/// the only artifact below the fold of the first frame.
class Hero extends StatelessComponent {
  const Hero({super.key});

  @override
  Component build(BuildContext context) => section(id: 'experience', classes: 'hero', [
    div(classes: 'hero-head', [
      h1(
        classes: 'hero-display hero-anim hr-h',
        [
          Component.text('Every brand.'),
          br(),
          span(classes: 'accent', [Component.text('Zero hardcoded values.')]),
        ],
      ),
      p(
        classes: 'hero-sub hero-anim hr-s',
        [
          Component.text('The Flutter design system that ships '),
          Component.text('tokens, components, and themes'),
          Component.text(' from one layer. Rebuild only what changed, theme everything else.'),
        ],
      ),
      div(classes: 'hero-ctas hero-anim hr-c', [
        a(
          href: DievasUrls.dievasPubDevURL,
          classes: 'cta-primary press',
          attributes: const {'target': '_blank', 'rel': 'noopener'},
          [
            img(
              src: '/assets/pubdev.png',
              alt: '',
              width: 14,
              height: 14,
              attributes: const {'aria-hidden': 'true'},
            ),
            Component.text('Install on pub.dev'),
            span(classes: 'cta-arrow', [Component.text('→')]),
          ],
        ),
        a(
          href: DievasUrls.gallery,
          classes: 'cta-ghost press',
          attributes: const {'target': '_blank', 'rel': 'noopener'},
          [
            img(
              src: '/favicon.svg',
              alt: '',
              width: 14,
              height: 14,
              attributes: const {'aria-hidden': 'true'},
            ),
            Component.text('Browse the gallery'),
            RawText(_arrowUpRightSvg),
          ],
        ),
      ]),
    ]),
    div(classes: 'hero-stage', [const Stage()]),
  ]);

  static const _arrowUpRightSvg =
      '''<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M7 17L17 7"/><path d="M7 7h10v10"/></svg>''';
}