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

    final indent = context.knobs.object.dropdown<DievasDividerIndent>(
      label: 'Indent',
      options: DievasDividerIndent.values,
      labelBuilder: (v) => '${v.resolve().toInt()}dp',
    );

    final endIndent = context.knobs.object.dropdown<DievasDividerIndent>(
      label: 'End Indent',
      options: DievasDividerIndent.values,
      labelBuilder: (v) => '${v.resolve().toInt()}dp',
    );

    final useCustomColour = context.knobs.boolean(label: 'Custom colour', initialValue: false);

    final colour = useCustomColour ? context.knobs.color(label: 'Colour', initialValue: const Color(0xFFE3F2FD)) : null;

    final thickness = context.knobs.double.slider(label: 'Thickness', initialValue: 2, min: 0.5, max: 3);

    return Center(
      child: Padding(
        padding: .all(context.spacing.lg),
        child: ComponentBoundary(
          child: SizedBox(
            width: orientation == .horizontal ? 280 : 3,
            height: orientation == .vertical ? 80 : 3,
            child: DievasDivider(
              orientation: orientation,
              indent: indent,
              endIndent: endIndent,
              colour: colour,
              thickness: thickness,
            ),
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
      padding: .all(context.spacing.lg),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Text(
            'Horizontal',
            style: context.typography.labelXs.copyWith(fontWeight: .w600, color: context.colours.text.textPrimary),
          ),
          SizedBox(height: context.spacing.sm),
          const ComponentBoundary(child: SizedBox(width: 280, child: DievasDivider())),
          SizedBox(height: context.spacing.lg),
          Text(
            'Horizontal with indent',
            style: context.typography.labelXs.copyWith(fontWeight: .w600, color: context.colours.text.textPrimary),
          ),
          SizedBox(height: context.spacing.sm),
          const ComponentBoundary(
            child: SizedBox(
              width: 280,
              child: DievasDivider(indent: DievasDividerIndent.md, endIndent: DievasDividerIndent.md),
            ),
          ),
          SizedBox(height: context.spacing.lg),
          Text(
            'Vertical',
            style: context.typography.labelXs.copyWith(fontWeight: .w600, color: context.colours.text.textPrimary),
          ),
          SizedBox(height: context.spacing.sm),
          ComponentBoundary(
            child: SizedBox(
              height: context.spacing.x2l,
              child: const DievasDivider(orientation: .vertical),
            ),
          ),
        ],
      ),
    ),
  );
}
