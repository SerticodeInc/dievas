import 'package:flutter/material.dart';

import 'package:dievas/dievas.dart';
import 'package:dievas_example/widgets/example_page.dart';

part 'example_overview/overview_section.dart';
part 'example_overview/overview_theme.dart';
part 'example_overview/overview_overlays.dart';
part 'example_overview/overview_readouts.dart';

/// Overview: how the app wires into the design system.
///
/// This screen demonstrates:
///   - theme mode switching via [DievasScope.of]
///   - banner / snackbar overlays via [DievasScope.of]
///   - the responsive grid ([DievasGrid] + `context.grid`)
///   - localizations via `context.l10n`
class ExampleOverviewScreen extends StatelessWidget {
  const ExampleOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return DievasGrid(
      child: ExamplePage(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text('Dievas Example App', style: context.typography.displaySM),
            SizedBox(height: spacing.SM),
            Text(
              'Theme setup · overlays · grid · l10n',
              style: context.typography.bodyMD.copyWith(color: context.colours.text.textSecondary),
            ),
            SizedBox(height: spacing.XL2),

            const _SectionCard(
              title: 'Theme mode',
              description:
                  'DievasScope.of(context).setThemeMode(...) drives the active theme. '
                  'Try switching; every widget below updates instantly.',
              child: _ThemeModeControl(),
            ),
            SizedBox(height: spacing.LG),

            const _SectionCard(
              title: 'Overlays',
              description:
                  'DievasScope owns a banner and a snackbar overlay. '
                  'The builder returns a Dievas feedback component; the scope animates it. '
                  'Both auto-dismiss on their own. Pass Duration.zero to showBanner/showSnackbar for a sticky overlay.',
              child: _OverlayControls(),
            ),
            SizedBox(height: spacing.LG),

            const _SectionCard(
              title: 'Responsive grid',
              description:
                  'Wrap content in DievasGrid to read the current breakpoint '
                  'via context.grid. Columns, margin and gutter change with width.',
              child: _GridReadout(),
            ),
            SizedBox(height: spacing.LG),

            const _SectionCard(
              title: 'Localizations',
              description:
                  'Component internal copy resolves through context.l10n. '
                  'Register DievasLocalizations delegates on MaterialApp to use it.',
              child: _L10nReadout(),
            ),
            SizedBox(height: spacing.XL3),
          ],
        ),
      ),
    );
  }
}
