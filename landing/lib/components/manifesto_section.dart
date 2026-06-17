import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Manifesto section — the problem Dievas solves.
///
/// Dark section immediately after the hero showing a before/after
/// code contrast. "Before" shows typical Flutter widget with hardcoded
/// values; "after" shows the same widget using Dievas context tokens.
class ManifestoSection extends StatelessComponent {
  const ManifestoSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(
      classes: 'w-full',
      attributes: const {'style': 'background: #FFFFFF;'},
      [
        div(classes: 'max-w-5xl mx-auto px-3 lg:px-6 w-full py-8', [
          // ── Header ────────────────────────────────────────────────────────
          div(classes: 'mb-16 flex flex-col lg:flex-row lg:items-end justify-between gap-10 reveal', [
            div([
              p(classes: 'section-eyebrow font-display text-sm tracking-[0.16em] uppercase mb-6', [
                Component.text('✶  The problem'),
              ]),
              h2(
                classes:
                    'font-display font-black text-[clamp(36px,5vw,64px)] '
                    'leading-[0.93] tracking-[-0.03em]',
                attributes: const {'style': 'color: #171717;'},
                [
                  Component.text('Components that know'),
                  br(),
                  span(classes: 'text-brand', [Component.text('nothing')]),
                  Component.text(' about brands.'),
                ],
              ),
            ]),
            p(
              classes:
                  'font-body font-light text-base leading-relaxed text-text-mid '
                  'lg:text-right lg:pb-2 lg:flex-shrink-0 lg:w-72',
              [
                Component.text(
                  'Most Flutter codebases scatter Color(), TextStyle(), '
                  'and magic numbers across every widget.',
                ),
                br(),
                Component.text('Dievas moves them all to the token layer.'),
              ],
            ),
          ]),

          // ── Before / After code panels ────────────────────────────────────
          div(classes: 'grid grid-cols-1 lg:grid-cols-2 gap-4 lg:gap-6', [
            div(classes: 'reveal-left', [
              _CodePanel(
                label: 'typical flutter widget',
                badge: 'before',
                badgeClass:
                    'text-[rgba(248,113,113,1)] border-[rgba(248,113,113,0.3)] '
                    'bg-[rgba(248,113,113,0.08)]',
                borderClass: 'border-slate-200',
                codeHtml: _beforeCode,
              ),
            ]),
            div(classes: 'reveal-right reveal-delayed', [
              _CodePanel(
                label: 'with dievas',
                badge: 'after',
                badgeClass: 'text-brand border-brand/30 bg-brand/10',
                borderClass: 'border-slate-200',
                codeHtml: _afterCode,
              ),
            ]),
          ]),

          // ── Rule strip ─────────────────────────────────────────────────────
          div(
            classes:
                'mt-16 pt-16 '
                'flex items-center gap-3 flex-wrap reveal-scale reveal-strong',
            [
              div(
                classes:
                    'w-1.5 h-1.5 rounded-full bg-brand flex-shrink-0 '
                    'animate-pulse',
                [],
              ),
              span(classes: 'font-mono text-sm text-text-mid', [
                Component.text('The rule: '),
                span(classes: 'text-text-mid font-medium', [
                  Component.text('No hardcoded values. Not one. Not anywhere.'),
                ]),
              ]),
            ],
          ),
        ]),
      ],
    );
  }

  static const _beforeCode = r'''
<pre style="font-family:ui-monospace,monospace;font-size:11.5px;line-height:1.9;color:#94a3b8;white-space:pre"><code><span style="color:#c4b5fd">class </span><span style="color:#fbbf24">SaveButton </span><span style="color:#c4b5fd">extends </span><span style="color:#fbbf24">StatelessWidget </span><span style="color:#94a3b8">{</span>
<span style="color:#c4b5fd">@override</span>
  <span style="color:#c4b5fd">Widget </span><span style="color:#93c5fd">build</span><span style="color:#94a3b8">(BuildContext context) {</span>
    <span style="color:#c4b5fd">return </span><span style="color:#fbbf24">Container</span><span style="color:#94a3b8">(</span>
      decoration: <span style="color:#fbbf24">BoxDecoration</span><span style="color:#94a3b8">(</span>
        color: <span style="color:#fbbf24">Color</span><span style="color:#94a3b8">(</span><span style="color:#fca5a5">0xFF6366F1</span><span style="color:#94a3b8">),</span>  <span style="color:#4b5563">// ← hardcoded</span>
        borderRadius: <span style="color:#fbbf24">BorderRadius</span>
          .<span style="color:#93c5fd">circular</span><span style="color:#94a3b8">(</span><span style="color:#fca5a5">8</span><span style="color:#94a3b8">),</span>          <span style="color:#4b5563">// ← hardcoded</span>
      <span style="color:#94a3b8">),</span>
      child: <span style="color:#fbbf24">Text</span><span style="color:#94a3b8">(</span><span style="color:#86efac">'Save'</span><span style="color:#94a3b8">,</span>
        style: <span style="color:#fbbf24">TextStyle</span><span style="color:#94a3b8">(</span>
          color: <span style="color:#fbbf24">Color</span><span style="color:#94a3b8">(</span><span style="color:#fca5a5">0xFFFFFFFF</span><span style="color:#94a3b8">),</span> <span style="color:#4b5563">// ← hardcoded</span>
          fontSize: <span style="color:#fca5a5">14</span><span style="color:#94a3b8">,</span>            <span style="color:#4b5563">// ← hardcoded</span>
          fontWeight: <span style="color:#fbbf24">FontWeight</span>.w600<span style="color:#94a3b8">,</span><span style="color:#4b5563">// ← hardcoded</span>
        <span style="color:#94a3b8">),</span>
      <span style="color:#94a3b8">),</span>
    <span style="color:#94a3b8">);</span>
  <span style="color:#94a3b8">}</span>
<span style="color:#94a3b8">}</span></code></pre>''';

  static const _afterCode = r'''
<pre style="font-family:ui-monospace,monospace;font-size:11.5px;line-height:1.9;color:#94a3b8;white-space:pre"><code><span style="color:#c4b5fd">class </span><span style="color:#fbbf24">SaveButton </span><span style="color:#c4b5fd">extends </span><span style="color:#fbbf24">StatelessWidget </span><span style="color:#94a3b8">{</span>
  <span style="color:#c4b5fd">@override</span>
  <span style="color:#c4b5fd">Widget </span><span style="color:#93c5fd">build</span><span style="color:#94a3b8">(BuildContext context) {</span>
    <span style="color:#c4b5fd">return </span><span style="color:#fbbf24">Container</span><span style="color:#94a3b8">(</span>
      decoration: <span style="color:#fbbf24">BoxDecoration</span><span style="color:#94a3b8">(</span>
        color: context.<span style="color:#93c5fd">colors</span>.<span style="color:#93c5fd">action</span>
          .<span style="color:#818cf8">actionPrimary</span><span style="color:#94a3b8">,</span>
        borderRadius: <span style="color:#fbbf24">BorderRadius</span>
          .<span style="color:#93c5fd">circular</span><span style="color:#94a3b8">(</span>
            context.<span style="color:#93c5fd">border</span>.<span style="color:#818cf8">radiusMd</span><span style="color:#94a3b8">,</span>
          <span style="color:#94a3b8">),</span>
      <span style="color:#94a3b8">),</span>
      child: <span style="color:#fbbf24">Text</span><span style="color:#94a3b8">(</span><span style="color:#86efac">'Save'</span><span style="color:#94a3b8">,</span>
        style: context.<span style="color:#93c5fd">typography</span>.<span style="color:#818cf8">labelMd</span><span style="color:#94a3b8">,</span>
        <span style="color:#4b5563">// color baked in   ✓</span>
        <span style="color:#4b5563">// size baked in    ✓</span>
        <span style="color:#4b5563">// weight baked in  ✓</span>
      <span style="color:#94a3b8">),</span>
    <span style="color:#94a3b8">);</span>
  <span style="color:#94a3b8">}</span>
<span style="color:#94a3b8">}</span></code></pre>''';
}

