import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final textAreaComponent = WidgetbookComponent(
  name: 'TextArea',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: _playground),
    WidgetbookUseCase(name: 'All States', builder: _allStates),
  ],
);

Widget _playground(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Bio');
  final hint = context.knobs.string(label: 'Hint', initialValue: 'Tell us about yourself...');
  final helperText = context.knobs.string(label: 'Helper', initialValue: 'Max 300 characters.');
  final errorText = context.knobs.string(label: 'Error', initialValue: '');

  final minLines = context.knobs.double.slider(
    label: 'Min Lines',
    initialValue: 3,
    min: 1,
    max: 8,
  ).round();

  final maxLines = context.knobs.double.slider(
    label: 'Max Lines',
    initialValue: 6,
    min: 2,
    max: 12,
  ).round();

  final disabled = context.knobs.boolean(label: 'Disabled');

  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ComponentBoundary(
        child: DievasTextArea(
          label: label.isEmpty ? null : label,
          hint: hint.isEmpty ? null : hint,
          helperText: helperText.isEmpty ? null : helperText,
          errorText: errorText.isEmpty ? null : errorText,
          minLines: minLines.clamp(1, maxLines),
          maxLines: maxLines,
          enabled: !disabled,
        ),
      ),
    ),
  );
}

Widget _allStates(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _stateBlock('Default', child: const DievasTextArea(hint: 'Start typing...')),
        const SizedBox(height: 20),
        _stateBlock(
          'With Label + Helper',
          child: const DievasTextArea(
            label: 'Cover letter',
            hint: 'Why do you want to work here?',
            helperText: 'Be concise — 300 words max.',
            minLines: 4,
          ),
        ),
        const SizedBox(height: 20),
        _stateBlock(
          'Error',
          child: const DievasTextArea(
            label: 'Bio',
            hint: 'Tell us about yourself...',
            errorText: 'Bio cannot be empty.',
          ),
        ),
        const SizedBox(height: 20),
        _stateBlock(
          'Disabled',
          child: const DievasTextArea(
            label: 'Notes',
            hint: 'No notes available.',
            enabled: false,
          ),
        ),
      ],
    ),
  ),
);

Widget _stateBlock(String name, {required Widget child}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
  children: [
    Text(name, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
    const SizedBox(height: 8),
    ComponentBoundary(child: child),
  ],
);
