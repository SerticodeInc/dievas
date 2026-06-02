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
    builder: (context, theme, child) => Theme(data: theme.material, child: child ?? const SizedBox()),
    child: _WidgetBookContent(),
  );
}

class _WidgetBookContent extends StatelessWidget {
  const _WidgetBookContent();

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.colors.background.bgSubtle,
    body: SingleChildScrollView(
      padding: .symmetric(horizontal: context.spacing.xl, vertical: context.spacing.x3l),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: .start,
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
                count: 10,
                components: const [
                  'Avatar',
                  'Badge',
                  'CircularProgress',
                  'CircularLoader',
                  'Divider',
                  'EmptyState',
                  'Icon',
                  'LinearProgress',
                  'LinearLoader',
                  'Tag',
                ],
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
              SizedBox(height: context.spacing.sm),
              _ComponentCategory(
                name: 'Nav / Disclosure',
                count: 3,
                components: const ['Accordion', 'Drawer', 'Popover'],
              ),
              SizedBox(height: context.spacing.x2lPlus),
              _HintBadge(),
              SizedBox(height: context.spacing.x3l),
              _FooterText(),
            ],
          ),
        ),
      ),
    ),
  );
}

class _Eyebrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    final colours = context.colors.core;

    return Row(
      children: [
        Container(
          width: spacing.smPlus,
          height: spacing.smPlus,
          decoration: BoxDecoration(color: colours.brand, shape: .circle),
        ),
        SizedBox(width: spacing.smPlus),
        Text(
          'FLUTTER DESIGN SYSTEM',
          style: context.typography.codeMd.copyWith(letterSpacing: 2.8, color: colours.brand),
        ),
      ],
    );
  }
}

class _Headline extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Text('Dievas', style: context.typography.displayLg);
}

class _Subtitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Text(
    "Ports Moon Design System's component catalogue.\n"
    'Token driven. InheritedModel first. Multi brand.',
    style: context.typography.bodyMd.copyWith(height: 2.0, color: context.colors.text.textSecondary),
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
        _StatCell(value: '28', label: 'components'),
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
      crossAxisAlignment: .start,
      children: [
        Text(value, style: context.typography.headingXl),
        SizedBox(height: context.spacing.sm),
        Text(
          label.toUpperCase(),
          style: context.typography.codeMd.copyWith(letterSpacing: 1.8, color: context.colors.text.textTertiary),
        ),
      ],
    ),
  );
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    width: context.spacing.sm - 6,
    margin: .symmetric(horizontal: context.spacing.lg),
    color: context.colors.border.borderDefault,
  );
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) =>
      Text(text.toUpperCase(), style: context.typography.codeMd.copyWith(color: context.colors.text.textTertiary));
}

class _ComponentCategory extends StatelessWidget {
  const _ComponentCategory({required this.name, required this.count, required this.components});

  final String name;
  final int count;
  final List<String> components;

  @override
  Widget build(BuildContext context) {
    final colours = context.colors;
    final spacing = context.spacing;
    final typography = context.typography;

    return Container(
      decoration: BoxDecoration(
        color: colours.background.bgSubtle,
        border: .all(color: context.colors.border.borderDefault),
        borderRadius: context.border.lg,
      ),
      padding: .all(spacing.md),
      child: Row(
        children: [
          Container(
            width: spacing.sm,
            height: spacing.sm,
            decoration: BoxDecoration(color: colours.action.actionSuccess, shape: .circle),
          ),
          SizedBox(width: spacing.smPlus),
          SizedBox(
            width: 80,
            child: Text(
              name,
              style: typography.titleLg.copyWith(color: colours.text.textPrimary, fontWeight: .w500),
            ),
          ),
          SizedBox(width: spacing.smPlus),
          Expanded(
            child: Wrap(
              spacing: context.spacing.sm,
              runSpacing: context.spacing.sm,
              children: [
                for (final component in components)
                  Container(
                    padding: .all(spacing.sm),
                    decoration: BoxDecoration(
                      color: colours.background.bgElevated,
                      borderRadius: context.border.md,
                      border: .all(color: context.colors.border.borderDefault),
                    ),
                    child: Text(component, style: typography.bodyXs.copyWith(color: context.colors.text.textSecondary)),
                  ),
              ],
            ),
          ),
          SizedBox(width: spacing.md),
          Text('$count', style: typography.codeMd.copyWith(color: colours.text.textTertiary)),
        ],
      ),
    );
  }
}

class _HintBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    final colours = context.colors;

    return Container(
      padding: .all(spacing.md),
      decoration: BoxDecoration(
        color: colours.background.bgSubtle,
        border: .all(color: colours.core.brandSubtle),
        borderRadius: context.border.lg,
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          Container(
            width: spacing.sm,
            height: spacing.sm,
            decoration: BoxDecoration(color: colours.core.brand, shape: .circle),
          ),
          SizedBox(width: spacing.smPlus),
          Flexible(
            child: Text(
              'Select a component from the sidebar to explore use cases',
              style: context.typography.codeMd.copyWith(color: colours.text.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Text(
    "Built with Dievas. \n💙 Serticode Inc.",
    style: context.typography.bodyLg.copyWith(color: context.colors.text.textDisabled),
  );
}
