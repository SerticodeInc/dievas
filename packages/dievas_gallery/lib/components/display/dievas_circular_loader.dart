import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final circularLoaderComponent = WidgetbookComponent(
  name: 'CircularLoader',
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
      initialOption: .md,
    );
    final label = context.knobs.string(label: 'Label', initialValue: '');

    return Center(
      child: ComponentBoundary(
        child: DievasLoader(size: size, label: label.isEmpty ? null : label),
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
