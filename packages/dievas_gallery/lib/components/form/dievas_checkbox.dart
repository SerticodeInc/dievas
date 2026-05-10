import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final checkboxComponent = WidgetbookComponent(
  name: 'Checkbox',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: _playground),
    WidgetbookUseCase(name: 'All States', builder: _allStates),
    WidgetbookUseCase(name: 'With Labels', builder: _withLabels),
  ],
);

Widget _playground(BuildContext context) {
  final value = context.knobs.list<DievasCheckboxValue>(
    label: 'Value',
    options: DievasCheckboxValue.values,
    labelBuilder: (v) => v.name,
    initialOption: DievasCheckboxValue.checked,
  );

  final label = context.knobs.string(label: 'Label', initialValue: 'Accept terms and conditions');
  final showLabel = context.knobs.boolean(label: 'Show Label', initialValue: true);
  final disabled = context.knobs.boolean(label: 'Disabled');

  return Center(
    child: StatefulBuilder(
      builder: (context, setState) {
        var current = value;
        return ComponentBoundary(
          child: DievasCheckbox(
            value: current,
            label: showLabel ? (label.isEmpty ? 'Label' : label) : null,
            onChanged: disabled ? null : (v) => setState(() => current = v),
          ),
        );
      },
    ),
  );
}

Widget _allStates(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _stateRow('Unchecked', DievasCheckboxValue.unchecked),
        const SizedBox(height: 16),
        _stateRow('Checked', DievasCheckboxValue.checked),
        const SizedBox(height: 16),
        _stateRow('Indeterminate', DievasCheckboxValue.indeterminate),
        const SizedBox(height: 16),
        _stateRow('Disabled (unchecked)', DievasCheckboxValue.unchecked, disabled: true),
        const SizedBox(height: 16),
        _stateRow('Disabled (checked)', DievasCheckboxValue.checked, disabled: true),
      ],
    ),
  ),
);

Widget _stateRow(String name, DievasCheckboxValue value, {bool disabled = false}) => Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    SizedBox(
      width: 180,
      child: Text(name, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
    ),
    ComponentBoundary(
      child: DievasCheckbox(
        value: value,
        onChanged: disabled ? null : (_) {},
      ),
    ),
  ],
);

Widget _withLabels(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComponentBoundary(
          child: DievasCheckbox(value: DievasCheckboxValue.unchecked, label: 'Unchecked label', onChanged: (_) {}),
        ),
        const SizedBox(height: 16),
        ComponentBoundary(
          child: DievasCheckbox(value: DievasCheckboxValue.checked, label: 'Checked label', onChanged: (_) {}),
        ),
        const SizedBox(height: 16),
        ComponentBoundary(
          child: DievasCheckbox(
            value: DievasCheckboxValue.indeterminate,
            label: 'Indeterminate label',
            onChanged: (_) {},
          ),
        ),
        const SizedBox(height: 16),
        ComponentBoundary(
          child: DievasCheckbox(
            value: DievasCheckboxValue.unchecked,
            label: 'Disabled',
            onChanged: null,
          ),
        ),
      ],
    ),
  ),
);
