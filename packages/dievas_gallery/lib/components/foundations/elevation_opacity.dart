import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

final elevationOpacityComponent = WidgetbookComponent(
  name: 'Elevation & Opacity',
  useCases: [
    WidgetbookUseCase(name: 'Elevation Levels', builder: (ctx) => const _ElevationLevels()),
    WidgetbookUseCase(name: 'Opacity Tokens', builder: (ctx) => const _OpacityTokens()),
  ],
);

class _ElevationLevels extends StatelessWidget {
  const _ElevationLevels();

  @override
  Widget build(BuildContext context) {
    final elevation = DievasTheme.elevationOf(context);
    final colours = DievasTheme.coloursOf(context);

    final levels = [
      ('none', elevation.none),
      ('xs', elevation.xs),
      ('sm', elevation.sm),
      ('md', elevation.md),
      ('lg', elevation.lg),
      ('xl', elevation.xl),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.lg, vertical: context.spacing.xlPlus),
      child: Wrap(
        spacing: context.spacing.xl,
        runSpacing: context.spacing.xlPlus,
        alignment: WrapAlignment.start,
        children: [
          for (final (name, shadows) in levels)
            Column(
              children: [
                Container(
                  width: 96, // elevation card demo — gallery-only visual dimension
                  height: 64, // elevation card demo — gallery-only visual dimension
                  decoration: BoxDecoration(
                    color: colours.background.dialogBackground,
                    borderRadius: DievasTheme.borderOf(context).md,
                    boxShadow: shadows,
                  ),
                ),
                SizedBox(height: context.spacing.smPlus),
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

class _OpacityTokens extends StatelessWidget {
  const _OpacityTokens();

  @override
  Widget build(BuildContext context) {
    final opacity = DievasTheme.opacityOf(context);
    final colours = DievasTheme.coloursOf(context);

    final entries = [
      ('transparent', opacity.transparent),
      ('hoverGhost', opacity.hoverGhost),
      ('focusRing', opacity.focusRing),
      ('pressedGhost', opacity.pressedGhost),
      ('disabled', opacity.disabled),
      ('overlay', opacity.overlay),
      ('opaque', opacity.opaque),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (name, value) in entries)
            Padding(
              padding: EdgeInsets.only(bottom: context.spacing.md),
              child: Row(
                children: [
                  SizedBox(
                    width: 112, // label column — gallery-only fixed width
                    child: Text(
                      name,
                      style: DievasTheme.typographyOf(
                        context,
                      ).labelXs.copyWith(fontFamily: 'monospace', color: colours.text.textTertiary),
                    ),
                  ),
                  SizedBox(
                    width: 40, // percentage column — gallery-only fixed width
                    child: Text(
                      '${(value * 100).round()}%',
                      textAlign: TextAlign.end,
                      style: DievasTheme.typographyOf(
                        context,
                      ).labelXs.copyWith(color: colours.text.textSecondary, fontFamily: 'monospace'),
                    ),
                  ),
                  SizedBox(width: context.spacing.md),
                  Opacity(
                    opacity: value,
                    child: Container(
                      width: 80, // opacity chip demo — gallery-only visual dimension
                      height: 28, // opacity chip demo — gallery-only visual dimension
                      decoration: BoxDecoration(
                        color: colours.action.buttonPrimaryBackground,
                        borderRadius: DievasTheme.borderOf(context).sm,
                      ),
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
