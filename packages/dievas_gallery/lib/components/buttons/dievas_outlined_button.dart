import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final outlinedButtonComponent = WidgetbookComponent(
  name: 'OutlinedButton',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: _playground),
    WidgetbookUseCase(name: 'All Styles', builder: _allStyles),
    WidgetbookUseCase(name: 'All Sizes', builder: _allSizes),
    WidgetbookUseCase(name: 'All States', builder: _allStates),
  ],
);

Widget _playground(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Cancel');

  final style = context.knobs.object.dropdown<DievasOutlinedButtonStyle>(
    label: 'Style',
    options: DievasOutlinedButtonStyle.values,
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

  final state = context.knobs.object.dropdown<DievasButtonState>(
    label: 'State',
    options: DievasButtonState.values,
    labelBuilder: (v) => v.name,
  );

  final leadingIcon = context.knobs.boolean(label: 'Leading Icon');
  final trailingIcon = context.knobs.boolean(label: 'Trailing Icon');
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

  return Center(
    child: ComponentBoundary(
      child: DievasOutlinedButton(
        label: label.isEmpty ? 'Cancel' : label,
        style: style,
        size: size,
        shape: shape,
        state: state,
        leadingIcon: leadingIcon ? const Icon(Icons.close_rounded) : null,
        trailingIcon: trailingIcon ? const Icon(Icons.arrow_back_rounded) : null,
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
        for (final style in DievasOutlinedButtonStyle.values)
          ComponentBoundary(
            child: DievasOutlinedButton(label: style.name, style: style, onPressed: () {}),
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
            child: DievasOutlinedButton(label: size.name, size: size, onPressed: () {}),
          ),
      ],
    ),
  ),
);

Widget _allStates(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final state in DievasButtonState.values)
          ComponentBoundary(
            child: DievasOutlinedButton(
              label: state.name,
              state: state,
              onPressed: state == DievasButtonState.disabled ? null : () {},
            ),
          ),
      ],
    ),
  ),
);
