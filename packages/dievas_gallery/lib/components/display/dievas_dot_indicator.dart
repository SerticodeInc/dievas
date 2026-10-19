import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';
import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';

final dotIndicatorComponent = WidgetbookComponent(
  name: 'DotIndicator',
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
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    context.knobSection('Colours');
    final overrideSelected = context.knobs.boolean(label: 'Override selected colour');
    final selected = context.tokenColourKnob(label: 'Selected colour', role: .background);
    final overrideUnselected = context.knobs.boolean(label: 'Override unselected colour');
    final unselected = context.tokenColourKnob(label: 'Unselected colour', role: .background);
    context.knobSection('Layout');
    final overrideSize = context.knobs.boolean(label: 'Override size');
    final size = context.knobs.double.slider(label: 'Size', initialValue: 8, min: 2, max: 32);
    final overrideGap = context.knobs.boolean(label: 'Override gap');
    final gap = context.knobs.double.slider(label: 'Gap', initialValue: 8, min: 0, max: 32);
    final count = context.knobs.double.slider(label: 'Count', initialValue: 4, min: 1, max: 8).round();
    context.knobSection('Interaction and motion');
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
    final tappable = context.knobs.boolean(label: 'Tap dots');
    final rtl = context.knobs.boolean(label: 'Right to left');
    final overrideDuration = context.knobs.boolean(label: 'Override transition duration');
    final duration = context.knobs.double.slider(
      label: 'Transition duration (ms)',
      initialValue: 200,
      min: 0,
      max: 1000,
    );
    final overrideCurve = context.knobs.boolean(label: 'Override transition curve');
    final curve = context.knobs.object.dropdown<Curve>(
      label: 'Transition curve',
      options: [Curves.easeInOutCubic, Curves.linear, Curves.easeOut],
      labelBuilder: (value) => value.toString(),
    );

    return Directionality(
      textDirection: rtl ? .rtl : .ltr,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: .min,
            children: [
              ComponentBoundary(
                child: DievasDotIndicator(
                  count: count,
                  activeIndex: _selected.clamp(0, count - 1),
                  enabled: enabled,
                  selectedColour: overrideSelected ? selected : null,
                  unselectedColour: overrideUnselected ? unselected : null,
                  size: overrideSize ? size : null,
                  gap: overrideGap ? gap : null,
                  transitionDuration: overrideDuration ? Duration(milliseconds: duration.round()) : null,
                  transitionCurve: overrideCurve ? curve : null,
                  onDotTap: tappable ? (index) => setState(() => _selected = index) : null,
                ),
              ),
              SizedBox(height: context.spacing.xl),
              Wrap(
                spacing: context.spacing.sm,
                runSpacing: context.spacing.sm,
                alignment: .center,
                children: [
                  for (int index = 0; index < count; index++)
                    DievasFilledButton(
                      label: '${index + 1}',
                      onPressed: enabled ? () => setState(() => _selected = index) : null,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Configurations extends StatelessWidget {
  const _Configurations();

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: .min,
      children: [
        const _DemoBlock('3 dots — first active', child: DievasDotIndicator(count: 3, activeIndex: 0)),
        SizedBox(height: context.spacing.md),
        const _DemoBlock('4 dots — middle active', child: DievasDotIndicator(count: 4, activeIndex: 1)),
        SizedBox(height: context.spacing.md),
        const _DemoBlock('5 dots — last active', child: DievasDotIndicator(count: 5, activeIndex: 4)),
        SizedBox(height: context.spacing.md),
        _DemoBlock('Disabled', child: DievasDotIndicator(count: 4, activeIndex: 1, enabled: false)),
      ],
    ),
  );
}

class _DemoBlock extends StatelessWidget {
  const _DemoBlock(this.name, {required this.child});
  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    mainAxisSize: .min,
    children: [
      Text(name, style: context.typography.labelXs.copyWith(color: context.colours.text.textTertiary)),
      SizedBox(height: context.spacing.sm),
      ComponentBoundary(child: child),
    ],
  );
}
