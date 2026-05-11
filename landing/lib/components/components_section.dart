import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

/// Component status strip — shipped vs. in-progress.
///
/// White-background section continuing the light treatment after the dark hero.
class ComponentsSection extends StatelessComponent {
  const ComponentsSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(classes: 'bg-transparent w-full py-4xl', [
      div(classes: 'max-w-5xl mx-auto px-10 w-full', [
        // Section label + legend
        div(classes: 'flex items-center justify-between flex-wrap gap-4 mb-10', [
          p(classes: 'section-eyebrow font-display text-sm tracking-[0.16em] uppercase', [
            Component.text('✶  Component status'),
          ]),
          div(classes: 'flex items-center gap-5 font-display text-sm text-slate-400', [
            _legendItem(shipped: true, label: 'production'),
            _legendItem(shipped: false, label: 'in progress'),
          ]),
        ]),

        // Pills grid
        div(classes: 'flex flex-wrap gap-2', [
          for (final c in _shipped) _pill(c, shipped: true, href: _galleryHref(c)),
          for (final c in _wip) _pill(c, shipped: false),
        ]),

        // CTA — dark island for contrast
        div(
          classes:
              'mt-20 py-16 text-center relative rounded-2xl overflow-hidden '
              'bg-bg-base',
          [
            // Glow
            div(classes: 'pointer-events-none absolute inset-0 flex items-center justify-center', [
              div(classes: 'w-[500px] h-[200px] rounded-full bg-brand/10 blur-[60px]', []),
            ]),

            div(classes: 'relative', [
              h2(
                classes:
                    'text-[clamp(36px,5vw,60px)] font-black tracking-[-0.025em] '
                    'leading-[1.05] mb-5 text-text-hi',
                [Component.text('See it in action.')],
              ),
              p(classes: 'font-body text-sm text-text-mid mb-10', [
                Component.text('Interact with every component, toggle themes,'),
                br(),
                Component.text('test viewports — in the live gallery.'),
              ]),
              a(
                href: DievasUrls.gallery,
                attributes: const {'target': '_blank', 'rel': 'noopener'},
                classes:
                    'inline-flex items-center gap-2 '
                    'px-6 py-3 rounded-md '
                    'bg-action text-on-brand '
                    'font-mono text-sm font-medium '
                    'no-underline transition-all duration-200 '
                    'hover:bg-action-hover hover:-translate-y-px',
                [
                  Component.text('Open Dievas Gallery'),
                  span(classes: 'text-xs', [Component.text('→')]),
                ],
              ),
            ]),
          ],
        ),
      ]),
    ]);
  }

  Component _legendItem({required bool shipped, required String label}) => div(classes: 'flex items-center gap-2', [
    div(classes: 'w-1.5 h-1.5 rounded-full ${shipped ? 'bg-brand' : 'bg-slate-300'}', []),
    Component.text(label),
  ]);

  Component _pill(String name, {required bool shipped, String? href}) {
    const pillClasses =
        'inline-flex items-center gap-2 '
        'px-3.5 py-2 '
        'border border-slate-200 rounded-full '
        'font-mono text-xs text-slate-600 '
        'bg-slate-50 '
        'transition-colors duration-200 '
        'hover:border-brand/40 hover:text-slate-900';

    final dot = div(
      classes:
          'w-1.5 h-1.5 rounded-full flex-shrink-0 '
          '${shipped ? 'bg-brand' : 'bg-slate-300'}',
      [],
    );

    if (href != null) {
      return a(
        href: href,
        attributes: const {'target': '_blank', 'rel': 'noopener'},
        classes: '$pillClasses no-underline cursor-pointer',
        [dot, Component.text(name)],
      );
    }

    return div(classes: pillClasses, [dot, Component.text(name)]);
  }

  static String _galleryHref(String componentName) {
    const base = DievasUrls.gallery;
    // Widgetbook uses hash routing — the slug is the component name lowercased,
    // no hyphens. e.g. OutlinedButton → outlinedbutton, TextInput → textinput.
    final slug = _gallerySlug[componentName] ?? componentName.toLowerCase();
    final folder = _galleryFolder[componentName] ?? 'display';
    return '$base/#/?path=components/$folder/$slug/playground';
  }

  static const _gallerySlug = <String, String>{
    'FilledButton':     'filledbutton',
    'OutlinedButton':   'outlinedbutton',
    'TextButton':       'textbutton',
    'IconButton':       'iconbutton',
    'Avatar':           'avatar',
    'Badge':            'badge',
    'Checkbox':         'checkbox',
    'Switch':           'switch',
    'TextArea':         'textarea',
    'TextField':        'textinput',
    'Radio':            'radio',
    'Tag':              'tag',
    'Divider':          'divider',
    'CircularProgress': 'circularprogress',
    'LinearProgress':   'linearprogress',
    'Icon':             'icon',
  };

  static const _galleryFolder = <String, String>{
    'FilledButton':     'buttons',
    'OutlinedButton':   'buttons',
    'TextButton':       'buttons',
    'IconButton':       'buttons',
    'Avatar':           'display',
    'Badge':            'display',
    'Checkbox':         'form',
    'Switch':           'form',
    'TextArea':         'form',
    'TextField':        'form',
    'Radio':            'form',
    'Tag':              'display',
    'Divider':          'display',
    'CircularProgress': 'display',
    'LinearProgress':   'display',
    'Icon':             'display',
  };

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
