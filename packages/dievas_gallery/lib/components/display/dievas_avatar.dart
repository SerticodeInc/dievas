import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final avatarComponent = WidgetbookComponent(
  name: 'Avatar',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: _playground),
    WidgetbookUseCase(name: 'All Sizes', builder: _allSizes),
    WidgetbookUseCase(name: 'All Shapes', builder: _allShapes),
  ],
);

Widget _playground(BuildContext context) {
  final initials = context.knobs.string(label: 'Initials', initialValue: 'AB');

  final size = context.knobs.object.dropdown<DievasAvatarSize>(
    label: 'Size',
    options: DievasAvatarSize.values,
    labelBuilder: (v) => v.name,
    initialOption: .md,
  );

  final shape = context.knobs.object.dropdown<DievasAvatarShape>(
    label: 'Shape',
    options: DievasAvatarShape.values,
    labelBuilder: (v) => v.name,
  );

  final showInitials = context.knobs.boolean(label: 'Show Initials', initialValue: true);

  return Center(
    child: ComponentBoundary(
      child: DievasAvatar(initials: showInitials ? initials : null, size: size, shape: shape),
    ),
  );
}

Widget _allSizes(BuildContext context) => Center(
  child: Padding(
    padding: const .all(24),
    child: Wrap(
      spacing: 16,
      crossAxisAlignment: .center,
      children: [
        for (final size in DievasAvatarSize.values)
          Column(
            mainAxisSize: .min,
            children: [
              ComponentBoundary(
                child: DievasAvatar(initials: 'AB', size: size),
              ),
              const SizedBox(height: 8),
              Text(size.name, style: const TextStyle(fontSize: 11)),
            ],
          ),
      ],
    ),
  ),
);

Widget _allShapes(BuildContext context) => Center(
  child: Padding(
    padding: const .all(24),
    child: Wrap(
      spacing: 24,
      crossAxisAlignment: .center,
      children: [
        for (final shape in DievasAvatarShape.values)
          Column(
            mainAxisSize: .min,
            children: [
              ComponentBoundary(
                child: DievasAvatar(initials: 'AB', size: DievasAvatarSize.lg, shape: shape),
              ),
              const SizedBox(height: 8),
              Text(shape.name, style: const TextStyle(fontSize: 11)),
            ],
          ),
      ],
    ),
  ),
);
