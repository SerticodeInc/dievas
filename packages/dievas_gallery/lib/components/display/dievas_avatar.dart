import 'dart:typed_data';

import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/token_colour_knob.dart';
import '../../knobs/knob_section.dart';
import '../../widgets/component_boundary.dart';

final avatarComponent = WidgetbookComponent(
  name: 'Avatar',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'All Sizes', builder: (ctx) => const _AllSizes()),
    WidgetbookUseCase(name: 'All Shapes', builder: (ctx) => const _AllShapes()),
    WidgetbookUseCase(name: 'Custom content', builder: (ctx) => const _CustomContent()),
  ],
);

enum _Content { initials, icon, custom }

enum _Image { sample, broken }

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.knobSection('Content');
    final initials = context.knobs.string(label: 'Content text', initialValue: 'MD');
    final content = context.knobs.object.dropdown(
      label: 'Content type',
      options: _Content.values,
      labelBuilder: (value) => value.name,
    );
    final image = context.knobs.object.dropdown(
      label: 'Image source',
      options: _Image.values,
      labelBuilder: (value) => value.name,
    );
    final overlay = context.knobs.boolean(label: 'Overlay content on image');
    context.knobSection('Size and shape');
    final size = context.knobs.object.dropdown(
      label: 'Size',
      options: DievasAvatarSize.values,
      initialOption: DievasAvatarSize.MD,
      labelBuilder: (value) => value.name,
    );
    final shape = context.knobs.object.dropdown(
      label: 'Shape',
      options: DievasAvatarShape.values,
      initialOption: DievasAvatarShape.square,
      labelBuilder: (value) => value.name,
    );
    final overrideDimensions = context.knobs.boolean(label: 'Override dimensions');
    final width = context.knobs.double.slider(label: 'Width', initialValue: 64, min: 24, max: 128);
    final height = context.knobs.double.slider(label: 'Height', initialValue: 64, min: 24, max: 128);
    final overrideRadius = context.knobs.boolean(label: 'Override border radius');
    final radius = context.knobs.double.slider(label: 'Border radius', initialValue: 8, min: 0, max: 64);
    context.knobSection('Surface and content colours');
    final overrideBackground = context.knobs.boolean(label: 'Override background colour');
    final background = context.tokenColourKnob(label: 'Background colour', role: .background);
    final overrideText = context.knobs.boolean(label: 'Override text colour');
    final text = context.tokenColourKnob(label: 'Text colour', role: .text);
    final overridePlaceholder = context.knobs.boolean(label: 'Override icon colour');
    final placeholder = context.tokenColourKnob(label: 'Icon colour', role: .icon);
    context.knobSection('Border');
    final showBorder = context.knobs.boolean(label: 'Show border');
    final border = context.tokenColourKnob(label: 'Border colour', role: .border);
    final borderWidth = context.knobs.double.slider(label: 'Border width', initialValue: 1, min: 0, max: 6);
    context.knobSection('Status badge');
    final showBadge = context.knobs.boolean(label: 'Show badge', initialValue: true);
    final overrideBadgeColour = context.knobs.boolean(label: 'Override badge colour');
    final badge = context.tokenColourKnob(label: 'Badge colour', role: .icon);
    final alignment = context.knobs.object.dropdown(
      label: 'Badge alignment',
      options: DievasAvatarBadgeAlignment.values,
      initialOption: DievasAvatarBadgeAlignment.bottomRight,
      labelBuilder: (value) => value.name,
    );
    final overrideBadgeSize = context.knobs.boolean(label: 'Override badge size');
    final badgeSize = context.knobs.double.slider(label: 'Badge size', initialValue: 8, min: 2, max: 24);
    final overrideMargin = context.knobs.boolean(label: 'Override badge margin');
    final margin = context.knobs.double.slider(label: 'Badge margin', initialValue: 4, min: 0, max: 12);
    context.knobSection('Accessibility');
    final rtl = context.knobs.boolean(label: 'Right to left');
    final semanticLabel = context.knobs.string(label: 'Semantic label', initialValue: 'Member avatar');
    final badgeLabel = context.knobs.string(label: 'Badge semantic label', initialValue: 'Online');

    return Directionality(
      textDirection: rtl ? .rtl : .ltr,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: .min,
          children: [
            _DemoBlock(
              label: 'Avatar',
              child: DievasAvatar(
                size: size,
                shape: shape,
                width: overrideDimensions ? width : null,
                height: overrideDimensions ? height : null,
                borderRadius: overrideRadius ? BorderRadius.circular(radius) : null,
                initials: content == .initials ? initials : null,
                backgroundColour: overrideBackground ? background : null,
                initialsColour: overrideText ? text : null,
                placeholderColour: overridePlaceholder ? placeholder : null,
                borderColour: showBorder ? border : null,
                borderWidth: borderWidth,
                showBadge: showBadge,
                badgeColour: overrideBadgeColour ? badge : null,
                badgeSize: overrideBadgeSize ? badgeSize : null,
                badgeMarginValue: overrideMargin ? margin : null,
                badgeAlignment: alignment,
                semanticLabel: semanticLabel,
                badgeSemanticLabel: showBadge ? badgeLabel : null,
                content: content == .custom ? _AvatarContent(type: content, text: initials) : null,
              ),
            ),
            SizedBox(height: context.spacing.xl),
            _DemoBlock(
              label: 'Image background',
              child: DievasAvatar(
                size: size,
                shape: shape,
                width: overrideDimensions ? width : null,
                height: overrideDimensions ? height : null,
                borderRadius: overrideRadius ? BorderRadius.circular(radius) : null,
                initials: content == .initials ? initials : null,
                backgroundColour: overrideBackground ? background : null,
                initialsColour: overrideText ? text : null,
                placeholderColour: overridePlaceholder ? placeholder : null,
                borderColour: showBorder ? border : null,
                borderWidth: borderWidth,
                showBadge: showBadge,
                badgeColour: overrideBadgeColour ? badge : null,
                badgeSize: overrideBadgeSize ? badgeSize : null,
                badgeMarginValue: overrideMargin ? margin : null,
                badgeAlignment: alignment,
                semanticLabel: semanticLabel,
                badgeSemanticLabel: showBadge ? badgeLabel : null,
                imageProvider: image == .sample
                    ? const AssetImage('assets/images/avatar-sample.jpg')
                    : MemoryImage(Uint8List(0)),
                content: overlay ? _AvatarContent(type: content, text: initials) : null,
              ),
            ),
            SizedBox(height: context.spacing.xl),
          ],
        ),
      ),
    );
  }
}

