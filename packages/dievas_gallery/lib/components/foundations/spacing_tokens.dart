import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

final spacingTokensComponent = WidgetbookComponent(
  name: 'Spacing Tokens',
  useCases: [
    WidgetbookUseCase(name: 'Spacing Scale', builder: (ctx) => const _SpacingScale()),
    WidgetbookUseCase(name: 'Border Radii', builder: (ctx) => const _BorderRadii()),
  ],
);

class _SpacingScale extends StatelessWidget {
  const _SpacingScale();

  @override
  Widget build(BuildContext context) {
    final spacing = DievasTheme.spacingOf(context);
    final colours = DievasTheme.coloursOf(context);

    final entries = [
      ('none', spacing.none),
      ('xs', spacing.xs),
      ('sm', spacing.sm),
      ('smPlus', spacing.smPlus),
      ('md', spacing.md),
      ('mdPlus', spacing.mdPlus),
      ('lg', spacing.lg),
      ('lgPlus', spacing.lgPlus),
      ('xl', spacing.xl),
      ('xl2', spacing.xl2),
      ('xl3', spacing.xl3),
      ('xl4', spacing.xl4),
      ('xl5', spacing.xl5),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (name, value) in entries)
            Padding(
              padding: EdgeInsets.only(bottom: context.spacing.smPlus),
              child: Row(
                children: [
                  SizedBox(
                    width: 80, // label column — gallery-only fixed width
                    child: Text(
                      name,
                      style: DievasTheme.typographyOf(
                        context,
                      ).labelXs.copyWith(fontFamily: 'monospace', color: colours.text.textTertiary),
                    ),
                  ),
                  Text(
                    '${value.toStringAsFixed(0)}dp',
                    style: DievasTheme.typographyOf(
                      context,
                    ).labelXs.copyWith(color: colours.text.textSecondary, fontFamily: 'monospace'),
                  ),
                  SizedBox(width: context.spacing.md),
                  Container(
                    width: value,
                    height: 20,
                    decoration: BoxDecoration(
                      color: colours.action.buttonPrimaryBackground.withAlpha(80),
                      borderRadius: context.border.xs, // tiny bar viz — closest token
                      border: Border.all(color: colours.action.buttonPrimaryBackground),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _BorderRadii extends StatelessWidget {
  const _BorderRadii();

  @override
  Widget build(BuildContext context) {
    final border = DievasTheme.borderOf(context);
    final colours = DievasTheme.coloursOf(context);

    final entries = [
      ('xs', border.xs),
      ('sm', border.sm),
      ('md', border.md),
      ('lg', border.lg),
      ('xl', border.xl),
      ('xl2', border.xl2),
      ('xl3', border.xl3),
      ('full', border.full),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Wrap(
        spacing: context.spacing.lg,
        runSpacing: context.spacing.lg,
        children: [
          for (final (name, radius) in entries)
            Column(
              children: [
                Container(
                  width: 64, // radius demo box — gallery-only visual dimension
                  height: 64, // radius demo box — gallery-only visual dimension
                  decoration: BoxDecoration(
                    color: colours.action.buttonPrimaryBackground.withAlpha(30),
                    border: Border.all(color: colours.action.buttonPrimaryBackground),
                    borderRadius: radius,
                  ),
                ),
                SizedBox(height: context.spacing.sm),
                Text(
                  name,
                  style: DievasTheme.typographyOf(
                    context,
                  ).labelXs.copyWith(fontFamily: 'monospace', color: colours.text.textTertiary),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
