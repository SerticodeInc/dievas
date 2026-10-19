part of '../example_foundations_screen.dart';

class _SpacingReadout extends StatelessWidget {
  const _SpacingReadout();

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        _StatChip(label: 'xs', value: '${spacing.xs}'),
        _StatChip(label: 'sm', value: '${spacing.sm}'),
        _StatChip(label: 'md', value: '${spacing.md}'),
        _StatChip(label: 'lg', value: '${spacing.lg}'),
        _StatChip(label: 'xl', value: '${spacing.xl}'),
        _StatChip(label: 'xl2', value: '${spacing.xl2}'),
      ],
    );
  }
}

class _ValueReadouts extends StatelessWidget {
  const _ValueReadouts();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    children: [
      const _ControlSizes(),
      SizedBox(height: context.spacing.xl2),
      const _SurfacePreviews(),
      SizedBox(height: context.spacing.xl2),
      const _DisabledPreview(),
      SizedBox(height: context.spacing.xl2),
      const _MotionPreview(),
    ],
  );
}

class _ControlSizes extends StatelessWidget {
  const _ControlSizes();

  @override
  Widget build(BuildContext context) {
    const wholeNumberPrecision = 0;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text('Medium controls', style: context.typography.titleMd),
        SizedBox(height: context.spacing.sm),
        Text(
          'The input is ${(context.sizing.inputHeightMd - context.sizing.buttonHeightMd).toStringAsFixed(wholeNumberPrecision)} px taller.',
          style: context.typography.bodySm,
        ),
        SizedBox(height: context.spacing.md),
        Row(
          crossAxisAlignment: .start,
          children: [
            Expanded(
              child: _TokenPreview(
                label: 'Button',
                value: '${context.sizing.buttonHeightMd.toStringAsFixed(wholeNumberPrecision)} px',
                child: DievasFilledButton(label: 'Continue', onPressed: () {}),
              ),
            ),
            SizedBox(width: context.spacing.md),
            Expanded(
              child: _TokenPreview(
                label: 'Input',
                value: '${context.sizing.inputHeightMd.toStringAsFixed(wholeNumberPrecision)} px',
                child: const DievasTextInput(hint: 'Your name'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TokenPreview extends StatelessWidget {
  const _TokenPreview({required this.label, required this.value, required this.child});

  final String label;
  final String value;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    children: [
      Text(label, style: context.typography.labelMd),
      SizedBox(height: context.spacing.sm),
      child,
      SizedBox(height: context.spacing.sm),
      Text(value, style: context.typography.codeSm.copyWith(color: context.colours.text.textSecondary)),
    ],
  );
}
