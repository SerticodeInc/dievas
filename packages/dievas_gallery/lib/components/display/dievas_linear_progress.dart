import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final linearProgressComponent = WidgetbookComponent(
  name: 'LinearProgress',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: _playground),
    WidgetbookUseCase(name: 'All Styles', builder: _allStyles),
    WidgetbookUseCase(name: 'Indeterminate', builder: _indeterminate),
  ],
);

Widget _playground(BuildContext context) {
  final value = context.knobs.double.slider(label: 'Value (0 = indeterminate)', initialValue: 0.6, min: 0, max: 1);

  final style = context.knobs.object.dropdown<DievasLinearProgressStyle>(
    label: 'Style',
    options: DievasLinearProgressStyle.values,
    labelBuilder: (v) => v.name,
  );

  final isIndeterminate = context.knobs.boolean(label: 'Indeterminate');

  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ComponentBoundary(
        child: DievasLinearProgress(value: isIndeterminate ? null : value, style: style),
      ),
    ),
  );
}

Widget _allStyles(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.all(32),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final style in DievasLinearProgressStyle.values) ...[
          Row(
            children: [
              SizedBox(width: 64, child: Text(style.name, style: const TextStyle(fontSize: 11))),
              Expanded(
                child: ComponentBoundary(child: DievasLinearProgress(value: 0.65, style: style)),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ],
    ),
  ),
);

Widget _indeterminate(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32),
    child: ComponentBoundary(child: DievasLinearProgress()),
  ),
);
