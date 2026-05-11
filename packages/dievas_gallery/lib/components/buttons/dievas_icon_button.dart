import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final iconButtonComponent = WidgetbookComponent(
  name: 'IconButton',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: _playground),
    WidgetbookUseCase(name: 'All Styles', builder: _allStyles),
    WidgetbookUseCase(name: 'All Sizes', builder: _allSizes),
  ],
);

Widget _playground(BuildContext context) {
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

Widget _allStyles(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      spacing: 12,
      runSpacing: 12,
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

Widget _allSizes(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      spacing: 12,
      runSpacing: 12,
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