class _AvatarContent extends StatelessWidget {
  const _AvatarContent({required this.type, required this.text});
  final _Content type;
  final String text;

  @override
  Widget build(BuildContext context) => switch (type) {
    .initials => Text(text),
    .icon => const Icon(Icons.person),
    .custom => const Icon(Icons.favorite),
  };
}

class _DemoBlock extends StatelessWidget {
  const _DemoBlock({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    children: [
      Text(label, style: context.typography.labelSm),
      SizedBox(height: context.spacing.lg),
      ComponentBoundary(child: child),
    ],
  );
}

class _CustomContent extends StatelessWidget {
  const _CustomContent();

  @override
  Widget build(BuildContext context) => Center(
    child: Wrap(
      spacing: context.spacing.lg,
      children: [
        const DievasAvatar(size: .XL, content: Icon(Icons.favorite), showBadge: true),
        const DievasAvatar(
          size: .XL,
          imageProvider: AssetImage('assets/images/avatar-sample.jpg'),
          content: Icon(Icons.star, color: Colors.white),
          showBadge: true,
        ),
      ],
    ),
  );
}

class _AllSizes extends StatelessWidget {
  const _AllSizes();

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return Center(
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
    );
  }
}

class _AllShapes extends StatelessWidget {
  const _AllShapes();

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return Center(
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
                  child: DievasAvatar(initials: 'AB', size: .LG, shape: shape),
                ),
                Text(shape.name, style: context.typography.labelXs),
              ],
            ),
        ],
      ),
    );
  }
}
