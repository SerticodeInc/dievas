import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';
import '../../widgets/component_boundary.dart';

final alertComponent = WidgetbookComponent(
  name: 'Alert',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Tones', builder: (ctx) => _AllTones()),
    WidgetbookUseCase(name: 'With Dismiss', builder: (ctx) => _WithDismiss()),
    WidgetbookUseCase(name: 'No Description', builder: (ctx) => _NoDescription()),
  ],
);

class _Playground extends StatefulWidget {
  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  final Set<int> _dismissed = {};

  @override
  Widget build(BuildContext context) {
    context.knobSection('Presentation');
    final allVariants = context.knobs.boolean(label: 'Show all variants', initialValue: true);
    final variant = context.knobs.object.dropdown<DievasAlertVariant>(
      label: 'Variant',
      options: DievasAlertVariant.values,
      initialOption: .filled,
      labelBuilder: (value) => value.name,
    );
    final tone = context.knobs.object.dropdown<DievasAlertTone>(
      label: 'Tone',
      options: DievasAlertTone.values,
      initialOption: .info,
      labelBuilder: (value) => value.name,
    );

    context.knobSection('Label');
    final title = context.knobs.string(label: 'Title', initialValue: 'Heads up');
    final labelOverride = context.knobs.boolean(label: 'Override label colour');
    final labelColour = context.tokenColourKnob(label: 'Label colour', role: .text);

    context.knobSection('Leading');
    final showLeading = context.knobs.boolean(label: 'Show leading', initialValue: false);
    final customLeading = context.knobs.boolean(label: 'Use custom leading');
    final leadingOverride = context.knobs.boolean(label: 'Override leading colour');
    final leadingColour = context.tokenColourKnob(label: 'Leading colour', role: .icon);

    context.knobSection('Content');
    final showContent = context.knobs.boolean(label: 'Show content', initialValue: false);
    final description = context.knobs.string(
      label: 'Description',
      initialValue: 'Something worth your attention has just happened.',
    );
    final customContent = context.knobs.boolean(label: 'Use custom content');
    final contentOverride = context.knobs.boolean(label: 'Override content colour');
    final contentColour = context.tokenColourKnob(label: 'Content colour', role: .text);

    context.knobSection('Trailing action');
    final showTrailing = context.knobs.boolean(label: 'Show trailing', initialValue: true);
    final customTrailing = context.knobs.boolean(label: 'Use custom trailing');
    final disabled = context.knobs.boolean(label: 'Disabled', initialValue: false);
    final trailingOverride = context.knobs.boolean(label: 'Override trailing colour');
    final trailingColour = context.tokenColourKnob(label: 'Trailing colour', role: .icon);

    context.knobSection('Background');
    final backgroundOverride = context.knobs.boolean(label: 'Override background colour');
    final backgroundColour = context.tokenColourKnob(label: 'Background colour', role: .background);

    context.knobSection('Border');
    final showBorder = context.knobs.boolean(label: 'Show border', initialValue: true);
    final borderVisibilityOverride = context.knobs.boolean(label: 'Override variant border');
    final borderOverride = context.knobs.boolean(label: 'Override border colour');
    final borderColour = context.tokenColourKnob(label: 'Border colour', role: .border);
    final radiusOverride = context.knobs.boolean(label: 'Override border radius');
    final radius = context.knobs.double.slider(
      label: 'Border radius',
      initialValue: context.components.alert.borderRadius.topLeft.x,
      min: 0,
      max: 64,
    );

    final examples = allVariants
        ? <(DievasAlertVariant, DievasAlertTone, String)>[
            (.base, .info, 'Base DievasAlert'),
            (.filled, .error, 'Filled error DievasAlert'),
            (.filled, .warning, 'Filled warning DievasAlert'),
            (.outlined, .success, 'Outlined success DievasAlert'),
            (.outlined, .info, 'Outlined info DievasAlert'),
          ]
        : [(variant, tone, title)];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          for (final (index, (exampleVariant, exampleTone, exampleTitle)) in examples.indexed) ...[
            ...switch ((allVariants, index)) {
              (true, 0) => [const _ExampleHeading(title: 'Base alert')],
              (true, 1) => [const _ExampleHeading(title: 'Filled alerts')],
              (true, 3) => [const _ExampleHeading(title: 'Outlined alerts')],
              _ => <Widget>[],
            },
            AnimatedSize(
              duration: context.animation.standard,
              child: switch (_dismissed.contains(index)) {
                true => const SizedBox.shrink(),
                false => ComponentBoundary(
                  child: DievasAlert(
                    variant: exampleVariant,
                    tone: exampleTone,
                    title: exampleTitle,
                    showLeading: showLeading,
                    leading: customLeading ? const Icon(Icons.star_outline) : null,
                    description: showContent ? description : null,
                    content: showContent && customContent
                        ? const Wrap(
                            spacing: 8,
                            children: [Text('Review your settings.'), Icon(Icons.settings_outlined)],
                          )
                        : null,
                    showTrailing: showTrailing && (!allVariants || index != 0),
                    trailing: customTrailing ? const Icon(Icons.arrow_forward) : null,
                    trailingSemanticLabel: customTrailing ? 'Hide alert' : null,
                    onDismiss: () => setState(() => _dismissed.add(index)),
                    disabled: disabled,
                    showBorder: borderVisibilityOverride ? showBorder : null,
                    borderRadius: radiusOverride ? BorderRadius.circular(radius) : null,
                    leadingColour: leadingOverride ? leadingColour : null,
                    labelColour: labelOverride ? labelColour : null,
                    trailingColour: trailingOverride ? trailingColour : null,
                    contentColour: contentOverride ? contentColour : null,
                    backgroundColour: backgroundOverride ? backgroundColour : null,
                    borderColour: borderOverride ? borderColour : null,
                  ),
                ),
              },
            ),
            SizedBox(height: context.spacing.md),
            ...switch ((allVariants, index)) {
              (true, 0) => [
                Center(
                  child: TextButton(
                    onPressed: () => setState(() => _dismissed.contains(0) ? _dismissed.remove(0) : _dismissed.add(0)),
                    child: const Text('Show/Hide alert'),
                  ),
                ),
              ],
              _ => <Widget>[],
            },
          ],
          ...switch (_dismissed.isNotEmpty) {
            true => [TextButton(onPressed: () => setState(_dismissed.clear), child: const Text('Restore alerts'))],
            false => <Widget>[],
          },
        ],
      ),
    );
  }
}

