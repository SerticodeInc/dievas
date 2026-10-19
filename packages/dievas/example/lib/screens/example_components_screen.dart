import 'package:dievas_example/example_navigation.dart';
import 'package:flutter/material.dart';

import 'package:dievas/dievas.dart';
import 'package:dievas_example/widgets/example_page.dart';

part 'example_components/component_controls.dart';
part 'example_components/component_display.dart';
part 'example_components/component_feedback.dart';
part 'example_components/component_form.dart';

/// Components: the Dievas widget library in action.
///
/// One section per component group. Every component reads its colours, sizes
/// and spacing from the theme: none of the values below are hardcoded.
class ExampleComponentsScreen extends StatelessWidget {
  const ExampleComponentsScreen({super.key});

  @override
  Widget build(BuildContext context) => ExamplePage(
    child: Column(
      crossAxisAlignment: .start,
      children: [
        Text('Components', style: context.typography.displaySm),
        SizedBox(height: context.spacing.sm),
        Text(
          'Explore the controls, content and feedback that make up an interface.',
          style: context.typography.bodyMd.copyWith(color: context.colours.text.textSecondary),
        ),
        SizedBox(height: context.spacing.xl2),
        const _GroupLabel('Buttons'),
        const _ButtonRow(),
        SizedBox(height: context.spacing.xl3),
        const _GroupLabel('Form'),
        const _FormExamples(),
        SizedBox(height: context.spacing.xl3),
        const _GroupLabel('Display'),
        const _DisplayRow(),
        SizedBox(height: context.spacing.lg),
        const _ProgressRow(),
        SizedBox(height: context.spacing.xl3),
        const _GroupLabel('Feedback & overlays'),
        const _FeedbackRow(),
        SizedBox(height: context.spacing.lg),
        const DievasLoader(label: 'Loading…'),
        SizedBox(height: context.spacing.xl3),
        const _GroupLabel('Empty state'),
        const DievasEmptyState(title: 'No projects yet', description: 'Create your first project to get started.'),
      ],
    ),
  );
}
