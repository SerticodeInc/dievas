import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

/// Hero section — above-the-fold landing content.
///
/// Left copy column in normal flow, right side handled by two absolutely-
/// positioned layers:
///   1. `_rightContainment` — large rounded frame, stops 88px from the bottom,
///      creating the "cut-out" space at bottom-right.
///   2. Social icon badges — sit in that cut-out space.
///
/// All motion is CSS-only. No hydration required.
class Hero extends StatelessComponent {
  const Hero({super.key});

  @override
  Component build(
    BuildContext context,
  ) => section(classes: 'relative min-h-screen overflow-hidden flex items-start lg:items-center', [
    // Ambient glow behind everything
    div(classes: 'pointer-events-none absolute inset-0 flex items-center justify-center', [
      div(classes: 'w-[700px] h-[500px] rounded-full bg-brand/8 blur-[120px]', []),
    ]),

    // Background word mark — desktop only, pinned to the bottom of the hero.
    // Hidden on mobile; mobile gets an in-flow version inside the left column
    // so it sits precisely above the gallery preview.
    div(
      classes:
          'pointer-events-none select-none '
          'absolute inset-x-0 bottom-0 '
          'hidden lg:flex justify-center overflow-hidden',
      [
        span(
          classes: 'font-display font-bold whitespace-nowrap text-brand',
          attributes: const {
            'style':
                'font-size: clamp(120px, 24vw, 340px); '
                'line-height: 0.85; '
                'letter-spacing: -0.02em; '
                'opacity: 0.05;',
          },
          [Component.text('DIEVAS')],
        ),
      ],
    ),

    // ── LEFT COLUMN — editorial copy ──────────────────────────────────────
    // padding-right: 56% pushes the content box to stay within the left 44%
    // of the viewport on lg+, avoiding overlap with the absolutely-positioned
    // right panel that starts at left: 45%. On mobile, pr-4 is used instead.
    div(
      classes:
          'relative z-10 flex flex-col w-full '
          'items-center lg:items-start '
          'text-center lg:text-left '
          'px-6 lg:px-0 lg:ml-[max(40px,9vw)] '
          'pt-28 pb-8 lg:pt-24 lg:pb-24 '
          'pr-6 lg:pr-[56%] '
          'opacity-0 animate-[fade-up_0.5s_ease_0.05s_forwards]',
      [
        // Eyebrow
        p(
          classes:
              'section-eyebrow font-display text-sm tracking-[0.16em] uppercase mb-7 '
              'opacity-0 animate-[fade-up_0.6s_ease_0.1s_forwards]',
          [Component.text('✶  Flutter Design System')],
        ),

        // Display headline
        h1(
          classes:
              'font-display text-[clamp(50px,6.5vw,86px)] font-black leading-[0.93] '
              'tracking-[-0.025em] mb-8 '
              'opacity-0 animate-[fade-up_0.7s_ease_0.2s_forwards]',
          [
            span(classes: 'text-text-lo', [Component.text('Build')]),
            br(),
            Component.text('Once'),
            span(classes: 'text-brand', [Component.text('.')]),
            br(),
            span(classes: 'text-text-lo', [Component.text('Ship')]),
            br(),
            Component.text('Anywhere'),
            span(classes: 'text-brand', [Component.text('.')]),
          ],
        ),

        // Subtitle
        p(
          classes:
              'max-w-sm font-body font-light text-sm leading-[1.8] '
              'text-text-mid mb-10 '
              'opacity-0 animate-[fade-up_0.7s_ease_0.35s_forwards]',
          [
            Component.text(
              "Dievas ports Moon Design System's component catalogue. "
              'Token-driven. InheritedModel-first. Multi-brand.',
            ),
          ],
        ),

        // CTAs
        div(
          classes:
              'flex items-center gap-4 flex-wrap '
              'opacity-0 animate-[fade-up_0.7s_ease_0.48s_forwards]',
          [
            a(
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
            ),
            a(
              href: DievasUrls.gallery,
              attributes: const {'target': '_blank', 'rel': 'noopener'},
              classes:
                  'inline-flex items-center gap-2 '
                  'px-6 py-3 rounded-md '
                  'border border-border-brand text-text-mid '
                  'font-mono text-sm font-normal '
                  'no-underline transition-all duration-200 '
                  'hover:border-brand hover:text-text-hi hover:-translate-y-px',
              [Component.text('Gallery')],
            ),
          ],
        ),

        // Stats
        div(
          classes:
              'flex gap-10 flex-wrap '
              'mt-16 pt-10 border-t border-border '
              'opacity-0 animate-[fade-up_0.7s_ease_0.62s_forwards]',
          [
            _stat('3', 'packages'),
            _stat('2', 'default themes'),
            _stat('16', 'components'),
            _stat('∞', 'brand configs'),
          ],
        ),

        // Mobile word mark — in-flow so it sits directly above the preview image.
        // Desktop uses the absolutely-positioned bottom version instead.
        div(classes: 'lg:hidden w-full text-center overflow-hidden mt-8 -mb-24', [
          span(
            classes: 'font-display font-bold whitespace-nowrap text-brand',
            attributes: const {
              'style':
                  'font-size: clamp(80px, 24vw, 140px); '
                  'line-height: 0.85; '
                  'letter-spacing: -0.02em; '
                  'opacity: 0.12;',
            },
            [Component.text('DIEVAS')],
          ),
        ]),

        // Mobile preview — gallery app window peek, desktop hides this
        div(
          classes:
              'lg:hidden relative w-full mt-10 h-[260px] rounded-2xl overflow-hidden '
              'opacity-0 animate-[fade-up_0.7s_ease_0.72s_forwards]',
          attributes: const {
            'style':
                'background: linear-gradient(160deg, rgba(28,44,82,1) 0%, rgba(18,28,60,1) 45%, rgba(8,13,32,1) 100%); '
                'border: 1px solid rgba(129,140,248,0.22); '
                'box-shadow: inset 0 1px 0 rgba(255,255,255,0.08), '
                '0 24px 64px rgba(0,0,0,0.6);',
          },
          [
            // Radial glow inside the frame
            div(
              classes: 'pointer-events-none absolute top-0 left-0 right-0',
              attributes: const {
                'style':
                    'height: 140px; '
                    'background: radial-gradient(ellipse 70% 50% at 55% 0%, rgba(129,140,248,0.14) 0%, transparent 75%);',
              },
              [],
            ),
            // App window — clipped to h-[260px], shows browser chrome + top content
            div(classes: 'absolute inset-0 p-3', [_appWindow()]),
            // Gradient vignette fades the bottom edge of the preview
            div(
              classes: 'pointer-events-none absolute bottom-0 left-0 right-0',
              attributes: const {
                'style':
                    'height: 96px; '
                    'background: linear-gradient(to bottom, transparent, rgba(8,13,32,0.97));',
              },
              [],
            ),
          ],
        ),
      ],
    ),

    // ── RIGHT CONTAINMENT — the framed region ─────────────────────────────
    // Stops 88px from the section bottom, leaving the cut-out space for icons.
    // Bleeds 32px past the right viewport edge — section overflow-hidden clips it.
    div(
      classes:
          'absolute hidden lg:block top-[88px] rounded-[32px] overflow-hidden '
          'opacity-0 animate-[fade-up_0.8s_ease_0.4s_forwards]',
      attributes: const {
        'style':
            'left: 45%; right: -32px; bottom: 88px; '
            'background: linear-gradient(160deg, rgba(28,44,82,1) 0%, rgba(18,28,60,1) 45%, rgba(8,13,32,1) 100%); '
            'border: 1px solid rgba(129,140,248,0.22); '
            'box-shadow: inset 0 1px 0 rgba(255,255,255,0.08), '
            '0 0 0 1px rgba(129,140,248,0.06), '
            '0 48px 120px rgba(0,0,0,0.7);',
      },
      [
        // Top screen-edge shine
        div(
          classes: 'pointer-events-none absolute top-0 left-0 right-0',
          attributes: const {
            'style':
                'height: 1px; '
                'background: linear-gradient(90deg, transparent 0%, rgba(255,255,255,0.18) 40%, rgba(129,140,248,0.3) 60%, transparent 100%);',
          },
          [],
        ),

        // Inner top radial glow
        div(
          classes: 'pointer-events-none absolute top-0 left-0 right-0',
          attributes: const {
            'style':
                'height: 280px; '
                'background: radial-gradient(ellipse 70% 50% at 55% 0%, rgba(129,140,248,0.16) 0%, transparent 75%);',
          },
          [],
        ),

        // Bottom vignette — fades content into the frame's dark base
        div(
          classes: 'pointer-events-none absolute bottom-0 left-0 right-0',
          attributes: const {
            'style':
                'height: 160px; '
                'background: linear-gradient(to bottom, transparent, rgba(8,13,32,0.96));',
          },
          [],
        ),

        // App window — inside the frame, bleeds past right edge (frame clips)
        div(classes: 'absolute top-8 left-6 bottom-8', attributes: const {'style': 'right: -36px;'}, [_appWindow()]),

        // Tooltip — top right
        div(
          classes:
              'absolute top-8 right-20 '
              'bg-bg-elevated border border-border-brand '
              'rounded-xl px-4 py-2.5 '
              'flex items-center gap-2.5 '
              'shadow-[0_8px_32px_rgba(0,0,0,0.5)] '
              'animate-[float-slow_4s_ease-in-out_0.3s_infinite]',
          [
            div(classes: 'w-2 h-2 rounded-full bg-brand flex-shrink-0', []),
            span(classes: 'font-mono text-xs text-text-hi whitespace-nowrap', [Component.text('9 theme aspects')]),
          ],
        ),

        // Tooltip — mid left
        div(
          classes:
              'absolute bottom-24 left-8 '
              'bg-bg-elevated border border-border '
              'rounded-xl px-4 py-2.5 '
              'flex items-center gap-2.5 '
              'shadow-[0_8px_32px_rgba(0,0,0,0.5)] '
              'animate-[float-slow_4s_ease-in-out_1.8s_infinite]',
          [
            div(classes: 'w-2 h-2 rounded-full bg-[#4ADE80] flex-shrink-0', []),
            span(classes: 'font-mono text-xs text-text-hi whitespace-nowrap', [
              Component.text('Zero hardcoded values'),
            ]),
          ],
        ),
      ],
    ),

    // ── LINK BADGES — in the cut-out below the containment ───────────────
    div(
      classes:
          'absolute hidden lg:flex items-center gap-3 bottom-6 right-8 '
          'opacity-0 animate-[fade-up_0.6s_ease_1.0s_forwards]',
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
  ]);

  // ── App window ─────────────────────────────────────────────────────────────

  Component _appWindow() => div(
    classes:
        'w-full h-full '
        'bg-bg-subtle rounded-2xl overflow-hidden '
        'border border-border/50 '
        'shadow-[0_32px_80px_rgba(0,0,0,0.8),0_0_0_1px_rgba(129,140,248,0.06)] '
        'animate-[float_9s_ease-in-out_infinite]',
    [
      // Browser chrome
      div(classes: 'bg-bg-base border-b border-border/60', [
        // Traffic lights + title bar
        div(classes: 'flex items-center justify-between px-5 py-3 border-b border-border/30', [
          div(classes: 'flex items-center gap-1.5', [
            div(classes: 'w-2.5 h-2.5 rounded-full bg-[#FF5F57]', []),
            div(classes: 'w-2.5 h-2.5 rounded-full bg-[#FEBC2E]', []),
            div(classes: 'w-2.5 h-2.5 rounded-full bg-[#28C840]', []),
          ]),
          span(classes: 'font-mono text-[10px] text-text-lo tracking-wider', [Component.text('dievas / gallery')]),
          div(classes: 'w-12', []),
        ]),
        // URL bar
        div(classes: 'flex items-center justify-center px-5 py-2.5', [
          div(
            classes:
                'flex-1 max-w-[320px] '
                'flex items-center gap-2 '
                'px-3.5 py-1.5 rounded-lg '
                'bg-bg-elevated border border-border/50',
            [
              div(classes: 'w-1.5 h-1.5 rounded-full bg-[#4ADE80] flex-shrink-0', []),
              span(classes: 'font-mono text-[10px] text-text-lo truncate', [
                Component.text('dievas.serticode.com/gallery'),
              ]),
            ],
          ),
        ]),
      ]),

      // Content
      div(classes: 'p-6 flex flex-col gap-5', [
        // BUTTONS
        _block('Buttons', [
          div(classes: 'flex items-center gap-2 flex-wrap', [
            div(
              classes:
                  'inline-flex items-center gap-1.5 px-4 py-2 rounded-md '
                  'bg-action text-on-brand font-mono text-xs font-medium',
              [div(classes: 'w-2.5 h-2.5 rounded-sm bg-white/30', []), Component.text('Filled')],
            ),
            div(
              classes:
                  'inline-flex items-center px-4 py-2 rounded-md '
                  'border border-border-brand text-brand font-mono text-xs',
              [Component.text('Outlined')],
            ),
            div(classes: 'inline-flex items-center px-4 py-2 rounded-md text-text-mid font-mono text-xs', [
              Component.text('Ghost'),
            ]),
            div(
              classes:
                  'inline-flex items-center justify-center w-9 h-9 rounded-md '
                  'border border-border/60 text-text-lo',
              [
                span(classes: 'text-sm', [Component.text('⊞')]),
              ],
            ),
          ]),
        ]),

        div(classes: 'border-t border-border/40', []),

        // COLOUR TOKENS
        _block('Colour Tokens', [
          div(classes: 'flex items-center gap-2 flex-wrap', [
            _swatch('#6366F1', 'action'),
            _swatch('#818CF8', 'brand'),
            _swatch('#F8FAFC', 'text-hi'),
            _swatch('#0F172A', 'bg-base'),
            _swatch('#334155', 'border'),
            _swatch('#4ADE80', 'success'),
            _swatch('#F59E0B', 'warning'),
            _swatch('#EF4444', 'error'),
          ]),
        ]),

        div(classes: 'border-t border-border/40', []),

        // TYPOGRAPHY SCALE
        _block('Typography Scale', [
          div(classes: 'flex flex-col gap-2.5', [
            div(classes: 'flex items-baseline justify-between', [
              span(classes: 'font-display text-2xl font-black text-text-hi leading-none', [Component.text('Aa')]),
              span(classes: 'font-mono text-[9px] text-text-lo', [Component.text('displayLg · Extended 500')]),
            ]),
            div(classes: 'flex items-baseline justify-between', [
              span(classes: 'font-body text-lg font-bold text-text-mid leading-none', [Component.text('Aa')]),
              span(classes: 'font-mono text-[9px] text-text-lo', [Component.text('headingMd · Maison 500')]),
            ]),
            div(classes: 'flex items-baseline justify-between', [
              span(classes: 'font-mono text-sm text-text-lo leading-none', [Component.text('Aa')]),
              span(classes: 'font-mono text-[9px] text-text-lo', [Component.text('codeMd · DM Mono 400')]),
            ]),
          ]),
        ]),

        div(classes: 'border-t border-border/40', []),

        // COMPONENT STATUS PILLS
        _block('Component Status', [
          div(classes: 'flex flex-wrap gap-1.5', [
            for (final c in _shipped) _pill(c, shipped: true),
            for (final c in _wip) _pill(c, shipped: false),
          ]),
        ]),
      ]),
    ],
  );

  // ── Helpers ─────────────────────────────────────────────────────────────────

  Component _block(String label, List<Component> children) => div([
    p(classes: 'font-mono text-[9px] tracking-[0.14em] uppercase text-text-lo mb-3', [Component.text(label)]),
    ...children,
  ]);

  Component _swatch(String hex, String label) => div(classes: 'flex flex-col items-center gap-1', [
    div(classes: 'w-9 h-9 rounded-lg border border-border/30', attributes: {'style': 'background-color: $hex'}, []),
    span(classes: 'font-mono text-[8px] text-text-lo text-center leading-tight', [Component.text(label)]),
  ]);

  Component _pill(String name, {required bool shipped}) => div(
    classes:
        'inline-flex items-center gap-1.5 '
        'px-2.5 py-1 '
        'border border-border/50 rounded-full '
        'font-mono text-[9px] text-text-lo',
    [
      div(classes: 'w-1 h-1 rounded-full flex-shrink-0 ${shipped ? 'bg-brand' : 'bg-border'}', []),
      Component.text(name),
    ],
  );

  Component _stat(String value, String label) => div(classes: 'flex flex-col gap-1', [
    span(classes: 'font-display text-3xl font-black text-text-hi leading-none', [Component.text(value)]),
    span(classes: 'font-body text-[11px] tracking-[0.12em] uppercase text-text-lo', [Component.text(label)]),
  ]);

  static const _shipped = [
    'FilledButton',
    'OutlinedButton',
    'TextButton',
    'IconButton',
    'Avatar',
    'Badge',
    'Checkbox',
    'Switch',
    'TextArea',
    'TextField',
    'Radio',
    'Tag',
    'Divider',
    'CircularProgress',
    'LinearProgress',
    'Icon',
  ];
  static const _wip = ['BottomSheet', 'Toast', 'Modal', 'Tooltip'];
}
