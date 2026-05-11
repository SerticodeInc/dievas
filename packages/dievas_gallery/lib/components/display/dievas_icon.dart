import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final iconComponent = WidgetbookComponent(
  name: 'Icon',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: _playground),
    WidgetbookUseCase(name: 'All Sizes', builder: _allSizes),
  ],
);

Widget _playground(BuildContext context) {
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

Widget _allSizes(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      spacing: 24,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final size in DievasIconSize.values)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ComponentBoundary(child: DievasIcon(Icons.star_rounded, size: size)),
              const SizedBox(height: 8),
              Text(size.name, style: const TextStyle(fontSize: 11)),
            ],
          ),
      ],
    ),
  ),
);
