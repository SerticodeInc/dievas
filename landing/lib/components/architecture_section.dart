import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Architecture section — token layer diagram + principle cards.
///
/// White-background section providing contrast after the dark hero.
class ArchitectureSection extends StatelessComponent {
  const ArchitectureSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(
      classes: 'bg-white w-full py-4xl border-t border-slate-100',
      [
        div(
          classes: 'max-w-5xl mx-auto px-10 w-full',
          [
            // Section label
            p(
              classes: 'section-eyebrow font-display text-sm tracking-[0.16em] uppercase mb-12',
              [Component.text('✶  Architecture')],
            ),

            // Two-column: principle cards left, layer stack right
            div(
              classes: 'grid grid-cols-1 lg:grid-cols-2 gap-12',
              [
                // Principles
                div(
                  classes: 'flex flex-col gap-px border border-slate-200 rounded-lg overflow-hidden',
                  [
                    for (final p in _principles) _principleCard(p.$1, p.$2, p.$3),
                  ],
                ),

                // Layer stack
                div(
                  classes: 'flex flex-col gap-0.5',
                  [
                    for (int i = 0; i < _layers.length; i++) ...[
                      _layerRow(_layers[i].$1, _layers[i].$2, _layers[i].$3),
                      if (i < _layers.length - 1)
                        div(
                          classes: 'flex justify-center py-1 '
                              'font-mono text-xs text-slate-400',
                          [Component.text('↓')],
                        ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _principleCard(String num, String title, String body) => div(
    classes: 'bg-slate-50 p-8 transition-colors duration-200 '
        'hover:bg-slate-100',
    [
      p(classes: 'font-mono text-[11px] text-brand tracking-wide mb-4', [Component.text(num)]),
      p(classes: 'text-sm font-semibold text-slate-900 mb-2 leading-snug', [Component.text(title)]),
      p(classes: 'font-body font-light text-xs leading-relaxed text-slate-500', [Component.text(body)]),
    ],
  );

  Component _layerRow(String name, String meta, String badge) => div(
    classes: 'flex items-center justify-between '
        'px-6 py-4 '
        'border border-slate-200 rounded-lg '
        'bg-white '
        'transition-colors duration-200 '
        'hover:border-brand/40 hover:bg-slate-50',
    [
      span(classes: 'font-mono text-sm font-medium text-slate-900', [Component.text(name)]),
      div(classes: 'flex items-center gap-3', [
        if (meta.isNotEmpty)
          span(
            classes: 'font-mono text-[11px] text-slate-400 hidden sm:block',
            [Component.text(meta)],
          ),
        span(
          classes: 'inline-block px-2 py-0.5 '
              'bg-brand/10 border border-brand/30 '
              'rounded font-mono text-[10px] tracking-wide text-brand',
          [Component.text(badge)],
        ),
      ]),
    ],
  );

  static const _principles = [
    ('01', 'Token-first', 'Primitives → semantic aliases → Flutter Color structs. Zero hardcoded values in components.'),
    ('02', 'InheritedModel precision', "DievasTheme has 9 aspects. A widget reading colors won't rebuild when spacing changes."),
    ('03', 'Multi-brand by design', 'Apps extend DievasGlobalThemeData — the system never knows which brand is running.'),
    ('04', 'Pure Dart token layer', 'dievas_tokens has zero Flutter imports. Safe for Jaspr, CLI, and server targets.'),
  ];

  static const _layers = [
    ('dievas_tokens', 'pure Dart, no Flutter dep', 'pure dart'),
    ('dievas', 'theme + components', 'flutter'),
    ('DievasScope', 'themeMode · material bridge', 'entry point'),
    ('DievasTheme', 'InheritedModel · 9 aspects', 'inherited'),
    ('components', 'zero hardcoded values', 'sealed styles'),
  ];
}
