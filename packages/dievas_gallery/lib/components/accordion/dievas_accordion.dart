import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';
import '../../widgets/component_boundary.dart';

final accordionComponent = WidgetbookComponent(
  name: 'Accordion',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(
      name: 'Grouped',
      builder: (ctx) => const _LayoutExample(layout: .grouped),
    ),
    WidgetbookUseCase(
      name: 'Ungrouped',
      builder: (ctx) => const _LayoutExample(layout: .ungrouped),
    ),
    WidgetbookUseCase(name: 'Controlled expansion', builder: (ctx) => const _ControlledExample()),
    WidgetbookUseCase(name: 'All States', builder: (ctx) => const _AllStates()),
    WidgetbookUseCase(name: 'With Icons', builder: (ctx) => const _WithIcons()),
  ],
);

class _Playground extends StatelessWidget {
  final text =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularized in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  @override
  Widget build(BuildContext context) {
    final accordionTheme = DievasTheme.componentsOf(context).accordion;

    context.knobSection('Layout and size');
    final layout = context.knobs.object.dropdown<DievasAccordionLayout>(
      label: 'Layout',
      options: DievasAccordionLayout.values,
      initialOption: .grouped,
      labelBuilder: (value) => switch (value) {
        .grouped => 'Grouped',
        .ungrouped => 'Ungrouped',
      },
    );
    final size = context.knobs.object.dropdown<DievasAccordionSize>(
      label: 'Size',
      options: DievasAccordionSize.values,
      initialOption: .md,
      labelBuilder: (value) => value.name,
    );
    final count = context.knobs.double.slider(label: 'Items', initialValue: 3, min: 1, max: 8).round();

    context.knobSection('Expansion and state');
    final allowMultiple = context.knobs.boolean(label: 'Allow multiple', initialValue: false);
    final initiallyExpanded = context.knobs.boolean(label: 'Initially expanded', initialValue: false);
    final disabled = context.knobs.boolean(label: 'Disabled', initialValue: false);
    final maintainState = context.knobs.boolean(label: 'Maintain content state', initialValue: false);

    context.knobSection('Border');
    final showBorder = context.knobs.boolean(label: 'Show border', initialValue: false);
    final borderColourEnabled = context.knobs.boolean(label: 'Override border colour', initialValue: false);
    final borderColour = context.tokenColourKnob(label: 'Border colour', role: .border);
    final radiusEnabled = context.knobs.boolean(label: 'Override border radius', initialValue: false);
    final radius = context.knobs.double.slider(
      label: 'Border radius',
      initialValue: accordionTheme.borderRadius.topLeft.x,
      min: 0,
      max: 48,
    );

    context.knobSection('Divider');
    final showDivider = context.knobs.boolean(label: 'Show divider', initialValue: true);
    final dividerColourEnabled = context.knobs.boolean(label: 'Override divider colour', initialValue: false);
    final dividerColour = context.tokenColourKnob(label: 'Divider colour', role: .border);

    context.knobSection('Shadows');
    final showShadows = context.knobs.boolean(label: 'Show shadows', initialValue: false);

    context.knobSection('Header text');
    final textColourEnabled = context.knobs.boolean(label: 'Override header text colour', initialValue: false);
    final textColour = context.tokenColourKnob(label: 'Header text colour', role: .text);
    final expandedTextColourEnabled = context.knobs.boolean(
      label: 'Override expanded header text colour',
      initialValue: false,
    );
    final expandedTextColour = context.tokenColourKnob(label: 'Expanded header text colour', role: .text);

    context.knobSection('Icons');
    final showLeading = context.knobs.boolean(label: 'Show leading icon', initialValue: false);
    final showCustomTrailing = context.knobs.boolean(label: 'Show custom trailing', initialValue: false);
    final showArrow = context.knobs.boolean(label: 'Show trailing arrow', initialValue: true);
    final iconColourEnabled = context.knobs.boolean(label: 'Override icon colour', initialValue: false);
    final iconColour = context.tokenColourKnob(label: 'Icon colour', role: .icon);
    final expandedIconColourEnabled = context.knobs.boolean(
      label: 'Override expanded icon colour',
      initialValue: false,
    );
    final expandedIconColour = context.tokenColourKnob(label: 'Expanded icon colour', role: .icon);
    final customGap = context.knobs.boolean(label: 'Override icon gap', initialValue: false);
    final gap = context.knobs.double.slider(label: 'Icon gap', initialValue: 8, min: 0, max: 32);

    context.knobSection('Background');
    final backgroundColourEnabled = context.knobs.boolean(label: 'Override background colour', initialValue: false);
    final backgroundColour = context.tokenColourKnob(label: 'Background colour', role: .background);
    final expandedBackgroundColourEnabled = context.knobs.boolean(
      label: 'Override expanded background colour',
      initialValue: false,
    );
    final expandedBackgroundColour = context.tokenColourKnob(label: 'Expanded background colour', role: .background);

    context.knobSection('Content');
    final formContent = context.knobs.boolean(label: 'Show form content', initialValue: false);
    final contentTextColourEnabled = context.knobs.boolean(label: 'Override content text colour', initialValue: false);
    final contentTextColour = context.tokenColourKnob(label: 'Content text colour', role: .text);
    final crossAxisAlignment = context.knobs.object.dropdown<CrossAxisAlignment>(
      label: 'Content cross-axis alignment',
      options: [
        CrossAxisAlignment.stretch,
        CrossAxisAlignment.start,
        CrossAxisAlignment.center,
        CrossAxisAlignment.end,
      ],
    );
    final alignment = context.knobs.object.dropdown<Alignment>(
      label: 'Content alignment',
      options: [Alignment.topLeft, Alignment.center, Alignment.topRight],
    );

    context.knobSection('Padding and height');
    final customPadding = context.knobs.boolean(label: 'Override padding', initialValue: false);
    final headerPadding = context.knobs.double.slider(label: 'Header padding', initialValue: 16, min: 0, max: 48);
    final contentPadding = context.knobs.double.slider(label: 'Content padding', initialValue: 16, min: 0, max: 48);
    final customHeight = context.knobs.boolean(label: 'Override header height', initialValue: false);
    final headerHeight = context.knobs.double.slider(label: 'Header minimum height', initialValue: 24, min: 0, max: 96);

    context.knobSection('Animation');
    final customMotion = context.knobs.boolean(label: 'Override animation', initialValue: false);
    final duration = context.knobs.double.slider(
      label: 'Animation duration (ms)',
      initialValue: 200,
      min: 0,
      max: 1000,
    );
    final curve = context.knobs.object.dropdown<Curve>(
      label: 'Animation curve',
      options: [Curves.easeInOut, Curves.linear, Curves.easeOutCubic],
    );

    final items = List.generate(
      count,
      (i) => DievasAccordionItem(
        title: Text('Accordion Section #${i + 1}'),
        disabled: disabled,
        initiallyExpanded: initiallyExpanded && (allowMultiple || i == 0),
        content: formContent
            ? const TextField(decoration: InputDecoration(labelText: 'Enter a value, then collapse and reopen'))
            : Text(text),
        leading: showLeading ? const Icon(Icons.folder_outlined, size: 16) : null,
        trailing: showCustomTrailing ? const Icon(Icons.settings, size: 16) : null,
        showTrailingArrow: showArrow,
      ),
    );

    return Center(
      child: SizedBox(
        width: .infinity,
        child: ComponentBoundary(
          child: DievasAccordion(
            key: ValueKey((initiallyExpanded, formContent)),
            items: items,
            allowMultiple: allowMultiple,
            layout: layout,
            size: size,
            showBorder: showBorder,
            showDivider: showDivider,
            showShadows: showShadows,
            maintainState: maintainState,
            borderRadius: radiusEnabled ? BorderRadius.circular(radius) : null,
            headerPadding: customPadding ? EdgeInsets.all(headerPadding) : null,
            contentPadding: customPadding ? EdgeInsets.all(contentPadding) : null,
            headerHeight: customHeight ? headerHeight : null,
            gap: customGap ? gap : null,
            transitionDuration: customMotion ? Duration(milliseconds: duration.round()) : null,
            transitionCurve: customMotion ? curve : null,
            expandedAlignment: alignment,
            expandedCrossAxisAlignment: crossAxisAlignment,
            textColour: textColourEnabled ? textColour : null,
            expandedTextColour: expandedTextColourEnabled ? expandedTextColour : null,
            contentTextColour: contentTextColourEnabled ? contentTextColour : null,
            iconColour: iconColourEnabled ? iconColour : null,
            expandedIconColour: expandedIconColourEnabled ? expandedIconColour : null,
            backgroundColour: backgroundColourEnabled ? backgroundColour : null,
            expandedBackgroundColour: expandedBackgroundColourEnabled ? expandedBackgroundColour : null,
            borderColour: borderColourEnabled ? borderColour : null,
            dividerColour: dividerColourEnabled ? dividerColour : null,
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
  );
}

class _WithIcons extends StatelessWidget {
  const _WithIcons();

  @override
  Widget build(BuildContext context) => Center(
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
  );
}

class _LayoutExample extends StatelessWidget {
  const _LayoutExample({required this.layout});

  final DievasAccordionLayout layout;

  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox(
      width: 400,
      child: ComponentBoundary(
        child: DievasAccordion(
          layout: layout,
          allowMultiple: context.knobs.boolean(label: 'Allow multiple', initialValue: false),
          items: const [
            DievasAccordionItem(
              title: Text('Account settings'),
              leading: Icon(Icons.person_outline),
              content: Text('Manage your profile, email address, and account preferences.'),
              initiallyExpanded: true,
            ),
            DievasAccordionItem(
              title: Text('Notifications'),
              leading: Icon(Icons.notifications_outlined),
              content: Text('Choose which updates you receive and how we notify you.'),
            ),
          ],
        ),
      ),
    ),
  );
}

class _ControlledExample extends StatefulWidget {
  const _ControlledExample();

  @override
  State<_ControlledExample> createState() => _ControlledExampleState();
}

class _ControlledExampleState extends State<_ControlledExample> {
  Set<int> _expanded = {};

  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox(
      width: 400,
      child: Column(
        mainAxisSize: .min,
        children: [
          Wrap(
            spacing: context.spacing.sm,
            children: [
              TextButton(onPressed: () => setState(() => _expanded = {0}), child: const Text('Open first')),
              TextButton(onPressed: () => setState(() => _expanded = {}), child: const Text('Close all')),
            ],
          ),
          Text('Expanded: ${_expanded.isEmpty ? 'none' : _expanded.map((index) => index + 1).join(', ')}'),
          ComponentBoundary(
            child: DievasAccordion(
              expandedIndices: _expanded,
              onExpansionChanged: (index, expanded) => setState(() => _expanded = expanded ? {index} : {}),
              items: const [
                DievasAccordionItem(title: Text('Account'), content: Text('Account preferences')),
                DievasAccordionItem(title: Text('Notifications'), content: Text('Notification preferences')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
