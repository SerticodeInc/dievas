import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';
import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';

final authCodeComponent = WidgetbookComponent(
  name: 'AuthCode',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => const _Playground()),
    WidgetbookUseCase(name: 'Configurations', builder: (ctx) => const _Configurations()),
  ],
);

class _Playground extends StatelessWidget {
  const _Playground();

  @override
  Widget build(BuildContext context) {
    context.knobSection('Layout');
    final codeLength = context.knobs.object.dropdown<int>(
      label: 'Code length',
      options: const [4, 5, 6, 7],
      labelBuilder: (value) => '$value digits',
    );
    final alignment = context.knobs.object.dropdown(
      label: 'Main axis alignment',
      options: MainAxisAlignment.values,
      initialOption: MainAxisAlignment.center,
      labelBuilder: (value) => value.name,
    );
    final shape = context.knobs.object.dropdown(
      label: 'Shape',
      options: DievasAuthCodeShape.values,
      labelBuilder: (value) => value.name,
    );
    final overrideRadius = context.knobs.boolean(label: 'Override border radius');
    final radius = context.knobs.double.slider(label: 'Border radius', initialValue: 8, min: 0, max: 32);
    final overrideGap = context.knobs.boolean(label: 'Override gap');
    final gap = context.knobs.double.slider(label: 'Gap', initialValue: 8, min: 0, max: 32);
    context.knobSection('Behaviour');
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
    final obscureText = context.knobs.boolean(label: 'Obscure text');
    final peek = context.knobs.boolean(label: 'Peek when obscuring');
    final hasError = context.knobs.boolean(label: 'Has error');
    final shake = context.knobs.boolean(label: 'Error shake animation');
    context.knobSection('Text and cursor');
    final overrideTextColour = context.knobs.boolean(label: 'Override text colour');
    final textColour = context.tokenColourKnob(label: 'Text colour', role: .text);
    final overrideCursorColour = context.knobs.boolean(label: 'Override cursor colour');
    final cursorColour = context.tokenColourKnob(label: 'Cursor colour', role: .text);
    context.knobSection('Selected field');
    final overrideSelectedFillColour = context.knobs.boolean(label: 'Override selected fill colour');
    final selectedFillColour = context.tokenColourKnob(label: 'Selected fill colour', role: .background);
    final overrideSelectedBorderColour = context.knobs.boolean(label: 'Override selected border colour');
    final selectedBorderColour = context.tokenColourKnob(label: 'Selected border colour', role: .border);
    context.knobSection('Active (filled) field');
    final overrideActiveFillColour = context.knobs.boolean(label: 'Override active fill colour');
    final activeFillColour = context.tokenColourKnob(label: 'Active fill colour', role: .background);
    final overrideActiveBorderColour = context.knobs.boolean(label: 'Override active border colour');
    final activeBorderColour = context.tokenColourKnob(label: 'Active border colour', role: .border);
    context.knobSection('Inactive field');
    final overrideInactiveFillColour = context.knobs.boolean(label: 'Override inactive fill colour');
    final inactiveFillColour = context.tokenColourKnob(label: 'Inactive fill colour', role: .background);
    final overrideInactiveBorderColour = context.knobs.boolean(label: 'Override inactive border colour');
    final inactiveBorderColour = context.tokenColourKnob(label: 'Inactive border colour', role: .border);
    context.knobSection('Error field');
    final overrideErrorBorderColour = context.knobs.boolean(label: 'Override error border colour');
    final errorBorderColour = context.tokenColourKnob(label: 'Error border colour', role: .border);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: .min,
        children: [
          _DemoBlock(
            'Interactive AuthCode',
            child: DievasAuthCode(
              codeLength: codeLength,
              onCompleted: (_) {},
              autofocus: false,
              enabled: enabled,
              obscureText: obscureText,
              peekWhenObscuring: peek,
              hasError: hasError,
              errorShakeAnimation: shake,
              mainAxisAlignment: alignment,
              shape: shape,
              borderRadius: overrideRadius ? .circular(radius) : null,
              gap: overrideGap ? gap : null,
              textColour: overrideTextColour ? textColour : null,
              cursorColour: overrideCursorColour ? cursorColour : null,
              selectedFillColour: overrideSelectedFillColour ? selectedFillColour : null,
              selectedBorderColour: overrideSelectedBorderColour ? selectedBorderColour : null,
              activeFillColour: overrideActiveFillColour ? activeFillColour : null,
              activeBorderColour: overrideActiveBorderColour ? activeBorderColour : null,
              inactiveFillColour: overrideInactiveFillColour ? inactiveFillColour : null,
              inactiveBorderColour: overrideInactiveBorderColour ? inactiveBorderColour : null,
              errorBorderColour: overrideErrorBorderColour ? errorBorderColour : null,
            ),
          ),
          SizedBox(height: context.spacing.xl),
          _DemoBlock(
            'Disabled AuthCode',
            child: DievasAuthCode(codeLength: 4, enabled: false, autofocus: false, onCompleted: (_) {}),
          ),
          SizedBox(height: context.spacing.xl),
          _DemoBlock('Active AuthCode', child: DievasAuthCode(codeLength: 6, autofocus: false, onCompleted: (_) {})),
          SizedBox(height: context.spacing.xl),
          _DemoBlock('Error AuthCode', child: _ErrorExample(shake: shake)),
        ],
      ),
    );
  }
}

class _Configurations extends StatelessWidget {
  const _Configurations();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
      mainAxisSize: .min,
      children: [
        _DemoBlock('4-digit — plain', child: DievasAuthCode(codeLength: 4, autofocus: false, onCompleted: (_) {})),
        SizedBox(height: context.spacing.lg),
        _DemoBlock('6-digit — plain', child: DievasAuthCode(codeLength: 6, autofocus: false, onCompleted: (_) {})),
        SizedBox(height: context.spacing.lg),
        _DemoBlock(
          '6-digit — obscured',
          child: DievasAuthCode(codeLength: 6, obscureText: true, autofocus: false, onCompleted: (_) {}),
        ),
        SizedBox(height: context.spacing.lg),
        _DemoBlock(
          '4-digit — disabled',
          child: DievasAuthCode(codeLength: 4, enabled: false, autofocus: false, onCompleted: (_) {}),
        ),
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

class _ErrorExample extends StatefulWidget {
  const _ErrorExample({required this.shake});

  final bool shake;

  @override
  State<_ErrorExample> createState() => _ErrorExampleState();
}

class _ErrorExampleState extends State<_ErrorExample> {
  bool _hasError = true;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    children: [
      DievasAuthCode(
        codeLength: 4,
        hasError: _hasError,
        errorShakeAnimation: widget.shake,
        autofocus: false,
        onCompleted: (_) {},
      ),
      TextButton(onPressed: widget.shake ? _replay : null, child: const Text('Replay error shake')),
    ],
  );

  void _replay() {
    setState(() => _hasError = false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _hasError = true);
    });
  }
}
