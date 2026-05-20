import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final alertComponent = WidgetbookComponent(
  name: 'Alert',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Tones', builder: (ctx) => _AllTones()),
    WidgetbookUseCase(name: 'With Dismiss', builder: (ctx) => _WithDismiss()),
    WidgetbookUseCase(name: 'No Description', builder: (ctx) => _NoDescription()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tone = context.knobs.object.dropdown<DievasAlertTone>(
      label: 'Tone',
      options: DievasAlertTone.values,
      labelBuilder: (v) => v.name,
      initialOption: .info,
    );

    final title = context.knobs.string(label: 'Title', initialValue: 'Heads up');
    final description = context.knobs.string(
      label: 'Description',
      initialValue: 'Something worth your attention has just happened.',
    );
    final showDismiss = context.knobs.boolean(label: 'Dismissible');

    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.spacing.lg),
        child: ComponentBoundary(
          child: DievasAlert(
            tone: tone,
            title: title.isEmpty ? 'Alert' : title,
            description: description.isEmpty ? null : description,
            onDismiss: showDismiss ? () {} : null,
          ),
        ),
      ),
    );
  }
}

class _AllTones extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.all(context.spacing.lg),
    child: Column(
      children: [
        for (final tone in DievasAlertTone.values) ...[
          ComponentBoundary(
            child: DievasAlert(
              tone: tone,
              title: '${tone.name[0].toUpperCase()}${tone.name.substring(1)} alert',
              description: 'This is a ${tone.name} tone alert with a supporting description.',
            ),
          ),
          SizedBox(height: context.spacing.smPlus),
        ],
      ],
    ),
  );
}

class _WithDismiss extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: ComponentBoundary(
        child: DievasAlert(
          tone: .warning,
          title: 'Action required',
          description: 'You have unsaved changes. Dismiss to discard them.',
          onDismiss: () {},
        ),
      ),
    ),
  );
}

class _NoDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.all(context.spacing.lg),
    child: Column(
      children: [
        for (final tone in DievasAlertTone.values) ...[
          ComponentBoundary(
            child: DievasAlert(tone: tone, title: '${tone.name[0].toUpperCase()}${tone.name.substring(1)}'),
          ),
          SizedBox(height: context.spacing.smPlus),
        ],
      ],
    ),
  );
}
