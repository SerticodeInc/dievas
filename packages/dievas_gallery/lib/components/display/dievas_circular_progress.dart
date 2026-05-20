import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final circularProgressComponent = WidgetbookComponent(
  name: 'CircularProgress',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Sizes', builder: (ctx) => const _AllSizes()),
    WidgetbookUseCase(name: 'All Styles', builder: (ctx) => const _AllStyles()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value = context.knobs.double.slider(label: 'Value (0 = indeterminate)', initialValue: 0.6, min: 0, max: 1);

    final size = context.knobs.object.dropdown<DievasCircularProgressSize>(
      label: 'Size',
      options: DievasCircularProgressSize.values,
      labelBuilder: (v) => v.name,
      initialOption: DievasCircularProgressSize.md,
    );

    final style = context.knobs.object.dropdown<DievasCircularProgressStyle>(
      label: 'Style',
      options: DievasCircularProgressStyle.values,
      labelBuilder: (v) => v.name,
    );

    final isIndeterminate = context.knobs.boolean(label: 'Indeterminate');

    return Center(
      child: ComponentBoundary(
        child: DievasCircularProgress(value: isIndeterminate ? null : value, size: size, style: style),
      ),
    );
  }
}

class _AllSizes extends StatelessWidget {
  const _AllSizes();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Wrap(
        spacing: context.spacing.lg,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final size in DievasCircularProgressSize.values)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ComponentBoundary(child: DievasCircularProgress(value: 0.65, size: size)),
                SizedBox(height: context.spacing.sm),
                Text(size.name, style: context.typography.labelXs),
              ],
            ),
        ],
      ),
    ),
  );
}

class _AllStyles extends StatelessWidget {
  const _AllStyles();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Wrap(
        spacing: context.spacing.lg,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final style in DievasCircularProgressStyle.values)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ComponentBoundary(child: DievasCircularProgress(value: 0.65, style: style)),
                SizedBox(height: context.spacing.sm),
                Text(style.name, style: context.typography.labelXs),
              ],
            ),
        ],
      ),
    ),
  );
}
