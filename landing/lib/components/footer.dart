import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

class FooterComponent extends StatelessComponent {
  const FooterComponent({super.key});

  @override
  Component build(BuildContext context) {
    return footer(classes: 'bg-transparent w-full', [
      div(
        classes:
            'max-w-5xl mx-auto px-10 w-full '
            'py-8 '
            'flex items-center justify-between flex-wrap gap-4',
        [
          span(classes: 'font-mono text-sm text-slate-400', [
            Component.text('Dievas — built by '),
            a(
              href: DievasUrls.portfolio,
              attributes: const {'target': '_blank', 'rel': 'noopener'},
              classes: 'text-brand no-underline hover:underline',
              [Component.text('Serticode Inc.')],
            ),
          ]),
          nav(classes: 'flex items-center gap-5', [
            a(
              href: DievasUrls.gallery,
              attributes: const {'target': '_blank', 'rel': 'noopener'},
              classes:
                  'font-mono text-sm text-slate-400 no-underline '
                  'transition-colors duration-200 hover:text-slate-700',
              [Component.text('Gallery')],
            ),
            span(classes: 'font-mono text-sm text-slate-400', [
              Component.text('Inspired by '),
              a(
                href: DievasUrls.moonDs,
                attributes: const {'target': '_blank', 'rel': 'noopener'},
                classes: 'text-brand no-underline hover:underline',
                [Component.text('Moon DS')],
              ),
            ]),
          ]),
        ],
      ),
    ]);
  }
}
