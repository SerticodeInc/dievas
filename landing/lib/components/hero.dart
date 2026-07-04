import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

/// Hero section — above-the-fold landing content.
///
/// Gradient mesh background, glassmorphism elements, animated entry.
/// Sub-components (badge, bottom cards, product chips) inlined as
/// private methods for a single-file section.
class Hero extends StatelessComponent {
  const Hero({super.key});

  @override
  Component build(BuildContext context) => section(
    id: 'hero',
    classes: 'relative overflow-hidden flex flex-col',
    attributes: const {'style': 'min-height: 100svh;'},
    [
      // Decorative floating particles
      for (var i = 0; i < 6; i++) div(classes: 'particle-dot', []),

      // ── MAIN CONTENT — viewport height area ────────────────────────────────
      div(
        classes: 'relative z-10 flex flex-col flex-1',
        attributes: const {'style': 'padding-top: 140px;'},
        [
          // Center content
          div(classes: 'flex flex-col items-center text-center px-6', [
            _heroBadge(),
            _headline(),
            _subtitle(),
            _ctas(),
          ]),

          // Push bottom cards to the bottom
          div(classes: 'flex-1', []),

          // Bottom row
          div(
            classes: 'flex items-end justify-between px-6 pb-6 md:px-8 md:pb-8',
            [_bottomLeftCard(), _bottomRightCorner()],
          ),
        ],
      ),

      // ── PRODUCT CHIPS — below viewport fold ─────────────────────────────────
      div(
        classes: 'relative z-10 w-full overflow-x-auto',
        attributes: const {
          'style':
              'scrollbar-width: none; '
              '-webkit-overflow-scrolling: touch; '
              'padding-bottom: 48px;',
        },
        [
          div(
            attributes: const {
              'style':
                  'display: flex; '
                  'gap: 12px; '
                  'padding: 0 24px 4px; '
                  'min-width: max-content; '
                  'max-width: 1152px; '
                  'margin: 0 auto;',
            },
            [
              _productChip(
                title: 'Buttons',
                count: '4 shipped',
                detail: 'Filled · Outlined · Text · Icon',
                bg: 'rgba(99, 102, 241, 0.03)',
                accentRgb: '129, 140, 248',
                fg: '#C7D2FE',
                index: 0,
              ),
              _productChip(
                title: 'Form',
                count: '12 shipped',
                detail:
                    'TextField · TextArea · Search · AuthCode\n'
                    'Checkbox · Switch · Radio · Dropdown · SegmentedControl',
                bg: 'rgba(74, 222, 128, 0.03)',
                accentRgb: '74, 222, 128',
                fg: '#A7F3D0',
                index: 1,
              ),
              _productChip(
                title: 'Display',
                count: '9 shipped',
                detail: 'Avatar · Badge · Tag · Icon\nDivider · Progress · Loader',
                bg: 'rgba(251, 191, 36, 0.03)',
                accentRgb: '251, 191, 36',
                fg: '#FDE68A',
                index: 2,
              ),
              _productChip(
                title: 'System',
                count: '9 typed aspects',
                detail: 'InheritedModel · Multi-brand\nZero hardcoded values',
                bg: 'rgba(56, 189, 248, 0.03)',
                accentRgb: '56, 189, 248',
                fg: '#BAE6FD',
                index: 3,
              ),
              _productChip(
                title: 'Up Next',
                count: '4 planned',
                detail: 'Carousel · Table\nSingleSelectComboBox · MultiSelectComboBox',
                bg: 'rgba(251, 113, 133, 0.03)',
                accentRgb: '251, 113, 133',
                fg: '#FECDD3',
                index: 4,
              ),
            ],
          ),
        ],
      ),
    ],
  );

  // ── HeroBadge — glass pill with sparkle ─────────────────────────────────────

  Component _heroBadge() => div(
    classes: 'hero-badge word-in',
    attributes: const {'style': 'animation-delay: 0.06s; margin-bottom: 32px;'},
    [
      RawText(_sparkleSvg),
      span(classes: 'font-mono text-xs tracking-[0.12em] uppercase text-brand', [
        Component.text('Dievas Design System'),
      ]),
    ],
  );

  // ── Headline — word-in staggered ───────────────────────────────────────────

  Component _headline() => h1(
    classes: 'font-display font-black leading-[0.92] tracking-[-0.025em] text-text-hi',
    attributes: const {'style': 'font-size: clamp(48px, 7.5vw, 104px); margin-bottom: 24px;'},
    [
      span(classes: 'word-in', attributes: const {'style': 'animation-delay: 0.16s'}, [
        Component.text('Tokens'),
      ]),
      Component.text(' '),
      span(classes: 'word-in', attributes: const {'style': 'animation-delay: 0.27s'}, [
        Component.text('that'),
      ]),
      Component.text(' '),
      span(classes: 'word-in text-brand', attributes: const {'style': 'animation-delay: 0.38s'}, [
        Component.text('scale.'),
      ]),
    ],
  );

  // ── Subtitle ───────────────────────────────────────────────────────────────

  Component _subtitle() => p(
    classes: 'max-w-md font-body font-light text-base leading-[1.8] text-slate-500 word-in',
    attributes: const {'style': 'animation-delay: 0.55s; margin-bottom: 40px;'},
    [
      Component.text(
        'Production-grade Flutter components built from the token layer up. '
        'Every brand. Zero hardcoded values.',
      ),
    ],
  );

  // ── CTA buttons ────────────────────────────────────────────────────────────

