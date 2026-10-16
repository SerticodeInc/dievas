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
      ('NONE', spacing.NONE),
      ('XS', spacing.XS),
      ('SM', spacing.SM),
      ('SMPlus', spacing.SMPlus),
      ('MD', spacing.MD),
      ('MDPlus', spacing.MDPlus),
      ('LG', spacing.LG),
      ('LGPlus', spacing.LGPlus),
      ('XL', spacing.XL),
      ('XL2', spacing.XL2),
      ('XL3', spacing.XL3),
      ('XL4', spacing.XL4),
      ('XL5', spacing.XL5),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacing.LG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (name, value) in entries)
            Padding(
              padding: EdgeInsets.only(bottom: context.spacing.SMPlus),
              child: Row(
                children: [
                  SizedBox(
                    width: 80, // label column — gallery-only fixed width
                    child: Text(
                      name,
                      style: DievasTheme.typographyOf(
                        context,
                      ).labelXS.copyWith(fontFamily: 'monospace', color: colours.text.textTertiary),
                    ),
                  ),
                  Text(
                    '${value.toStringAsFixed(0)}dp',
                    style: DievasTheme.typographyOf(
                      context,
                    ).labelXS.copyWith(color: colours.text.textSecondary, fontFamily: 'monospace'),
                  ),
                  SizedBox(width: context.spacing.MD),
                  Container(
                    width: value,
                    height: 20,
                    decoration: BoxDecoration(
                      color: colours.action.buttonPrimaryBackground.withAlpha(80),
                      borderRadius: context.border.XS, // tiny bar viz — closest token
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
      ('XS', border.XS),
      ('SM', border.SM),
      ('MD', border.MD),
      ('LG', border.LG),
      ('XL', border.XL),
      ('XL2', border.XL2),
      ('XL3', border.XL3),
      ('FULL', border.FULL),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacing.LG),
      child: Wrap(
        spacing: context.spacing.LG,
        runSpacing: context.spacing.LG,
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
                SizedBox(height: context.spacing.SM),
                Text(
                  name,
                  style: DievasTheme.typographyOf(
                    context,
                  ).labelXS.copyWith(fontFamily: 'monospace', color: colours.text.textTertiary),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
