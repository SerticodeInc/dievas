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
      ('NONE', elevation.NONE),
      ('XS', elevation.XS),
      ('SM', elevation.SM),
      ('MD', elevation.MD),
      ('LG', elevation.LG),
      ('XL', elevation.XL),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.LG, vertical: context.spacing.XLPlus),
      child: Wrap(
        spacing: context.spacing.XL,
        runSpacing: context.spacing.XLPlus,
        alignment: WrapAlignment.start,
        children: [
          for (final (name, shadows) in levels)
            Column(
              children: [
                Container(
                  width: 96, // elevation card demo — gallery-only visual dimension
                  height: 64, // elevation card demo — gallery-only visual dimension
                  decoration: BoxDecoration(
                    color: colours.background.bgElevated,
                    borderRadius: DievasTheme.borderOf(context).MD,
                    boxShadow: shadows,
                  ),
                ),
                SizedBox(height: context.spacing.SMPlus),
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
      padding: EdgeInsets.all(context.spacing.LG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (name, value) in entries)
            Padding(
              padding: EdgeInsets.only(bottom: context.spacing.MD),
              child: Row(
                children: [
                  SizedBox(
                    width: 112, // label column — gallery-only fixed width
                    child: Text(
                      name,
                      style: DievasTheme.typographyOf(
                        context,
                      ).labelXS.copyWith(fontFamily: 'monospace', color: colours.text.textTertiary),
                    ),
                  ),
                  SizedBox(
                    width: 40, // percentage column — gallery-only fixed width
                    child: Text(
                      '${(value * 100).round()}%',
                      textAlign: TextAlign.end,
                      style: DievasTheme.typographyOf(
                        context,
                      ).labelXS.copyWith(color: colours.text.textSecondary, fontFamily: 'monospace'),
                    ),
                  ),
                  SizedBox(width: context.spacing.MD),
                  Opacity(
                    opacity: value,
                    child: Container(
                      width: 80, // opacity chip demo — gallery-only visual dimension
                      height: 28, // opacity chip demo — gallery-only visual dimension
                      decoration: BoxDecoration(
                        color: colours.action.actionPrimary,
                        borderRadius: DievasTheme.borderOf(context).SM,
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
