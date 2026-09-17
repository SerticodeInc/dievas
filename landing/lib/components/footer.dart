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
        span(classes: 'footer-built', [
          Component.text('Built by '),
          a(
            href: DievasUrls.portfolio,
            classes: 'footer-credit press',
            attributes: const {'target': '_blank', 'rel': 'noopener'},
            [
              Component.text('Serticode Inc.'),
              RawText(_arrowUpRightSvg),
            ],
          ),
        ]),
        const ThemeToggle(),
      ]),
      a(
        href: DievasUrls.github,
        classes: 'footer-github press',
        attributes: const {'target': '_blank', 'rel': 'noopener', 'aria-label': 'GitHub'},
        [
          RawText(_githubMarkSvg),
          span(classes: 'star-pill', [
            RawText(_starSvg),
            span(classes: 'star-count', [Component.text('…')]),
          ]),
          span(classes: 'footer-github-arrow', [RawText(_arrowUpRightSvg)]),
        ],
      ),
    ]),
    div(classes: 'footer-wordmark', [
      span(classes: 'ghost-word', [Component.text('dievas')]),
      div(classes: 'ghost-tag', [Component.text('design system for flutter')]),
    ]),
  ]);

  static const _githubMarkSvg =
      '''<svg width="15" height="15" viewBox="0 0 16 16" fill="currentColor" aria-hidden="true"><path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27s1.36.09 2 .27c1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"/></svg>''';

  static const _starSvg =
      '''<svg width="10" height="10" viewBox="0 0 16 16" fill="currentColor" aria-hidden="true"><path d="M8 .25a.75.75 0 0 1 .673.418l1.882 3.815 4.21.612a.75.75 0 0 1 .416 1.279l-3.046 2.97.719 4.192a.75.75 0 0 1-1.088.791L8 12.347l-3.766 1.98a.75.75 0 0 1-1.088-.79l.72-4.194L.818 6.374a.75.75 0 0 1 .416-1.28l4.21-.611L7.327.668A.75.75 0 0 1 8 .25z"/></svg>''';

  static const _arrowUpRightSvg =
      '''<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M7 17L17 7"/><path d="M7 7h10v10"/></svg>''';
}