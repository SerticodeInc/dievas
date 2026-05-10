import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final circularProgressComponent = WidgetbookComponent(
  name: 'CircularProgress',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: _playground),
    WidgetbookUseCase(name: 'All Sizes', builder: _allSizes),
    WidgetbookUseCase(name: 'All Styles', builder: _allStyles),
  ],
);

Widget _playground(BuildContext context) {
  final value = context.knobs.double.slider(
    label: 'Value (0 = indeterminate)',
    initialValue: 0.6,
    min: 0,
    max: 1,
  );

  final size = context.knobs.list<DievasCircularProgressSize>(
    label: 'Size',
    options: DievasCircularProgressSize.values,
    labelBuilder: (v) => v.name,
    initialOption: DievasCircularProgressSize.md,
  );

  final style = context.knobs.list<DievasCircularProgressStyle>(
    label: 'Style',
    options: DievasCircularProgressStyle.values,
    labelBuilder: (v) => v.name,
  );

  final isIndeterminate = context.knobs.boolean(label: 'Indeterminate');

  return Center(
    child: ComponentBoundary(
      child: DievasCircularProgress(
        value: isIndeterminate ? null : value,
        size: size,
        style: style,
      ),
    ),
  );
}

Widget _allSizes(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      spacing: 24,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final size in DievasCircularProgressSize.values)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ComponentBoundary(child: DievasCircularProgress(value: 0.65, size: size)),
              const SizedBox(height: 8),
              Text(size.name, style: const TextStyle(fontSize: 11)),
            ],
          ),
      ],
    ),
  ),
);

Widget _allStyles(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      spacing: 24,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final style in DievasCircularProgressStyle.values)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ComponentBoundary(child: DievasCircularProgress(value: 0.65, style: style)),
              const SizedBox(height: 8),
              Text(style.name, style: const TextStyle(fontSize: 11)),
            ],
          ),
      ],
    ),
  ),
);
