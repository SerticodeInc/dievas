import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final searchWithListComponent = WidgetbookComponent(
  name: 'SearchWithList',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => const _Playground()),
    WidgetbookUseCase(name: 'Static Demo', builder: (ctx) => const _StaticDemo()),
  ],
);

class _Playground extends StatelessWidget {
  const _Playground();

  @override
  Widget build(BuildContext context) {
    final hint = context.knobs.string(label: 'Hint', initialValue: 'Search fruits...');
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

    const fruits = [
      'Apple',
      'Apricot',
      'Banana',
      'Blackberry',
      'Blueberry',
      'Cherry',
      'Coconut',
      'Date',
      'Dragonfruit',
    ];

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
        child: ComponentBoundary(
          child: SizedBox(
            width: context.sizing.inputHeightMd * 8,
            child: DievasSearchWithList<String>(
              items: fruits,
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
            'Default',
            child: SizedBox(
              width: 320,
              child: DievasSearchWithList<String>(
                items: const ['Apple', 'Banana', 'Cherry'],
                displayString: (s) => s,
                hint: 'Search...',
                onSelected: (_) {},
              ),
            ),
          ),
          SizedBox(height: context.spacing.md),
          _DemoBlock(
            'With Custom Leading Icon',
            child: SizedBox(
              width: 320,
              child: DievasSearchWithList<String>(
                items: const ['Apple', 'Banana', 'Cherry'],
                displayString: (s) => s,
                hint: 'Find...',
                leadingIcon: const Icon(Icons.filter_list_rounded),
                onSelected: (_) {},
              ),
            ),
          ),
          SizedBox(height: context.spacing.md),
          _DemoBlock(
            'Disabled',
            child: SizedBox(
              width: 320,
              child: DievasSearchWithList<String>(
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
      Text(name, style: context.typography.labelXs.copyWith(color: context.colours.text.textTertiary)),
      SizedBox(height: context.spacing.sm),
      ComponentBoundary(child: child),
    ],
  );
}
