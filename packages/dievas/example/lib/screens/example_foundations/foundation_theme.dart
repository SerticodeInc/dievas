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
          }, style: context.typography.labelMd),
        ),
        SizedBox(height: context.spacing.lg),
        _ThemeValueRow(
          label: 'Brand colour',
          accessor: 'DievasTheme.coloursOf(context).core.primary',
          value: Semantics(
            label: 'Active theme primary colour',
            child: CircleAvatar(
              radius: context.sizing.avatarSm * avatarRadiusFactor,
              backgroundColor: DievasTheme.coloursOf(context).core.primary,
            ),
          ),
        ),
        SizedBox(height: context.spacing.lg),
        _ThemeValueRow(
          label: 'Fast motion',
          accessor: 'DievasTheme.animationOf(context).fast',
          value: Text('${DievasTheme.animationOf(context).fast.inMilliseconds} ms', style: context.typography.labelMd),
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
        spacing: context.spacing.md,
        runSpacing: context.spacing.sm,
        crossAxisAlignment: .center,
        children: [
          Text(label, style: context.typography.bodyMd),
          value,
        ],
      ),
      SizedBox(height: context.spacing.xs),
      Text(accessor, style: context.typography.codeSm.copyWith(color: context.colours.text.textSecondary)),
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
          backgroundColour: context.colours.action.buttonPrimaryBackground,
          initialsColour: context.colours.text.buttonPrimaryText,
        ),
      ),
    );

    return Wrap(
      spacing: context.spacing.xl2,
      runSpacing: context.spacing.lg,
      children: [
        Column(
          crossAxisAlignment: .start,
          children: [
            Text('Default', style: context.typography.labelSm),
            SizedBox(height: context.spacing.md),
            const DievasAvatar(initials: 'DX'),
          ],
        ),
        Column(
          crossAxisAlignment: .start,
          children: [
            Text('Local override', style: context.typography.labelSm),
            SizedBox(height: context.spacing.md),
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
