import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final accordionComponent = WidgetbookComponent(
  name: 'Accordion',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All States', builder: (ctx) => const _AllStates()),
    WidgetbookUseCase(name: 'With Icons', builder: (ctx) => const _WithIcons()),
  ],
);

class _Playground extends StatelessWidget {
  final text =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularized in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  @override
  Widget build(BuildContext context) {
    final count = context.knobs.double.slider(label: 'Items', initialValue: 3, min: 1, max: 8).round();
    final allowMultiple = context.knobs.boolean(label: 'Allow multiple', initialValue: false);
    final showLeading = context.knobs.boolean(label: 'Show leading icon', initialValue: false);
    final showCustomTrailing = context.knobs.boolean(label: 'Show custom trailing', initialValue: false);
    final showArrow = context.knobs.boolean(label: 'Show trailing arrow', initialValue: true);

    final items = List.generate(
      count,
      (i) => DievasAccordionItem(
        title: Text('Accordion Section #${i + 1}'),
        content: Text(text),
        leading: showLeading ? const Icon(Icons.folder_outlined, size: 16) : null,
        trailing: showCustomTrailing ? const Icon(Icons.settings, size: 16) : null,
        showTrailingArrow: showArrow,
      ),
    );

    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.spacing.md),
        child: SizedBox(
          width: .infinity,
          child: ComponentBoundary(
            child: DievasAccordion(items: items, allowMultiple: allowMultiple),
          ),
        ),
      ),
    );
  }
}

class _AllStates extends StatelessWidget {
  const _AllStates();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.md),
      child: SizedBox(
        width: 400,
        child: ComponentBoundary(
          child: DievasAccordion(
            items: const [
              DievasAccordionItem(title: Text('Collapsed'), content: Text('Hidden content')),
              DievasAccordionItem(title: Text('Expanded'), content: Text('Visible content'), initiallyExpanded: true),
              DievasAccordionItem(title: Text('Disabled'), content: Text('Cannot expand'), disabled: true),
              DievasAccordionItem(
                title: Text('No Arrow'),
                content: Text('Trailing arrow hidden'),
                showTrailingArrow: false,
              ),
            ],
            allowMultiple: true,
          ),
        ),
      ),
    ),
  );
}

class _WithIcons extends StatelessWidget {
  const _WithIcons();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.md),
      child: SizedBox(
        width: 400,
        child: ComponentBoundary(
          child: DievasAccordion(
            items: const [
              DievasAccordionItem(
                title: Text('Leading Icon'),
                content: Text('This item has a leading folder icon.'),
                leading: Icon(Icons.folder_outlined),
              ),
              DievasAccordionItem(
                title: Text('Custom Trailing'),
                content: Text('This item has a custom trailing icon.'),
                trailing: Icon(Icons.settings),
              ),
              DievasAccordionItem(
                title: Text('Leading + Custom Trailing'),
                content: Text('Both leading and custom trailing icons.'),
                leading: Icon(Icons.star_border),
                trailing: Icon(Icons.more_vert),
              ),
            ],
            allowMultiple: true,
          ),
        ),
      ),
    ),
  );
}
