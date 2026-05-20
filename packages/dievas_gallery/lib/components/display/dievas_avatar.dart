import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final avatarComponent = WidgetbookComponent(
  name: 'Avatar',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Sizes', builder: (ctx) => const _AllSizes()),
    WidgetbookUseCase(name: 'All Shapes', builder: (ctx) => const _AllShapes()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}

class _AllSizes extends StatelessWidget {
  const _AllSizes();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Wrap(
        spacing: context.spacing.md,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final size in DievasAvatarSize.values)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ComponentBoundary(
                  child: DievasAvatar(initials: 'AB', size: size),
                ),
                SizedBox(height: context.spacing.sm),
                Text(size.name, style: context.typography.labelXs),
              ],
            ),
        ],
      ),
    ),
  );
}

class _AllShapes extends StatelessWidget {
  const _AllShapes();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Wrap(
        spacing: context.spacing.lg,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final shape in DievasAvatarShape.values)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ComponentBoundary(
                  child: DievasAvatar(initials: 'AB', size: DievasAvatarSize.lg, shape: shape),
                ),
                SizedBox(height: context.spacing.sm),
                Text(shape.name, style: context.typography.labelXs),
              ],
            ),
        ],
      ),
    ),
  );
}