class _CodePanel extends StatelessComponent {
  const _CodePanel({
    required this.label,
    required this.badge,
    required this.badgeClass,
    required this.borderClass,
    required this.codeHtml,
  });

  final String label, badge, badgeClass, borderClass, codeHtml;

  @override
  Component build(BuildContext context) => div(
    classes:
        'code-panel rounded-2xl border $borderClass overflow-hidden '
        'transition-shadow duration-300 hover:shadow-[0_8px_40px_rgba(0,0,0,0.3)] '
        'h-full flex flex-col',
    [
      div(
        classes:
            'bg-bg-elevated border-b border-border/40 px-5 py-3 '
            'flex items-center justify-between',
        [
          div(classes: 'flex items-center gap-1.5', [
            div(classes: 'code-dot code-dot-close w-2 h-2 rounded-full bg-[#FF5F57]', []),
            div(classes: 'code-dot code-dot-minimize w-2 h-2 rounded-full bg-[#FEBC2E]', []),
            div(classes: 'code-dot code-dot-maximize w-2 h-2 rounded-full bg-[#28C840]', []),
          ]),
          span(classes: 'section-eyebrow font-display text-sm tracking-[0.16em] uppercase', [Component.text(label)]),
          span(
            classes:
                'font-mono text-[9px] tracking-wider px-2 py-0.5 '
                'rounded-full border $badgeClass',
            [Component.text(badge)],
          ),
        ],
      ),
      div(classes: 'bg-bg-base p-5 overflow-x-auto flex-1', [RawText(codeHtml)]),
    ],
  );
}
