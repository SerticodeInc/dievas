import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final iconButtonComponent = WidgetbookComponent(
  name: 'IconButton',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Styles', builder: (ctx) => const _AllStyles()),
    WidgetbookUseCase(name: 'All Sizes', builder: (ctx) => const _AllSizes()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = context.knobs.object.dropdown<DievasIconButtonStyle>(
      label: 'Style',
      options: DievasIconButtonStyle.values,
      labelBuilder: (v) => v.name,
    );

    final size = context.knobs.object.dropdown<DievasButtonSize>(
      label: 'Size',
      options: DievasButtonSize.values,
      labelBuilder: (v) => v.name,
      initialOption: DievasButtonSize.md,
    );

    final shape = context.knobs.object.dropdown<DievasButtonShape>(
      label: 'Shape',
      options: DievasButtonShape.values,
      labelBuilder: (v) => v.name,
    );

    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

    return Center(
      child: ComponentBoundary(
        child: DievasIconButton(
          icon: const Icon(Icons.add_rounded),
          style: style,
          size: size,
          shape: shape,
          onPressed: enabled ? () {} : null,
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
        spacing: context.spacing.smPlus,
        runSpacing: context.spacing.smPlus,
        alignment: WrapAlignment.center,
        children: [
          for (final style in DievasIconButtonStyle.values)
            ComponentBoundary(
              child: DievasIconButton(icon: const Icon(Icons.star_rounded), style: style, onPressed: () {}),
            ),
        ],
      ),
    ),
  );
}

class _AllSizes extends StatelessWidget {
  const _AllSizes();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Wrap(
        spacing: context.spacing.smPlus,
        runSpacing: context.spacing.smPlus,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final size in DievasButtonSize.values)
            ComponentBoundary(
              child: DievasIconButton(icon: const Icon(Icons.star_rounded), size: size, onPressed: () {}),
            ),
        ],
      ),
    ),
  );
}