class _ExampleHeading extends StatelessWidget {
  const _ExampleHeading({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: context.spacing.lg),
    child: Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
          child: Text(title, style: context.typography.labelSm.copyWith(color: context.colours.text.textSecondary)),
        ),
        const Expanded(child: Divider()),
      ],
    ),
  );
}

class _AllTones extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
      children: [
        for (final tone in DievasAlertTone.values) ...[
          ComponentBoundary(
            child: DievasAlert(
              tone: tone,
              title: '${tone.name[0].toUpperCase()}${tone.name.substring(1)} alert',
              description: 'This is a ${tone.name} tone alert with a supporting description.',
            ),
          ),
          SizedBox(height: context.spacing.smPlus),
        ],
      ],
    ),
  );
}

class _WithDismiss extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: ComponentBoundary(
      child: DievasAlert(
        tone: .warning,
        title: 'Action required',
        description: 'You have unsaved changes. Dismiss to discard them.',
        onDismiss: () {},
      ),
    ),
  );
}

class _NoDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
      children: [
        for (final tone in DievasAlertTone.values) ...[
          ComponentBoundary(
            child: DievasAlert(tone: tone, title: '${tone.name[0].toUpperCase()}${tone.name.substring(1)}'),
          ),
          SizedBox(height: context.spacing.smPlus),
        ],
      ],
    ),
  );
}
