import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

final colorTokensComponent = WidgetbookComponent(
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
    final colors = DievasTheme.colorsOf(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(
            label: 'Core',
            swatches: [
              _Swatch('brand', colors.core.brand),
              _Swatch('brandSubtle', colors.core.brandSubtle),
              _Swatch('onBrand', colors.core.onBrand, dark: true),
            ],
          ),
          _Section(
            label: 'Text',
            swatches: [
              _Swatch('textPrimary', colors.text.textPrimary),
              _Swatch('textSecondary', colors.text.textSecondary),
              _Swatch('textTertiary', colors.text.textTertiary),
              _Swatch('textDisabled', colors.text.textDisabled),
              _Swatch('textInverse', colors.text.textInverse, dark: true),
              _Swatch('textOnBrand', colors.text.textOnBrand, dark: true),
            ],
          ),
          _Section(
            label: 'Background',
            swatches: [
              _Swatch('bgBase', colors.background.bgBase),
              _Swatch('bgSubtle', colors.background.bgSubtle),
              _Swatch('bgElevated', colors.background.bgElevated),
              _Swatch('bgOverlay', colors.background.bgOverlay, dark: true),
            ],
          ),
          _Section(
            label: 'Border',
            swatches: [
              _Swatch('borderDefault', colors.border.borderDefault),
              _Swatch('borderStrong', colors.border.borderStrong),
              _Swatch('borderDisabled', colors.border.borderDisabled),
              _Swatch('borderFocus', colors.border.borderFocus),
              _Swatch('borderBrand', colors.border.borderBrand),
            ],
          ),
          _Section(
            label: 'Action',
            swatches: [
              _Swatch('actionPrimary', colors.action.actionPrimary, dark: true),
              _Swatch('actionPrimaryHover', colors.action.actionPrimaryHover, dark: true),
              _Swatch('actionPrimaryActive', colors.action.actionPrimaryActive, dark: true),
              _Swatch('actionPrimaryDisabled', colors.action.actionPrimaryDisabled),
              _Swatch('actionSecondary', colors.action.actionSecondary),
              _Swatch('actionSecondaryHover', colors.action.actionSecondaryHover),
              _Swatch('actionError', colors.action.actionError, dark: true),
              _Swatch('actionErrorHover', colors.action.actionErrorHover, dark: true),
              _Swatch('actionSuccess', colors.action.actionSuccess, dark: true),
            ],
          ),
          _Section(
            label: 'Icon',
            swatches: [
              _Swatch('iconPrimary', colors.icon.iconPrimary),
              _Swatch('iconSecondary', colors.icon.iconSecondary),
              _Swatch('iconDisabled', colors.icon.iconDisabled),
              _Swatch('iconOnBrand', colors.icon.iconOnBrand, dark: true),
            ],
          ),
          _Section(
            label: 'Static',
            swatches: [
              _Swatch('staticWhite', colors.staticColours.staticWhite),
              _Swatch('staticBlack', colors.staticColours.staticBlack, dark: true),
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
    final colors = DievasTheme.colorsOf(context);

    final tones = [
      ('Success', colors.feedback.feedbackSuccess),
      ('Warning', colors.feedback.feedbackWarning),
      ('Error', colors.feedback.feedbackError),
      ('Info', colors.feedback.feedbackInfo),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacing.lg),
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
    final colors = DievasTheme.colorsOf(context);

    return Padding(
      padding: EdgeInsets.only(bottom: context.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: typography.labelXs.copyWith(letterSpacing: 2, color: colors.text.textTertiary),
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
            border: Border.all(color: context.colors.border.borderDefault.withAlpha(50)),
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
