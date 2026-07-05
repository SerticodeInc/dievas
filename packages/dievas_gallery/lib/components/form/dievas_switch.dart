import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final switchComponent = WidgetbookComponent(
  name: 'Switch',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All States', builder: (ctx) => _AllStates()),
    WidgetbookUseCase(name: 'With Labels', builder: (ctx) => _WithLabels()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          _StateRow('Off', value: false),
          SizedBox(height: context.spacing.md),
          _StateRow('On', value: true),
          SizedBox(height: context.spacing.md),
          _StateRow('Disabled (off)', value: false, disabled: true),
          SizedBox(height: context.spacing.md),
          _StateRow('Disabled (on)', value: true, disabled: true),
        ],
      ),
    ),
  );
}

class _StateRow extends StatelessWidget {
  const _StateRow(this.name, {required this.value, this.disabled = false});
  final String name;
  final bool value;
  final bool disabled;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: 140,
        child: Text(name, style: context.typography.labelXs.copyWith(color: context.colours.text.textTertiary)),
      ),
      ComponentBoundary(
        child: DievasSwitch(value: value, onChanged: disabled ? null : (_) {}),
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
            child: DievasSwitch(value: false, label: 'Notifications', onChanged: (_) {}),
          ),
          SizedBox(height: context.spacing.md),
          ComponentBoundary(
            child: DievasSwitch(value: true, label: 'Dark mode', onChanged: (_) {}),
          ),
          SizedBox(height: context.spacing.md),
          ComponentBoundary(child: DievasSwitch(value: false, label: 'Disabled setting', onChanged: null)),
        ],
      ),
    ),
  );
}
