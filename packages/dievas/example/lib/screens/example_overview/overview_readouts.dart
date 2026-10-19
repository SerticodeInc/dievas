part of '../example_overview_screen.dart';

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
  Widget build(BuildContext context) => Container(
    padding: .symmetric(horizontal: context.spacing.md, vertical: context.spacing.sm),
    decoration: BoxDecoration(color: context.colours.background.dialogBackground, borderRadius: context.border.md),
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

class _L10nReadout extends StatelessWidget {
  const _L10nReadout();

  @override
  Widget build(BuildContext context) => Text(
    'context.l10n.emptyStateDefaultTitle → "${context.l10n.emptyStateDefaultTitle}"',
    style: context.typography.codeMd.copyWith(color: context.colours.text.textSecondary),
  );
}
