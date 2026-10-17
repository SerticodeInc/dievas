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

    final thickness = context.knobs.double.slider(label: 'Thickness', initialValue: 2, min: 0.5, max: 3);

    return Center(
      child: Padding(
        padding: .all(context.spacing.LG),
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
      padding: .all(context.spacing.LG),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Text(
            'Horizontal',
            style: context.typography.labelXS.copyWith(fontWeight: .w600, color: context.colours.text.textPrimary),
          ),
          SizedBox(height: context.spacing.SM),
          const ComponentBoundary(child: SizedBox(width: 280, child: DievasDivider())),
          SizedBox(height: context.spacing.LG),
          Text(
            'Horizontal with indent',
            style: context.typography.labelXS.copyWith(fontWeight: .w600, color: context.colours.text.textPrimary),
          ),
          SizedBox(height: context.spacing.SM),
          const ComponentBoundary(
            child: SizedBox(
              width: 280,
              child: DievasDivider(indent: DievasDividerIndent.MD, endIndent: DievasDividerIndent.MD),
            ),
          ),
          SizedBox(height: context.spacing.LG),
          Text(
            'Vertical',
            style: context.typography.labelXS.copyWith(fontWeight: .w600, color: context.colours.text.textPrimary),
          ),
          SizedBox(height: context.spacing.SM),
          ComponentBoundary(
            child: SizedBox(
              height: context.spacing.XL2,
              child: const DievasDivider(orientation: .vertical),
            ),
          ),
        ],
      ),
    ),
  );
}
