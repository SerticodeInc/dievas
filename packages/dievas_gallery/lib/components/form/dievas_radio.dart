import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';
import '../../widgets/component_boundary.dart';

final _sessions = Expando<Map<String, _RadioSession>>();
final radioComponent = WidgetbookComponent(
  name: 'Radio',
  useCases: [
    for (final name in ['Playground', 'Group', 'All States'])
      WidgetbookUseCase(
        name: name,
        builder: (context) => _Playground(
          example: name,
          session: (_sessions[WidgetbookState.of(context)] ??= {}).putIfAbsent(name, _RadioSession.new),
        ),
      ),
  ],
);

enum _Choice { first, second }

enum _TapArea {
  none,
  compact,
  regular,
  large;

  double resolve(DievasSizingThemeData sizing) => switch (this) {
    .none => 0,
    .compact => sizing.height32,
    .regular => sizing.height40,
    .large => sizing.height48,
  };
}

class _RadioSession {
  _Choice? plain = .first;
  _Choice? labelled = .first;
}

typedef _Appearance = ({Color? active, Color? inactive, bool toggleable, bool disabled, double tapArea});

class _Playground extends StatefulWidget {
  const _Playground({required this.example, required this.session});
  final String example;
  final _RadioSession session;

  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  @override
  Widget build(BuildContext context) {
    context.knobSection('Colours');
    final overrideActive = context.knobs.boolean(label: 'Override active colour');
    final active = context.tokenColourKnob(label: 'Active colour', role: .border, initialValue: .brand);
    final overrideInactive = context.knobs.boolean(label: 'Override inactive colour');
    final inactive = context.tokenColourKnob(label: 'Inactive colour', role: .border, initialValue: .brand);
    context.knobSection('Interaction');
    final toggleable = context.knobs.boolean(label: 'Toggleable');
    final disabled = context.knobs.boolean(label: 'Disabled');
    context.knobSection('Layout');
    final rtl = context.knobs.boolean(label: 'Right to left');
    final tapArea = context.knobs.object.dropdown(
      label: 'Tap area',
      options: _TapArea.values,
      initialOption: _TapArea.regular,
      labelBuilder: (value) => value.name,
    );
    final theme = DievasTheme.of(context);
    final appearance = (
      active: overrideActive ? active : null,
      inactive: overrideInactive ? inactive : null,
      toggleable: toggleable,
      disabled: disabled,
      tapArea: tapArea.resolve(theme.sizing),
    );
    return Directionality(
      textDirection: rtl ? .rtl : .ltr,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: theme.spacing.xl3, horizontal: theme.spacing.md),
          child: Column(
            mainAxisSize: .min,
            children: [
              const _SectionTitle(label: 'DievasRadio'),
              for (final choice in _Choice.values)
                ComponentBoundary(
                  child: DievasRadio<_Choice>(
                    key: ValueKey('plain-${choice.name}'),
                    value: choice,
                    groupValue: widget.session.plain,
                    onChanged: disabled ? null : (value) => setState(() => widget.session.plain = value),
                    toggleable: toggleable,
                    activeColour: appearance.active,
                    inactiveColour: appearance.inactive,
                    tapAreaSize: appearance.tapArea,
                    semanticLabel: 'Radio ${choice.name}',
                  ),
                ),
              SizedBox(height: theme.spacing.xl3),
              const _SectionTitle(label: 'DievasRadio with label'),
              _LabelledGroup(
                selected: widget.session.labelled,
                appearance: appearance,
                onChanged: (value) => setState(() => widget.session.labelled = value),
              ),
              if (widget.example == 'Group') ...[
                SizedBox(height: theme.spacing.lg),
                DievasRadio<_Choice>(
                  value: .first,
                  groupValue: widget.session.labelled,
                  label: 'Label convenience',
                  toggleable: toggleable,
                  onChanged: disabled ? null : (value) => setState(() => widget.session.labelled = value),
                ),
              ],
              if (widget.example == 'All States') ...[
                SizedBox(height: theme.spacing.xl3),
                const _SectionTitle(label: 'Disabled states'),
                const DievasRadio<bool>(value: true, groupValue: true, onChanged: null, label: 'Selected'),
                const DievasRadio<bool>(value: true, groupValue: false, onChanged: null, label: 'Unselected'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LabelledGroup extends StatelessWidget {
  const _LabelledGroup({required this.selected, required this.appearance, required this.onChanged});
  final _Choice? selected;
  final _Appearance appearance;
  final ValueChanged<_Choice?> onChanged;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    children: [
      for (final choice in _Choice.values)
        Semantics(
          checked: selected == choice,
          inMutuallyExclusiveGroup: true,
          child: DievasMenuItem(
            key: ValueKey('labelled-${choice.name}'),
            label: 'With label #${choice.index + 1}',
            enabled: !appearance.disabled,
            absorbGestures: true,
            onTap: switch ((appearance.disabled, appearance.toggleable, selected == choice)) {
              (true, _, _) => null,
              (false, false, true) => () {},
              (false, true, true) => () => onChanged(null),
              (false, _, false) => () => onChanged(choice),
            },
            trailing: ExcludeSemantics(
              child: ExcludeFocus(
                child: DievasRadio<_Choice>(
                  value: choice,
                  groupValue: selected,
                  toggleable: appearance.toggleable,
                  activeColour: appearance.active,
                  inactiveColour: appearance.inactive,
                  tapAreaSize: 0,
                  onChanged: appearance.disabled ? null : (_) {},
                ),
              ),
            ),
          ),
        ),
    ],
  );
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
          child: Text(label, style: context.typography.bodySm.copyWith(color: context.colours.text.textSecondary)),
        ),
        const Expanded(child: DievasDivider()),
      ],
    ),
  );
}
