import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final bottomSheetComponent = WidgetbookComponent(
  name: 'BottomSheet',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'With Drag Handle', builder: (ctx) => _WithHandle()),
    WidgetbookUseCase(name: 'No Handle', builder: (ctx) => _NoHandle()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final showHandle = context.knobs.boolean(label: 'Drag handle', initialValue: true);

    return Center(
      child: ComponentBoundary(
        child: DievasBottomSheet(
          showDragHandle: showHandle,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              context.spacing.lg,
              context.spacing.md,
              context.spacing.lg,
              context.spacing.xl,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sheet title', style: DievasTheme.typographyOf(context).titleMd),
                SizedBox(height: context.spacing.sm),
                Text(
                  'This is a Dievas bottom sheet. Content goes here.',
                  style: DievasTheme.typographyOf(context).bodyMd,
                ),
                SizedBox(height: context.spacing.lg),
                DievasFilledButton(label: 'Confirm', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WithHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: ComponentBoundary(
      child: DievasBottomSheet(
        child: Padding(
          padding: EdgeInsets.fromLTRB(context.spacing.lg, context.spacing.md, context.spacing.lg, context.spacing.xl),
          child: Text('Content with drag handle', style: DievasTheme.typographyOf(context).bodyMd),
        ),
      ),
    ),
  );
}

class _NoHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: ComponentBoundary(
      child: DievasBottomSheet(
        showDragHandle: false,
        child: Padding(
          padding: EdgeInsets.all(context.spacing.lg),
          child: Text('Content without drag handle', style: DievasTheme.typographyOf(context).bodyMd),
        ),
      ),
    ),
  );
}
