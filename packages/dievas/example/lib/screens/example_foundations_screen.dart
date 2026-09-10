import 'package:flutter/material.dart';

import 'package:dievas/dievas.dart';

/// Foundations — every Dievas sub-system, live.
///
/// Dievas splits the theme into aspect-scoped sub-systems. Widgets read the
/// one they need and only rebuild when it changes. This screen shows each
/// getter (via the flat `context.*` extension and the [DievasTheme] statics),
/// plus a per-instance component override via `copyWith`.
class ExampleFoundationsScreen extends StatelessWidget {
  const ExampleFoundationsScreen({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: .symmetric(horizontal: context.spacing.xl, vertical: context.spacing.x2l),
    child: Column(
      crossAxisAlignment: .start,
      children: [
        Text('Foundations', style: context.typography.displaySm),
        SizedBox(height: context.spacing.sm),
        Text(
          'Each card reads one aspect-scoped sub-system.',
          style: context.typography.bodyMd.copyWith(color: context.colours.text.textSecondary),
        ),
        SizedBox(height: context.spacing.x2l),

        const _SubsystemCard(
          title: 'context.colours',
          description: 'Every semantic colour role, grouped by domain.',
          child: _ColourSwatches(),
        ),
        SizedBox(height: context.spacing.lg),

        const _SubsystemCard(
          title: 'context.typography',
          description: 'The full type ramp as pre-coloured TextStyles.',
          child: _TypographyScale(),
        ),
        SizedBox(height: context.spacing.lg),

        const _SubsystemCard(
          title: 'context.spacing',
          description: '4pt-grid spacing tokens.',
          child: _SpacingReadout(),
        ),
        SizedBox(height: context.spacing.lg),

        const _SubsystemCard(
          title: 'context.sizing / border / elevation / opacity / animation',
          description: 'Component dimensions, radii, shadows, opacity values, motion durations.',
          child: _ValueReadouts(),
        ),
        SizedBox(height: context.spacing.lg),

        const _SubsystemCard(
          title: 'DievasTheme statics',
          description: 'The same data via DievasTheme.of / coloursOf / … — identical values.',
          child: _ThemeStatics(),
        ),
        SizedBox(height: context.spacing.lg),

        const _SubsystemCard(
          title: 'Per-instance override (copyWith)',
          description:
              'Wrap a subtree in DievasTheme with a copyWith-ed theme to override '
              'a component for that subtree only.',
          child: _ComponentOverride(),
        ),
        SizedBox(height: context.spacing.x3l),
      ],
    ),
  );
}

class _SubsystemCard extends StatelessWidget {
  const _SubsystemCard({required this.title, required this.description, required this.child});

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: .infinity,
    padding: .all(context.spacing.lg),
    decoration: BoxDecoration(
      color: context.colours.background.bgSubtle,
      border: .all(color: context.colours.border.borderDefault),
      borderRadius: context.border.lg,
    ),
    child: Column(
      crossAxisAlignment: .start,
      children: [
        Text(title, style: context.typography.codeMd),
        SizedBox(height: context.spacing.xs),
        Text(description, style: context.typography.bodySm.copyWith(color: context.colours.text.textSecondary)),
        SizedBox(height: context.spacing.lg),
        child,
      ],
    ),
  );
}

class _ColourSwatches extends StatelessWidget {
  const _ColourSwatches();

  @override
  Widget build(BuildContext context) {
    final colours = context.colours;

    return Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        _Swatch(label: 'brand', colour: colours.core.brand),
        _Swatch(label: 'textPrimary', colour: colours.text.textPrimary),
        _Swatch(label: 'bgBase', colour: colours.background.bgBase),
        _Swatch(label: 'bgSubtle', colour: colours.background.bgSubtle),
        _Swatch(label: 'actionPrimary', colour: colours.action.actionPrimary),
        _Swatch(label: 'actionError', colour: colours.action.actionError),
        _Swatch(label: 'borderBrand', colour: colours.border.borderBrand),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.label, required this.colour});

  final String label;
  final Color colour;

  @override
  Widget build(BuildContext context) => Container(
    width: 96,
    padding: .all(context.spacing.sm),
    decoration: BoxDecoration(
      color: colour,
      borderRadius: context.border.md,
      border: .all(color: context.colours.border.borderDefault),
    ),
    child: Text(
      label,
      style: context.typography.labelXs.copyWith(
        color: ThemeData.estimateBrightnessForColor(colour) == Brightness.dark
            ? context.colours.staticColours.staticWhite
            : context.colours.staticColours.staticBlack,
      ),
    ),
  );
}

class _TypographyScale extends StatelessWidget {
  const _TypographyScale();

