import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final dividerComponent = WidgetbookComponent(
  name: 'Divider',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'Both Orientations', builder: (ctx) => const _BothOrientations()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orientation = context.knobs.object.dropdown<DievasDividerOrientation>(
      label: 'Orientation',
      options: DievasDividerOrientation.values,
      labelBuilder: (v) => v.name,
    );

    final indent = context.knobs.double.slider(label: 'Indent', initialValue: 0, min: 0, max: 48);

    final endIndent = context.knobs.double.slider(label: 'End Indent', initialValue: 0, min: 0, max: 48);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.spacing.lg),
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
}

class _BothOrientations extends StatelessWidget {
  const _BothOrientations();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Horizontal',
            style: context.typography.labelXs.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colours.text.textPrimary,
            ),
          ),
          SizedBox(height: context.spacing.sm),
          const ComponentBoundary(child: SizedBox(width: 280, child: DievasDivider())),
          SizedBox(height: context.spacing.lg),
          Text(
            'Horizontal with indent',
            style: context.typography.labelXs.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colours.text.textPrimary,
            ),
          ),
          SizedBox(height: context.spacing.sm),
          const ComponentBoundary(child: SizedBox(width: 280, child: DievasDivider(indent: 16, endIndent: 16))),
          SizedBox(height: context.spacing.lg),
          Text(
            'Vertical',
            style: context.typography.labelXs.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colours.text.textPrimary,
            ),
          ),
          SizedBox(height: context.spacing.sm),
          ComponentBoundary(
            child: SizedBox(
              height: context.spacing.x2l,
              child: const DievasDivider(orientation: DievasDividerOrientation.vertical),
            ),
          ),
        ],
      ),
    ),
  );
}
