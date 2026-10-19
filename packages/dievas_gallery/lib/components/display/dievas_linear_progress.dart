import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final linearProgressComponent = WidgetbookComponent(
  name: 'LinearProgress',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Styles', builder: (ctx) => const _AllStyles()),
    WidgetbookUseCase(name: 'Indeterminate', builder: (ctx) => const _Indeterminate()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value = context.knobs.double.slider(label: 'Value (0 = indeterminate)', initialValue: 0.6, min: 0, max: 1);

    final style = context.knobs.object.dropdown<DievasLinearProgressStyle>(
      label: 'Style',
      options: DievasLinearProgressStyle.values,
      labelBuilder: (v) => v.name,
    );

    final isIndeterminate = context.knobs.boolean(label: 'Indeterminate');

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
        child: ComponentBoundary(
          child: DievasLinearProgress(value: isIndeterminate ? null : value, style: style),
        ),
      ),
    );
  }
}

class _AllStyles extends StatelessWidget {
  const _AllStyles();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final style in DievasLinearProgressStyle.values) ...[
            Row(
              children: [
                SizedBox(width: 64, child: Text(style.name, style: context.typography.labelXs)),
                Expanded(
                  child: ComponentBoundary(child: DievasLinearProgress(value: 0.65, style: style)),
                ),
              ],
            ),
            SizedBox(height: context.spacing.md),
          ],
        ],
      ),
    ),
  );
}

class _Indeterminate extends StatelessWidget {
  const _Indeterminate();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
      child: const ComponentBoundary(child: DievasLinearProgress()),
    ),
  );
}
