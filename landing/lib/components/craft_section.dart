import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../constants.dart';

/// "Native to the last token" — four factual craft rows.
class CraftSection extends StatelessComponent {
  const CraftSection({super.key});

  @override
  Component build(BuildContext context) => section(classes: 'craft section', [
    div(classes: 'shell', [
      div(classes: 'craft-head', [
        h2(classes: 'craft-title sr sr-s', [
          span(classes: 'craft-title-accent', [Component.text('Verified,')]),
          Component.text(' in the code.'),
        ]),
        p(classes: 'craft-lede sr sr-l', [
          Component.text('Four things Dievas holds true at every layer, verified '),
          _anchor('in the code', DievasUrls.github),
          Component.text(' and shown on this page.'),
        ]),
      ]),
      div(classes: 'craft-grid sr-stagger', [
        _card(
          title: 'Semantic by construction',
          accent: 'brand',
          icon: _globeSvg,
          lines: [
            Component.text('Components read the semantic layer and nothing else. '),
            span([
              Component.text('A '),
              _anchor('Widget', _flutterWidget),
              Component.text(' never hardcodes a '),
              _anchor('Colour', _flutterColor),
              Component.text(', '),
              _anchor('Radius', _flutterRadius),
              Component.text(', or '),
              _anchor('Duration', _flutterDuration),
              Component.text('. '),
            ]),
            span([
              Component.text('Do not believe '),
              _anchor('Our Docs', DievasUrls.docs),
              Component.text('? Try a Grep'),
            ]),
          ],
        ),
        _card(
          title: 'Accessible from first frame',
          accent: 'lime',
          icon: _a11ySvg,
          lines: [
            span([
              _anchor('Focus', _flutterFocus),
              Component.text(', '),
              _anchor('Semantics', _flutterSemantics),
              Component.text(', and '),
              _anchor('Animation', _flutterAnimation),
              Component.text(' handling are built into the components, not layered on by you at integration time.'),
            ]),
          ],
        ),
        _card(
          title: 'Granular by inheritance',
          accent: 'peach',
          icon: _boltSvg,
          lines: [
            span([
              _anchor('InheritedModel', _flutterInheritedModel),
              Component.text(' keeps a theme tweak a narrowly scoped micro rebuild instead of an app wide hot swap. '),
            ]),
            span([
              Component.text('Your '),
              _anchor('Widget', _flutterWidget),
              Component.text(' rebuilds when its aspect changes.'),
            ]),
          ],
        ),
        _card(
          title: 'Open, not orphaned',
          accent: 'black',
          icon: _openSvg,
          lines: [
            span([
              Component.text('On '),
              a(
                href: DievasUrls.dievasPubDevURL,
                classes: 'craft-inline-link',
                attributes: const {'target': '_blank', 'rel': 'noopener'},
                [Component.text('pub.dev'), RawText(_arrowSvg)],
              ),
              Component.text(' with a public '),
              a(
                href: DievasUrls.gallery,
                classes: 'craft-inline-link',
                attributes: const {'target': '_blank', 'rel': 'noopener'},
                [Component.text('Widgetbook gallery'), RawText(_arrowSvg)],
              ),
              Component.text(' and a living component catalogue behind it.'),
            ]),
            span([
              Component.text('Built by '),
              a(
                href: DievasUrls.portfolio,
                classes: 'credit-link press',
                attributes: const {'target': '_blank', 'rel': 'noopener'},
                [Component.text('Serticode Inc.'), RawText(_arrowSvg)],
              ),
            ]),
          ],
        ),
      ]),
    ]),
  ]);

  Component _card({
    required String title,
    required String accent,
    required String icon,
    required List<Component> lines,
  }) => div(classes: 'craft-card sr craft-card--$accent', [
    div(classes: 'craft-icon', [RawText(icon)]),
    h3([Component.text(title)]),
    p([
      for (final line in lines) span(classes: 'craft-line', [line]),
    ]),
  ]);

  Component _anchor(String text, String href) => a(
    href: href,
    classes: 'craft-inline-link',
    attributes: const {'target': '_blank', 'rel': 'noopener'},
    [Component.text(text), RawText(_arrowSvg)],
  );

  static const _flutterWidget = 'https://api.flutter.dev/flutter/widgets/Widget-class.html';
  static const _flutterInheritedModel = 'https://api.flutter.dev/flutter/widgets/InheritedModel-class.html';
  static const _flutterColor = 'https://api.flutter.dev/flutter/dart-ui/Color-class.html';
  static const _flutterRadius = 'https://api.flutter.dev/flutter/dart-ui/Radius-class.html';
  static const _flutterDuration = 'https://api.flutter.dev/flutter/dart-core/Duration-class.html';
  static const _flutterFocus = 'https://api.flutter.dev/flutter/widgets/Focus-class.html';
  static const _flutterSemantics = 'https://api.flutter.dev/flutter/widgets/Semantics-class.html';
  static const _flutterAnimation = 'https://api.flutter.dev/flutter/animation/animation-library.html';

  static const _globeSvg =
      '''<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3c2.5 2.6 3.8 5.7 3.8 9S14.5 18.4 12 21c-2.5-2.6-3.8-5.7-3.8-9S9.5 5.6 12 3Z"/></svg>''';

  static const _a11ySvg =
      '''<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 7.5V17M8.5 11h7"/></svg>''';

  static const _boltSvg =
      '''<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M13 2L4.5 13.5H11L9.5 22 19 10h-6.5L13 2Z"/></svg>''';

  static const _openSvg =
      '''<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path class="cv-l" d="M14 7l5 5-5 5"/><path class="cv-r" d="M10 7l-5 5 5 5"/></svg>''';

  static const _arrowSvg =
      '''<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M7 17L17 7"/><path d="M7 7h10v10"/></svg>''';
}
