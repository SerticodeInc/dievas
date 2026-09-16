import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final textInputGroupComponent = WidgetbookComponent(
  name: 'TextInputGroup',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => const _Playground()),
    WidgetbookUseCase(name: 'All Sizes', builder: (ctx) => const _AllSizes()),
    WidgetbookUseCase(name: 'All States', builder: (ctx) => const _AllStates()),
  ],
);

class _Playground extends StatelessWidget {
  const _Playground();

  @override
  Widget build(BuildContext context) {
    final size = context.knobs.object.dropdown<DievasTextInputGroupSize>(
      label: 'Size',
      options: DievasTextInputGroupSize.values,
      labelBuilder: (v) => v.name,
      initialOption: .md,
    );
    final segmentCount = context.knobs.double.slider(label: 'Segments', initialValue: 3, min: 2, max: 4).round();
    final hint = context.knobs.string(label: 'Hint', initialValue: 'Value');
    final disabled = context.knobs.boolean(label: 'Disabled');

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
        child: ComponentBoundary(
          child: DievasTextInputGroup(
            size: size,
            enabled: !disabled,
            children: List.generate(segmentCount, (i) => DievasTextInput(hint: '$hint ${i + 1}')),
          ),
        ),
      ),
    );
  }
}

class _AllSizes extends StatelessWidget {
  const _AllSizes();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xl, vertical: context.spacing.lg),
      child: Column(
        mainAxisSize: .min,
        children: [
          for (final size in DievasTextInputGroupSize.values) ...[
            Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    size.name,
                    style: context.typography.labelXs.copyWith(color: context.colours.text.textTertiary),
                  ),
                ),
                SizedBox(width: context.spacing.md),
                Expanded(
                  child: ComponentBoundary(
                    child: DievasTextInputGroup(
                      size: size,
                      children: const [
                        DievasTextInput(hint: 'First'),
                        DievasTextInput(hint: 'Last'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (size != DievasTextInputGroupSize.lg) SizedBox(height: context.spacing.md),
          ],
        ],
      ),
    ),
  );
}

class _AllStates extends StatelessWidget {
  const _AllStates();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xl, vertical: context.spacing.lg),
      child: Column(
        mainAxisSize: .min,
        children: [
          const _StateBlock(
            'Two Segments',
            child: DievasTextInputGroup(
              children: [
                DievasTextInput(hint: 'First'),
                DievasTextInput(hint: 'Last'),
              ],
            ),
          ),
          SizedBox(height: context.spacing.mdPlus),
          const _StateBlock(
            'Three Segments',
            child: DievasTextInputGroup(
              children: [
                DievasTextInput(hint: 'DD'),
                DievasTextInput(hint: 'MM'),
                DievasTextInput(hint: 'YYYY'),
              ],
            ),
          ),
          SizedBox(height: context.spacing.mdPlus),
          const _StateBlock(
            'Four Segments',
            child: DievasTextInputGroup(
              children: [
                DievasTextInput(hint: 'A1'),
                DievasTextInput(hint: 'A2'),
                DievasTextInput(hint: 'A3'),
                DievasTextInput(hint: 'A4'),
              ],
            ),
          ),
          SizedBox(height: context.spacing.mdPlus),
          _StateBlock(
            'Disabled',
            child: DievasTextInputGroup(
              enabled: false,
              children: const [
                DievasTextInput(hint: 'First'),
                DievasTextInput(hint: 'Last'),
              ],
            ),
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
      Text(name, style: context.typography.labelXs.copyWith(color: context.colours.text.textTertiary)),
      SizedBox(height: context.spacing.sm),
      ComponentBoundary(child: child),
    ],
  );
}
