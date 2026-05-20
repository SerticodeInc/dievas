import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

/// Hero section — above-the-fold landing content.
///
/// Animation layers — all gated on body.js-loaded (added via rAF in app.dart):
///   • Eyebrow + headline words → `.word-in` (perspective rotateX tilt reveal)
///   • Product chips → `.chip-falling` (perspective rotateX + translateY fall)
///   • Marquee strip → `.marquee-track` CSS infinite scroll
///
/// No Jaspr client hydration required.
class Hero extends StatelessComponent {
  const Hero({super.key});

  @override
  Component build(BuildContext context) => section(
    id: 'hero',
    classes: 'relative overflow-hidden flex flex-col',
    attributes: const {'style': 'min-height: 120svh; background: #171717;'},
    [
      // ── Background word mark ──────────────────────────────────────────────────
      div(
        classes:
            'pointer-events-none select-none '
            'absolute inset-x-0 bottom-0 '
            'flex justify-center overflow-hidden',
        [
          span(
            classes: 'font-display font-black whitespace-nowrap text-brand',
            attributes: const {
              'style':
                  'font-size: clamp(110px, 24vw, 360px); '
                  'line-height: 0.85; '
                  'letter-spacing: -0.02em; '
                  'opacity: 0.12;',
            },
            [Component.text('DIEVAS')],
          ),
        ],
      ),

      // ── CENTER CONTENT — above fold ──────────────────────────────────────────
      // Inline padding-top so this compiles regardless of Tailwind JIT cache.
      // pt-40 = 160px clears the fixed nav (top-5 + ~48px pill height + comfort).
      div(
        classes: 'relative z-10 flex flex-col items-center text-center px-6',
        attributes: const {'style': 'padding-top: 160px; padding-bottom: 32px;'},
        [
          // Eyebrow
          p(
            classes: 'section-eyebrow font-display text-sm tracking-[0.16em] uppercase word-in',
            attributes: const {'style': 'animation-delay: 0.06s; margin-bottom: 32px;'},
            [Component.text('✶  Flutter Design System')],
          ),

          // Headline — each word is a separate animated span (Anchor word-reveal)
          h1(
            classes: 'font-display font-black leading-[0.92] tracking-[-0.025em] text-text-hi',
            attributes: const {'style': 'font-size: clamp(54px, 8.5vw, 116px); margin-bottom: 32px;'},
            [
              span(
                classes: 'word-in',
                attributes: const {'style': 'animation-delay: 0.16s'},
                [Component.text('Every')],
              ),
              Component.text(' '),
              span(
                classes: 'word-in',
                attributes: const {'style': 'animation-delay: 0.27s'},
                [Component.text('token')],
              ),
              span(
                classes: 'word-in text-brand',
                attributes: const {'style': 'animation-delay: 0.31s'},
                [Component.text('.')],
              ),
              br(),
              span(
                classes: 'word-in text-slate-400',
                attributes: const {'style': 'animation-delay: 0.43s'},
                [Component.text('Every')],
              ),
              Component.text(' '),
              span(
                classes: 'word-in text-slate-400',
                attributes: const {'style': 'animation-delay: 0.54s'},
                [Component.text('brand')],
              ),
              span(
                classes: 'word-in text-slate-400',
                attributes: const {'style': 'animation-delay: 0.58s'},
                [Component.text('.')],
              ),
            ],
          ),

          // Subtitle
          p(
            classes: 'max-w-sm font-body font-light text-base leading-[1.8] text-slate-500 word-in',
            attributes: const {'style': 'animation-delay: 0.7s; margin-bottom: 40px;'},
            [
              Component.text(
                'Production grade Flutter components built from the token layer up. '
                'Your apps own the brand. The system stays out of the way.',
              ),
            ],
          ),

          // CTAs
          div(
            classes: 'flex items-center gap-4 flex-wrap justify-center word-in',
            attributes: const {'style': 'animation-delay: 0.82s'},
            [
              /// *** Keep the below for a forth night till we decide if we want to send this to pub.dev.
              /* a(
                href: DievasUrls.pubDev,
                attributes: const {'target': '_blank', 'rel': 'noopener'},
                classes:
                    'inline-flex items-center gap-2 '
                    'px-6 py-3 rounded-md '
                    'bg-action text-on-brand '
                    'font-mono text-sm font-medium tracking-wide '
                    'no-underline transition-all duration-200 '
                    'hover:bg-action-hover hover:-translate-y-px '
                    'hover:shadow-[0_8px_32px_rgba(129,140,248,0.35)]',
                [
                  Component.text('View on pub.dev'),
                  span(classes: 'text-xs', [Component.text('→')]),
                ],
              ), */
              a(
                href: DievasUrls.gallery,
                attributes: const {'target': '_blank', 'rel': 'noopener'},
                classes:
                    'inline-flex items-center gap-2 '
                    'px-6 py-3 rounded-md '
                    'bg-action text-on-brand '
                    'font-mono text-sm font-medium tracking-wide '
                    'no-underline transition-all duration-200 '
                    'hover:bg-action-hover hover:-translate-y-px '
                    'hover:shadow-[0_8px_32px_rgba(129,140,248,0.35)]',

                /// *** Initial version, restore if and when we set up pub.dev
                /* classes:
                    'inline-flex items-center gap-2 '
                    'px-6 py-3 rounded-md '
                    'border border-slate-300 text-slate-600 '
                    'font-mono text-sm font-normal '
                    'no-underline transition-all duration-200 '
                    'hover:border-brand hover:text-white hover:-translate-y-px', */
                [Component.text('Gallery')],
              ),
            ],
          ),

          // Manifest strip — stat bar
          div(
            classes: 'flex items-center flex-wrap justify-center word-in',
            attributes: const {'style': 'animation-delay: 0.94s; margin-top: 56px; padding-top: 40px;'},
            [
              _manifestItem('3', 'packages'),
              _manifestSep(),
              _manifestItem('25', 'components'),
              _manifestSep(),
              _manifestItem('9', 'theme aspects'),
              _manifestSep(),
              _manifestItem('∞', 'brands'),
            ],
          ),
        ],
      ),

      // ── PRODUCT CHIP STRIP — Anchor cc-falling cards ─────────────────────────
      //
      // Five category cards analogous to Anchor's product-tool chips.
      // Each falls with a staggered chip-fall animation (3D perspective + overshoot).
      // Horizontally scrollable on mobile — like Anchor's cc-sliding section.
      // Glass morphism: semi-transparent dark backgrounds + backdrop-filter blur.
      div(
        classes: 'relative z-10 w-full overflow-x-auto',
        attributes: const {
          'style':
              '-webkit-overflow-scrolling: touch; '
              'scrollbar-width: none; '
              'padding-bottom: 4px; '
              'margin-top: 40px;',
        },
        [
          div(
            attributes: const {
              'style':
                  'display: flex; '
                  'gap: 12px; '
                  'padding: 0 4px 4px; '
                  'min-width: max-content; '
                  'max-width: 1152px; '
                  'margin: 0 auto;',
            },
            [
              _productChip(
                title: 'Buttons',
                count: '4 shipped',
                detail: 'Filled · Outlined · Text · Icon',
                bg: 'rgba(99, 102, 241, 0.02)',
                accentRgb: '129, 140, 248',
                fg: '#C7D2FE',
                index: 0,
              ),
              _productChip(
                title: 'Form',
                count: '5 shipped',
                detail: 'TextField · TextArea\nCheckbox · Switch · Radio',
                bg: 'rgba(74, 222, 128, 0.02)',
                accentRgb: '74, 222, 128',
                fg: '#A7F3D0',
                index: 1,
              ),
              _productChip(
                title: 'Display',
                count: '10 shipped',
                detail: 'Avatar · Badge · Tag\nDivider · Progress · Loader · Icon',
                bg: 'rgba(251, 191, 36, 0.02)',
                accentRgb: '251, 191, 36',
                fg: '#FDE68A',
                index: 2,
              ),
              _productChip(
                title: 'System',
                count: '9 typed aspects',
                detail: 'InheritedModel · Multi-brand\nZero hardcoded values',
                bg: 'rgba(56, 189, 248, 0.02)',
                accentRgb: '56, 189, 248',
                fg: '#BAE6FD',
                index: 3,
              ),
              _productChip(
                title: 'In Progress',
                count: '17 coming',
                detail: 'Accordion · AuthCode · Carousel\nDrawer · Dropdown · Popover · ...',
                bg: 'rgba(251, 113, 133, 0.02)',
                accentRgb: '251, 113, 133',
                fg: '#FECDD3',
                index: 4,
              ),
            ],
          ),
        ],
      ),

      // ── MARQUEE STRIP — infinite component name ticker ────────────────────────
      //
      // `.marquee-track` animation fires only when body.js-loaded is set.
      // Outer div clips overflow so only the visible portion is shown.
      div(
        classes: 'relative z-10 w-full',
        attributes: const {'style': 'overflow: hidden; padding: 14px 0;'},
        [
          div(classes: 'marquee-track', [
            for (final name in [..._allComponents, ..._allComponents])
              span(
                classes: 'font-mono text-xs text-slate-400 whitespace-nowrap',
                attributes: const {'style': 'display: inline-flex; align-items: center; gap: 8px; padding: 0 20px;'},
                [
                  div(
                    classes: 'inline-block rounded-full flex-shrink-0',
                    attributes: const {'style': 'width: 4px; height: 4px; background: rgba(148,163,184,0.6);'},
                    [],
                  ),
                  Component.text(name),
                ],
              ),
          ]),
        ],
      ),

      // ── LINK BADGES ──────────────────────────────────────────────────────────
      div(
        classes: 'relative z-10 flex items-center justify-center gap-3',
        attributes: const {'style': 'padding: 20px 24px 32px;'},
        [
          a(
            href: DievasUrls.portfolio,
            attributes: const {'target': '_blank', 'rel': 'noopener'},
            classes:
                'flex items-center gap-2.5 '
                'bg-bg-elevated border border-border-brand '
                'rounded-xl px-4 py-2.5 '
                'font-mono text-xs text-text-hi no-underline '
                'shadow-[0_8px_32px_rgba(0,0,0,0.5)] '
                'transition-all duration-200 '
                'hover:border-brand hover:text-brand hover:-translate-y-px',
            [div(classes: 'w-2 h-2 rounded-full bg-brand flex-shrink-0', []), Component.text('Serticode Inc.')],
          ),
          a(
            href: DievasUrls.moonDs,
            attributes: const {'target': '_blank', 'rel': 'noopener'},
            classes:
                'flex items-center gap-2.5 '
                'bg-bg-elevated border border-border '
                'rounded-xl px-4 py-2.5 '
                'font-mono text-xs text-text-hi no-underline '
                'shadow-[0_8px_32px_rgba(0,0,0,0.5)] '
                'transition-all duration-200 '
                'hover:border-brand/50 hover:text-brand hover:-translate-y-px',
            [div(classes: 'w-2 h-2 rounded-full bg-brand/50 flex-shrink-0', []), Component.text('Moon DS')],
          ),
        ],
      ),
    ],
  );

