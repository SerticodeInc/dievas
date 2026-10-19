import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'button_playground.dart';
import '../../widgets/component_boundary.dart';

final outlinedButtonComponent = WidgetbookComponent(
  name: 'OutlinedButton',
  useCases: [
    WidgetbookUseCase(
      name: 'Playground',
      builder: (ctx) => const ButtonPlayground(variant: .outlined),
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
      padding: EdgeInsets.all(context.spacing.LG),
      child: Wrap(
        spacing: context.spacing.SMPlus,
        runSpacing: context.spacing.SMPlus,
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
      padding: EdgeInsets.all(context.spacing.LG),
      child: Wrap(
        spacing: context.spacing.SMPlus,
        runSpacing: context.spacing.SMPlus,
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
      padding: EdgeInsets.all(context.spacing.LG),
      child: Wrap(
        spacing: context.spacing.SMPlus,
        runSpacing: context.spacing.SMPlus,
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
