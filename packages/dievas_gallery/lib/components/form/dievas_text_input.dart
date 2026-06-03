import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final textInputComponent = WidgetbookComponent(
  name: 'TextInput',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Sizes', builder: (ctx) => _AllSizes()),
    WidgetbookUseCase(name: 'All States', builder: (ctx) => _AllStates()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = context.knobs.object.dropdown<DievasTextInputSize>(
      label: 'Size',
      options: DievasTextInputSize.values,
      labelBuilder: (v) => v.name,
      initialOption: .lg,
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
        padding: .symmetric(horizontal: context.spacing.xl),
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
}

class _AllSizes extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: .symmetric(horizontal: context.spacing.xl, vertical: context.spacing.lg),
      child: Column(
        mainAxisSize: .min,
        children: [
          for (final size in DievasTextInputSize.values) ...[
            Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    size.name,
                    style: context.typography.labelXs.copyWith(color: context.colors.text.textTertiary),
                  ),
                ),
                SizedBox(width: context.spacing.md),
                Expanded(
                  child: ComponentBoundary(
                    child: DievasTextInput(size: size, hint: 'Placeholder'),
                  ),
                ),
              ],
            ),
            if (size != .lg) SizedBox(height: context.spacing.md),
          ],
        ],
      ),
    ),
  );
}

class _AllStates extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: .symmetric(horizontal: context.spacing.xl, vertical: context.spacing.lg),
      child: Column(
        mainAxisSize: .min,
        children: [
          _StateBlock('Default', child: DievasTextInput(hint: 'Placeholder')),
          SizedBox(height: context.spacing.mdPlus),
          _StateBlock(
            'With Label + Helper',
            child: DievasTextInput(label: 'Full name', hint: 'John Appleseed', helperText: 'As it appears on your ID.'),
          ),
          SizedBox(height: context.spacing.mdPlus),
          _StateBlock(
            'Error',
            child: DievasTextInput(
              label: 'Email',
              hint: 'you@serticodeinc.com',
              errorText: 'This email is already in use.',
            ),
          ),
          SizedBox(height: context.spacing.mdPlus),
          _StateBlock(
            'With Icons',
            child: DievasTextInput(
              hint: 'Search...',
              leadingIcon: const Icon(Icons.search_rounded),
              trailingIcon: const Icon(Icons.close_rounded),
            ),
          ),
          SizedBox(height: context.spacing.mdPlus),
          _StateBlock(
            'Disabled',
            child: DievasTextInput(label: 'Username', hint: 'adonis_serticode', enabled: false),
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
    crossAxisAlignment: .start,
    mainAxisSize: .min,
    children: [
      Text(name, style: context.typography.labelXs.copyWith(color: context.colors.text.textTertiary)),
      SizedBox(height: context.spacing.sm),
      ComponentBoundary(child: child),
    ],
  );
}
