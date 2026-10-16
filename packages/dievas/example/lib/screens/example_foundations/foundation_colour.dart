part of '../example_foundations_screen.dart';

class _ColourSwatches extends StatelessWidget {
  const _ColourSwatches();

  @override
  Widget build(BuildContext context) {
    final colours = context.colours;

    return Wrap(
      spacing: context.spacing.MD,
      runSpacing: context.spacing.MD,
      children: [
        _Swatch(label: 'primary', colour: colours.core.primary),
        _Swatch(label: 'textPrimary', colour: colours.text.textPrimary),
        _Swatch(label: 'pageBackground', colour: colours.background.pageBackground),
        _Swatch(label: 'cardBackground', colour: colours.background.cardBackground),
        _Swatch(label: 'buttonPrimaryBackground', colour: colours.action.buttonPrimaryBackground),
        _Swatch(label: 'buttonDestructiveBackground', colour: colours.action.buttonDestructiveBackground),
        _Swatch(label: 'selectionBorder', colour: colours.border.selectionBorder),
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
            height: context.spacing.XL3,
            decoration: BoxDecoration(
              color: colour,
              borderRadius: context.border.MD,
              border: .all(color: context.colours.border.dividerColour),
            ),
          ),
          SizedBox(height: context.spacing.SM),
          Text(label, style: context.typography.codeSM),
        ],
      ),
    );
  }
}
