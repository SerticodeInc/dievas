import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final filledButtonComponent = WidgetbookComponent(
  name: 'FilledButton',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Styles', builder: (ctx) => const _AllStyles()),
    WidgetbookUseCase(name: 'All Sizes', builder: (ctx) => const _AllSizes()),
    WidgetbookUseCase(name: 'All States', builder: (ctx) => const _AllStates()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final label = context.knobs.string(label: 'Label', initialValue: 'Confirm');

    final style = context.knobs.object.dropdown<DievasFilledButtonStyle>(
      label: 'Style',
      options: DievasFilledButtonStyle.values,
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
        child: DievasFilledButton(
          label: label.isEmpty ? 'Confirm' : label,
          style: style,
          size: size,
          shape: shape,
          state: state,
          leadingIcon: leadingIcon ? const Icon(Icons.add_rounded) : null,
          trailingIcon: trailingIcon ? const Icon(Icons.arrow_forward_rounded) : null,
          onPressed: enabled ? () {} : null,
        ),
      ),
    );
  }
}

class _AllStyles extends StatelessWidget {
  const _AllStyles();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Wrap(
        spacing: context.spacing.smPlus,
        runSpacing: context.spacing.smPlus,
        alignment: WrapAlignment.center,
        children: [
          for (final style in DievasFilledButtonStyle.values)
            ComponentBoundary(
              child: DievasFilledButton(label: style.name, style: style, onPressed: () {}),
            ),
        ],
      ),
    ),
  );
}

class _AllSizes extends StatelessWidget {
  const _AllSizes();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Wrap(
        spacing: context.spacing.smPlus,
        runSpacing: context.spacing.smPlus,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final size in DievasButtonSize.values)
            ComponentBoundary(
              child: DievasFilledButton(label: size.name, size: size, onPressed: () {}),
            ),
        ],
      ),
    ),
  );
}

class _AllStates extends StatelessWidget {
  const _AllStates();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Wrap(
        spacing: context.spacing.smPlus,
        runSpacing: context.spacing.smPlus,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final state in DievasButtonState.values)
            ComponentBoundary(
              child: DievasFilledButton(
                label: state.name,
                state: state,
                onPressed: state == DievasButtonState.disabled ? null : () {},
              ),
            ),
        ],
      ),
    ),
  );
}
