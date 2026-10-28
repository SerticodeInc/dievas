import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';
import '../../widgets/component_boundary.dart';

final _sessions = Expando<Map<String, _PopoverSession>>();

final popoverComponent = WidgetbookComponent(
  name: 'Popover',
  useCases: [
    for (final name in ['Playground', 'Edge placement', 'Long content'])
      WidgetbookUseCase(
        name: name,
        builder: (context) => _Playground(
          example: name,
          session: (_sessions[WidgetbookState.of(context)] ??= {}).putIfAbsent(name, _PopoverSession.new),
        ),
      ),
  ],
);

class _PopoverSession {
  bool open = false;
}

enum _Radius { none, sm, md, lg, xl, r32 }

enum _Spacing {
  none,
  sm,
  smPlus,
  md,
  lg;

  double resolve(DievasSpacingThemeData spacing) => switch (this) {
    .none => 0,
    .sm => spacing.sm,
    .smPlus => spacing.smPlus,
    .md => spacing.md,
    .lg => spacing.lg,
  };
}

enum _Width { compact, regular, wide }

class _Playground extends StatefulWidget {
  const _Playground({required this.example, required this.session});
  final String example;
  final _PopoverSession session;

  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  @override
  Widget build(BuildContext context) {
    context.knobSection('Content');
    final label = context.knobs.string(label: 'Label text', initialValue: 'Custom DievasPopover text');
    context.knobSection('Surface');
    final overrideBackground = context.knobs.boolean(label: 'Override background colour');
    final background = context.tokenColourKnob(label: 'Background colour', role: .background, initialValue: .brand);
    final overrideBorder = context.knobs.boolean(label: 'Override border colour');
    final border = context.tokenColourKnob(label: 'Border colour', role: .border, initialValue: .brand);
    final overrideText = context.knobs.boolean(label: 'Override text colour');
    final text = context.tokenColourKnob(label: 'Text colour', role: .text, initialValue: .inverseText);
    final overrideIcon = context.knobs.boolean(label: 'Override icon colour');
    final icon = context.tokenColourKnob(label: 'Icon colour', role: .icon, initialValue: .brand);
    final overrideRadius = context.knobs.boolean(label: 'Override border radius');
    final radius = context.knobs.object.dropdown(
      label: 'Border radius',
      options: _Radius.values,
      initialOption: _Radius.md,
      labelBuilder: (v) => v.name,
    );
    final shadow = context.knobs.boolean(label: 'Show shadow', initialValue: true);
    final customDecoration = context.knobs.boolean(label: 'Custom decoration');
    context.knobSection('Layout');
    final position = context.knobs.object.dropdown(
      label: 'Position',
      options: DievasPopoverPosition.values,
      initialOption: DievasPopoverPosition.top,
      labelBuilder: (v) => v.name,
    );
    final distance = context.knobs.object.dropdown(
      label: 'Distance to target',
      options: _Spacing.values,
      initialOption: _Spacing.sm,
      labelBuilder: (v) => v.name,
    );
    final padding = context.knobs.object.dropdown(
      label: 'Content padding',
      options: _Spacing.values,
      initialOption: _Spacing.smPlus,
      labelBuilder: (v) => v.name,
    );
    final width = context.knobs.object.dropdown(
      label: 'Maximum width',
      options: _Width.values,
      initialOption: _Width.wide,
      labelBuilder: (v) => v.name,
    );
    final rtl = context.knobs.boolean(label: 'Right to left');
    context.knobSection('Interaction');
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
    final animated = context.knobs.boolean(label: 'Animate', initialValue: true);
    final dismissOutside = context.knobs.boolean(label: 'Dismiss on outside tap', initialValue: true);
    final theme = DievasTheme.of(context);
    final resolvedRadius = switch (radius) {
      .none => theme.border.none,
      .sm => theme.border.sm,
      .md => theme.border.md,
      .lg => theme.border.lg,
      .xl => theme.border.xl,
      .r32 => theme.border.r32,
    };

    return Directionality(
      textDirection: rtl ? .rtl : .ltr,
      child: Align(
        alignment: widget.example == 'Edge placement' ? .topRight : .center,
        child: ComponentBoundary(
          child: DievasPopover(
            show: widget.session.open,
            enabled: enabled,
            onOpenChanged: (open) => setState(() => widget.session.open = open),
            dismissOnTapOutside: dismissOutside,
            position: position,
            distanceToTarget: distance.resolve(theme.spacing),
            contentPadding: .all(padding.resolve(theme.spacing)),
            maxWidth: switch (width) {
              .compact => theme.sizing.width160,
              .regular => theme.sizing.width192,
              .wide => theme.sizing.width256,
            },
            backgroundColour: overrideBackground ? background : null,
            textColour: overrideText ? text : null,
            iconColour: overrideIcon ? icon : null,
            borderColour: overrideBorder ? border : null,
            borderWidth: overrideBorder ? theme.border.strokeThin : null,
            borderRadius: overrideRadius ? resolvedRadius : null,
            shadow: shadow ? null : const [],
            decoration: switch (customDecoration) {
              true => BoxDecoration(
                color: background,
                borderRadius: resolvedRadius,
                border: .all(color: border),
              ),
              _ => null,
            },
            transitionDuration: animated ? null : Duration.zero,
            semanticLabel: 'Popover information',
            trigger: DievasFilledButton(
              label: 'Tap me',
              onPressed: enabled ? () => setState(() => widget.session.open = !widget.session.open) : null,
            ),
            content: _PopoverContent(
              label: label,
              longContent: widget.example == 'Long content',
              close: () => setState(() => widget.session.open = false),
            ),
          ),
        ),
      ),
    );
  }
}

class _PopoverContent extends StatelessWidget {
  const _PopoverContent({required this.label, required this.longContent, required this.close});

  final String label;
  final bool longContent;
  final VoidCallback close;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: theme.sizing.width192),
      child: Column(
        mainAxisSize: .min,
        children: [
          Row(
            children: [
              DievasAvatar(
                backgroundColour: theme.colours.background.menuHoveredBackground,
                content: const Icon(Icons.rocket_launch_outlined),
              ),
              SizedBox(width: theme.spacing.smPlus),
              Expanded(child: Text(label)),
            ],
          ),
          if (longContent) ...[
            for (int i = 0; i < 16; i++)
              Padding(
                padding: .only(top: theme.spacing.sm),
                child: Text('Additional information ${i + 1}'),
              ),
          ],
          SizedBox(height: theme.spacing.md),
          SizedBox(
            width: .infinity,
            child: DievasFilledButton(label: 'Close', size: .sm, isFullWidth: true, onPressed: close),
          ),
        ],
      ),
    );
  }
}
