import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final badgeComponent = WidgetbookComponent(
  name: 'Badge',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Styles', builder: (ctx) => const _AllStyles()),
    WidgetbookUseCase(name: 'All Tones', builder: (ctx) => const _AllTones()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final label = context.knobs.string(label: 'Label', initialValue: 'New');

    final style = context.knobs.object.dropdown<DievasBadgeStyle>(
      label: 'Style',
      options: DievasBadgeStyle.values,
      labelBuilder: (v) => v.name,
      initialOption: .tinted,
    );

    final tone = context.knobs.object.dropdown<DievasBadgeTone>(
      label: 'Tone',
      options: DievasBadgeTone.values,
      labelBuilder: (v) => v.name,
    );

    final showIcon = context.knobs.boolean(label: 'Leading Icon');

    return Center(
      child: ComponentBoundary(
        child: DievasBadge(
          label: label.isEmpty ? 'Badge' : label,
          style: style,
          tone: tone,
          leadingIcon: showIcon ? const Icon(Icons.circle, size: 8) : null,
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
      padding: EdgeInsets.all(context.spacing.lg),
      child: Wrap(
        spacing: context.spacing.sm,
        runSpacing: context.spacing.smPlus,
        alignment: WrapAlignment.center,
        children: [
          for (final style in DievasBadgeStyle.values)
            ComponentBoundary(
              child: DievasBadge(label: style.name, style: style),
            ),
        ],
      ),
    ),
  );
}

class _AllTones extends StatelessWidget {
  const _AllTones();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final style in DievasBadgeStyle.values) ...[
            Text(
              style.name,
              style: context.typography.labelXs.copyWith(
                fontWeight: FontWeight.w600,
                color: context.colors.text.textPrimary,
              ),
            ),
            SizedBox(height: context.spacing.sm),
            Wrap(
              spacing: context.spacing.sm,
              runSpacing: context.spacing.sm,
              children: [
                for (final tone in DievasBadgeTone.values)
                  ComponentBoundary(
                    child: DievasBadge(label: tone.name, style: style, tone: tone),
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
