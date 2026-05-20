import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final checkboxComponent = WidgetbookComponent(
  name: 'Checkbox',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All States', builder: (ctx) => _AllStates()),
    WidgetbookUseCase(name: 'With Labels', builder: (ctx) => _WithLabels()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value = context.knobs.object.dropdown<DievasCheckboxValue>(
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
}

class _AllStates extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StateRow('Unchecked', DievasCheckboxValue.unchecked),
          SizedBox(height: context.spacing.md),
          _StateRow('Checked', DievasCheckboxValue.checked),
          SizedBox(height: context.spacing.md),
          _StateRow('Indeterminate', DievasCheckboxValue.indeterminate),
          SizedBox(height: context.spacing.md),
          _StateRow('Disabled (unchecked)', DievasCheckboxValue.unchecked, disabled: true),
          SizedBox(height: context.spacing.md),
          _StateRow('Disabled (checked)', DievasCheckboxValue.checked, disabled: true),
        ],
      ),
    ),
  );
}

class _StateRow extends StatelessWidget {
  const _StateRow(this.name, this.value, {this.disabled = false});
  final String name;
  final DievasCheckboxValue value;
  final bool disabled;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: 180,
        child: Text(name, style: context.typography.labelXs.copyWith(color: context.colors.text.textTertiary)),
      ),
      ComponentBoundary(
        child: DievasCheckbox(value: value, onChanged: disabled ? null : (_) {}),
      ),
    ],
  );
}

class _WithLabels extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ComponentBoundary(
            child: DievasCheckbox(value: DievasCheckboxValue.unchecked, label: 'Unchecked label', onChanged: (_) {}),
          ),
          SizedBox(height: context.spacing.md),
          ComponentBoundary(
            child: DievasCheckbox(value: DievasCheckboxValue.checked, label: 'Checked label', onChanged: (_) {}),
          ),
          SizedBox(height: context.spacing.md),
          ComponentBoundary(
            child: DievasCheckbox(
              value: DievasCheckboxValue.indeterminate,
              label: 'Indeterminate label',
              onChanged: (_) {},
            ),
          ),
          SizedBox(height: context.spacing.md),
          ComponentBoundary(
            child: DievasCheckbox(value: DievasCheckboxValue.unchecked, label: 'Disabled', onChanged: null),
          ),
        ],
      ),
    ),
  );
}
