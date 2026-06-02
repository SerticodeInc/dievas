import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final popoverComponent = WidgetbookComponent(
  name: 'Popover',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Positions', builder: (ctx) => const _AllPositions()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final position = context.knobs.object.dropdown<DievasPopoverPosition>(
      label: 'Position',
      options: DievasPopoverPosition.values,
      labelBuilder: (v) => v.name,
      initialOption: .bottom,
    );
    final content = context.knobs.string(label: 'Content', initialValue: 'Popover content here');

    return Center(
      child: ComponentBoundary(
        child: DievasPopover(
          position: position,
          trigger: DievasFilledButton(label: 'Open Popover', onPressed: () {}),
          content: Text(content.isEmpty ? 'Popover content here' : content),
        ),
      ),
    );
  }
}

class _AllPositions extends StatelessWidget {
  const _AllPositions();

  @override
  Widget build(BuildContext context) => Center(
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: .center,
      children: [
        Column(
          mainAxisSize: .min,
          children: [
            const Text('Bottom'),
            ComponentBoundary(
              child: DievasPopover(
                position: .bottom,
                trigger: DievasFilledButton(label: 'Open', onPressed: () {}),
                content: const Text('Bottom popover'),
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: .min,
          children: [
            const Text('Top'),
            ComponentBoundary(
              child: DievasPopover(
                position: .top,
                trigger: DievasFilledButton(label: 'Open', onPressed: () {}),
                content: const Text('Top popover'),
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: .min,
          children: [
            const Text('Left'),
            ComponentBoundary(
              child: DievasPopover(
                position: .left,
                trigger: DievasFilledButton(label: 'Open', onPressed: () {}),
                content: const Text('Left popover'),
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: .min,
          children: [
            const Text('Right'),
            ComponentBoundary(
              child: DievasPopover(
                position: .right,
                trigger: DievasFilledButton(label: 'Open', onPressed: () {}),
                content: const Text('Right popover'),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
