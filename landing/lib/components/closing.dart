import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

/// Closing island — the last instruction before the fold-out.
class Closing extends StatelessComponent {
  const Closing({super.key});

  @override
  Component build(BuildContext context) => section(classes: 'closing', [
    div(classes: 'closing-island', [
      h2(classes: 'closing-title sr', [Component.text('One layer between your tokens and a shipped app.')]),
      p(
        classes: 'closing-body sr sr-s',
        [
          Component.text('Install Dievas, open the gallery, and theme your whole application tomorrow.'),
        ],
      ),
      div(classes: 'closing-ctas sr sr-l', [
        a(
          href: DievasUrls.dievasPubDevURL,
          classes: 'cta-primary press',
          attributes: const {'target': '_blank', 'rel': 'noopener'},
          [
            Component.text('Install on pub.dev'),
            span(classes: 'cta-arrow', [Component.text('→')]),
          ],
        ),
        a(
          href: DievasUrls.gallery,
          classes: 'cta-ghost press',
          attributes: const {'target': '_blank', 'rel': 'noopener'},
          [Component.text('Browse the gallery'), span(classes: 'cta-arrow', [Component.text('↗')])],
        ),
        a(
          href: DievasUrls.github,
          classes: 'cta-ghost press',
          attributes: const {'target': '_blank', 'rel': 'noopener'},
          [Component.text('GitHub')],
        ),
      ]),
    ]),
  ]);
}