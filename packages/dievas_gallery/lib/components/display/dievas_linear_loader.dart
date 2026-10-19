import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final linearLoaderComponent = WidgetbookComponent(
  name: 'LinearLoader',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Sizes', builder: (ctx) => const _AllSizes()),
    WidgetbookUseCase(name: 'With Label', builder: (ctx) => const _WithLabel()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final defaultWidthValue = 200.0;
    final useCustomWidth = context.knobs.boolean(label: 'Custom Width', initialValue: false);
    final width = useCustomWidth ? context.knobs.double.input(label: 'Width', initialValue: 200.0) : defaultWidthValue;

    return Center(
      child: ComponentBoundary(
        child: SizedBox(width: width, child: const DievasLinearProgress()),
      ),
    );
  }
}

class _AllSizes extends StatelessWidget {
  const _AllSizes();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: .all(context.spacing.xl),
      child: Column(
        mainAxisSize: .min,
        children: [
          ComponentBoundary(child: SizedBox(width: 200, child: const DievasLinearProgress())),
          SizedBox(height: context.spacing.lg),
          ComponentBoundary(child: SizedBox(width: 320, child: const DievasLinearProgress())),
        ],
      ),
    ),
  );
}

class _WithLabel extends StatelessWidget {
  const _WithLabel();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: .all(context.spacing.xl),
      child: Column(
        mainAxisSize: .min,
        children: [ComponentBoundary(child: SizedBox(width: 240, child: const DievasLinearProgress()))],
      ),
    ),
  );
}
