part of '../example_foundations_screen.dart';

class _SpacingReadout extends StatelessWidget {
  const _SpacingReadout();

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return Wrap(
      spacing: context.spacing.MD,
      runSpacing: context.spacing.MD,
      children: [
        _StatChip(label: 'XS', value: '${spacing.XS}'),
        _StatChip(label: 'SM', value: '${spacing.SM}'),
        _StatChip(label: 'MD', value: '${spacing.MD}'),
        _StatChip(label: 'LG', value: '${spacing.LG}'),
        _StatChip(label: 'XL', value: '${spacing.XL}'),
        _StatChip(label: 'XL2', value: '${spacing.XL2}'),
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
      SizedBox(height: context.spacing.XL2),
      const _SurfacePreviews(),
      SizedBox(height: context.spacing.XL2),
      const _DisabledPreview(),
      SizedBox(height: context.spacing.XL2),
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
        Text('Medium controls', style: context.typography.titleMD),
        SizedBox(height: context.spacing.SM),
        Text(
          'The input is ${(context.sizing.inputHeightMD - context.sizing.buttonHeightMD).toStringAsFixed(wholeNumberPrecision)} px taller.',
          style: context.typography.bodySM,
        ),
        SizedBox(height: context.spacing.MD),
        Row(
          crossAxisAlignment: .start,
          children: [
            Expanded(
              child: _TokenPreview(
                label: 'Button',
                value: '${context.sizing.buttonHeightMD.toStringAsFixed(wholeNumberPrecision)} px',
                child: DievasFilledButton(label: 'Continue', onPressed: () {}),
              ),
            ),
            SizedBox(width: context.spacing.MD),
            Expanded(
              child: _TokenPreview(
                label: 'Input',
                value: '${context.sizing.inputHeightMD.toStringAsFixed(wholeNumberPrecision)} px',
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
      Text(label, style: context.typography.labelMD),
      SizedBox(height: context.spacing.SM),
      child,
      SizedBox(height: context.spacing.SM),
      Text(value, style: context.typography.codeSM.copyWith(color: context.colours.text.textSecondary)),
    ],
  );
}
