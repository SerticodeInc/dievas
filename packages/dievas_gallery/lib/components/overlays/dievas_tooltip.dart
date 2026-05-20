import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final tooltipComponent = WidgetbookComponent(
  name: 'Tooltip',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'On Icon Button', builder: (ctx) => const _OnIconButton()),
    WidgetbookUseCase(name: 'Prefer Above', builder: (ctx) => const _PreferAbove()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final message = context.knobs.string(label: 'Message', initialValue: 'Tooltip message');
    final preferBelow = context.knobs.boolean(label: 'Prefer below', initialValue: true);

    return Center(
      child: ComponentBoundary(
        child: DievasTooltip(
          message: message.isEmpty ? 'Tooltip' : message,
          preferBelow: preferBelow,
          child: DievasFilledButton(label: 'Hover / long-press me', onPressed: () {}),
        ),
      ),
    );
  }
}

class _OnIconButton extends StatelessWidget {
  const _OnIconButton();

  @override
  Widget build(BuildContext context) => Center(
    child: ComponentBoundary(
      child: DievasTooltip(
        message: 'Delete item',
        child: DievasIconButton(icon: const _TrashIcon(), onPressed: () {}),
      ),
    ),
  );
}

class _PreferAbove extends StatelessWidget {
  const _PreferAbove();

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: EdgeInsets.all(context.spacing.x2l),
      child: ComponentBoundary(
        child: DievasTooltip(
          message: 'Shown above the target',
          preferBelow: false,
          child: DievasFilledButton(label: 'Tooltip above', onPressed: () {}),
        ),
      ),
    ),
  );
}

class _TrashIcon extends StatelessWidget {
  const _TrashIcon();

  @override
  Widget build(BuildContext context) => Text(
    String.fromCharCode(0xe872), // delete
    style: const TextStyle(fontFamily: 'MaterialIcons', fontSize: 20),
  );
}
