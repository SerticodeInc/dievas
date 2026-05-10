import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final switchComponent = WidgetbookComponent(
  name: 'Switch',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: _playground),
    WidgetbookUseCase(name: 'All States', builder: _allStates),
    WidgetbookUseCase(name: 'With Labels', builder: _withLabels),
  ],
);

Widget _playground(BuildContext context) {
  final initialValue = context.knobs.boolean(label: 'Initial Value', initialValue: true);
  final label = context.knobs.string(label: 'Label', initialValue: 'Dark mode');
  final showLabel = context.knobs.boolean(label: 'Show Label', initialValue: true);
  final disabled = context.knobs.boolean(label: 'Disabled');

  return Center(
    child: StatefulBuilder(
      builder: (context, setState) {
        var current = initialValue;
        return ComponentBoundary(
          child: DievasSwitch(
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
        _stateRow('Off', value: false),
        const SizedBox(height: 16),
        _stateRow('On', value: true),
        const SizedBox(height: 16),
        _stateRow('Disabled (off)', value: false, disabled: true),
        const SizedBox(height: 16),
        _stateRow('Disabled (on)', value: true, disabled: true),
      ],
    ),
  ),
);

Widget _stateRow(String name, {required bool value, bool disabled = false}) => Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    SizedBox(
      width: 140,
      child: Text(name, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
    ),
    ComponentBoundary(
      child: DievasSwitch(
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
          child: DievasSwitch(value: false, label: 'Notifications', onChanged: (_) {}),
        ),
        const SizedBox(height: 16),
        ComponentBoundary(
          child: DievasSwitch(value: true, label: 'Dark mode', onChanged: (_) {}),
        ),
        const SizedBox(height: 16),
        ComponentBoundary(
          child: DievasSwitch(value: false, label: 'Disabled setting', onChanged: null),
        ),
      ],
    ),
  ),
);
