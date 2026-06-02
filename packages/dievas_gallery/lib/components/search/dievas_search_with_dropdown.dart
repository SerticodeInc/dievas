import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final searchWithDropdownComponent = WidgetbookComponent(
  name: 'SearchWithDropdown',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => const _Playground()),
    WidgetbookUseCase(name: 'Static Demo', builder: (ctx) => const _StaticDemo()),
  ],
);

class _Playground extends StatelessWidget {
  const _Playground();

  @override
  Widget build(BuildContext context) {
    final hint = context.knobs.string(label: 'Hint', initialValue: 'Search countries...');
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

    const countries = [
      'Afghanistan',
      'Albania',
      'Algeria',
      'Argentina',
      'Australia',
      'Austria',
      'Bangladesh',
      'Belgium',
      'Brazil',
      'Canada',
      'China',
      'Denmark',
      'Egypt',
      'Finland',
      'France',
      'Germany',
      'India',
      'Indonesia',
      'Italy',
      'Japan',
    ];

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
        child: ComponentBoundary(
          child: SizedBox(
            width: context.sizing.inputHeightMd * 8,
            child: DievasSearchWithDropdown<String>(
              items: countries,
              displayString: (s) => s,
              hint: hint,
              enabled: enabled,
              onSelected: (_) {},
            ),
          ),
        ),
      ),
    );
  }
}

class _StaticDemo extends StatelessWidget {
  const _StaticDemo();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
      child: Column(
        mainAxisSize: .min,
        children: [
          _DemoBlock(
            'Default — tight layout (clipped)',
            child: SizedBox(
              width: 280,
              height: 280,
              child: DievasSearchWithDropdown<String>(
                items: const ['Apple', 'Apricot', 'Banana', 'Blueberry', 'Cherry'],
                displayString: (s) => s,
                hint: 'Search...',
                onSelected: (_) {},
              ),
            ),
          ),
          SizedBox(height: context.spacing.lg),
          _DemoBlock(
            'Disabled',
            child: SizedBox(
              width: 320,
              child: DievasSearchWithDropdown<String>(
                items: ['Apple', 'Banana', 'Cherry'],
                displayString: (s) => s,
                hint: 'Search...',
                enabled: false,
                onSelected: (_) {},
              ),
            ),
          ),
        ],
      ),
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
