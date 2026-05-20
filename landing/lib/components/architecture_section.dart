import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Architecture section — token layer diagram + principle cards.
///
/// White-background section with a horizontal code pipeline showing
/// the three-layer data flow (tokens → theme → app), followed by
/// principle cards in an editorial 2×2 grid.
class ArchitectureSection extends StatelessComponent {
  const ArchitectureSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(
      classes: 'w-full',
      attributes: const {'style': 'background: #FFFFFF;'},
      [
        div(classes: 'max-w-5xl mx-auto px-3 lg:px-6 w-full py-8', [
          // ── Section header ─────────────────────────────────────────────────
          div(classes: 'mb-20 flex flex-col lg:flex-row lg:items-end justify-between gap-8 reveal', [
            div([
              p(classes: 'section-eyebrow font-display text-sm tracking-[0.16em] uppercase mb-6', [
                Component.text('✶  Architecture'),
              ]),
              h2(
                classes:
                    'font-display font-black text-[clamp(36px,5vw,60px)] '
                    'leading-[0.95] tracking-[-0.025em] text-slate-900',
                [
                  Component.text('Three layers.'),
                  br(),
                  span(classes: 'text-slate-400', [Component.text('One rule.')]),
                ],
              ),
            ]),
            p(
              classes:
                  'font-body font-light text-base leading-[1.8] text-slate-500 mb-8 '
                  'max-w-[260px]',
              [
                Component.text('Each layer has exactly one responsibility.'),
                br(),
                Component.text('Tokens define.'),
                br(),
                Component.text('Theme composes.'),
                br(),
                Component.text('Components consume.'),
              ],
            ),
          ]),

          // ── Code pipeline ─────────────────────────────────────────────────
          div(classes: 'mb-24 reveal', [
            div(classes: 'flex flex-col lg:flex-row items-stretch gap-3', [
              _CodePanel(
                label: 'Tokens.',
                badgeClass:
                    'text-[rgba(248,113,113,1)] border-[rgba(248,113,113,0.3)] '
                    'bg-[rgba(248,113,113,0.08)]',
                badge: 'Pure Dart',
                codeHtml: _tokensCode,
              ),
              _CodePanel(label: 'theme + components', badge: 'Flutter', badgeClass: '#93c5fd', codeHtml: _dievasCode),
              _CodePanel(label: 'Your app', badge: 'Consumer', badgeClass: '#818cf8', codeHtml: _appCode),
            ]),
          ]),

          // ── Principle cards ────────────────────────────────────────────────
          div(classes: 'grid grid-cols-1 sm:grid-cols-2 gap-4 reveal-group', [
            for (final p in _principles) _principleCard(p.$1, p.$2, p.$3, p.$4, p.$5),
          ]),
        ]),
      ],
    );
  }

  Component _principleCard(String num, String title, String body, String symbol, String colorClass) => div(
    classes:
        'group p-8 rounded-2xl border $colorClass '
        'bg-white '
        'transition-all duration-300 cursor-default '
        'hover:shadow-[0_8px_32px_rgba(129,140,248,0.4)]',
    [
      div(classes: 'flex items-center justify-between mb-6', [
        span(
          classes: 'font-mono text-[12px] tracking-[0.2em] uppercase',
          attributes: const {'style': 'color: rgba(129,140,248,0.7)'},
          [Component.text(num)],
        ),
        div(
          classes:
              'w-9 h-9 rounded-xl border border-slate-700 bg-white/5 '
              'flex items-center justify-center text-slate-400 text-base select-none '
              'group-hover:border-brand/25 group-hover:bg-brand/8 group-hover:text-brand '
              'transition-all duration-300',
          [Component.text(symbol)],
        ),
      ]),
      p(classes: 'font-display font-semibold text-slate-900 text-base leading-snug mb-3', [Component.text(title)]),
      p(classes: 'font-body font-light text-sm leading-relaxed text-text-mid', [Component.text(body)]),
    ],
  );

  static const _tokensCode = r'''
<pre style="font-family:ui-monospace,monospace;font-size:11px;line-height:1.85;color:#94a3b8;white-space:pre"><code><span style="color:#64748b">// primitive scale — raw ints</span>
<span style="color:#c4b5fd">abstract</span> <span style="color:#c4b5fd">final</span> <span style="color:#c4b5fd">class</span> <span style="color:#fbbf24">DievasColourPrimitives</span> <span style="color:#94a3b8">{</span>
  <span style="color:#c4b5fd">static</span> <span style="color:#c4b5fd">const</span> <span style="color:#818cf8">int</span> indigo500 <span style="color:#94a3b8">= </span><span style="color:#fca5a5">0xFF6366F1</span><span style="color:#94a3b8">;</span>
  <span style="color:#c4b5fd">static</span> <span style="color:#c4b5fd">const</span> <span style="color:#818cf8">int</span> slate900  <span style="color:#94a3b8">= </span><span style="color:#fca5a5">0xFF0F172A</span><span style="color:#94a3b8">;</span>
<span style="color:#94a3b8">}</span>

<span style="color:#64748b">// semantic alias — no Flutter import</span>
<span style="color:#c4b5fd">abstract</span> <span style="color:#c4b5fd">final</span> <span style="color:#c4b5fd">class</span> <span style="color:#fbbf24">DievasColourSemanticLight</span> <span style="color:#94a3b8">{</span>
  <span style="color:#c4b5fd">static</span> <span style="color:#c4b5fd">const</span> <span style="color:#818cf8">int</span> actionPrimary <span style="color:#94a3b8">=</span>
    <span style="color:#fbbf24">DievasColourPrimitives</span>.indigo500<span style="color:#94a3b8">;</span>
  <span style="color:#c4b5fd">static</span> <span style="color:#c4b5fd">const</span> <span style="color:#818cf8">int</span> textPrimary <span style="color:#94a3b8">=</span>
    <span style="color:#fbbf24">DievasColourPrimitives</span>.slate900<span style="color:#94a3b8">;</span>
<span style="color:#94a3b8">}</span></code></pre>''';

  static const _dievasCode = r'''
<pre style="font-family:ui-monospace,monospace;font-size:11px;line-height:1.85;color:#94a3b8;white-space:pre"><code><span style="color:#64748b">// Color wrapping happens once, here</span>
<span style="color:#c4b5fd">import</span> <span style="color:#86efac">'package:flutter/painting.dart'</span><span style="color:#94a3b8">;</span>
<span style="color:#c4b5fd">import</span> <span style="color:#86efac">'package:dievas_tokens/...'</span><span style="color:#94a3b8">;</span>

<span style="color:#c4b5fd">class</span> <span style="color:#fbbf24">ActionColors</span> <span style="color:#c4b5fd">extends</span> <span style="color:#fbbf24">Equatable</span> <span style="color:#94a3b8">{</span>
  <span style="color:#c4b5fd">static</span> <span style="color:#c4b5fd">const</span> <span style="color:#fbbf24">Color</span> actionPrimary <span style="color:#94a3b8">= </span><span style="color:#fbbf24">Color</span><span style="color:#94a3b8">(</span>
    DievasColourSemanticLight.actionPrimary<span style="color:#94a3b8">,</span>
  <span style="color:#94a3b8">);</span>
<span style="color:#94a3b8">}</span>

<span style="color:#64748b">// 9 typed aspects — surgical rebuilds</span>
<span style="color:#c4b5fd">enum</span> <span style="color:#fbbf24">DievasThemeAspect</span> <span style="color:#94a3b8">{</span>
  colors<span style="color:#94a3b8">,</span> typography<span style="color:#94a3b8">,</span> spacing<span style="color:#94a3b8">,</span>
  sizing<span style="color:#94a3b8">,</span> border<span style="color:#94a3b8">,</span> elevation<span style="color:#94a3b8">, </span><span style="color:#64748b">...</span>
<span style="color:#94a3b8">}</span></code></pre>''';

  static const _appCode = r'''
<pre style="font-family:ui-monospace,monospace;font-size:11px;line-height:1.85;color:#94a3b8;white-space:pre"><code><span style="color:#64748b">// extend with your brand tokens</span>
<span style="color:#c4b5fd">class</span> <span style="color:#fbbf24">CadenceLightThemeData</span>
    <span style="color:#c4b5fd">extends</span> <span style="color:#fbbf24">DievasGlobalThemeData</span> <span style="color:#94a3b8">{</span>
  <span style="color:#fbbf24">CadenceLightThemeData</span><span style="color:#94a3b8">({super.components})</span>
    <span style="color:#94a3b8">: </span><span style="color:#c4b5fd">super</span><span style="color:#94a3b8">(colors: ..., border: ...);</span>
<span style="color:#94a3b8">}</span>

<span style="color:#64748b">// wire up — system is brand-agnostic</span>
<span style="color:#fbbf24">DievasScope</span><span style="color:#94a3b8">(</span>
  lightTheme<span style="color:#94a3b8">: </span><span style="color:#fbbf24">CadenceLightThemeData</span><span style="color:#94a3b8">(),</span>
  darkTheme<span style="color:#94a3b8">:  </span><span style="color:#fbbf24">CadenceDarkThemeData</span><span style="color:#94a3b8">(),</span>
  child<span style="color:#94a3b8">: </span><span style="color:#fbbf24">MaterialApp</span>.router<span style="color:#94a3b8">(</span><span style="color:#64748b">...</span><span style="color:#94a3b8">),</span>
<span style="color:#94a3b8">)</span></code></pre>''';

  static const _principles = [
    (
      '01',
      'Token-first, always',
      'Primitives → semantic aliases → Flutter Color. Nothing in a component file is ever a raw hex or a magic number.',
      '◈',
      'pc-indigo',
    ),
    (
      '02',
      'InheritedModel precision',
      'DievasTheme has 9 aspects. A widget reading colors never rebuilds when spacing changes. Surgical, not shotgun.',
      '⊞',
      'pc-sky',
    ),
    (
      '03',
      'Multi-brand by design',
      'Apps extend DievasGlobalThemeData with their own brand tokens. The design system never knows which brand is active.',
      '⋮',
      'pc-green',
    ),
    (
      '04',
      'Pure Dart token layer',
      'dievas_tokens has zero Flutter imports. Safe for Jaspr, CLI, and server-side Dart targets. No platform lock-in.',
      '◎',
      'pc-amber',
    ),
  ];
}

