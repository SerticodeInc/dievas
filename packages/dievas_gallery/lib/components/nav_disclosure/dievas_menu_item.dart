import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';

final menuItemComponent = WidgetbookComponent(
  name: 'MenuItem',
  useCases: [WidgetbookUseCase(name: 'Playground', builder: (_) => const _Playground())],
);

// Keep interactive values across Widgetbook's knob URI remounts.
final _states = Expando<_MenuState>();

class _MenuState {
  DievasCheckboxValue checked = .unchecked;
  bool switched = false;
  bool expanded = false;
  String feedback = '';
}

enum _Radius { none, xs, sm, md, lg, xl, xl2, xl3, r28, r32 }

enum _Spacing {
  none,
  xs,
  sm,
  smPlus,
  md,
  mdPlus,
  lg,
  lgPlus,
  xl;

  double resolve(BuildContext context) => switch (this) {
    .none => context.spacing.none,
    .xs => context.spacing.xs,
    .sm => context.spacing.sm,
    .smPlus => context.spacing.smPlus,
    .md => context.spacing.md,
    .mdPlus => context.spacing.mdPlus,
    .lg => context.spacing.lg,
    .lgPlus => context.spacing.lgPlus,
    .xl => context.spacing.xl,
  };
}

enum _Width {
  width128,
  width160,
  width192,
  width256;

  double resolve(BuildContext context) => switch (this) {
    .width128 => context.sizing.width128,
    .width160 => context.sizing.width160,
    .width192 => context.sizing.width192,
    .width256 => context.sizing.width256,
  };
}

enum _Height {
  height96,
  height128,
  height160,
  height192,
  height256;

  double resolve(BuildContext context) => switch (this) {
    .height96 => context.sizing.height96,
    .height128 => context.sizing.height128,
    .height160 => context.sizing.height160,
    .height192 => context.sizing.height192,
    .height256 => context.sizing.height256,
  };
}

