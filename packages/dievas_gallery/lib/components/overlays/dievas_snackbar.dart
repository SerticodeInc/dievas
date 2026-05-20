import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final snackbarComponent = WidgetbookComponent(
  name: 'Snackbar',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'With Action', builder: (ctx) => _WithAction()),
    WidgetbookUseCase(name: 'Message Only', builder: (ctx) => _MessageOnly()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final message = context.knobs.string(label: 'Message', initialValue: 'Changes saved successfully.');
    final showAction = context.knobs.boolean(label: 'Show action');
    final actionLabel = context.knobs.string(label: 'Action label', initialValue: 'Undo');

    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.spacing.lg),
        child: ComponentBoundary(
          child: DievasSnackbar(
            message: message.isEmpty ? 'Snackbar message' : message,
            action: showAction
                ? DievasSnackbarAction(label: actionLabel.isEmpty ? 'Action' : actionLabel, onPressed: () {})
                : null,
          ),
        ),
      ),
    );
  }
}

class _WithAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: ComponentBoundary(
        child: DievasSnackbar(
          message: 'Message deleted.',
          action: DievasSnackbarAction(label: 'Undo', onPressed: () {}),
        ),
      ),
    ),
  );
}

class _MessageOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: ComponentBoundary(child: DievasSnackbar(message: 'Your profile has been updated.')),
    ),
  );
}
