import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final radioComponent = WidgetbookComponent(
  name: 'Radio',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: _playground),
    WidgetbookUseCase(name: 'Group', builder: _group),
    WidgetbookUseCase(name: 'All States', builder: _allStates),
  ],
);

// Playground simulates a 3-option group — the knob sets which one is pre-selected.
Widget _playground(BuildContext context) {
  final options = ['Option A', 'Option B', 'Option C'];

  final initialSelection = context.knobs.object.dropdown<String>(
    label: 'Selected',
    options: options,
    labelBuilder: (v) => v,
    initialOption: 'Option A',
  );

  final showLabels = context.knobs.boolean(label: 'Show Labels', initialValue: true);
  final disabled = context.knobs.boolean(label: 'Disabled');

  return Center(
    child: StatefulBuilder(
      builder: (context, setState) {
        var selected = initialSelection;
        return ComponentBoundary(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final option in options) ...[
                DievasRadio<String>(
                  value: option,
                  groupValue: selected,
                  label: showLabels ? option : null,
                  onChanged: disabled ? null : (v) => setState(() => selected = v),
                ),
                if (option != options.last) const SizedBox(height: 12),
              ],
            ],
          ),
        );
      },
    ),
  );
}

Widget _group(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: StatefulBuilder(
      builder: (context, setState) {
        var selected = 'Standard';
        final options = ['Standard', 'Express', 'Overnight'];

        return ComponentBoundary(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Shipping method', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              for (final option in options) ...[
                DievasRadio<String>(
                  value: option,
                  groupValue: selected,
                  label: option,
                  onChanged: (v) => setState(() => selected = v),
                ),
                if (option != options.last) const SizedBox(height: 12),
              ],
            ],
          ),
        );
      },
    ),
  ),
);

Widget _allStates(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _stateRow('Unselected', isSelected: false),
        const SizedBox(height: 16),
        _stateRow('Selected', isSelected: true),
        const SizedBox(height: 16),
        _stateRow('Disabled (unselected)', isSelected: false, disabled: true),
        const SizedBox(height: 16),
        _stateRow('Disabled (selected)', isSelected: true, disabled: true),
      ],
    ),
  ),
);

Widget _stateRow(String name, {required bool isSelected, bool disabled = false}) => Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    SizedBox(
      width: 180,
      child: Text(name, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
    ),
    ComponentBoundary(
      child: DievasRadio<bool>(value: true, groupValue: isSelected ? true : false, onChanged: disabled ? null : (_) {}),
    ),
  ],
);
