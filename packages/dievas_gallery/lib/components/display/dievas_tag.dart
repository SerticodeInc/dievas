import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final tagComponent = WidgetbookComponent(
  name: 'Tag',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Styles', builder: (ctx) => const _AllStyles()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final label = context.knobs.string(label: 'Label', initialValue: 'Flutter');

    final style = context.knobs.object.dropdown<DievasTagStyle>(
      label: 'Style',
      options: DievasTagStyle.values,
      labelBuilder: (v) => v.name,
      initialOption: DievasTagStyle.tinted,
    );

    final showLeadingIcon = context.knobs.boolean(label: 'Leading Icon');
    final showRemove = context.knobs.boolean(label: 'Dismiss Button');
    final tappable = context.knobs.boolean(label: 'Tappable');

    return Center(
      child: ComponentBoundary(
        child: DievasTag(
          label: label.isEmpty ? 'Tag' : label,
          style: style,
          leadingIcon: showLeadingIcon ? const Icon(Icons.label_outline_rounded, size: 14) : null,
          onRemove: showRemove ? () {} : null,
          onPressed: tappable ? () {} : null,
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
          for (final style in DievasTagStyle.values) ...[
            ComponentBoundary(
              child: DievasTag(label: style.name, style: style),
            ),
            ComponentBoundary(
              child: DievasTag(
                label: style.name,
                style: style,
                leadingIcon: const Icon(Icons.label_outline_rounded, size: 14),
                onRemove: () {},
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
