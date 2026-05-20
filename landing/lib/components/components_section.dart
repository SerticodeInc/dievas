import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

/// Component status section — Anchor-style alternating full-width category rows.
///
/// Each category row swaps sides on even indices (like Anchor's
/// `.product-list_item:nth-of-type(even) { flex-direction: row-reverse }`),
/// with a large visual preview on one side and the component list on the other.
/// Rows get `.reveal` for scroll-triggered fade-up via IntersectionObserver.
class ComponentsSection extends StatelessComponent {
  const ComponentsSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(classes: 'bg-transparent w-full', [
      // ── Section header ─────────────────────────────────────────────────────
      div(classes: 'max-w-5xl mx-auto px-3 lg:px-6 w-full py-8 reveal', [
        p(classes: 'section-eyebrow font-display text-sm tracking-[0.16em] uppercase mb-6', [
          Component.text('✶  Component catalog'),
        ]),
        div(classes: 'flex flex-col lg:flex-row lg:items-end justify-between gap-6', [
          h2(
            classes:
                'font-display font-black text-[clamp(36px,5vw,60px)] '
                'leading-[0.95] tracking-[-0.025em] text-slate-900',
            [
              Component.text('25 shipped.'),
              br(),
              span(classes: 'text-slate-400', [Component.text('17 in progress.')]),
            ],
          ),
          p(
            classes:
                'font-body font-light text-base leading-[1.8] text-slate-500 mb-8 '
                'max-w-[260px]',
            [
              Component.text(
                'Every component covers all sizes, states, and variants. '
                'All verified in the live gallery.',
              ),
            ],
          ),
        ]),
      ]),

      // ── Category rows — Anchor alternating layout ─────────────────────────
      _categoryRow(
        label: 'Buttons',
        count: '4',
        description:
            'Four button styles covering the full interaction spectrum. '
            'Filled, outlined, ghost, and square icon variants '
            'all driven by DievasButtonThemeData, no hardcoded values.',
        preview: _buttonsPreview(),
        components: const ['FilledButton', 'OutlinedButton', 'TextButton', 'IconButton'],
        accentHex: '818CF8',
        isFlipped: false,
        index: 0,
      ),

      _categoryRow(
        label: 'Form Inputs',
        count: '5',
        description:
            'The full input surface: text fields, text areas, checkboxes, '
            'switches, and radio groups. Token driven states for focus, '
            'error, and disabled. Localized via DievasLocalizations.',
        preview: _formPreview(),
        components: const ['Checkbox', 'Switch', 'TextInput', 'TextArea', 'Radio'],
        accentHex: '4ADE80',
        isFlipped: true,
        index: 1,
      ),

      _categoryRow(
        label: 'Display',
        count: '10',
        description:
            'Avatar, badges, tags, dividers, loaders, and progress variants '
            'cover the visual data layer. Each derives color, sizing, '
            'and border radius entirely from DievasComponentThemeData.',
        preview: _displayPreview(),
        components: const [
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
        ],
        accentHex: 'FBBF24',
        isFlipped: false,
        index: 2,
      ),

      // ── Overlays ────────────────────────────────────────────────────────────
      _categoryRow(
        label: 'Overlays',
        count: '6',
        description:
            'Alert dialogs, bottom sheets, modals, snackbars, banners, '
            'and tooltips provide contextual feedback. Each integrates '
            'with DievasOverlayThemeData for backdrop and animation.',
        preview: _overlaysPreview(),
        components: const ['Alert', 'BottomSheet', 'Modal', 'Snackbar', 'Banner', 'Tooltip'],
        accentHex: 'F472B6',
        isFlipped: true,
        index: 3,
      ),

      // ── In progress ─────────────────────────────────────────────────────────
      div(classes: 'max-w-5xl mx-auto px-3 lg:px-6 w-full py-12 reveal', [
        div(classes: 'flex items-center gap-3 mb-5', [
          span(classes: 'font-mono text-sm tracking-[0.12em] uppercase text-slate-400', [
            Component.text('In progress'),
          ]),
          span(
            classes:
                'inline-block px-3 py-1 rounded-full '
                'border border-slate-200 bg-slate-100 '
                'font-mono text-xs text-slate-400',
            [Component.text('17')],
          ),
        ]),
        div(classes: 'flex flex-wrap gap-2', [for (final c in _wip) _wipPill(c)]),
      ]),

      // ── CTA island ─────────────────────────────────────────────────────────
      div(classes: 'max-w-5xl mx-auto px-3 lg:px-6 w-full pb-20 reveal', [
        div(classes: 'py-16 text-center relative rounded-2xl overflow-hidden bg-bg-base', [
          div(classes: 'relative px-6', [
            p(classes: 'section-eyebrow font-display text-sm tracking-[0.16em] uppercase mb-6', [
              Component.text('✶  proof of work'),
            ]),
            h2(
              classes:
                  'font-display text-[clamp(32px,4.5vw,56px)] font-black tracking-[-0.025em] '
                  'leading-[1.05] mb-5 text-text-hi',
              [Component.text('The gallery is the proof.')],
            ),
            p(classes: 'font-body text-sm text-text-mid mb-10 max-w-sm mx-auto', [
              Component.text('Every component. Every state. Every size.'),
              br(),
              Component.text('Toggle themes, resize viewports — live.'),
            ]),
            a(
              href: DievasUrls.gallery,
              attributes: const {'target': '_blank', 'rel': 'noopener'},
              classes:
                  'inline-flex items-center gap-2 '
                  'px-7 py-3.5 rounded-md '
                  'bg-action text-on-brand '
                  'font-mono text-sm font-medium tracking-wide '
                  'no-underline transition-all duration-200 '
                  'hover:bg-action-hover hover:-translate-y-0.5 '
                  'hover:shadow-[0_8px_32px_rgba(99,102,241,0.4)]',
              [
                Component.text('Open Dievas Gallery'),
                span(classes: 'text-xs opacity-70', [Component.text('→')]),
              ],
            ),
          ]),
        ]),
      ]),
    ]);
  }

  // ── Anchor-style alternating category row ───────────────────────────────────
  //
  // Even rows (isFlipped=true) mirror the layout so the visual preview and
  // description text alternate sides — matching Anchor's alternating product rows.

  Component _categoryRow({
    required String label,
    required String count,
    required String description,
    required Component preview,
    required List<String> components,
    required String accentHex,
    required bool isFlipped,
    required int index,
  }) {
    final content = [
      // Text side
      div(classes: 'flex-1 flex flex-col justify-center py-10 lg:py-0', [
        div(classes: 'flex items-center gap-3 mb-6', [
          span(classes: 'font-mono text-sm tracking-[0.12em] uppercase text-slate-400', [Component.text(label)]),
          span(
            classes: 'inline-block px-3 py-1 rounded-full border font-mono text-xs',
            attributes: {
              'style':
                  'border-color: #${accentHex}40; '
                  'background: #${accentHex}12; '
                  'color: #$accentHex;',
            },
            [Component.text(count)],
          ),
        ]),
        p(
          classes:
              'font-body font-light text-base leading-[1.8] text-slate-500 mb-8 '
              'max-w-[380px]',
          [Component.text(description)],
        ),
        div(classes: 'flex flex-wrap gap-2', [for (final c in components) _shippedPill(c, accentHex)]),
      ]),

      // Visual preview side
      div(
        classes:
            'lg:w-96 flex-shrink-0 '
            'rounded-2xl overflow-hidden '
            'p-5 flex items-center justify-center '
            'border-2',
        attributes: {
          'style':
              'background: rgba(255,255,255,0.75); '
              'backdrop-filter: blur(20px) saturate(180%); '
              '-webkit-backdrop-filter: blur(20px) saturate(180%); '
              'border-color: #${accentHex}60; '
              'box-shadow: 0 8px 32px rgba(0,0,0,0.06), 0 2px 8px rgba(0,0,0,0.06);',
        },
        [preview],
      ),
    ];

    return div(
      classes:
          'max-w-5xl mx-auto px-3 lg:px-6 w-full '
          'border-t border-[rgba(129,140,248,0.2)] reveal',
      [
        div(
          classes:
              'flex flex-col lg:flex-row '
              '${isFlipped ? "lg:flex-row-reverse" : ""} '
              'items-stretch gap-10 lg:gap-16 '
              'py-16 lg:py-20',
          content,
        ),
      ],
    );
  }

  // ── Mini previews ───────────────────────────────────────────────────────────

  Component _buttonsPreview() => div(classes: 'flex flex-col gap-3 w-full', [
    div(classes: 'flex items-center flex-wrap gap-2', [
      div(
        classes:
            'inline-flex items-center gap-1 px-4 py-2 rounded-md '
            'bg-action text-on-brand font-mono text-xs font-medium '
            'shadow-[0_2px_8px_rgba(99,102,241,0.3)]',
        [div(classes: 'w-2 h-2 rounded-sm bg-white/30', []), Component.text('Filled')],
      ),
      div(
        classes:
            'inline-flex items-center px-4 py-2 rounded-md '
            'border border-brand/40 text-brand font-mono text-xs',
        [Component.text('Outlined')],
      ),
      div(classes: 'inline-flex items-center px-3 py-2 text-slate-400 font-mono text-xs', [Component.text('Ghost')]),
      div(
        classes:
            'inline-flex items-center justify-center w-9 h-9 rounded-md '
            'border border-slate-300 text-slate-400 font-mono text-sm',
        [Component.text('⊞')],
      ),
    ]),
    div(classes: 'border-t border-slate-300', []),
    div(classes: 'flex items-center gap-2 flex-wrap', [
      div(
        classes:
            'inline-flex items-center gap-1 px-3 py-1.5 rounded-full '
            'bg-action text-on-brand font-mono text-[10px] font-medium',
        [Component.text('Active')],
      ),
      div(
        classes:
            'inline-flex items-center gap-1 px-3 py-1.5 rounded-full '
            'border border-slate-200 text-slate-400 font-mono text-[10px]',
        [Component.text('Disabled')],
      ),
    ]),
  ]);

  Component _formPreview() => div(classes: 'flex flex-col gap-4 w-full', [
    // Checkbox row
    div(classes: 'flex items-center gap-3', [
      div(
        classes:
            'w-4 h-4 rounded flex items-center justify-center flex-shrink-0 '
            'bg-action',
        [
          span(classes: 'text-white font-mono text-[8px] leading-none', [Component.text('✓')]),
        ],
      ),
      span(classes: 'font-mono text-xs text-slate-600', [Component.text('Checkbox — checked')]),
    ]),
    // Switch
    div(classes: 'flex items-center gap-3', [
      div(classes: 'w-9 h-5 rounded-full bg-action relative flex-shrink-0', [
        div(classes: 'absolute right-0.5 top-0.5 w-4 h-4 rounded-full bg-white shadow-sm', []),
      ]),
      span(classes: 'font-mono text-xs text-slate-600', [Component.text('Switch — on')]),
    ]),
    // Text field
    div(
      classes:
          'flex items-center gap-2 px-3 py-2 rounded-lg '
          'border-2 border-action/60 bg-white w-full',
      [
        div(classes: 'w-0.5 h-3.5 bg-action/80 animate-pulse flex-shrink-0', []),
        span(classes: 'font-mono text-[10px] text-slate-300', [Component.text('Enter value...')]),
      ],
    ),
    // Radio
    div(classes: 'flex items-center gap-3', [
      div(classes: 'w-4 h-4 rounded-full border-2 border-action relative flex-shrink-0', [
        div(classes: 'absolute inset-1 rounded-full bg-action', []),
      ]),
      span(classes: 'font-mono text-xs text-slate-600', [Component.text('Radio — selected')]),
    ]),
  ]);

  Component _displayPreview() => div(classes: 'flex flex-col gap-4 w-full', [
    // Avatar + Badge
    div(classes: 'flex items-center gap-3', [
      div(
        classes: 'relative w-9 h-9 rounded-full flex items-center justify-center flex-shrink-0',
        attributes: const {'style': 'background: rgba(251,191,36,0.15); border: 1px solid rgba(251,191,36,0.3);'},
        [
          span(
            classes: 'font-mono text-xs font-medium',
            attributes: const {'style': 'color: #FBBF24;'},
            [Component.text('AB')],
          ),
          div(
            classes:
                'absolute -top-1 -right-1 '
                'min-w-[18px] h-[18px] px-1 '
                'rounded-full bg-action text-on-brand '
                'font-mono text-[8px] font-medium '
                'flex items-center justify-center',
            [Component.text('3')],
          ),
        ],
      ),
      div(
        classes: 'inline-flex items-center px-2.5 py-1 rounded-full font-mono text-[10px]',
        attributes: const {
          'style':
              'border: 1px solid rgba(251,191,36,0.35); '
              'background: rgba(251,191,36,0.10); '
              'color: #FBBF24;',
        },
        [Component.text('Tag')],
      ),
    ]),
    // Divider
    div(classes: 'w-full border-t border-slate-300', []),
    // Progress bars
    div(classes: 'flex flex-col gap-2', [
      div(classes: 'w-full h-1.5 rounded-full bg-slate-200 overflow-hidden', [
        div(classes: 'h-full rounded-full bg-action', attributes: const {'style': 'width: 62%'}, []),
      ]),
      div(classes: 'w-full h-1.5 rounded-full bg-slate-200 overflow-hidden', [
        div(classes: 'h-full rounded-full', attributes: const {'style': 'width: 38%; background: #FBBF24;'}, []),
      ]),
    ]),
    // Circular + Loader
    div(classes: 'flex items-center gap-3', [
      div(
        classes: 'w-7 h-7 rounded-full border-[3px] border-slate-200 border-t-action flex-shrink-0',
        attributes: const {'style': 'transform: rotate(-45deg)'},
        [],
      ),
      div(
        classes: 'w-6 h-6 rounded-full border-[2.5px] border-slate-200 border-t-slate-400 flex-shrink-0',
        attributes: const {'style': 'animation: spin 1s linear infinite'},
        [],
      ),
    ]),
  ]);

  Component _overlaysPreview() => div(classes: 'flex flex-col gap-3 w-full', [
    // Alert
    div(
      classes: 'p-3 rounded-lg border border-amber-300/50 bg-amber-50',
      attributes: const {'style': 'border-left: 3px solid #F59E0B;'},
      [
        div(classes: 'flex items-center gap-2 mb-1', [
          span(classes: 'text-amber-600 font-mono text-xs font-bold', [Component.text('Alert')]),
        ]),
        span(classes: 'text-amber-700 font-mono text-[10px]', [Component.text('Important notice here')]),
      ],
    ),
    // Snackbar
    div(classes: 'px-3 py-2 rounded-md bg-slate-800 text-white flex items-center gap-2', [
      div(classes: 'w-1 h-1 rounded-full bg-green-400', []),
      span(classes: 'font-mono text-[10px]', [Component.text('Item saved')]),
    ]),
    // Modal preview (centered box)
    div(classes: 'rounded-lg border border-slate-200 bg-white p-3 text-center', [
      span(classes: 'font-mono text-xs text-slate-600', [Component.text('Modal')]),
    ]),
    // Tooltip
    div(classes: 'flex items-center justify-center gap-2', [
      div(classes: 'px-2 py-1 rounded bg-slate-100 border border-slate-200', [
        span(classes: 'font-mono text-[10px] text-slate-400', [Component.text('Hover me')]),
      ]),
      div(classes: 'px-2 py-1 rounded bg-slate-800 text-white font-mono text-[9px]', [Component.text('Tooltip')]),
    ]),
  ]);

  // ── Pills ────────────────────────────────────────────────────────────────────

  Component _shippedPill(String name, String accentHex) => a(
    href: _galleryHref(name),
    attributes: const {'target': '_blank', 'rel': 'noopener'},
    classes:
        'group inline-flex items-center gap-2 '
        'px-4 py-2.5 '
        'border border-slate-200 rounded-full '
        'font-mono text-sm text-slate-600 '
        'bg-white no-underline cursor-pointer '
        'transition-all duration-200 '
        'hover:text-slate-900 '
        'hover:shadow-[0_2px_12px_rgba(0,0,0,0.08)]',
    [
      div(classes: 'w-1.5 h-1.5 rounded-full flex-shrink-0', attributes: {'style': 'background: #$accentHex;'}, []),
      Component.text(name),
      span(classes: 'text-[12px] arrow-span', attributes: {'style': 'color: #$accentHex;'}, [Component.text('→')]),
    ],
  );

  Component _wipPill(String name) => div(
    classes:
        'inline-flex items-center gap-2 '
        'px-4 py-2.5 '
        'border border-slate-200 rounded-full '
        'font-mono text-sm text-slate-400 '
        'bg-slate-50/60',
    [div(classes: 'w-1.5 h-1.5 rounded-full bg-slate-300 flex-shrink-0', []), Component.text(name)],
  );

  // ── URL helpers ──────────────────────────────────────────────────────────────

  static String _galleryHref(String componentName) {
    const base = DievasUrls.gallery;
    final slug = _gallerySlug[componentName] ?? componentName.toLowerCase();
    final folder = _galleryFolder[componentName] ?? 'display';
    return '$base/#/?path=components/$folder/$slug/playground';
  }

  static const _gallerySlug = <String, String>{
    'FilledButton': 'filledbutton',
    'OutlinedButton': 'outlinedbutton',
    'TextButton': 'textbutton',
    'IconButton': 'iconbutton',
    'Avatar': 'avatar',
    'Badge': 'badge',
    'Checkbox': 'checkbox',
    'Switch': 'switch',
    'TextArea': 'textarea',
    'TextInput': 'textinput',
    'Radio': 'radio',
    'Tag': 'tag',
    'Divider': 'divider',
    'CircularProgress': 'circularprogress',
    'LinearProgress': 'linearprogress',
    'Icon': 'icon',
    'CircularLoader': 'loader',
    'LinearLoader': 'loader',
    'EmptyState': 'empty_state',
    'Alert': 'alert',
    'BottomSheet': 'bottom_sheet',
    'Modal': 'modal',
    'Snackbar': 'snackbar',
    'Banner': 'banner',
    'Tooltip': 'tooltip',
  };

  static const _galleryFolder = <String, String>{
    'FilledButton': 'buttons',
    'OutlinedButton': 'buttons',
    'TextButton': 'buttons',
    'IconButton': 'buttons',
    'Avatar': 'display',
    'Badge': 'display',
    'Checkbox': 'form',
    'Switch': 'form',
    'TextArea': 'form',
    'TextInput': 'form',
    'Radio': 'form',
    'Tag': 'display',
    'Divider': 'display',
    'CircularProgress': 'display',
    'LinearProgress': 'display',
    'Icon': 'display',
    'CircularLoader': 'display',
    'LinearLoader': 'display',
    'EmptyState': 'display',
    'Alert': 'overlays',
    'BottomSheet': 'overlays',
    'Modal': 'overlays',
    'Snackbar': 'overlays',
    'Banner': 'overlays',
    'Tooltip': 'overlays',
  };

  static const _wip = [
    'Accordion',
    'AuthCode',
    'BreadCrumb',
    'Carousel',
    'DotIndicator',
    'Drawer',
    'Dropdown',
    'MenuItem',
    'Popover',
    'SegmentedControl',
    'TabBar',
    'Table',
    'TextInputGroup',
    'SearchWithList',
    'SearchWithDropdown',
    'SingleSelectComboBox',
    'MultiSelectComboBox',
  ];
}
