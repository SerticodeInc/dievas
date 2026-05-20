import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final modalComponent = WidgetbookComponent(
  name: 'Modal',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'With Actions', builder: (ctx) => _WithActions()),
    WidgetbookUseCase(name: 'Content Only', builder: (ctx) => _ContentOnly()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = context.knobs.string(label: 'Title', initialValue: 'Confirm action');
    final body = context.knobs.string(
      label: 'Body',
      initialValue: 'This action cannot be undone. Are you sure you want to continue?',
    );
    final showClose = context.knobs.boolean(label: 'Close button', initialValue: true);
    final showActions = context.knobs.boolean(label: 'Show actions', initialValue: true);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.spacing.lg),
        child: ComponentBoundary(
          child: DievasModal(
            title: title.isEmpty ? 'Modal title' : title,
            body: body.isEmpty ? null : body,
            showCloseButton: showClose,
            actions: showActions
                ? [
                    DievasTextButton(label: 'Cancel', onPressed: () {}),
                    DievasFilledButton(label: 'Confirm', onPressed: () {}),
                  ]
                : [],
          ),
        ),
      ),
    );
  }
}

class _WithActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: ComponentBoundary(
        child: DievasModal(
          title: 'Delete item',
          body: 'This will permanently delete the item. This action cannot be undone.',
          actions: [
            DievasTextButton(label: 'Cancel', onPressed: () {}),
            DievasFilledButton(label: 'Delete', style: .destructive, onPressed: () {}),
          ],
        ),
      ),
    ),
  );
}

class _ContentOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: ComponentBoundary(
        child: DievasModal(
          title: 'Custom content',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DievasAlert(tone: .info, title: 'Note', description: 'Custom widget content inside a modal.'),
              SizedBox(height: context.spacing.md),
              DievasTextInput(label: 'Confirm name', onChanged: (_) {}),
            ],
          ),
          actions: [DievasFilledButton(label: 'Submit', onPressed: () {})],
        ),
      ),
    ),
  );
}
