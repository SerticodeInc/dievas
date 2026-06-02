import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

/// Fixed top navigation — glass pill matching Serti0x.
///
/// Centered pill, `min(860px, calc(100% - 20vw))` wide.
/// Glass: rgba(12,12,12,0.55) + backdrop-filter blur(20px) saturate(180%).
/// Maison Neue Extended for the logo mark, Maison Neue for links.
/// Server-rendered; all motion is CSS-only.
///
/// Micro animations:
/// - dievas text scales to 1.25rem
/// - nav links fade to white on hover
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
              'px-7 py-3.5 '
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
            // Logo mark — subtle letter-spacing shift on hover
            a(
              href: '/',
              classes:
                  'logo-mark no-underline flex items-center gap-px '
                  'font-display font-medium text-xl tracking-[0.02em] text-text-hi',
              [
                Component.text('die'),
                span(classes: 'text-brand', [Component.text('v')]),
                Component.text('as'),
              ],
            ),

            // Links — with hover dot indicators
            div(classes: 'flex items-center gap-7', [
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
          ],
        ),
      ],
    );
  }

  static const _links = [
    /// *** We might need to have docs here to show people how to use it
    ///('Docs', '#', false),
    ('Gallery', DievasUrls.gallery, true),
  ];
}
