part of '../example_foundations_screen.dart';

class _ThemeStatics extends StatelessWidget {
  const _ThemeStatics();

  @override
  Widget build(BuildContext context) {
    const avatarRadiusFactor = 0.5;

    return Column(
      crossAxisAlignment: .start,
      children: [
        _ThemeValueRow(
          label: 'Appearance',
          accessor: 'DievasTheme.materialOf(context)',
          value: Text(switch (DievasTheme.materialOf(context).brightness) {
            .light => 'Light',
            .dark => 'Dark',
          }, style: context.typography.labelMD),
        ),
        SizedBox(height: context.spacing.LG),
        _ThemeValueRow(
          label: 'Brand colour',
          accessor: 'DievasTheme.coloursOf(context).core.brand',
          value: Semantics(
            label: 'Active theme brand colour',
            child: CircleAvatar(
              radius: context.sizing.avatarSM * avatarRadiusFactor,
              backgroundColor: DievasTheme.coloursOf(context).core.brand,
            ),
          ),
        ),
        SizedBox(height: context.spacing.LG),
        _ThemeValueRow(
          label: 'Fast motion',
          accessor: 'DievasTheme.animationOf(context).fast',
          value: Text('${DievasTheme.animationOf(context).fast.inMilliseconds} ms', style: context.typography.labelMD),
        ),
      ],
    );
  }
}

class _ThemeValueRow extends StatelessWidget {
  const _ThemeValueRow({required this.label, required this.accessor, required this.value});

  final String label;
  final String accessor;
  final Widget value;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    children: [
      Wrap(
        spacing: context.spacing.MD,
        runSpacing: context.spacing.SM,
        crossAxisAlignment: .center,
        children: [
          Text(label, style: context.typography.bodyMD),
          value,
        ],
      ),
      SizedBox(height: context.spacing.XS),
      Text(accessor, style: context.typography.codeSM.copyWith(color: context.colours.text.textSecondary)),
    ],
  );
}

class _ComponentOverride extends StatelessWidget {
  const _ComponentOverride();

  @override
  Widget build(BuildContext context) {
    // Build a theme copy with the avatar component overridden for this subtree
    // only. Everything else inherits from the scope theme above.
    final theme = DievasTheme.of(context);
    final overridden = theme.copyWith(
      components: theme.components.copyWith(
        avatar: theme.components.avatar.copyWith(
          backgroundColour: context.colours.action.actionPrimary,
          initialsColour: context.colours.core.onBrand,
        ),
      ),
    );

    return Wrap(
      spacing: context.spacing.XL2,
      runSpacing: context.spacing.LG,
      children: [
        Column(
          crossAxisAlignment: .start,
          children: [
            Text('Default', style: context.typography.labelSM),
            SizedBox(height: context.spacing.MD),
            const DievasAvatar(initials: 'DX'),
          ],
        ),
        Column(
          crossAxisAlignment: .start,
          children: [
            Text('Local override', style: context.typography.labelSM),
            SizedBox(height: context.spacing.MD),
            DievasTheme(
              data: overridden,
              child: const DievasAvatar(initials: 'DX'),
            ),
          ],
        ),
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
    decoration: BoxDecoration(color: context.colours.background.bgElevated, borderRadius: context.border.MD),
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
