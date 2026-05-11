import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final textButtonComponent = WidgetbookComponent(
  name: 'TextButton',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: _playground),
    WidgetbookUseCase(name: 'All Styles', builder: _allStyles),
    WidgetbookUseCase(name: 'All Sizes', builder: _allSizes),
    WidgetbookUseCase(name: 'All States', builder: _allStates),
  ],
);

Widget _playground(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'View details');

  final style = context.knobs.object.dropdown<DievasTextButtonStyle>(
    label: 'Style',
    options: DievasTextButtonStyle.values,
    labelBuilder: (v) => v.name,
  );

  final size = context.knobs.object.dropdown<DievasButtonSize>(
    label: 'Size',
    options: DievasButtonSize.values,
    labelBuilder: (v) => v.name,
    initialOption: DievasButtonSize.md,
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
      child: DievasTextButton(
        label: label.isEmpty ? 'View details' : label,
        style: style,
        size: size,
        state: state,
        leadingIcon: leadingIcon ? const Icon(Icons.info_outline_rounded) : null,
        trailingIcon: trailingIcon ? const Icon(Icons.chevron_right_rounded) : null,
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
        for (final style in DievasTextButtonStyle.values)
          ComponentBoundary(
            child: DievasTextButton(label: style.name, style: style, onPressed: () {}),
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
            child: DievasTextButton(label: size.name, size: size, onPressed: () {}),
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
            child: DievasTextButton(
              label: state.name,
              state: state,
              onPressed: state == DievasButtonState.disabled ? null : () {},
            ),
          ),
      ],
    ),
  ),
);
