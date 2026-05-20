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
    final colors = DievasTheme.colorsOf(context);

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
      ('x2l', spacing.x2l),
      ('x3l', spacing.x3l),
      ('x4l', spacing.x4l),
      ('x5l', spacing.x5l),
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
                      ).labelXs.copyWith(fontFamily: 'monospace', color: colors.text.textTertiary),
                    ),
                  ),
                  Text(
                    '${value.toStringAsFixed(0)}dp',
                    style: DievasTheme.typographyOf(
                      context,
                    ).labelXs.copyWith(color: colors.text.textSecondary, fontFamily: 'monospace'),
                  ),
                  SizedBox(width: context.spacing.md),
                  Container(
                    width: value,
                    height: 20,
                    decoration: BoxDecoration(
                      color: colors.action.actionPrimary.withAlpha(80),
                      borderRadius: context.border.xs, // tiny bar viz — closest token
                      border: Border.all(color: colors.action.actionPrimary),
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
    final colors = DievasTheme.colorsOf(context);

    final entries = [
      ('xs', border.xs),
      ('sm', border.sm),
      ('md', border.md),
      ('lg', border.lg),
      ('xl', border.xl),
      ('x2l', border.x2l),
      ('x3l', border.x3l),
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
                    color: colors.action.actionPrimary.withAlpha(30),
                    border: Border.all(color: colors.action.actionPrimary),
                    borderRadius: radius,
                  ),
                ),
                SizedBox(height: context.spacing.sm),
                Text(
                  name,
                  style: DievasTheme.typographyOf(
                    context,
                  ).labelXs.copyWith(fontFamily: 'monospace', color: colors.text.textTertiary),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
