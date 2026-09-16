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

    final customColours = context.knobs.boolean(label: 'Custom Colours');

    final avatarTheme = DievasTheme.componentsOf(context).avatar;
    final colours = context.colours;

    final background = customColours
        ? context.knobs.color(label: 'Background', initialValue: avatarTheme.backgroundColour)
        : null;
    final initialsColour = customColours
        ? context.knobs.color(label: 'Initials', initialValue: avatarTheme.initialsColour)
        : null;
    final placeholder = customColours
        ? context.knobs.color(label: 'Placeholder', initialValue: avatarTheme.placeholderColour)
        : null;
    final border = customColours
        ? context.knobs.color(label: 'Border', initialValue: colours.border.borderDefault)
        : null;

    return Center(
      child: ComponentBoundary(
        child: DievasAvatar(
          initials: showInitials ? initials : null,
          size: size,
          shape: shape,
          backgroundColour: background,
          initialsColour: initialsColour,
          placeholderColour: placeholder,
          borderColour: border,
        ),
      ),
    );
  }
}

class _AllSizes extends StatelessWidget {
  const _AllSizes();

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return Center(
      child: Padding(
        padding: .all(spacing.lg),
        child: Wrap(
          spacing: spacing.md,
          crossAxisAlignment: .center,
          children: [
            for (final size in DievasAvatarSize.values)
              Column(
                mainAxisSize: .min,
                spacing: spacing.sm,
                children: [
                  ComponentBoundary(
                    child: DievasAvatar(initials: 'AB', size: size),
                  ),
                  Text(size.name, style: context.typography.labelXs),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _AllShapes extends StatelessWidget {
  const _AllShapes();

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return Center(
      child: Padding(
        padding: .all(spacing.lg),
        child: Wrap(
          spacing: spacing.lg,
          crossAxisAlignment: .center,
          children: [
            for (final shape in DievasAvatarShape.values)
              Column(
                mainAxisSize: .min,
                spacing: spacing.sm,
                children: [
                  ComponentBoundary(
                    child: DievasAvatar(initials: 'AB', size: DievasAvatarSize.lg, shape: shape),
                  ),
                  Text(shape.name, style: context.typography.labelXs),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
