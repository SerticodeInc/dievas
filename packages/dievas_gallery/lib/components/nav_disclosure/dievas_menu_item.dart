import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final menuItemComponent = WidgetbookComponent(
  name: 'MenuItem',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => const _Playground()),
    WidgetbookUseCase(name: 'Configurations', builder: (ctx) => const _Configurations()),
  ],
);

class _Playground extends StatelessWidget {
  const _Playground();

  @override
  Widget build(BuildContext context) {
    final label = context.knobs.string(label: 'Label', initialValue: 'Profile');
    final subtitle = context.knobs.string(label: 'Subtitle', initialValue: '');
    final showIcon = context.knobs.boolean(label: 'Leading Icon', initialValue: true);
    final showChevron = context.knobs.boolean(label: 'Trailing Chevron');
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
    final dense = context.knobs.boolean(label: 'Dense');

    return Center(
      child: Column(
        mainAxisSize: .min,
        children: [
          ComponentBoundary(
            child: DievasMenuItem(
              label: label.isEmpty ? 'MenuItem' : label,
              subtitle: subtitle.isEmpty ? null : subtitle,
              leadingIcon: showIcon ? const Icon(Icons.person_outline) : null,
              trailing: showChevron ? const Icon(Icons.chevron_right) : null,
              enabled: enabled,
              dense: dense,
            ),
          ),
        ],
      ),
    );
  }
}

class _Configurations extends StatelessWidget {
  const _Configurations();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: .symmetric(horizontal: context.spacing.md, vertical: context.spacing.lg),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          const _DemoBlock('Default', child: DievasMenuItem(label: 'Profile')),
          SizedBox(height: context.spacing.sm),
          const _DemoBlock(
            'With leading icon',
            child: DievasMenuItem(label: 'Settings', leadingIcon: Icon(Icons.settings)),
          ),
          SizedBox(height: context.spacing.sm),
          const _DemoBlock(
            'With trailing',
            child: DievasMenuItem(label: 'More', trailing: Icon(Icons.chevron_right)),
          ),
          SizedBox(height: context.spacing.sm),
          const _DemoBlock(
            'With subtitle',
            child: DievasMenuItem(label: 'Delete', subtitle: 'This cannot be undone'),
          ),
          SizedBox(height: context.spacing.sm),
          const _DemoBlock('Dense', child: DievasMenuItem(label: 'Dense item', dense: true)),
          SizedBox(height: context.spacing.sm),
          const _DemoBlock('Disabled', child: DievasMenuItem(label: 'Disabled', enabled: false)),
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
      SizedBox(height: context.spacing.xs),
      ComponentBoundary(child: child),
    ],
  );
}
