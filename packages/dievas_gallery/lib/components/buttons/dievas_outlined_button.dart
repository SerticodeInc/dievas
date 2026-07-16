import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final outlinedButtonComponent = WidgetbookComponent(
  name: 'OutlinedButton',
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

    final state = context.knobs.object.dropdown<DievasButtonState>(
      label: 'State',
      options: DievasButtonState.values,
      labelBuilder: (v) => v.name,
    );

    final borderRadiusOverride = context.knobs.double.slider(label: 'Border radius', initialValue: 0, min: 0, max: 24);
    final leadingIcon = context.knobs.boolean(label: 'Leading Icon');
    final trailingIcon = context.knobs.boolean(label: 'Trailing Icon');
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
    final useChild = context.knobs.boolean(label: 'Use custom child');

    final useCustomColours = context.knobs.boolean(label: 'Custom colours');
    final backgroundColor = useCustomColours ? context.knobs.color(label: 'Background colour', initialValue: const Color(0xFF6200EE)) : null;
    final foregroundColor = useCustomColours ? context.knobs.color(label: 'Foreground colour', initialValue: Colors.white) : null;
    final borderColor = useCustomColours ? context.knobs.color(label: 'Border colour', initialValue: const Color(0xFF6200EE)) : null;

    return Center(
      child: ComponentBoundary(
        child: DievasOutlinedButton(
          label: useChild ? null : (label.isEmpty ? 'Cancel' : label),
          style: style,
          size: size,
          shape: borderRadiusOverride > 0 ? BorderRadius.circular(borderRadiusOverride) : null,
          state: state,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          borderColor: borderColor,
          leadingIcon: leadingIcon ? const Icon(Icons.close_rounded) : null,
          trailingIcon: trailingIcon ? const Icon(Icons.arrow_back_rounded) : null,
          child: useChild ? const Text('Custom child') : null,
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
          for (final style in DievasOutlinedButtonStyle.values)
            ComponentBoundary(
              child: DievasOutlinedButton(label: style.name, style: style, onPressed: () {}),
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
              child: DievasOutlinedButton(label: size.name, size: size, onPressed: () {}),
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
}
