import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';

final searchWithDropdownComponent = WidgetbookComponent(
  name: 'SearchWithDropdown',
  useCases: [
    WidgetbookUseCase(
      name: 'Playground',
      builder: (context) {
        final state = WidgetbookState.of(context);
        final session = _sessions[state] ??= _SearchSession();
        return _Playground(session: session);
      },
    ),
  ],
);

const _components = [
  'Accordion',
  'Alert',
  'AuthCode',
  'Avatar',
  'BottomSheet',
  'Breadcrumb',
  'Button',
  'Carousel',
  'Checkbox',
  'Chip',
  'CircularLoader',
  'CircularProgress',
  'Combobox',
  'DotIndicator',
  'Drawer',
  'Dropdown',
  'Icons',
  'LinearLoader',
  'LinearProgress',
  'MenuItem',
  'Modal',
  'Popover',
  'Radio',
  'Search',
  'SegmentedControl',
  'Switch',
  'TabBar',
  'Table',
  'Tag',
  'TextArea',
  'TextInput',
  'TextInputGroup',
  'Toast',
  'Tooltip',
];

// Widgetbook remounts use cases when changing knob query parameters.
final _sessions = Expando<_SearchSession>();

class _SearchSession {
  String query = '';
  String? selection;
  bool open = false;
}

class _Playground extends StatefulWidget {
  const _Playground({required this.session});
  final _SearchSession session;

  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  @override
  Widget build(BuildContext context) {
    context.knobSection('Input colours');
    final overrideActive = context.knobs.boolean(label: 'Override active border colour');
    final active = context.tokenColourKnob(label: 'Active border colour', role: .border, initialValue: .brand);
    final overrideInactive = context.knobs.boolean(label: 'Override inactive border colour');
    final inactive = context.tokenColourKnob(label: 'Inactive border colour', role: .border, initialValue: .brand);
    final overrideHover = context.knobs.boolean(label: 'Override hover border colour');
    final hover = context.tokenColourKnob(label: 'Hover border colour', role: .border, initialValue: .brand);
    final overrideBackground = context.knobs.boolean(label: 'Override background colour');
    final background = context.tokenColourKnob(label: 'Background colour', role: .background, initialValue: .brand);

    context.knobSection('Dropdown layout');
    final overrideRadius = context.knobs.boolean(label: 'Override border radius');
    final radius = context.knobs.object.dropdown<_SearchRadius>(
      label: 'Border radius',
      options: _SearchRadius.values,
      initialOption: .md,
      labelBuilder: (value) => value.name,
    );
    final overrideGap = context.knobs.boolean(label: 'Override distance to target');
    final gap = context.knobs.object.dropdown<_SearchGap>(
      label: 'Distance to target',
      options: _SearchGap.values,
      initialOption: .sm,
      labelBuilder: (value) => value.name,
    );
    final shadow = context.knobs.boolean(label: 'Show shadow', initialValue: true);

    context.knobSection('Input behaviour');
    final size = context.knobs.object.dropdown<DievasSearchSize>(
      label: 'Input size',
      options: DievasSearchSize.values,
      initialOption: .md,
      labelBuilder: (value) => value.name,
    );
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
    final floatingLabel = context.knobs.boolean(label: 'Floating label');
    final rtl = context.knobs.boolean(label: 'Right to left');
    final session = widget.session;
    final borderRadius = switch (radius) {
      .none => context.border.none,
      .xs => context.border.xs,
      .sm => context.border.sm,
      .md => context.border.md,
      .lg => context.border.lg,
      .xl => context.border.xl,
      .xl2 => context.border.xl2,
      .xl3 => context.border.xl3,
      .r28 => context.border.r28,
      .r32 => context.border.r32,
    };
    final distance = switch (gap) {
      .none => context.spacing.none,
      .xs => context.spacing.xs,
      .sm => context.spacing.sm,
      .smPlus => context.spacing.smPlus,
      .md => context.spacing.md,
      .lg => context.spacing.lg,
      .xl => context.spacing.xl,
    };

    return Directionality(
      textDirection: rtl ? .rtl : .ltr,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.spacing.xl3, horizontal: context.spacing.md),
        child: Stack(
          children: [
            if (!session.open)
              Center(
                child: Text(
                  'Search results displayed within DievasDropdown.',
                  textAlign: .center,
                  style: context.typography.bodySm,
                ),
              ),
            Align(
              alignment: .topCenter,
              child: DievasSearchWithDropdown<String>(
                items: _components,
                displayString: (value) => value,
                hint: 'Search components',
                initialQuery: session.query,
                initialValue: session.selection,
                show: session.open,
                enabled: enabled,
                size: size,
                hasFloatingLabel: floatingLabel,
                showShadow: shadow,
                borderRadius: overrideRadius ? borderRadius : null,
                distanceToTarget: overrideGap ? distance : null,
                activeBorderColour: overrideActive ? active : null,
                inactiveBorderColour: overrideInactive ? inactive : null,
                hoverBorderColour: overrideHover ? hover : null,
                backgroundColour: overrideBackground ? background : null,
                onChanged: (query) {
                  session.query = query;
                  if (query != session.selection) session.selection = null;
                },
                onSelected: (value) => setState(() => session.selection = value),
                onOpenChanged: (open) => setState(() => session.open = open),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _SearchRadius { none, xs, sm, md, lg, xl, xl2, xl3, r28, r32 }

enum _SearchGap { none, xs, sm, smPlus, md, lg, xl }
