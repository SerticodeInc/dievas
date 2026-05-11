import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final dividerComponent = WidgetbookComponent(
  name: 'Divider',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: _playground),
    WidgetbookUseCase(name: 'Both Orientations', builder: _bothOrientations),
  ],
);

Widget _playground(BuildContext context) {
  final orientation = context.knobs.object.dropdown<DievasDividerOrientation>(
    label: 'Orientation',
    options: DievasDividerOrientation.values,
    labelBuilder: (v) => v.name,
  );

  final indent = context.knobs.double.slider(label: 'Indent', initialValue: 0, min: 0, max: 48);

  final endIndent = context.knobs.double.slider(label: 'End Indent', initialValue: 0, min: 0, max: 48);

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: ComponentBoundary(
        child: SizedBox(
          width: orientation == DievasDividerOrientation.horizontal ? 280 : 1,
          height: orientation == DievasDividerOrientation.vertical ? 80 : 1,
          child: DievasDivider(orientation: orientation, indent: indent, endIndent: endIndent),
        ),
      ),
    ),
  );
}

Widget _bothOrientations(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Horizontal', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        const ComponentBoundary(child: SizedBox(width: 280, child: DievasDivider())),
        const SizedBox(height: 24),
        const Text('Horizontal with indent', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        const ComponentBoundary(child: SizedBox(width: 280, child: DievasDivider(indent: 16, endIndent: 16))),
        const SizedBox(height: 24),
        const Text('Vertical', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        const ComponentBoundary(
          child: SizedBox(height: 48, child: DievasDivider(orientation: DievasDividerOrientation.vertical)),
        ),
      ],
    ),
  ),
);
