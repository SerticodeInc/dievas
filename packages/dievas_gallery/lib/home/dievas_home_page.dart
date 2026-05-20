import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';

/// Custom home page shown in the Widgetbook canvas when no component is selected.
///
/// Wraps itself in a [DievasScope] so that [DievasTheme.of(context)] is
/// available to all sub-widgets — the Widgetbook addons have not fired yet at
/// this route, so no inherited theme exists above this widget.
class DievasHomePage extends StatelessWidget {
  const DievasHomePage({super.key});

  @override
  Widget build(BuildContext context) => DievasScope(
    lightTheme: DievasDarkThemeData(),
    darkTheme: DievasDarkThemeData(),
    global: false,
    child: Builder(builder: _build),
  );

  Widget _build(BuildContext context) => Scaffold(
    backgroundColor: context.colors.background.bgBase,
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.x2l, vertical: context.spacing.x3l),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Eyebrow(),
              SizedBox(height: context.spacing.lg),
              _Headline(),
              SizedBox(height: context.spacing.md),
              _Subtitle(),
              SizedBox(height: context.spacing.x2lPlus),
              _StatsRow(),
              SizedBox(height: context.spacing.x2lPlus),
              const _SectionLabel('Components'),
              SizedBox(height: context.spacing.md),
              _ComponentCategory(
                name: 'Buttons',
                count: 4,
                components: const ['FilledButton', 'OutlinedButton', 'TextButton', 'IconButton'],
              ),
              SizedBox(height: context.spacing.sm),
              _ComponentCategory(
                name: 'Display',
                count: 7,
                components: const ['Avatar', 'Badge', 'CircularProgress', 'Divider', 'Icon', 'LinearProgress', 'Tag'],
              ),
              SizedBox(height: context.spacing.sm),
              _ComponentCategory(
                name: 'Form',
                count: 5,
                components: const ['Checkbox', 'Radio', 'Switch', 'TextInput', 'TextArea'],
              ),
              SizedBox(height: context.spacing.sm),
              _ComponentCategory(name: 'Feedback', count: 3, components: const ['Alert', 'Banner', 'Snackbar']),
              SizedBox(height: context.spacing.sm),
              _ComponentCategory(name: 'Overlays', count: 3, components: const ['BottomSheet', 'Modal', 'Tooltip']),
              SizedBox(height: context.spacing.sm),
              _ComponentCategory(name: 'Utility', count: 2, components: const ['Loader', 'EmptyState']),
              SizedBox(height: context.spacing.x2lPlus),
              _HintBadge(),
              SizedBox(height: context.spacing.x3l),
            ],
          ),
        ),
      ),
    ),
  );
}

class _Eyebrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(color: context.colors.core.brand, shape: BoxShape.circle),
      ),
      SizedBox(width: context.spacing.sm),
      Text(
        'FLUTTER DESIGN SYSTEM',
        style: context.typography.codeSm.copyWith(letterSpacing: 2.5, color: context.colors.core.brand),
      ),
    ],
  );
}

class _Headline extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Text(
    'Dievas',
    style: context.typography.displayLg.copyWith(fontWeight: FontWeight.w900, height: 0.92, letterSpacing: -3),
  );
}

class _Subtitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Text(
    "Ports Moon Design System's component catalogue.\n"
    'Token-driven. InheritedModel-first. Multi-brand.',
    style: context.typography.bodyMd.copyWith(height: 1.75, color: context.colors.text.textSecondary),
  );
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(
      children: [
        _StatCell(value: '3', label: 'packages'),
        _Divider(),
        _StatCell(value: '2', label: 'default themes'),
        _Divider(),
        _StatCell(value: '24', label: 'components'),
        _Divider(),
        _StatCell(value: '∞', label: 'brand configs'),
      ],
    ),
  );
}

class _StatCell extends StatelessWidget {
  const _StatCell({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: context.typography.headingXl.copyWith(height: 1, letterSpacing: -1)),
        SizedBox(height: context.spacing.sm),
        Text(
          label.toUpperCase(),
          style: context.typography.codeSm.copyWith(letterSpacing: 1.8, color: context.colors.text.textTertiary),
        ),
      ],
    ),
  );
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    width: 1,
    margin: EdgeInsets.symmetric(horizontal: context.spacing.lg),
    color: context.colors.border.borderDefault,
  );
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: context.typography.codeSm.copyWith(letterSpacing: 2, color: context.colors.text.textTertiary),
  );
}

class _ComponentCategory extends StatelessWidget {
  const _ComponentCategory({required this.name, required this.count, required this.components});

  final String name;
  final int count;
  final List<String> components;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: context.colors.background.bgSubtle,
      border: Border.all(color: context.colors.border.borderDefault),
      borderRadius: context.border.lg,
    ),
    padding: EdgeInsets.symmetric(horizontal: context.spacing.mdPlus, vertical: context.spacing.md),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: context.colors.action.actionSuccess, shape: BoxShape.circle),
        ),
        SizedBox(width: context.spacing.smPlus),
        SizedBox(
          width: 80, // label column — gallery-only fixed width
          child: Text(name, style: context.typography.codeSm.copyWith(color: context.colors.text.textPrimary)),
        ),
        Expanded(
          child: Wrap(
            spacing: context.spacing.xs,
            runSpacing: context.spacing.xs,
            children: [
              for (final c in components)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: context.spacing.sm, vertical: context.spacing.xs),
                  decoration: BoxDecoration(
                    color: context.colors.background.bgElevated,
                    borderRadius: context.border.sm,
                    border: Border.all(color: context.colors.border.borderDefault.withAlpha(100)),
                  ),
                  child: Text(c, style: context.typography.codeSm.copyWith(color: context.colors.text.textSecondary)),
                ),
            ],
          ),
        ),
        SizedBox(width: context.spacing.md),
        Text('$count', style: context.typography.codeSm.copyWith(color: context.colors.text.textTertiary)),
      ],
    ),
  );
}

class _HintBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: context.spacing.md, vertical: context.spacing.smPlus),
    decoration: BoxDecoration(
      color: context.colors.background.bgSubtle,
      border: Border.all(color: context.colors.core.brand.withAlpha(80)),
      borderRadius: context.border.lg,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: context.colors.core.brand, shape: BoxShape.circle),
        ),
        SizedBox(width: context.spacing.smPlus),
        Flexible(
          child: Text(
            'Select a component from the sidebar to explore use cases',
            style: context.typography.codeSm.copyWith(color: context.colors.text.textSecondary),
          ),
        ),
      ],
    ),
  );
}
