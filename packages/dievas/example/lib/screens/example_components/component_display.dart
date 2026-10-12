part of '../example_components_screen.dart';

class _DisplayRow extends StatelessWidget {
  const _DisplayRow();

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: context.spacing.MD,
    runSpacing: context.spacing.MD,
    crossAxisAlignment: .center,
    children: [
      // Per instance colour overrides (added for per component customization).
      const DievasAvatar(initials: 'DX'),
      DievasAvatar(
        initials: 'DX',
        backgroundColour: context.colours.action.actionPrimary,
        initialsColour: context.colours.core.onBrand,
      ),
      const DievasBadge(label: 'New', tone: .primary),
      const DievasBadge(label: 'Shipped', tone: .success),
      const DievasTag(label: 'Flutter'),
      DievasTag(label: 'Removable', onRemove: () {}, backgroundColor: context.colours.action.actionSecondary),
      const DievasIcon(Icons.bolt, size: .LG, semanticLabel: 'Bolt'),
      const DievasDivider(),
    ],
  );
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow();

  @override
  Widget build(BuildContext context) {
    const linearProgressWidth = 160.0;
    const sampleProgress = 0.65;

    return Wrap(
      spacing: context.spacing.MD,
      runSpacing: context.spacing.MD,
      crossAxisAlignment: .center,
      children: [
        const SizedBox(
          width: linearProgressWidth,
          child: DievasLinearProgress(value: sampleProgress),
        ),
        const SizedBox(width: linearProgressWidth, child: DievasLinearProgress(value: null)),
        const DievasCircularProgress(value: sampleProgress),
        const DievasCircularProgress(value: null),
      ],
    );
  }
}
