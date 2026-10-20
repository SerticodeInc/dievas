import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/token_colour_knob.dart';
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

    final useCustomColour = context.knobs.boolean(label: 'Override token colour', initialValue: false);

    final colour = useCustomColour ? context.tokenColourKnob(label: 'Colour', role: .border) : null;

    final overrideThickness = context.knobs.boolean(label: 'Override thickness');
    final thickness = context.knobs.double.slider(label: 'Thickness', initialValue: 1.5, min: 0.5, max: 3);
    final showLabel = context.knobs.boolean(label: 'Show label');
    final label = context.knobs.string(label: 'Label', initialValue: 'Divider');

    return Center(
      child: ComponentBoundary(
        child: SizedBox(
          width: orientation == .horizontal ? 280 : 120,
          height: orientation == .vertical ? 180 : null,
          child: DievasDivider(
            orientation: orientation,
            indent: indent,
            endIndent: endIndent,
            colour: colour,
            thickness: overrideThickness ? thickness : null,
            label: showLabel ? label : null,
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
            height: context.spacing.xl2,
            child: const DievasDivider(orientation: .vertical),
          ),
        ),
      ],
    ),
  );
}