class _CodePanel extends StatelessComponent {
  const _CodePanel({required this.label, required this.badge, required this.badgeClass, required this.codeHtml});

  final String label, badge, badgeClass, codeHtml;

  @override
  Component build(BuildContext context) => div(
    classes:
'rounded-2xl border border-slate-200 overflow-hidden transition-shadow duration-300 hover:shadow-[0_8px_40px_rgba(0,0,0,0.3)] h-full flex flex-col',
    [
      div(
        classes:
            'bg-bg-elevated border-b border-border/40 px-5 py-3 '
            'flex items-center justify-between',
        [
          div(classes: 'flex items-center gap-1.5', [
            div(classes: 'w-2 h-2 rounded-full bg-[#FF5F57]', []),
            div(classes: 'w-2 h-2 rounded-full bg-[#FEBC2E]', []),
            div(classes: 'w-2 h-2 rounded-full bg-[#28C840]', []),
          ]),
          span(classes: 'section-eyebrow font-display text-mid tracking-[0.07em] uppercase', [Component.text(label)]),
          span(
            classes:
                'font-mono text-[8px] tracking-wider px-2 py-0.5 '
                'rounded-full border $badgeClass',
            [Component.text(badge)],
          ),
        ],
      ),
      div(classes: 'bg-bg-base p-5 overflow-x-auto flex-1', [RawText(codeHtml)]),
    ],
  );
}
