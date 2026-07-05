import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final tagComponent = WidgetbookComponent(
  name: 'Tag',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Styles', builder: (ctx) => const _AllStyles()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final iconSize = DievasTheme.componentsOf(context).tag.iconSize;
    final label = context.knobs.string(label: 'Label', initialValue: 'Dievas');

    final style = context.knobs.object.dropdown<DievasTagStyle>(
      label: 'Style',
      options: DievasTagStyle.values,
      labelBuilder: (v) => v.name,
      initialOption: .tinted,
    );

    final customColours = context.knobs.boolean(label: 'Custom Colours');

    final bg = customColours ? context.knobs.color(label: 'Background', initialValue: const Color(0xFFE3F2FD)) : null;
    final fg = customColours ? context.knobs.color(label: 'Foreground', initialValue: const Color(0xFF1565C0)) : null;
    final border = customColours ? context.knobs.color(label: 'Border', initialValue: const Color(0xFF90CAF9)) : null;

    final shape = context.knobs.object.dropdown<String>(
      label: 'Shape',
      options: const ['Pill', 'Rounded'],
      initialOption: 'Rounded',
    );

    final DievasTagBorderRadius borderRadius = switch (shape) {
      'Pill' => .pill,
      _ => .rounded(DievasTheme.borderOf(context).sm),
    };

    final showLeadingIcon = context.knobs.boolean(label: 'Leading Icon');
    final showRemove = context.knobs.boolean(label: 'Dismiss Button');
    final tappable = context.knobs.boolean(label: 'Tappable');

    return Center(
      child: ComponentBoundary(
        child: DievasTag(
          label: label.isEmpty ? 'Tag' : label,
          style: style,
          backgroundColor: bg,
          foregroundColor: fg,
          borderColor: border,
          borderRadius: borderRadius,
          leadingIcon: showLeadingIcon ? Icon(Icons.label_outline_rounded, size: iconSize) : null,
          onRemove: showRemove ? () {} : null,
          onPressed: tappable ? () {} : null,
        ),
      ),
    );
  }
}

class _AllStyles extends StatelessWidget {
  const _AllStyles();

  @override
  Widget build(BuildContext context) {
    final iconSize = DievasTheme.componentsOf(context).tag.iconSize;
    final borderSm = DievasTheme.borderOf(context).sm;

    return Center(
      child: Padding(
        padding: .all(context.spacing.lg),
        child: Wrap(
          spacing: context.spacing.sm,
          runSpacing: context.spacing.smPlus,
          alignment: .center,
          children: [
            for (final style in DievasTagStyle.values) ...[
              ComponentBoundary(
                child: DievasTag(label: style.name, style: style),
              ),
              ComponentBoundary(
                child: DievasTag(
                  label: style.name,
                  style: style,
                  leadingIcon: Icon(Icons.label_outline_rounded, size: iconSize),
                  onRemove: () {},
                ),
              ),
              ComponentBoundary(
                child: DievasTag(
                  label: style.name,
                  style: style,
                  borderRadius: DievasTagBorderRadius.rounded(borderSm),
                ),
              ),
              ComponentBoundary(
                child: DievasTag(
                  label: style.name,
                  style: style,
                  borderRadius: DievasTagBorderRadius.rounded(borderSm),
                  leadingIcon: Icon(Icons.label_outline_rounded, size: iconSize),
                  onRemove: () {},
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
