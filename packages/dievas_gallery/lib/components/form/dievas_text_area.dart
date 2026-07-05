import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final textAreaComponent = WidgetbookComponent(
  name: 'TextArea',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All States', builder: (ctx) => _AllStates()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final label = context.knobs.string(label: 'Label', initialValue: 'Bio');
    final hint = context.knobs.string(label: 'Hint', initialValue: 'Tell us about yourself...');
    final helperText = context.knobs.string(label: 'Helper', initialValue: 'Max 300 characters.');
    final errorText = context.knobs.string(label: 'Error', initialValue: '');

    final minLines = context.knobs.double.slider(label: 'Min Lines', initialValue: 3, min: 1, max: 8).round();
    final maxLines = context.knobs.double.slider(label: 'Max Lines', initialValue: 6, min: 2, max: 12).round();
    final disabled = context.knobs.boolean(label: 'Disabled');

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
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
}

class _AllStates extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xl, vertical: context.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StateBlock('Default', child: const DievasTextArea(hint: 'Start typing...')),
          SizedBox(height: context.spacing.mdPlus),
          _StateBlock(
            'With Label + Helper',
            child: const DievasTextArea(
              label: 'Cover letter',
              hint: 'Why do you want to work here?',
              helperText: 'Be concise — 300 words max.',
              minLines: 4,
            ),
          ),
          SizedBox(height: context.spacing.mdPlus),
          _StateBlock(
            'Error',
            child: const DievasTextArea(
              label: 'Bio',
              hint: 'Tell us about yourself...',
              errorText: 'Bio cannot be empty.',
            ),
          ),
          SizedBox(height: context.spacing.mdPlus),
          _StateBlock(
            'Disabled',
            child: const DievasTextArea(label: 'Notes', hint: 'No notes available.', enabled: false),
          ),
        ],
      ),
    ),
  );
}

class _StateBlock extends StatelessWidget {
  const _StateBlock(this.name, {required this.child});
  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(name, style: context.typography.labelXs.copyWith(color: context.colours.text.textTertiary)),
      SizedBox(height: context.spacing.sm),
      ComponentBoundary(child: child),
    ],
  );
}
