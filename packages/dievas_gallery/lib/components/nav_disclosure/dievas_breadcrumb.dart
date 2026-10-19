import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';
import '../../widgets/component_boundary.dart';

final breadcrumbComponent = WidgetbookComponent(
  name: 'BreadCrumb',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => const _Playground()),
    WidgetbookUseCase(name: 'Configurations', builder: (ctx) => const _Configurations()),
  ],
);

class _Playground extends StatefulWidget {
  const _Playground();

  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  int? _selected;

  @override
  Widget build(BuildContext context) {
    context.knobSection('Layout');
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
    final count = context.knobs.object.dropdown(label: 'Item count', options: [2, 3, 4, 5, 6, 7, 8], initialOption: 7);
    final collapse = context.knobs.boolean(label: 'Collapse middle items', initialValue: true);
    final visible = context.knobs.object.dropdown(
      label: 'Visible item count',
      options: [2, 3, 4, 5, 6, 7, 8],
      initialOption: 3,
    );
    final overrideGap = context.knobs.boolean(label: 'Override gap');
    final gap = context.knobs.double.slider(label: 'Gap', initialValue: 8, min: 0, max: 24);
    final rtl = context.knobs.boolean(label: 'Right to left');
    context.knobSection('Item slots');
    final leading = context.knobs.boolean(label: 'Leading');
    final trailing = context.knobs.boolean(label: 'Trailing');
    final home = context.knobs.boolean(label: 'Home icon');
    context.knobSection('Colours');
    final overrideItem = context.knobs.boolean(label: 'Override item colour');
    final itemColour = context.tokenColourKnob(label: 'Item colour', role: .text);
    final overrideCurrent = context.knobs.boolean(label: 'Override current item colour');
    final currentColour = context.tokenColourKnob(label: 'Current item colour', role: .text);
    final overrideHover = context.knobs.boolean(label: 'Override hover effect colour');
    final hoverColour = context.tokenColourKnob(label: 'Hover effect colour', role: .background);
    final overrideDivider = context.knobs.boolean(label: 'Override divider colour');
    final dividerColour = context.tokenColourKnob(label: 'Divider colour', role: .icon);
    final selected = (_selected ?? count - 1).clamp(0, count - 1);

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(context.spacing.LG),
        child: Directionality(
          textDirection: rtl ? .rtl : .ltr,
          child: Column(
            mainAxisSize: .min,
            children: [
              for (final custom in [false, true]) ...[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: context.spacing.LG),
                  child: _SectionTitle(label: custom ? 'Custom breadcrumb with dropdown' : 'Breadcrumb'),
                ),
                ComponentBoundary(
                  child: DievasBreadcrumb<int>(
                    items: List.generate(selected + 1, (index) => index),
                    displayString: (index) => index == 0 ? 'Home' : 'Page $index',
                    selectedItem: selected,
                    enabled: enabled,
                    visibleItemCount: collapse ? visible : null,
                    gap: overrideGap ? gap : null,
                    itemColour: overrideItem ? itemColour : null,
                    currentItemColour: overrideCurrent ? currentColour : null,
                    hoverEffectColour: overrideHover ? hoverColour : null,
                    dividerColour: overrideDivider ? dividerColour : null,
                    leading: leading ? const DievasIcon(Icons.folder_outlined) : null,
                    trailing: trailing ? const DievasIcon(Icons.open_in_new) : null,
                    onHomeTap: home ? () => setState(() => _selected = 0) : null,
                    overflow: custom ? const DievasIcon(Icons.menu) : null,
                    onItemTap: (index) => setState(() => _selected = index),
                  ),
                ),
                if (!custom) ...[
                  SizedBox(height: context.spacing.MD),
                  DievasFilledButton(label: 'Reset', onPressed: () => setState(() => _selected = null)),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Expanded(child: DievasDivider()),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.MD),
        child: Text(label, style: context.typography.labelXS),
      ),
      const Expanded(child: DievasDivider()),
    ],
  );
}

class _Configurations extends StatelessWidget {
  const _Configurations();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.all(context.spacing.LG),
    child: Column(
      mainAxisSize: .min,
      children: [
        for (final (label, limit, enabled) in const [
          ('Full trail', null, true),
          ('Collapsed read-only trail', 3, true),
          ('Disabled', 3, false),
        ]) ...[
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.spacing.LG),
            child: _SectionTitle(label: label),
          ),
          DievasBreadcrumb<String>(
            items: const ['Home', 'Products', 'Clothing', 'Shirts'],
            displayString: (item) => item,
            selectedItem: 'Shirts',
            visibleItemCount: limit,
            enabled: enabled,
          ),
        ],
      ],
    ),
  );
}
