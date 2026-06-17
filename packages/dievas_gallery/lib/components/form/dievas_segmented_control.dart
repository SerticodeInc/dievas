import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final segmentedControlComponent = WidgetbookComponent(
  name: 'SegmentedControl',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => const _Playground()),
    WidgetbookUseCase(name: 'Configurations', builder: (ctx) => const _Configurations()),
  ],
);

class _Playground extends StatelessWidget {
  const _Playground();

  @override
  Widget build(BuildContext context) {
    final options = ['Day', 'Week', 'Month', 'Year'];
    final selected = context.knobs.string(label: 'Selected', initialValue: 'Week');
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

    final clamped = options.contains(selected) ? selected : options.first;

    return Center(
      child: ComponentBoundary(
        child: DievasSegmentedControl<String>(options: options, value: clamped, onChanged: (_) {}, enabled: enabled),
      ),
    );
  }
}

class _Configurations extends StatelessWidget {
  const _Configurations();

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _DemoBlock(
          '2 segments',
          child: DievasSegmentedControl(options: ['On', 'Off'], value: 'On', onChanged: null),
        ),
        SizedBox(height: context.spacing.lg),
        const _DemoBlock(
          '3 segments',
          child: DievasSegmentedControl(options: ['Day', 'Week', 'Month'], value: 'Week', onChanged: null),
        ),
        SizedBox(height: context.spacing.lg),
        const _DemoBlock(
          '4 segments',
          child: DievasSegmentedControl(options: ['Day', 'Week', 'Month', 'Year'], value: 'Month', onChanged: null),
        ),
        SizedBox(height: context.spacing.lg),
        const _DemoBlock(
          'Disabled',
          child: DievasSegmentedControl(
            options: ['Day', 'Week', 'Month'],
            value: 'Week',
            onChanged: null,
            enabled: false,
          ),
        ),
      ],
    ),
  );
}

class _DemoBlock extends StatelessWidget {
  const _DemoBlock(this.name, {required this.child});
  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(name, style: context.typography.labelXs.copyWith(color: context.colors.text.textTertiary)),
      SizedBox(height: context.spacing.xs),
      ComponentBoundary(child: child),
    ],
  );
}
