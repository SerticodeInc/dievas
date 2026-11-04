import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';
import '../../widgets/component_boundary.dart';

final _sessions = Expando<Map<String, _SwitchSession>>();
final switchComponent = WidgetbookComponent(
  name: 'Switch',
  useCases: [
    for (final name in ['Playground', 'All States', 'With Labels'])
      WidgetbookUseCase(
        name: name,
        builder: (context) => _Playground(
          example: name,
          session: (_sessions[WidgetbookState.of(context)] ??= {}).putIfAbsent(name, () => _SwitchSession(name)),
        ),
      ),
  ],
);

class _SwitchSession {
  _SwitchSession(String example)
    : values = example == 'All States' ? [false, true, false, true, false, false] : [false, false, false, true];
  final List<bool> values;
}

enum _Motion { standard, instant, slow }

class _Playground extends StatefulWidget {
  const _Playground({required this.example, required this.session});
  final String example;
  final _SwitchSession session;

  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  @override
  Widget build(BuildContext context) {
    context.knobSection('Size');
    final size = context.knobs.object.dropdown(
      label: 'Switch size',
      options: DievasSwitchSize.values,
      initialOption: DievasSwitchSize.xs,
      labelBuilder: (value) => value.name,
    );
    context.knobSection('Colours');
    final overrideThumb = context.knobs.boolean(label: 'Override thumb colour');
    final thumb = context.tokenColourKnob(label: 'Thumb colour', role: .background, initialValue: .page);
    final overrideActive = context.knobs.boolean(label: 'Override active track colour');
    final active = context.tokenColourKnob(label: 'Active track colour', role: .background, initialValue: .brand);
    final overrideInactive = context.knobs.boolean(label: 'Override inactive track colour');
    final inactive = context.tokenColourKnob(label: 'Inactive track colour', role: .background, initialValue: .track);
    context.knobSection('Content');
    final thumbContent = context.knobs.boolean(label: 'Thumb icons', initialValue: true);
    final trackContent = context.knobs.boolean(label: 'Track content', initialValue: true);
    context.knobSection('Interaction');
    final disabled = context.knobs.boolean(label: 'Disabled');
    final haptics = context.knobs.boolean(label: 'Haptic feedback', initialValue: true);
    final rtl = context.knobs.boolean(label: 'Right to left');
    final motion = context.knobs.object.dropdown(
      label: 'Motion',
      options: _Motion.values,
      initialOption: _Motion.standard,
      labelBuilder: (value) => value.name,
    );
    return Directionality(
      textDirection: rtl ? .rtl : .ltr,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: context.spacing.xl3, horizontal: context.spacing.md),
          child: Column(
            mainAxisSize: .min,
            children: [
              const _SectionTitle(label: 'DievasSwitch'),
              for (int index = 0; index < (widget.example == 'All States' ? 4 : 1); index++)
                Padding(
                  padding: EdgeInsets.only(bottom: widget.example == 'All States' ? context.spacing.md : 0),
                  child: ComponentBoundary(
                    child: DievasSwitch(
                      key: ValueKey('plain-$index'),
                      value: widget.session.values.elementAt(index),
                      onChanged: switch ((disabled, widget.example, index)) {
                        (true, _, _) || (_, 'All States', >= 2) => null,
                        _ => (value) => setState(() => widget.session.values[index] = value),
                      },
                      label: widget.example == 'With Labels' ? 'Notifications' : null,
                      semanticLabel: 'Notifications',
                      switchSize: size,
                      thumbColour: overrideThumb ? thumb : null,
                      activeTrackColour: overrideActive ? active : null,
                      inactiveTrackColour: overrideInactive ? inactive : null,
                      hasHapticFeedback: haptics,
                      duration: switch (motion) {
                        .standard => null,
                        .instant => Duration.zero,
                        .slow => const Duration(milliseconds: 600),
                      },
                    ),
                  ),
                ),
              SizedBox(height: context.spacing.xl),
              const _SectionTitle(label: 'Custom DievasSwitch'),
              for (int index = 1; index <= 2; index++)
                Padding(
                  padding: EdgeInsets.only(bottom: index == 1 ? context.spacing.xl : 0),
                  child: ComponentBoundary(
                    child: DievasSwitch(
                      key: ValueKey('custom-$index'),
                      value: widget.session.values.elementAt(widget.example == 'All States' ? index + 3 : index),
                      onChanged: switch (disabled) {
                        true => null,
                        false => (value) => setState(() {
                          widget.session.values[widget.example == 'All States' ? index + 3 : index] = value;
                        }),
                      },
                      semanticLabel: index == 1 ? 'Custom toggle' : 'Dark mode',
                      switchSize: size,
                      thumbColour: overrideThumb ? thumb : null,
                      activeTrackColour: overrideActive ? active : null,
                      inactiveTrackColour: overrideInactive ? inactive : null,
                      hasHapticFeedback: haptics,
                      duration: switch (motion) {
                        .standard => null,
                        .instant => Duration.zero,
                        .slow => const Duration(milliseconds: 600),
                      },
                      activeThumbWidget: thumbContent && index == 1 ? const Icon(Icons.check) : null,
                      inactiveThumbWidget: thumbContent && index == 1 ? const Icon(Icons.close) : null,
                      activeTrackWidget: switch ((trackContent, index)) {
                        (true, 1) => const Text('ON'),
                        (true, _) => const Icon(Icons.dark_mode_outlined),
                        _ => null,
                      },
                      inactiveTrackWidget: switch ((trackContent, index)) {
                        (true, 1) => const Text('OFF'),
                        (true, _) => const Icon(Icons.light_mode_outlined),
                        _ => null,
                      },
                    ),
                  ),
                ),
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
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: context.spacing.xl),
    child: Row(
      children: [
        const Expanded(child: DievasDivider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
          child: Text(label, style: context.typography.bodyXs.copyWith(color: context.colours.text.textSecondary)),
        ),
        const Expanded(child: DievasDivider()),
      ],
    ),
  );
}