  Component _ctas() => div(
    classes: 'flex items-center gap-4 flex-wrap justify-center word-in cta-group',
    attributes: const {'style': 'animation-delay: 0.7s'},
    [
      a(
        href: DievasUrls.dievasPubDevURL,
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
          span(classes: 'cta-arrow text-xs', [Component.text('→')]),
        ],
      ),
      a(
        href: DievasUrls.gallery,
        attributes: const {'target': '_blank', 'rel': 'noopener'},
        classes:
            'group inline-flex items-center gap-2 '
            'px-6 py-3 rounded-md '
            'bg-action text-on-brand '
            'font-mono text-sm font-medium tracking-wide '
            'no-underline transition-all duration-200 '
            'hover:bg-action-hover hover:-translate-y-px '
            'hover:shadow-[0_8px_32px_rgba(129,140,248,0.35)]',
        [
          Component.text('Gallery'),
          span(classes: 'cta-arrow text-xs', [Component.text('→')]),
        ],
      ),
    ],
  );

  // ── BottomLeftCard — glass stat card ───────────────────────────────────────

  Component _bottomLeftCard() => div(
    classes:
        'glass-card rounded-2xl p-4 md:p-5 '
        'flex flex-col gap-3 md:gap-4 '
        'min-w-[160px] md:min-w-[200px]',
    [
      div(classes: 'flex items-end gap-4 md:gap-6', [
        _statBlock('36', 'components'),
        _statBlock('9', 'aspects'),
        _statBlock('3', 'packages'),
      ]),
      a(
        href: DievasUrls.gallery,
        attributes: {'target': '_blank', 'rel': 'noopener'},
        classes:
            'inline-flex items-center gap-2 self-start '
            'px-3.5 py-1.5 rounded-full '
            'bg-white/10 text-brand '
            'font-mono text-[11px] font-medium tracking-wide '
            'no-underline '
            'transition-all duration-200 '
            'hover:bg-white/15 hover:-translate-y-px',
        [
          Component.text('View Gallery'),
          RawText(_arrowUpRightSvg),
        ],
      ),
    ],
  );

  Component _statBlock(String value, String label) => div(classes: 'bottom-card-stat', [
    span(classes: 'bottom-card-stat-value', [Component.text(value)]),
    span(classes: 'bottom-card-stat-label', [Component.text(label)]),
  ]);

  // ── BottomRightCorner — glass docs card ────────────────────────────────────

  Component _bottomRightCorner() => div(
    classes: 'glass-card corner-card p-3 md:p-4 flex items-center gap-3 md:gap-4',
    [
      div(
        classes:
            'flex items-center justify-center '
            'w-9 h-9 md:w-11 md:h-11 '
            'rounded-full bg-white/5 border border-white/10',
        [RawText(_arrowUpRightSvg)],
      ),
      div(classes: 'flex flex-col', [
        span(classes: 'font-display font-semibold text-sm md:text-base text-text-hi leading-tight', [
          Component.text('GitHub'),
        ]),
        a(
          href: DievasUrls.github,
          attributes: {'target': '_blank', 'rel': 'noopener'},
          classes:
              'flex items-center gap-1 '
              'text-xs text-text-mid no-underline '
              'transition-colors duration-200 '
              'hover:text-brand',
          [
            Component.text('Repository'),
            RawText(_chevronRightSvg),
          ],
        ),
      ]),
    ],
  );

  // ── Product chip — glass category card ──────────────────────────────────────

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
      classes: 'chip-falling product-chip flex-shrink-0 rounded-2xl relative',
      attributes: {
        'style':
            '--accent-rgb: $accentRgb; '
            'animation-delay: ${delay}s; '
            'background: $bg; '
            'backdrop-filter: blur(16px) saturate(200%); '
            '-webkit-backdrop-filter: blur(16px) saturate(200%); '
            'border: 1px solid rgba($accentRgb, 0.6); '
            'box-shadow: '
            '  0 1px 0 rgba(255,255,255,0.04) inset, '
            '  0 8px 24px rgba(0,0,0,0.08); '
            'width: 260px; '
            'height: 220px; '
            'padding: 20px; '
            'display: flex; '
            'flex-direction: column; '
            'justify-content: space-between;',
      },
      [
        div(
          attributes: const {'style': 'display: flex; align-items: center; justify-content: space-between;'},
          [
            span(
              attributes: {
                'style':
                    'font-family: ui-monospace, monospace; '
                    'font-size: 11px; '
                    'letter-spacing: 0.14em; '
                    'text-transform: uppercase; '
                    'color: rgba($accentRgb, 1); '
                    'opacity: 0.85;',
              },
              [Component.text(count)],
            ),
          ],
        ),
        span(
          attributes: {
            'style':
                'font-family: "Maison Neue Extended", system-ui, sans-serif; '
                'font-size: 26px; '
                'font-weight: 900; '
                'letter-spacing: -0.02em; '
                'color: $fg; '
                'line-height: 1.0;',
          },
          [Component.text(title)],
        ),
        span(
          attributes: {
            'style':
                'font-family: ui-monospace, monospace; '
                'font-size: 11px; '
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

  // ── Inline SVGs ────────────────────────────────────────────────────────────

  static const _sparkleSvg =
      '''<svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 2L13.09 8.26L18 6L14.74 11.91L20 13.17L13.83 14.26L16 20L10.09 15.91L7 21L7.74 14.26L2 11.91L8.26 10.09L6 5L11.91 8.09L12 2Z" fill="#818CF8"/></svg>''';

  static const _arrowUpRightSvg =
      '''<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#818CF8" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M7 17L17 7"/><path d="M7 7H17V17"/></svg>''';

  static const _chevronRightSvg =
      '''<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 18L15 12L9 6"/></svg>''';
}
