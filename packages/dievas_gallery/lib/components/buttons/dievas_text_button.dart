import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'button_playground.dart';
import '../../widgets/component_boundary.dart';

final textButtonComponent = WidgetbookComponent(
  name: 'TextButton',
  useCases: [
    WidgetbookUseCase(
      name: 'Playground',
      builder: (ctx) => const ButtonPlayground(variant: .text),
    ),
    WidgetbookUseCase(name: 'All Styles', builder: (ctx) => const _AllStyles()),
    WidgetbookUseCase(name: 'All Sizes', builder: (ctx) => const _AllSizes()),
    WidgetbookUseCase(name: 'All States', builder: (ctx) => const _AllStates()),
  ],
);

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
          for (final style in DievasTextButtonStyle.values)
            ComponentBoundary(
              child: DievasTextButton(label: style.name, style: style, onPressed: () {}),
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
              child: DievasTextButton(label: size.name, size: size, onPressed: () {}),
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
}
