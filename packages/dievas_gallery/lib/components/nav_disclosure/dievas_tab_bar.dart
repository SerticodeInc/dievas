import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final tabBarComponent = WidgetbookComponent(
  name: 'TabBar',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => const _Playground()),
    WidgetbookUseCase(name: 'Configurations', builder: (ctx) => const _Configurations()),
  ],
);

class _Playground extends StatelessWidget {
  const _Playground();

  @override
  Widget build(BuildContext context) {
    final tabs = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];
    final selected = context.knobs.object.dropdown<int>(
      label: 'Selected index',
      options: const [0, 1, 2, 3],
      initialOption: 0,
    );
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

    return Center(
      child: ComponentBoundary(
        child: DievasTabBar(tabs: tabs, selectedIndex: selected, onChanged: (_) {}, enabled: enabled),
      ),
    );
  }
}

class _Configurations extends StatelessWidget {
  const _Configurations();

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    children: [
      const _DemoBlock('2 tabs', child: DievasTabBar(tabs: ['On', 'Off'], selectedIndex: 0, onChanged: null)),
      SizedBox(height: context.spacing.lg),
      const _DemoBlock(
        '3 tabs',
        child: DievasTabBar(tabs: ['Details', 'Activity', 'Settings'], selectedIndex: 1, onChanged: null),
      ),
      SizedBox(height: context.spacing.lg),
      const _DemoBlock(
        '4 tabs',
        child: DievasTabBar(tabs: ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'], selectedIndex: 2, onChanged: null),
      ),
      SizedBox(height: context.spacing.lg),
      const _DemoBlock(
        'Disabled',
        child: DievasTabBar(tabs: ['One', 'Two', 'Three'], selectedIndex: 1, onChanged: null, enabled: false),
      ),
    ],
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
      Padding(
        padding: .symmetric(horizontal: context.spacing.md),
        child: Text(name, style: context.typography.labelXs.copyWith(color: context.colors.text.textTertiary)),
      ),
      SizedBox(height: context.spacing.xs),
      ComponentBoundary(child: child),
    ],
  );
}
