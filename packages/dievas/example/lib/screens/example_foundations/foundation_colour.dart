part of '../example_foundations_screen.dart';

class _ColourSwatches extends StatelessWidget {
  const _ColourSwatches();

  @override
  Widget build(BuildContext context) {
    final colours = context.colours;

    return Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        _Swatch(label: 'brand', colour: colours.core.brand),
        _Swatch(label: 'textPrimary', colour: colours.text.textPrimary),
        _Swatch(label: 'bgBase', colour: colours.background.bgBase),
        _Swatch(label: 'bgSubtle', colour: colours.background.bgSubtle),
        _Swatch(label: 'actionPrimary', colour: colours.action.actionPrimary),
        _Swatch(label: 'actionError', colour: colours.action.actionError),
        _Swatch(label: 'borderBrand', colour: colours.border.borderBrand),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.label, required this.colour});

  final String label;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    const colourSwatchWidth = 144.0;

    return SizedBox(
      width: colourSwatchWidth,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Container(
            height: context.spacing.x3l,
            decoration: BoxDecoration(
              color: colour,
              borderRadius: context.border.md,
              border: .all(color: context.colours.border.borderDefault),
            ),
          ),
          SizedBox(height: context.spacing.sm),
          Text(label, style: context.typography.codeSm),
        ],
      ),
    );
  }
}
