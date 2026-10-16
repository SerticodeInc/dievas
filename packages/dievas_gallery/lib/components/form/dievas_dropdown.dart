import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final dropdownComponent = WidgetbookComponent(
  name: 'Dropdown',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => const _Playground()),
    WidgetbookUseCase(name: 'Configurations', builder: (ctx) => const _Configurations()),
  ],
);

class _Playground extends StatefulWidget {
  const _Playground();

  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  String? _value;
  String? _knobValue;

  @override
  Widget build(BuildContext context) {
    final options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
    final knobSelected = context.knobs.string(label: 'Selected', initialValue: '');
    final hint = context.knobs.stringOrNull(label: 'Hint', initialValue: 'Select an option');
    final label = context.knobs.stringOrNull(label: 'Label', initialValue: 'Choose');
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

    // Adopt the knob when it changes, but let taps drive the selection afterwards.
    if (knobSelected != _knobValue) {
      _knobValue = knobSelected;
      _value = knobSelected.isNotEmpty && options.contains(knobSelected) ? knobSelected : null;
    }

    return Center(
      child: ComponentBoundary(
        child: SizedBox(
          width: 240,
          child: DievasDropdown<String>(
            options: options,
            value: _value,
            onChanged: (value) => setState(() => _value = value),
            hint: hint,
            label: label,
            enabled: enabled,
          ),
        ),
      ),
    );
  }
}

class _Configurations extends StatelessWidget {
  const _Configurations();

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _DemoBlock(
          'Without label',
          child: SizedBox(
            width: 240,
            child: DievasDropdown<String>(
              options: ['Option 1', 'Option 2', 'Option 3'],
              onChanged: null,
              hint: 'Select an option',
            ),
          ),
        ),
        SizedBox(height: context.spacing.LG),
        const _DemoBlock(
          'With label',
          child: SizedBox(
            width: 240,
            child: DievasDropdown<String>(
              options: ['Option 1', 'Option 2', 'Option 3'],
              value: 'Option 2',
              onChanged: null,
              label: 'Choose option',
            ),
          ),
        ),
        SizedBox(height: context.spacing.LG),
        const _DemoBlock(
          'Disabled',
          child: SizedBox(
            width: 240,
            child: DievasDropdown<String>(
              options: ['Option 1', 'Option 2', 'Option 3'],
              onChanged: null,
              hint: 'Select an option',
              enabled: false,
            ),
          ),
        ),
      ],
    ),
  );
}

class _DemoBlock extends StatelessWidget {
  const _DemoBlock(this.name, {required this.child});
  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(name, style: context.typography.labelXS.copyWith(color: context.colours.text.textTertiary)),
      SizedBox(height: context.spacing.XS),
      ComponentBoundary(child: child),
    ],
  );
}