class _Playground extends StatefulWidget {
  const _Playground();

  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  late _MenuState _state;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final book = WidgetbookState.of(context);
    _state = _states[book] ??= _MenuState();
  }

  @override
  Widget build(BuildContext context) {
    context.knobSection('Slots');
    final leading = context.knobs.boolean(label: 'Leading', initialValue: true);
    final selectionLeading = leading ? const Icon(Icons.crop_square) : null;
    final content = context.knobs.boolean(label: 'Content', initialValue: true);
    final trailing = context.knobs.boolean(label: 'Trailing', initialValue: true);
    final customSlots = context.knobs.boolean(label: 'Custom label and content');
    final longLabel = context.knobs.boolean(label: 'Long label');
    context.knobSection('Colours');
    final overrideLeading = context.knobs.boolean(label: 'Override leading colour');
    final leadingColour = context.tokenColourKnob(label: 'Leading colour', role: .icon);
    final overrideLabel = context.knobs.boolean(label: 'Override label colour');
    final labelColour = context.tokenColourKnob(label: 'Label colour', role: .text);
    final overrideContent = context.knobs.boolean(label: 'Override content colour');
    final contentColour = context.tokenColourKnob(label: 'Content colour', role: .text);
    final overrideTrailing = context.knobs.boolean(label: 'Override trailing colour');
    final trailingColour = context.tokenColourKnob(label: 'Trailing colour', role: .icon);
    final overrideBackground = context.knobs.boolean(label: 'Override background colour');
    final backgroundColour = context.tokenColourKnob(label: 'Background colour', role: .background);
    final overrideHover = context.knobs.boolean(label: 'Override hover colour');
    final hoverColour = context.tokenColourKnob(label: 'Hover colour', role: .background);
    context.knobSection('Layout');
    final dense = context.knobs.boolean(label: 'Dense');
    final overrideRadius = context.knobs.boolean(label: 'Override border radius');
    final radius = context.knobs.object.dropdown(
      label: 'Border radius',
      options: _Radius.values,
      initialOption: _Radius.sm,
      labelBuilder: (value) => value.name,
    );
    final overrideGap = context.knobs.boolean(label: 'Override gaps');
    final horizontalGap = context.knobs.object
        .dropdown<_Spacing>(
          label: 'Horizontal gap',
          options: _Spacing.values,
          initialOption: .smPlus,
          labelBuilder: (value) => value.name,
        )
        .resolve(context);
    final verticalGap = context.knobs.object
        .dropdown<_Spacing>(
          label: 'Vertical gap',
          options: _Spacing.values,
          initialOption: .xs,
          labelBuilder: (value) => value.name,
        )
        .resolve(context);
    final overridePadding = context.knobs.boolean(label: 'Override padding');
    final padding = context.knobs.object
        .dropdown<_Spacing>(
          label: 'Padding',
          options: _Spacing.values,
          initialOption: .smPlus,
          labelBuilder: (value) => value.name,
        )
        .resolve(context);
    final overrideWidth = context.knobs.boolean(label: 'Override width');
    final width = context.knobs.object
        .dropdown<_Width>(
          label: 'Width',
          options: _Width.values,
          initialOption: .width256,
          labelBuilder: (value) => value.name,
        )
        .resolve(context);
    final overrideHeight = context.knobs.boolean(label: 'Override height');
    final height = context.knobs.object
        .dropdown<_Height>(
          label: 'Height',
          options: _Height.values,
          initialOption: .height128,
          labelBuilder: (value) => value.name,
        )
        .resolve(context);
    final alignment = context.knobs.object.dropdown(
      label: 'Row alignment',
      options: [CrossAxisAlignment.start, CrossAxisAlignment.center, CrossAxisAlignment.end],
      initialOption: CrossAxisAlignment.center,
      labelBuilder: (value) => value.name,
    );
    final textAlignment = context.knobs.object.dropdown(
      label: 'Label/content alignment',
      options: [CrossAxisAlignment.start, CrossAxisAlignment.center, CrossAxisAlignment.end],
      initialOption: CrossAxisAlignment.start,
      labelBuilder: (value) => value.name,
    );
    context.knobSection('Behaviour');
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
    final absorb = context.knobs.boolean(label: 'Absorb child gestures');
    final rtl = context.knobs.boolean(label: 'Right to left');
    final customDecoration = context.knobs.boolean(label: 'Custom decoration');
    final slowHover = context.knobs.boolean(label: 'Slow hover transition');
    final radiusValue = switch (radius) {
      .none => context.border.none,
      .xs => context.border.xs,
      .sm => context.border.sm,
      .md => context.border.md,
      .lg => context.border.lg,
      .xl => context.border.xl,
      .xl2 => context.border.xl2,
      .xl3 => context.border.xl3,
      .r28 => context.border.r28,
      .r32 => context.border.r32,
    };

    final _MenuAppearance appearance = (
      enabled: enabled,
      dense: dense,
      hoverEffectDuration: slowHover ? const Duration(milliseconds: 600) : null,
      decoration: switch (customDecoration) {
        true => BoxDecoration(
          color: context.colours.core.badgePrimaryTintedBackground,
          borderRadius: radiusValue,
          border: .all(color: context.colours.core.primary),
        ),
        _ => null,
      },
      width: overrideWidth ? width : null,
      height: overrideHeight ? height : null,
      padding: overridePadding ? .all(padding) : null,
      horizontalGap: overrideGap ? horizontalGap : null,
      verticalGap: overrideGap ? verticalGap : null,
      menuItemCrossAxisAlignment: alignment,
      labelAndContentCrossAxisAlignment: textAlignment,
      borderRadius: overrideRadius ? radiusValue : null,
      leadingColour: overrideLeading ? leadingColour : null,
      labelColour: overrideLabel ? labelColour : null,
      contentColour: overrideContent ? contentColour : null,
      trailingColour: overrideTrailing ? trailingColour : null,
      backgroundColour: overrideBackground ? backgroundColour : null,
      hoverEffectColour: overrideHover ? hoverColour : null,
    );

    return Directionality(
      textDirection: rtl ? .rtl : .ltr,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: context.spacing.xl3),
            child: Column(
              mainAxisSize: .min,
              children: [
                const _Section('DievasMenuItem'),
                for (final multiline in [true, false])
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: context.spacing.md),
                    child: _PreviewMenuItem(
                      label: switch ((longLabel, multiline)) {
                        (true, _) => 'A longer menu label that wraps naturally in a narrow viewport',
                        (_, true) => 'Multi-line menu item',
                        _ => 'One-line menu item',
                      },
                      labelWidget: customSlots ? const Text('Custom label widget') : null,
                      content: customSlots && content ? const Text('Caller-owned content widget') : null,
                      subtitle: switch ((content, multiline)) {
                        (false, _) => null,
                        (_, true) => 'Multi-line default content field as an example for DievasMenuItem component.',
                        _ => 'One-line content field example',
                      },
                      leading: leading ? _Leading(multiline: multiline) : null,
                      trailing: trailing ? const Icon(Icons.chevron_right) : null,
                      appearance: appearance,
                      onTap: () => setState(() => _state.feedback = 'Menu item tapped'),
                      onLongPress: () => setState(() => _state.feedback = 'Menu item long pressed'),
                    ),
                  ),
                const _Section('Menu item with selection control'),
                _PreviewMenuItem(
                  label: 'Menu item with DievasCheckbox',
                  leading: selectionLeading,
                  appearance: appearance,
                  absorbGestures: absorb,
                  onTap: () => setState(() => _state.checked = _state.checked == .checked ? .unchecked : .checked),
                  trailing: DievasCheckbox(
                    value: _state.checked,
                    onChanged: enabled ? (value) => setState(() => _state.checked = value) : null,
                  ),
                ),
                SizedBox(height: context.spacing.md),
                _PreviewMenuItem(
                  label: 'Menu item with DievasSwitch',
                  leading: selectionLeading,
                  appearance: appearance,
                  absorbGestures: absorb,
                  onTap: () => setState(() => _state.switched = !_state.switched),
                  trailing: DievasSwitch(
                    value: _state.switched,
                    onChanged: enabled ? (value) => setState(() => _state.switched = value) : null,
                  ),
                ),
                const _Section('Expandable menu item with divider'),
                _PreviewMenuItem(
                  label: 'Expandable menu item',
                  leading: selectionLeading,
                  appearance: appearance,
                  onTap: () => setState(() => _state.expanded = !_state.expanded),
                  trailing: Icon(_state.expanded ? Icons.expand_less : Icons.expand_more),
                ),
                if (_state.expanded)
                  Column(
                    children: DievasMenuItem.divideMenuItems(
                      menuItems: [
                        for (final label in ['Profile', 'Settings', 'Notifications'])
                          _PreviewMenuItem(
                            label: label,
                            appearance: appearance,
                            onTap: () => setState(() => _state.feedback = '$label selected'),
                          ),
                      ],
                    ).toList(),
                  ),
                if (_state.feedback.isNotEmpty)
                  Padding(
                    padding: .all(context.spacing.md),
                    child: Text(_state.feedback, style: context.typography.bodyXs),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef _MenuAppearance = ({
  bool enabled,
  bool dense,
  Duration? hoverEffectDuration,
  Decoration? decoration,
  double? width,
  double? height,
  EdgeInsetsGeometry? padding,
  double? horizontalGap,
  double? verticalGap,
  CrossAxisAlignment menuItemCrossAxisAlignment,
  CrossAxisAlignment labelAndContentCrossAxisAlignment,
  BorderRadiusGeometry? borderRadius,
  Color? leadingColour,
  Color? labelColour,
  Color? contentColour,
  Color? trailingColour,
  Color? backgroundColour,
  Color? hoverEffectColour,
});

/// Apply shared playground overrides without repeating them in each example.
class _PreviewMenuItem extends StatelessWidget {
  const _PreviewMenuItem({
    required this.appearance,
    required this.label,
    this.subtitle,
    this.labelWidget,
    this.content,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.absorbGestures = false,
  });

  final _MenuAppearance appearance;
  final String label;
  final String? subtitle;
  final Widget? labelWidget;
  final Widget? content;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool absorbGestures;

  @override
  Widget build(BuildContext context) => DievasMenuItem(
    label: label,
    subtitle: subtitle,
    labelWidget: labelWidget,
    content: content,
    leading: leading,
    trailing: trailing,
    onTap: onTap,
    onLongPress: onLongPress,
    absorbGestures: absorbGestures,
    enabled: appearance.enabled,
    dense: appearance.dense,
    hoverEffectDuration: appearance.hoverEffectDuration,
    decoration: appearance.decoration,
    width: appearance.width,
    height: appearance.height,
    padding: appearance.padding,
    horizontalGap: appearance.horizontalGap,
    verticalGap: appearance.verticalGap,
    menuItemCrossAxisAlignment: appearance.menuItemCrossAxisAlignment,
    labelAndContentCrossAxisAlignment: appearance.labelAndContentCrossAxisAlignment,
    borderRadius: appearance.borderRadius,
    leadingColour: appearance.leadingColour,
    labelColour: appearance.labelColour,
    contentColour: appearance.contentColour,
    trailingColour: appearance.trailingColour,
    backgroundColour: appearance.backgroundColour,
    hoverEffectColour: appearance.hoverEffectColour,
  );
}

class _Section extends StatelessWidget {
  const _Section(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: .symmetric(vertical: context.spacing.xl),
    child: Row(
      children: [
        const Expanded(child: DievasDivider()),
        Padding(
          padding: .symmetric(horizontal: context.spacing.sm),
          child: Text(
            label,
            textAlign: .center,
            style: context.typography.bodyXs.copyWith(color: context.colours.text.textSecondary),
          ),
        ),
        const Expanded(child: DievasDivider()),
      ],
    ),
  );
}

class _Leading extends StatelessWidget {
  const _Leading({required this.multiline});
  final bool multiline;

  @override
  Widget build(BuildContext context) => Container(
    padding: .all(context.spacing.sm),
    decoration: BoxDecoration(
      color: context.colours.core.badgePrimaryTintedBackground,
      borderRadius: context.border.md,
    ),
    child: Icon(
      multiline ? Icons.airplanemode_active : Icons.show_chart,
      size: multiline ? context.sizing.iconMd : context.sizing.iconSm,
    ),
  );
}
