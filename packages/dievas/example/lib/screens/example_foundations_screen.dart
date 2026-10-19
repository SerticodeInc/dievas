import 'package:flutter/material.dart';

import 'package:dievas/dievas.dart';
import 'package:dievas_example/widgets/example_page.dart';

part 'example_foundations/foundation_section.dart';
part 'example_foundations/foundation_colour.dart';
part 'example_foundations/foundation_typography.dart';
part 'example_foundations/foundation_values.dart';
part 'example_foundations/foundation_surfaces.dart';
part 'example_foundations/foundation_motion.dart';
part 'example_foundations/foundation_theme.dart';

/// Foundations: every Dievas sub-system, live.
///
/// Dievas splits the theme into aspect-scoped sub-systems. Widgets read the
/// one they need and only rebuild when it changes. This screen shows each
/// getter (via the flat `context.*` extension and the [DievasTheme] statics),
/// plus a per-instance component override via `copyWith`.
class ExampleFoundationsScreen extends StatelessWidget {
  const ExampleFoundationsScreen({super.key});

  @override
  Widget build(BuildContext context) => ExamplePage(
    child: Column(
      crossAxisAlignment: .start,
      children: [
        Text('Foundations', style: context.typography.displaySm),
        SizedBox(height: context.spacing.sm),
        Text(
          'Colour, type, space and motion. The decisions behind every component.',
          style: context.typography.bodyMd.copyWith(color: context.colours.text.textSecondary),
        ),
        SizedBox(height: context.spacing.xl2),

        const _FoundationSection(
          title: 'Colour',
          description: 'Semantic roles for surfaces, content and actions. • context.colours',
          child: _ColourSwatches(),
        ),
        SizedBox(height: context.spacing.lg),

        const _FoundationSection(
          title: 'Typography',
          description: 'A clear hierarchy from display to detail. • context.typography',
          child: _TypographyScale(),
        ),
        SizedBox(height: context.spacing.lg),

        const _FoundationSection(
          title: 'Spacing',
          description: 'A consistent rhythm on a 4pt grid. • context.spacing',
          child: _SpacingReadout(),
        ),
        SizedBox(height: context.spacing.lg),

        const _FoundationSection(
          title: 'Shape & motion',
          description:
              'Compare real control heights, surface treatments and motion. Each preview uses the active tokens.',
          child: _ValueReadouts(),
        ),
        SizedBox(height: context.spacing.lg),

        Text('Working with the theme', style: context.typography.headingMd),
        SizedBox(height: context.spacing.lg),
        const _FoundationSection(
          title: 'Theme access',
          description: 'These examples read the active theme. Switch appearance in Overview to see them update.',
          child: _ThemeStatics(),
        ),
        SizedBox(height: context.spacing.lg),

        const _FoundationSection(
          title: 'Local customization',
          description:
              'The local avatar uses the theme’s primary action colour. '
              'Its override stays inside this subtree; the default avatar keeps the original theme.',
          child: _ComponentOverride(),
        ),
        SizedBox(height: context.spacing.xl3),
      ],
    ),
  );
}
