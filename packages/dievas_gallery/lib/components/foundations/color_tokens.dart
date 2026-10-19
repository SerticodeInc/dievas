import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

final colourTokensComponent = WidgetbookComponent(
  name: 'Colour Tokens',
  useCases: [
    WidgetbookUseCase(name: 'All Colour Sets', builder: (ctx) => const _AllSets()),
    WidgetbookUseCase(name: 'Feedback Colours', builder: (ctx) => const _FeedbackColours()),
  ],
);

class _AllSets extends StatelessWidget {
  const _AllSets();

  @override
  Widget build(BuildContext context) {
    final colours = DievasTheme.coloursOf(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(
            label: 'Core',
            swatches: [
              _Swatch('primary', colours.core.primary),
              _Swatch('badgePrimaryTintedBackground', colours.core.badgePrimaryTintedBackground),
              _Swatch('buttonPrimaryText', colours.text.buttonPrimaryText, dark: true),
            ],
          ),
          _Section(
            label: 'Text',
            swatches: [
              _Swatch('textPrimary', colours.text.textPrimary),
              _Swatch('textSecondary', colours.text.textSecondary),
              _Swatch('textTertiary', colours.text.textTertiary),
              _Swatch('textDisabled', colours.text.textDisabled),
              _Swatch('textInverse', colours.text.textInverse, dark: true),
              _Swatch('buttonPrimaryText', colours.text.buttonPrimaryText, dark: true),
            ],
          ),
          _Section(
            label: 'Background',
            swatches: [
              _Swatch('pageBackground', colours.background.pageBackground),
              _Swatch('cardBackground', colours.background.cardBackground),
              _Swatch('dialogBackground', colours.background.dialogBackground),
              _Swatch('modalBarrierBackground', colours.background.modalBarrierBackground, dark: true),
            ],
          ),
          _Section(
            label: 'Border',
            swatches: [
              _Swatch('dividerColour', colours.border.dividerColour),
              _Swatch('inputActiveBorder', colours.border.inputActiveBorder),
              _Swatch('inputDisabledBorder', colours.border.inputDisabledBorder),
              _Swatch('focusIndicatorColour', colours.border.focusIndicatorColour),
              _Swatch('selectionBorder', colours.border.selectionBorder),
            ],
          ),
          _Section(
            label: 'Action',
            swatches: [
              _Swatch('buttonPrimaryBackground', colours.action.buttonPrimaryBackground, dark: true),
              _Swatch('buttonPrimaryHoveredBackground', colours.action.buttonPrimaryHoveredBackground, dark: true),
              _Swatch('buttonPrimaryPressedBackground', colours.action.buttonPrimaryPressedBackground, dark: true),
              _Swatch('buttonPrimaryDisabledBackground', colours.action.buttonPrimaryDisabledBackground),
              _Swatch('buttonSecondaryBackground', colours.action.buttonSecondaryBackground),
              _Swatch('buttonSecondaryHoveredBackground', colours.action.buttonSecondaryHoveredBackground),
              _Swatch('buttonDestructiveBackground', colours.action.buttonDestructiveBackground, dark: true),
              _Swatch(
                'buttonDestructiveHoveredBackground',
                colours.action.buttonDestructiveHoveredBackground,
                dark: true,
              ),
              _Swatch('buttonSuccessBackground', colours.action.buttonSuccessBackground, dark: true),
            ],
          ),
          _Section(
            label: 'Icon',
            swatches: [
              _Swatch('iconPrimary', colours.icon.iconPrimary),
              _Swatch('iconSecondary', colours.icon.iconSecondary),
              _Swatch('iconDisabled', colours.icon.iconDisabled),
              _Swatch('buttonPrimaryIcon', colours.icon.buttonPrimaryIcon, dark: true),
            ],
          ),
          _Section(
            label: 'Static',
            swatches: [
              _Swatch('staticWhite', colours.staticColours.staticWhite),
              _Swatch('staticBlack', colours.staticColours.staticBlack, dark: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeedbackColours extends StatelessWidget {
  const _FeedbackColours();

  @override
  Widget build(BuildContext context) {
    final colours = DievasTheme.coloursOf(context);

    final tones = [
      ('Success', colours.feedback.feedbackSuccess),
      ('Warning', colours.feedback.feedbackWarning),
      ('Error', colours.feedback.feedbackError),
      ('Info', colours.feedback.feedbackInfo),
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (name, fc) in tones)
            _Section(
              label: name,
              swatches: [
                _Swatch('background', fc.background),
                _Swatch('border', fc.border),
                _Swatch('icon', fc.icon),
                _Swatch('text', fc.text),
              ],
            ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.label, required this.swatches});

  final String label;
  final List<_Swatch> swatches;

  @override
  Widget build(BuildContext context) {
    final typography = DievasTheme.typographyOf(context);
    final colours = DievasTheme.coloursOf(context);

    return Padding(
      padding: EdgeInsets.only(bottom: context.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: typography.labelXs.copyWith(letterSpacing: 2, color: colours.text.textTertiary),
          ),
          SizedBox(height: context.spacing.smPlus),
          Wrap(spacing: context.spacing.smPlus, runSpacing: context.spacing.smPlus, children: swatches),
        ],
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch(this.name, this.color, {this.dark = false});

  final String name;
  final Color color;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final typography = DievasTheme.typographyOf(context);

    return Column(
      children: [
        Container(
          width: 72, // swatch chip — gallery-only visual dimension
          height: 48, // swatch chip — gallery-only visual dimension
          decoration: BoxDecoration(
            color: color,
            borderRadius: context.border.md,
            border: Border.all(color: context.colours.border.dividerColour.withAlpha(50)),
          ),
        ),
        SizedBox(height: context.spacing.sm),
        SizedBox(
          width: 72, // swatch label width — gallery-only
          child: Text(
            name,
            style: typography.labelXs,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
