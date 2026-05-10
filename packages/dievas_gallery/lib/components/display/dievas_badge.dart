import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final badgeComponent = WidgetbookComponent(
  name: 'Badge',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: _playground),
    WidgetbookUseCase(name: 'All Styles', builder: _allStyles),
    WidgetbookUseCase(name: 'All Tones', builder: _allTones),
  ],
);

Widget _playground(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'New');

  final style = context.knobs.list<DievasBadgeStyle>(
    label: 'Style',
    options: DievasBadgeStyle.values,
    labelBuilder: (v) => v.name,
    initialOption: .tinted,
  );

  final tone = context.knobs.list<DievasBadgeTone>(
    label: 'Tone',
    options: DievasBadgeTone.values,
    labelBuilder: (v) => v.name,
  );

  final showIcon = context.knobs.boolean(label: 'Leading Icon');

  return Center(
    child: ComponentBoundary(
      child: DievasBadge(
        label: label.isEmpty ? 'Badge' : label,
        style: style,
        tone: tone,
        leadingIcon: showIcon ? const Icon(Icons.circle, size: 8) : null,
      ),
    ),
  );
}

Widget _allStyles(BuildContext context) => Center(
  child: Padding(
    padding: const .all(24),
    child: Wrap(
      spacing: 8,
      runSpacing: 12,
      alignment: .center,
      children: [
        for (final style in DievasBadgeStyle.values)
          ComponentBoundary(
            child: DievasBadge(label: style.name, style: style),
          ),
      ],
    ),
  ),
);

Widget _allTones(BuildContext context) => Center(
  child: Padding(
    padding: const .all(24),
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        for (final style in DievasBadgeStyle.values) ...[
          Text(style.name, style: const TextStyle(fontSize: 11, fontWeight: .w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tone in DievasBadgeTone.values)
                ComponentBoundary(
                  child: DievasBadge(label: tone.name, style: style, tone: tone),
                ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ],
    ),
  ),
);
