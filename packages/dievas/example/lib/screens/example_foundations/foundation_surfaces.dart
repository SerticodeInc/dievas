part of '../example_foundations_screen.dart';

class _SurfacePreviews extends StatelessWidget {
  const _SurfacePreviews();

  @override
  Widget build(BuildContext context) {
    const wholeNumberPrecision = 0;

    return Wrap(
      spacing: context.spacing.lg,
      runSpacing: context.spacing.lg,
      children: [
        _TokenPreview(
          label: 'Large radius',
          value: '${context.border.lg.topLeft.x.toStringAsFixed(wholeNumberPrecision)} px radius',
          child: _SurfaceSample(borderRadius: context.border.lg),
        ),
        _TokenPreview(
          label: 'Thin stroke',
          value: '${context.border.strokeThin} px stroke',
          child: _SurfaceSample(
            borderRadius: context.border.none,
            border: Border.all(color: context.colours.text.textPrimary, width: context.border.strokeThin),
          ),
        ),
        _TokenPreview(
          label: 'Medium elevation',
          value: 'elevation.md',
          child: Padding(
            padding: EdgeInsets.all(context.spacing.md),
            child: _SurfaceSample(borderRadius: context.border.md, shadows: context.elevation.md),
          ),
        ),
      ],
    );
  }
}

class _SurfaceSample extends StatelessWidget {
  const _SurfaceSample({required this.borderRadius, this.border, this.shadows});

  final BorderRadius borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? shadows;

  @override
  Widget build(BuildContext context) {
    const surfaceWidthInControlHeights = 2.0;

    return Container(
      width: context.sizing.buttonHeightMd * surfaceWidthInControlHeights,
      height: context.sizing.buttonHeightMd,
      decoration: BoxDecoration(
        color: context.colours.background.dialogBackground,
        borderRadius: borderRadius,
        border: border,
        boxShadow: shadows,
      ),
    );
  }
}

class _DisabledPreview extends StatelessWidget {
  const _DisabledPreview();

  @override
  Widget build(BuildContext context) {
    const opacityPrecision = 2;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text('Disabled opacity', style: context.typography.titleMd),
        SizedBox(height: context.spacing.md),
        Wrap(
          spacing: context.spacing.lg,
          runSpacing: context.spacing.md,
          children: [
            _TokenPreview(
              label: 'Enabled',
              value: 'Full opacity',
              child: DievasFilledButton(label: 'Continue', onPressed: () {}),
            ),
            _TokenPreview(
              label: 'Disabled',
              value: 'opacity.disabled: ${context.opacity.disabled.toStringAsFixed(opacityPrecision)}',
              child: const DievasFilledButton(label: 'Continue', state: .disabled),
            ),
          ],
        ),
      ],
    );
  }
}
