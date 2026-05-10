import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final textInputComponent = WidgetbookComponent(
  name: 'TextInput',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: _playground),
    WidgetbookUseCase(name: 'All Sizes', builder: _allSizes),
    WidgetbookUseCase(name: 'All States', builder: _allStates),
  ],
);

Widget _playground(BuildContext context) {
  final size = context.knobs.list<DievasTextInputSize>(
    label: 'Size',
    options: DievasTextInputSize.values,
    labelBuilder: (v) => v.name,
    initialOption: DievasTextInputSize.md,
  );

  final label = context.knobs.string(label: 'Label', initialValue: 'Email address');
  final hint = context.knobs.string(label: 'Hint', initialValue: 'you@example.com');
  final helperText = context.knobs.string(label: 'Helper', initialValue: "We'll never share your email.");
  final errorText = context.knobs.string(label: 'Error', initialValue: '');
  final showLeadingIcon = context.knobs.boolean(label: 'Leading Icon');
  final showTrailingIcon = context.knobs.boolean(label: 'Trailing Icon');
  final disabled = context.knobs.boolean(label: 'Disabled');

  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ComponentBoundary(
        child: DievasTextInput(
          size: size,
          label: label.isEmpty ? null : label,
          hint: hint.isEmpty ? null : hint,
          helperText: helperText.isEmpty ? null : helperText,
          errorText: errorText.isEmpty ? null : errorText,
          enabled: !disabled,
          leadingIcon: showLeadingIcon ? const Icon(Icons.email_outlined) : null,
          trailingIcon: showTrailingIcon ? const Icon(Icons.visibility_outlined) : null,
        ),
      ),
    ),
  );
}

Widget _allSizes(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final size in DievasTextInputSize.values) ...[
          Row(
            children: [
              SizedBox(
                width: 40,
                child: Text(size.name, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ComponentBoundary(
                  child: DievasTextInput(
                    size: size,
                    hint: 'Placeholder',
                  ),
                ),
              ),
            ],
          ),
          if (size != DievasTextInputSize.lg) const SizedBox(height: 16),
        ],
      ],
    ),
  ),
);

Widget _allStates(BuildContext context) => Center(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _stateBlock('Default', child: DievasTextInput(hint: 'Placeholder')),
        const SizedBox(height: 20),
        _stateBlock(
          'With Label + Helper',
          child: DievasTextInput(
            label: 'Full name',
            hint: 'John Appleseed',
            helperText: 'As it appears on your ID.',
          ),
        ),
        const SizedBox(height: 20),
        _stateBlock(
          'Error',
          child: DievasTextInput(
            label: 'Email',
            hint: 'you@example.com',
            errorText: 'This email is already in use.',
          ),
        ),
        const SizedBox(height: 20),
        _stateBlock(
          'With Icons',
          child: DievasTextInput(
            hint: 'Search...',
            leadingIcon: const Icon(Icons.search_rounded),
            trailingIcon: const Icon(Icons.close_rounded),
          ),
        ),
        const SizedBox(height: 20),
        _stateBlock(
          'Disabled',
          child: DievasTextInput(
            label: 'Username',
            hint: 'adonis_serticode',
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
