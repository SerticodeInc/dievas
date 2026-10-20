import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';
import '../../widgets/component_boundary.dart';

final checkboxComponent = WidgetbookComponent(
  name: 'Checkbox',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (context) => const _Playground()),
    WidgetbookUseCase(name: 'All States', builder: (context) => const _Examples()),
    WidgetbookUseCase(name: 'With Labels', builder: (context) => const _Examples(labels: true)),
  ],
);

class _Playground extends StatefulWidget {
  const _Playground();

  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  DievasCheckboxValue _value = .unchecked;
  DievasCheckboxValue _labelValue = .unchecked;

  @override
  Widget build(BuildContext context) {
    context.knobSection('Colours');
    final overrideCheck = context.knobs.boolean(label: 'Override check colour');
    final check = context.tokenColourKnob(label: 'Check colour', role: .text);
    final overrideActive = context.knobs.boolean(label: 'Override active colour');
    final active = context.tokenColourKnob(label: 'Active colour', role: .background);
    final overrideInactive = context.knobs.boolean(label: 'Override inactive colour');
    final inactive = context.tokenColourKnob(label: 'Inactive colour', role: .background);
    final overrideBorder = context.knobs.boolean(label: 'Override border colour');
    final border = context.tokenColourKnob(label: 'Border colour', role: .border);
    context.knobSection('Interaction');
    final tristate = context.knobs.boolean(label: 'Tristate');
    final disabled = context.knobs.boolean(label: 'Disabled');
    context.knobSection('Label and layout');
    final label = context.knobs.string(label: 'Label text', initialValue: 'With label');
    final rtl = context.knobs.boolean(label: 'Right to left');
    final overrideTapSize = context.knobs.boolean(label: 'Override tap area');
    final tapSize = context.knobs.double.slider(label: 'Tap area size', initialValue: 40, min: 24, max: 64);

    return Center(
      child: SingleChildScrollView(
        child: Directionality(
          textDirection: rtl ? .rtl : .ltr,
          child: Column(
            mainAxisSize: .min,
            children: [
              const _SectionTitle(label: 'Checkbox'),
              ComponentBoundary(
                child: DievasCheckbox(
                  value: _value,
                  onChanged: disabled ? null : (value) => setState(() => _value = value),
                  tristate: tristate,
                  checkColour: overrideCheck ? check : null,
                  activeColour: overrideActive ? active : null,
                  inactiveColour: overrideInactive ? inactive : null,
                  borderColour: overrideBorder ? border : null,
                  tapAreaSize: overrideTapSize ? tapSize : null,
                  semanticLabel: 'Standalone checkbox',
                ),
              ),
              const _SectionTitle(label: 'Checkbox with label'),
              ComponentBoundary(
                child: DievasCheckbox(
                  value: _labelValue,
                  label: label,
                  labelPosition: .start,
                  isFullWidth: true,
                  onChanged: disabled ? null : (value) => setState(() => _labelValue = value),
                  tristate: tristate,
                  checkColour: overrideCheck ? check : null,
                  activeColour: overrideActive ? active : null,
                  inactiveColour: overrideInactive ? inactive : null,
                  borderColour: overrideBorder ? border : null,
                  tapAreaSize: overrideTapSize ? tapSize : null,
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
    padding: EdgeInsets.symmetric(vertical: context.spacing.xl),
    child: Row(
      children: [
        const Expanded(child: DievasDivider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
          child: Text(label, style: context.typography.labelXs.copyWith(color: context.colours.text.textSecondary)),
        ),
        const Expanded(child: DievasDivider()),
      ],
    ),
  );
}

class _Examples extends StatelessWidget {
  const _Examples({this.labels = false});

  final bool labels;

  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: .min,
        children: [
          for (final value in DievasCheckboxValue.values)
            for (final disabled in [false, true]) _Example(initialValue: value, disabled: disabled, labelled: labels),
        ],
      ),
    ),
  );
}

class _Example extends StatefulWidget {
  const _Example({required this.initialValue, required this.disabled, required this.labelled});

  final DievasCheckboxValue initialValue;
  final bool disabled;
  final bool labelled;

  @override
  State<_Example> createState() => _ExampleState();
}

class _ExampleState extends State<_Example> {
  late DievasCheckboxValue _value = widget.initialValue;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: context.spacing.sm),
    child: ComponentBoundary(
      child: DievasCheckbox(
        value: _value,
        tristate: true,
        label: widget.labelled ? '${widget.initialValue.name}${widget.disabled ? ' (disabled)' : ''}' : null,
        semanticLabel: widget.labelled ? null : '${widget.initialValue.name}${widget.disabled ? ' (disabled)' : ''}',
        onChanged: widget.disabled ? null : (value) => setState(() => _value = value),
      ),
    ),
  );
}
