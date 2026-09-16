import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// "Native to the last token" — four factual craft rows.
class CraftSection extends StatelessComponent {
  const CraftSection({super.key});

  @override
  Component build(BuildContext context) => section(classes: 'craft section shell', [
    div(classes: 'craft-head', [
      div(classes: 'eyebrow sr', [Component.text('Craft')]),
      h2(classes: 'craft-title sr sr-s', [Component.text('Native to the last token.')]),
      p(
        classes: 'craft-lede sr sr-l',
        [
          Component.text('Four things Dievas holds true at every layer, verified in the code and shown on this page.'),
        ],
      ),
    ]),
    div(classes: 'craft-grid', [
      _card(
        'Semantic by construction',
        'Components read the semantic layer and nothing else. A widget never hardcodes a colour, radius, or duration. Grep says so, not our docs.',
        _globeSvg,
      ),
      _card(
        'Accessible from first frame',
        'Focus, semantics, and reduced-motion handling are built into the components, not layered on by you at integration time.',
        _a11ySvg,
      ),
      _card(
        'Granular by inheritance',
        'InheritedModel keeps a theme tweak a nine-reason micro-rebuild instead of an app-wide hot swap. Your widget rebuilds when its aspect changes.',
        _boltSvg,
      ),
      _card(
        'Open, not orphaned',
        'Apache-2.0 on pub.dev, a public Widgetbook gallery, and a living component catalogue behind it. Built by Serticode Inc.',
        _openSvg,
      ),
    ]),
  ]);

  Component _card(String title, String body, String icon) => div(
    classes: 'craft-card sr',
    [
      div(classes: 'craft-icon', [RawText(icon)]),
      h3([Component.text(title)]),
      p([Component.text(body)]),
    ],
  );

  static const _globeSvg =
      '''<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3c2.5 2.6 3.8 5.7 3.8 9S14.5 18.4 12 21c-2.5-2.6-3.8-5.7-3.8-9S9.5 5.6 12 3Z"/></svg>''';

  static const _a11ySvg =
      '''<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 7.5V17M8.5 11h7"/></svg>''';

  static const _boltSvg =
      '''<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M13 2L4.5 13.5H11L9.5 22 19 10h-6.5L13 2Z"/></svg>''';

  static const _openSvg =
      '''<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M14 7l5 5-5 5M10 7l-5 5 5 5"/></svg>''';
}