  // ── Product chip (Anchor product-tool card) ──────────────────────────────────
  //
  // Glass morphism: semi-transparent dark background + backdrop-filter blur so
  // the hero canvas (dark + DIEVAS watermark) subtly bleeds through.
  // Matches Anchor's cc-falling pattern: title · count label · detail · arrow.

  Component _productChip({
    required String title,
    required String count,
    required String detail,
    required String bg,
    required String accentRgb,
    required String fg,
    required int index,
  }) {
    final delay = 1.1 + (index * 0.12);
    return div(
      classes: 'chip-falling flex-shrink-0 rounded-2xl relative',
      attributes: {
        'style':
            'animation-delay: ${delay}s; '
            'background: $bg; '
            'backdrop-filter: blur(16px) saturate(200%); '
            '-webkit-backdrop-filter: blur(16px) saturate(200%); '
            'border: 1px solid rgba($accentRgb, 0.8); '
            'box-shadow: '
            '  0 1px 0 rgba(255,255,255,0.05) inset, '
            '  0 8px 24px rgba(0,0,0,0.05); '
            'width: 280px; '
            'height: 240px; '
            'padding: 16px; '
            'display: flex; '
            'flex-direction: column; '
            'justify-content: space-between;',
      },
      [
        // Top row: count label + arrow
        div(
          attributes: const {'style': 'display: flex; align-items: center; justify-content: space-between;'},
          [
            span(
              attributes: {
                'style':
                    'font-family: ui-monospace, monospace; '
                    'font-size: 12px; '
                    'letter-spacing: 0.14em; '
                    'text-transform: uppercase; '
                    'color: rgba($accentRgb, 1); '
                    'opacity: 0.85;',
              },
              [Component.text(count)],
            ),
          ],
        ),

        // Large category name
        span(
          attributes: {
            'style':
                'font-family: "Maison Neue Extended", system-ui, sans-serif; '
                'font-size: 28px; '
                'font-weight: 900; '
                'letter-spacing: -0.025em; '
                'color: $fg; '
                'line-height: 1.0;',
          },
          [Component.text(title)],
        ),

        // Detail / component list
        span(
          attributes: {
            'style':
                'font-family: ui-monospace, monospace; '
                'font-size: 12px; '
                'color: $fg; '
                'opacity: 0.45; '
                'line-height: 1.7; '
                'white-space: pre-line;',
          },
          [Component.text(detail)],
        ),
      ],
    );
  }

  Component _manifestItem(String value, String label) => span(classes: 'font-mono text-base text-text-mid', [
    span(classes: 'text-text-hi', [Component.text(value)]),
    Component.text(' $label'),
  ]);

  Component _manifestSep() => span(classes: 'font-mono text-sm text-text-lo mx-3 select-none', [Component.text('·')]);

  static const _allComponents = [
    'FilledButton',
    'OutlinedButton',
    'TextButton',
    'IconButton',
    'TextInput',
    'TextArea',
    'Checkbox',
    'Switch',
    'Radio',
    'Avatar',
    'Badge',
    'Tag',
    'Divider',
    'CircularProgress',
    'LinearProgress',
    'Icon',
    'CircularLoader',
    'LinearLoader',
    'EmptyState',
    'Alert',
    'BottomSheet',
    'Modal',
    'Snackbar',
    'Banner',
    'Tooltip',
  ];
}
