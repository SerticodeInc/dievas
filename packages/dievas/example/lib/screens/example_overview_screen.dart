import 'package:flutter/material.dart';

import 'package:dievas/dievas.dart';

/// Overview — how the app wires into the design system.
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
      child: SingleChildScrollView(
        padding: .symmetric(horizontal: spacing.xl, vertical: spacing.x2l),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text('Dievas Example App', style: context.typography.displaySm),
            SizedBox(height: spacing.sm),
            Text(
              'Theme setup · overlays · grid · l10n',
              style: context.typography.bodyMd.copyWith(color: context.colours.text.textSecondary),
            ),
            SizedBox(height: spacing.x2l),

            const _SectionCard(
              title: 'Theme mode',
              description:
                  'DievasScope.of(context).setThemeMode(...) drives the active theme. '
                  'Try switching; every widget below updates instantly.',
              child: _ThemeModeControl(),
            ),
            SizedBox(height: spacing.lg),

            const _SectionCard(
              title: 'Overlays',
              description:
                  'DievasScope owns a banner and a snackbar overlay. '
                  'The builder returns a Dievas feedback component; the scope animates it.',
              child: _OverlayControls(),
            ),
            SizedBox(height: spacing.lg),

            const _SectionCard(
              title: 'Responsive grid',
              description:
                  'Wrap content in DievasGrid to read the current breakpoint '
                  'via context.grid. Columns, margin and gutter change with width.',
              child: _GridReadout(),
            ),
            SizedBox(height: spacing.lg),

            _SectionCard(
              title: 'Localizations',
              description:
                  'Component internal copy resolves through context.l10n. '
                  'Register DievasLocalizations delegates on MaterialApp to use it.',
              child: _L10nReadout(),
            ),
            SizedBox(height: spacing.x3l),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.description, required this.child});

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    final colours = context.colours;

    return Container(
      width: .infinity,
      padding: .all(spacing.lg),
      decoration: BoxDecoration(
        color: colours.background.bgSubtle,
        border: .all(color: colours.border.borderDefault),
        borderRadius: context.border.lg,
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(title, style: context.typography.titleLg),
          SizedBox(height: spacing.xs),
          Text(description, style: context.typography.bodySm.copyWith(color: colours.text.textSecondary)),
          SizedBox(height: spacing.lg),
          child,
        ],
      ),
    );
  }
}

class _ThemeModeControl extends StatelessWidget {
  const _ThemeModeControl();

  @override
  Widget build(BuildContext context) => DievasSegmentedControl<ThemeMode>(
    options: const [ThemeMode.system, ThemeMode.light, ThemeMode.dark],
    value: DievasScope.of(context).themeMode,
    onChanged: (mode) => DievasScope.of(context).setThemeMode(mode),
    labelBuilder: (mode) => switch (mode) {
      .system => 'System',
      .light => 'Light',
      .dark => 'Dark',
    },
  );
}

class _OverlayControls extends StatelessWidget {
  const _OverlayControls();

  @override
  Widget build(BuildContext context) {
    final scope = DievasScope.of(context);

    return Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        DievasFilledButton(
          label: 'Show banner',
          onPressed: () => _showDievasBanner(scope: scope),
        ),
        DievasOutlinedButton(
          label: 'Show snackbar',
          onPressed: () => _showDievasSnackbar(scope: scope),
        ),
      ],
    );
  }

  void _showDievasBanner({required DievasScopeController scope}) => scope.showBanner(
    (context, _) => DievasBanner(
      tone: .info,
      message: 'This banner is rendered by DievasScope.showBanner.',
      onDismiss: scope.hideBanner,
    ),
  );

  void _showDievasSnackbar({required DievasScopeController scope}) => scope.showSnackbar(
    (context, _) => DievasSnackbar(
      message: 'Snackbar rendered by DievasScope.showSnackbar.',
      action: DievasSnackbarAction(label: 'Dismiss', onPressed: scope.hideSnackbar),
    ),
  );
}

class _GridReadout extends StatelessWidget {
  const _GridReadout();

  @override
  Widget build(BuildContext context) {
    final grid = context.grid;

    return Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        _StatChip(label: 'Breakpoint', value: grid.name),
        _StatChip(label: 'Columns', value: '${grid.columns}'),
        _StatChip(label: 'Margin', value: '${grid.margin}'),
        _StatChip(label: 'Gutter', value: '${grid.gutter}'),
        _StatChip(label: 'Family', value: grid.family),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return Container(
      padding: .symmetric(horizontal: spacing.md, vertical: spacing.sm),
      decoration: BoxDecoration(color: context.colours.background.bgElevated, borderRadius: context.border.md),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(label, style: context.typography.labelXs.copyWith(color: context.colours.text.textTertiary)),
          SizedBox(height: context.spacing.xs),
          Text(value, style: context.typography.labelMd),
        ],
      ),
    );
  }
}

class _L10nReadout extends StatelessWidget {
  const _L10nReadout();

  @override
  Widget build(BuildContext context) => Text(
    'context.l10n.emptyStateDefaultTitle → "${context.l10n.emptyStateDefaultTitle}"',
    style: context.typography.codeMd.copyWith(color: context.colours.text.textSecondary),
  );
}
