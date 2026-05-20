import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final bannerComponent = WidgetbookComponent(
  name: 'Banner',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Tones', builder: (ctx) => _AllTones()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tone = context.knobs.object.dropdown<DievasAlertTone>(
      label: 'Tone',
      options: DievasAlertTone.values,
      labelBuilder: (v) => v.name,
      initialOption: .warning,
    );
    final message = context.knobs.string(label: 'Message', initialValue: 'You are currently in offline mode.');
    final showDismiss = context.knobs.boolean(label: 'Dismissible', initialValue: true);

    return ComponentBoundary(
      child: DievasBanner(
        tone: tone,
        message: message.isEmpty ? 'Banner message' : message,
        onDismiss: showDismiss ? () {} : null,
      ),
    );
  }
}

class _AllTones extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (final tone in DievasAlertTone.values)
        ComponentBoundary(
          child: DievasBanner(
            tone: tone,
            message: '${tone.name[0].toUpperCase()}${tone.name.substring(1)}: system message displayed here.',
            onDismiss: () {},
          ),
        ),
    ],
  );
}
