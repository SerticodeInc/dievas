part of '../example_overview_screen.dart';

class _GridReadout extends StatelessWidget {
  const _GridReadout();

  @override
  Widget build(BuildContext context) {
    final grid = context.grid;

    return Wrap(
      spacing: context.spacing.MD,
      runSpacing: context.spacing.MD,
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
    padding: .symmetric(horizontal: context.spacing.MD, vertical: context.spacing.SM),
    decoration: BoxDecoration(color: context.colours.background.dialogBackground, borderRadius: context.border.MD),
    child: Column(
      crossAxisAlignment: .start,
      children: [
        Text(label, style: context.typography.labelXS.copyWith(color: context.colours.text.textTertiary)),
        SizedBox(height: context.spacing.XS),
        Text(value, style: context.typography.labelMD),
      ],
    ),
  );
}

class _L10nReadout extends StatelessWidget {
  const _L10nReadout();

  @override
  Widget build(BuildContext context) => Text(
    'context.l10n.emptyStateDefaultTitle → "${context.l10n.emptyStateDefaultTitle}"',
    style: context.typography.codeMD.copyWith(color: context.colours.text.textSecondary),
  );
}
