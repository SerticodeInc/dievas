import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final dotIndicatorComponent = WidgetbookComponent(
  name: 'DotIndicator',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => const _Playground()),
    WidgetbookUseCase(name: 'Configurations', builder: (ctx) => const _Configurations()),
  ],
);

class _Playground extends StatelessWidget {
  const _Playground();

  @override
  Widget build(BuildContext context) {
    final count = context.knobs.double.slider(label: 'Count', initialValue: 4, min: 1, max: 8).round();
    final activeIndex = context.knobs.double.slider(label: 'Active index', initialValue: 1, min: 0, max: 7).round();
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

    final clampedActive = activeIndex.clamp(0, count - 1);

    return Center(
      child: ComponentBoundary(
        child: DievasDotIndicator(count: count, activeIndex: clampedActive, enabled: enabled),
      ),
    );
  }
}

class _Configurations extends StatelessWidget {
  const _Configurations();

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: .min,
      children: [
        const _DemoBlock('3 dots — first active', child: DievasDotIndicator(count: 3, activeIndex: 0)),
        SizedBox(height: context.spacing.md),
        const _DemoBlock('4 dots — middle active', child: DievasDotIndicator(count: 4, activeIndex: 1)),
        SizedBox(height: context.spacing.md),
        const _DemoBlock('5 dots — last active', child: DievasDotIndicator(count: 5, activeIndex: 4)),
        SizedBox(height: context.spacing.md),
        _DemoBlock('Disabled', child: DievasDotIndicator(count: 4, activeIndex: 1, enabled: false)),
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
    crossAxisAlignment: .start,
    mainAxisSize: .min,
    children: [
      Text(name, style: context.typography.labelXs.copyWith(color: context.colors.text.textTertiary)),
      SizedBox(height: context.spacing.sm),
      ComponentBoundary(child: child),
    ],
  );
}
