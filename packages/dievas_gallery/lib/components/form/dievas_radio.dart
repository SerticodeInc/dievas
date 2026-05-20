import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final radioComponent = WidgetbookComponent(
  name: 'Radio',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'Group', builder: (ctx) => _Group()),
    WidgetbookUseCase(name: 'All States', builder: (ctx) => _AllStates()),
  ],
);

// Playground simulates a 3-option group — the knob sets which one is pre-selected.
class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  if (option != options.last) SizedBox(height: context.spacing.smPlus),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Group extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: StatefulBuilder(
        builder: (context, setState) {
          var selected = 'Standard';
          final options = ['Standard', 'Express', 'Overnight'];

          return ComponentBoundary(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shipping method', style: context.typography.titleSm),
                SizedBox(height: context.spacing.smPlus),
                for (final option in options) ...[
                  DievasRadio<String>(
                    value: option,
                    groupValue: selected,
                    label: option,
                    onChanged: (v) => setState(() => selected = v),
                  ),
                  if (option != options.last) SizedBox(height: context.spacing.smPlus),
                ],
              ],
            ),
          );
        },
      ),
    ),
  );
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
          _StateRow('Unselected', isSelected: false),
          SizedBox(height: context.spacing.md),
          _StateRow('Selected', isSelected: true),
          SizedBox(height: context.spacing.md),
          _StateRow('Disabled (unselected)', isSelected: false, disabled: true),
          SizedBox(height: context.spacing.md),
          _StateRow('Disabled (selected)', isSelected: true, disabled: true),
        ],
      ),
    ),
  );
}

class _StateRow extends StatelessWidget {
  const _StateRow(this.name, {required this.isSelected, this.disabled = false});
  final String name;
  final bool isSelected;
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
        child: DievasRadio<bool>(value: true, groupValue: isSelected, onChanged: disabled ? null : (_) {}),
      ),
    ],
  );
}
