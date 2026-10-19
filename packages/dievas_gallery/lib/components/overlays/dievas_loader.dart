import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/token_colour_knob.dart';
import '../../widgets/component_boundary.dart';

final loaderComponent = WidgetbookComponent(
  name: 'Loader',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Sizes', builder: (ctx) => const _AllSizes()),
    WidgetbookUseCase(name: 'With Label', builder: (ctx) => const _WithLabel()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = context.knobs.object.dropdown<DievasLoaderSize>(
      label: 'Size',
      options: DievasLoaderSize.values,
      labelBuilder: (v) => v.name,
      initialOption: .MD,
    );
    final label = context.knobs.string(label: 'Label', initialValue: '');
    final useCustomColours = context.knobs.boolean(label: 'Override token colours');
    final colour = useCustomColours ? context.tokenColourKnob(label: 'Colour', role: .icon) : null;
    final trackColour = useCustomColours ? context.tokenColourKnob(label: 'Track colour', role: .background) : null;

    return Center(
      child: ComponentBoundary(
        child: DievasLoader(size: size, label: label.isEmpty ? null : label, colour: colour, trackColour: trackColour),
      ),
    );
  }
}

class _AllSizes extends StatelessWidget {
  const _AllSizes();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [for (final size in DievasLoaderSize.values) ComponentBoundary(child: DievasLoader(size: size))],
      ),
    ),
  );
}

class _WithLabel extends StatelessWidget {
  const _WithLabel();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final size in DievasLoaderSize.values) ...[
            ComponentBoundary(
              child: DievasLoader(size: size, label: 'Loading ${size.name}…'),
            ),
            SizedBox(height: context.spacing.xl),
          ],
        ],
      ),
    ),
  );
}
