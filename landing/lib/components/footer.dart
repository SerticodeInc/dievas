import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';
import 'theme_toggle.dart';

/// Footer — ghost wordmark settle + a single utility row.
///
/// The last thing the eye lands on is the giant background-clip
/// wordmark (deskmodes register), staying ghostly on both sheets.
class FooterComponent extends StatelessComponent {
  const FooterComponent({super.key});

  @override
  Component build(BuildContext context) => footer(classes: 'footer', [
    div(classes: 'shell footer-util', [
      div(classes: 'footer-copy', [
        Component.text('Serticode Inc.'),
        const ThemeToggle(),
      ]),
      div(classes: 'footer-links', [
        _link('Gallery', DievasUrls.gallery),
        _link('GitHub', DievasUrls.github),
        _link('pub.dev', DievasUrls.dievasPubDevURL),
        _link('Portfolio', DievasUrls.portfolio),
      ]),
    ]),
    div(classes: 'footer-wordmark', [
      span(classes: 'ghost-word', [Component.text('dievas')]),
      div(classes: 'ghost-tag', [Component.text('design system for flutter')]),
    ]),
  ]);

  Component _link(String label, String href) => a(
    href: href,
    classes: 'footer-link',
    attributes: const {'target': '_blank', 'rel': 'noopener'},
    [Component.text(label)],
  );
}