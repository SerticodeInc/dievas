import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

class FooterComponent extends StatelessComponent {
  const FooterComponent({super.key});

  @override
  Component build(BuildContext context) => footer(classes: 'bg-transparent w-full', [
    div(
      classes:
          'max-w-5xl mx-auto px-6 w-full py-8 '
          'flex items-center justify-between flex-wrap gap-4',
      [
        span(classes: 'font-mono text-sm text-slate-400', [
          Component.text('Dievas — built by '),
          a(
            href: DievasUrls.portfolio,
            attributes: const {'target': '_blank', 'rel': 'noopener'},
            classes: 'footer-link text-brand no-underline',
            [Component.text('Serticode Inc.')],
          ),
        ]),
      ],
    ),
  ]);
}
