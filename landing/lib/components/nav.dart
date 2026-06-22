import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

/// Fixed top navigation — glass pill.
///
/// Centered pill, `min(860px, calc(100% - 20vw))` wide.
/// Glass: rgba(12,12,12,0.55) + backdrop-filter blur(20px) saturate(180%).
/// Maison Neue Extended for the logo mark, Maison Neue for links.
/// Server-rendered; all motion is CSS-only.
///
/// Three-section layout:
///   Left:  dievas logo
///   Center: nav links (hidden on mobile)
///   Right:  pub.dev CTA pill
class Nav extends StatelessComponent {
  const Nav({super.key});

  @override
  Component build(BuildContext context) {
    return header(
      id: 'site-nav',
      classes: 'fixed top-5 left-0 right-0 z-50 flex justify-center pointer-events-none',
      attributes: const {'style': 'transition: transform 0.4s cubic-bezier(0.4,0,0.2,1);'},
      [
        nav(
          classes:
              'pointer-events-auto '
              'flex items-center justify-between '
              'px-4 md:px-7 py-3 '
              'rounded-full',
          attributes: const {
            'style':
                'width: min(860px, calc(100% - 20vw)); '
                'background: rgba(12, 12, 12, 0.55); '
                'backdrop-filter: blur(20px) saturate(180%); '
                '-webkit-backdrop-filter: blur(20px) saturate(180%); '
                'border: 1px solid rgba(255, 255, 255, 0.1); '
                'box-shadow: 0 8px 32px rgba(0, 0, 0, 0.25);',
          },
          [
            // ── Left: Logo ──────────────────────────────────────────────────
            a(
              href: '/',
              classes:
                  'logo-mark no-underline flex items-center gap-px '
                  'font-display font-medium text-lg md:text-xl '
                  'tracking-[0.02em] text-text-hi',
              [
                Component.text('die'),
                span(classes: 'text-brand', [Component.text('v')]),
                Component.text('as'),
              ],
            ),

            // ── Center: Nav links — hidden on mobile ─────────────────────────
            div(classes: 'hidden md:flex items-center gap-6', [
              for (final lnk in _links)
                a(
                  href: lnk.$2,
                  classes:
                      'nav-link font-body font-medium text-xs tracking-[0.08em] uppercase '
                      'text-text-mid no-underline '
                      'transition-colors duration-200 '
                      'hover:text-white',
                  attributes: {if (lnk.$3) 'target': '_blank', if (lnk.$3) 'rel': 'noopener'},
                  [
                    span(classes: 'flex items-center gap-2', [
                      span(
                        classes: 'nav-dot inline-block w-1 h-1 rounded-full bg-text-mid',
                        attributes: const {'style': 'transition: all 0.3s cubic-bezier(0.22,1,0.36,1);'},
                        [],
                      ),
                      Component.text(lnk.$1),
                    ]),
                  ],
                ),
            ]),

            // ── Right: CTA pill ─────────────────────────────────────────────
            a(
              href: DievasUrls.dievasPubDevURL,
              attributes: const {'target': '_blank', 'rel': 'noopener'},
              classes:
                  'inline-flex items-center gap-1.5 '
                  'px-3.5 md:px-4 py-1.5 md:py-2 '
                  'rounded-full '
                  'bg-action text-on-brand '
                  'font-mono text-xs font-medium tracking-wide '
                  'no-underline '
                  'transition-all duration-200 '
                  'hover:bg-action-hover hover:-translate-y-px '
                  'hover:shadow-[0_4px_16px_rgba(99,102,241,0.35)]',
              [
                span(classes: 'hidden md:inline', [Component.text('pub.dev')]),
                span(classes: 'md:hidden', [Component.text('pub')]),
                Component.text(' →'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  static const _links = [
    ('Components', '#components', false),
    ('Architecture', '#architecture', false),
    ('Gallery', DievasUrls.gallery, true),
    ('GitHub', DievasUrls.github, true),
  ];
}
