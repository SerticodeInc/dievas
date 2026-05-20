import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final iconComponent = WidgetbookComponent(
  name: 'Icon',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Sizes', builder: (ctx) => const _AllSizes()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = context.knobs.object.dropdown<DievasIconSize>(
      label: 'Size',
      options: DievasIconSize.values,
      labelBuilder: (v) => v.name,
      initialOption: DievasIconSize.md,
    );

    return Center(
      child: ComponentBoundary(child: DievasIcon(Icons.star_rounded, size: size)),
    );
  }
}

class _AllSizes extends StatelessWidget {
  const _AllSizes();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Wrap(
        spacing: context.spacing.lg,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final size in DievasIconSize.values)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ComponentBoundary(child: DievasIcon(Icons.star_rounded, size: size)),
                SizedBox(height: context.spacing.sm),
                Text(size.name, style: context.typography.labelXs),
              ],
            ),
        ],
      ),
    ),
  );
}
