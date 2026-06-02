import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final breadcrumbComponent = WidgetbookComponent(
  name: 'BreadCrumb',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => const _Playground()),
    WidgetbookUseCase(name: 'Configurations', builder: (ctx) => const _Configurations()),
  ],
);

class _Playground extends StatelessWidget {
  const _Playground();

  @override
  Widget build(BuildContext context) {
    final showHome = context.knobs.boolean(label: 'Home Icon', initialValue: true);
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
    final depth = context.knobs.double.slider(label: 'Depth', initialValue: 2, min: 1, max: 4).round();

    const items = ['Home', 'Products', 'Footwear', 'Shoes'];

    return Center(
      child: ComponentBoundary(
        child: DievasBreadcrumb<String>(
          items: items.sublist(0, depth + 1),
          displayString: (s) => s,
          selectedItem: items[depth],
          enabled: enabled,
          homeIcon: showHome ? const Icon(Icons.home_outlined) : null,
          onItemTap: (_) {},
        ),
      ),
    );
  }
}

class _Configurations extends StatelessWidget {
  const _Configurations();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xl, vertical: context.spacing.lg),
      child: Column(
        mainAxisSize: .min,
        children: [
          _DemoBlock(
            'Default — mid trail',
            child: DievasBreadcrumb<String>(
              items: const ['Home', 'Products', 'Shoes'],
              displayString: (s) => s,
              selectedItem: 'Products',
              onItemTap: (_) {},
            ),
          ),
          SizedBox(height: context.spacing.lg),
          _DemoBlock(
            'With Home Icon',
            child: DievasBreadcrumb<String>(
              items: const ['Products', 'Clothing', 'Shirts'],
              displayString: (s) => s,
              selectedItem: 'Shirts',
              homeIcon: const Icon(Icons.home_outlined),
              onItemTap: (_) {},
            ),
          ),
          SizedBox(height: context.spacing.lg),
          _DemoBlock(
            'Last crumb selected',
            child: DievasBreadcrumb<String>(
              items: const ['Docs', 'API', 'Widgets', 'Button'],
              displayString: (s) => s,
              selectedItem: 'Button',
              onItemTap: (_) {},
            ),
          ),
          SizedBox(height: context.spacing.lg),
          _DemoBlock(
            'Disabled',
            child: DievasBreadcrumb<String>(
              items: ['Home', 'Settings', 'Profile'],
              displayString: (s) => s,
              selectedItem: 'Profile',
              enabled: false,
              onItemTap: (_) {},
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