  @override
  Widget build(BuildContext context) {
    final t = context.typography;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text('displaySm — Display', style: t.displaySm),
        SizedBox(height: context.spacing.md),
        Text('headingMd — Heading', style: t.headingMd),
        SizedBox(height: context.spacing.md),
        Text('titleLg — Title', style: t.titleLg),
        SizedBox(height: context.spacing.md),
        Text('bodyMd — Body copy', style: t.bodyMd),
        SizedBox(height: context.spacing.md),
        Text('labelMd — Label', style: t.labelMd),
        SizedBox(height: context.spacing.md),
        Text('codeMd — Inline code', style: t.codeMd),
      ],
    );
  }
}

class _SpacingReadout extends StatelessWidget {
  const _SpacingReadout();

  @override
  Widget build(BuildContext context) {
    final s = context.spacing;

    return Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        _StatChip(label: 'xs', value: '${s.xs}'),
        _StatChip(label: 'sm', value: '${s.sm}'),
        _StatChip(label: 'md', value: '${s.md}'),
        _StatChip(label: 'lg', value: '${s.lg}'),
        _StatChip(label: 'xl', value: '${s.xl}'),
        _StatChip(label: 'x2l', value: '${s.x2l}'),
      ],
    );
  }
}

class _ValueReadouts extends StatelessWidget {
  const _ValueReadouts();

  @override
  Widget build(BuildContext context) {
    final sizing = context.sizing;
    final border = context.border;
    final elevation = context.elevation;
    final opacity = context.opacity;
    final animation = context.animation;

    return Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        _StatChip(label: 'sizing.buttonHeightMd', value: '${sizing.buttonHeightMd}'),
        _StatChip(label: 'sizing.inputHeightMd', value: '${sizing.inputHeightMd}'),
        _StatChip(label: 'border.lg radius', value: '${border.lg.topLeft.x}'),
        _StatChip(label: 'border.strokeThin', value: '${border.strokeThin}'),
        _StatChip(label: 'elevation.md shadows', value: '${elevation.md.length}'),
        _StatChip(label: 'opacity.disabled', value: opacity.disabled.toStringAsFixed(2)),
        _StatChip(label: 'animation.standard', value: '${animation.standard.inMilliseconds}ms'),
      ],
    );
  }
}

class _ThemeStatics extends StatelessWidget {
  const _ThemeStatics();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    children: [
      _CodeLine('DievasTheme.of(context) → ${DievasTheme.of(context).runtimeType}'),
      SizedBox(height: context.spacing.sm),
      _CodeLine('DievasTheme.coloursOf(context).core.brand → ${DievasTheme.coloursOf(context).core.brand}'),
      SizedBox(height: context.spacing.sm),
      _CodeLine('DievasTheme.animationOf(context).fast → ${DievasTheme.animationOf(context).fast}'),
      SizedBox(height: context.spacing.sm),
      _CodeLine(
        'DievasTheme.materialOf(context).colorScheme.brightness → '
        '${DievasTheme.materialOf(context).colorScheme.brightness}',
      ),
    ],
  );
}

class _CodeLine extends StatelessWidget {
  const _CodeLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(text, style: context.typography.codeSm);
}

class _ComponentOverride extends StatelessWidget {
  const _ComponentOverride();

  @override
  Widget build(BuildContext context) {
    // Build a theme copy with the avatar component overridden for this subtree
    // only. Everything else inherits from the scope theme above.
    final overridden = DievasTheme.of(context).copyWith(
      components: DievasTheme.of(context).components.copyWith(
        avatar: DievasTheme.of(context).components.avatar.copyWith(
          backgroundColour: context.colours.action.actionPrimary,
          initialsColour: context.colours.core.onBrand,
        ),
      ),
    );

    return Row(
      children: [
        Column(
          crossAxisAlignment: .start,
          children: [
            Text('Default', style: context.typography.labelSm),
            SizedBox(height: context.spacing.md),
            const DievasAvatar(initials: 'DX'),
          ],
        ),
        SizedBox(width: context.spacing.x2l),
        Column(
          crossAxisAlignment: .start,
          children: [
            Text('copyWith override', style: context.typography.labelSm),
            SizedBox(height: context.spacing.md),
            DievasTheme(
              data: overridden,
              child: const DievasAvatar(initials: 'DX'),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
    padding: .symmetric(horizontal: context.spacing.md, vertical: context.spacing.sm),
    decoration: BoxDecoration(color: context.colours.background.bgElevated, borderRadius: context.border.md),
    child: Column(
      crossAxisAlignment: .start,
      children: [
        Text(label, style: context.typography.labelXs.copyWith(color: context.colours.text.textTertiary)),
        SizedBox(height: context.spacing.xs),
        Text(value, style: context.typography.labelMd),
      ],
    ),
  );
}
