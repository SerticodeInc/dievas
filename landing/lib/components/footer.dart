import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

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
        Component.text('Apache-2.0 · Serticode Inc.'),
        button(
          type: ButtonType.button,
          classes: 'theme-toggle press',
          attributes: const {'data-theme-toggle': '', 'aria-label': 'Switch colour theme'},
          [
            span(classes: 'ti ti-sun', [RawText(_sunSvg)]),
            span(classes: 'ti ti-moon', [RawText(_moonSvg)]),
          ],
        ),
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

  static const _sunSvg =
      '''<svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="4.2"/><path d="M12 2.5v2.2M12 19.3v2.2M4.9 4.9l1.6 1.6M17.5 17.5l1.6 1.6M2.5 12h2.2M19.3 12h2.2M4.9 19.1l1.6-1.6M17.5 6.5l1.6-1.6"/></svg>''';

  static const _moonSvg =
      '''<svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M20 13.5A8 8 0 0 1 10.5 4 8 8 0 1 0 20 13.5Z"/></svg>''';
}