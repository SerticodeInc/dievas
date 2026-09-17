import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// The shared sun/moon theme toggle.
///
/// One markup, two homes (nav pill + footer closing column). Both
/// `data-theme-toggle` buttons drive the same handler in
/// `app.dart`, which flips `data-theme` on the document root.
class ThemeToggle extends StatelessComponent {
  const ThemeToggle({super.key});

  @override
  Component build(BuildContext context) => button(
    type: ButtonType.button,
    classes: 'theme-toggle press',
    attributes: const {'data-theme-toggle': '', 'aria-label': 'Switch colour theme'},
    [
      span(classes: 'ti ti-sun', [RawText(_sunSvg)]),
      span(classes: 'ti ti-moon', [RawText(_moonSvg)]),
    ],
  );

  static const _sunSvg =
      '''<svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="4.2"/><path d="M12 2.5v2.2M12 19.3v2.2M4.9 4.9l1.6 1.6M17.5 17.5l1.6 1.6M2.5 12h2.2M19.3 12h2.2M4.9 19.1l1.6-1.6M17.5 6.5l1.6-1.6"/></svg>''';

  static const _moonSvg =
      '''<svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M20 13.5A8 8 0 0 1 10.5 4 8 8 0 1 0 20 13.5Z"/></svg>''';
}
