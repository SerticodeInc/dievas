import 'package:dievas/dievas.dart';
import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';
import '../../widgets/component_boundary.dart';

final dropdownComponent = WidgetbookComponent(
  name: 'Dropdown',
  useCases: [
    WidgetbookUseCase(
      name: 'Playground',
      builder: (context) {
        final state = WidgetbookState.of(context);
        final session = _sessions[state] ??= _DropdownSession();
        return _Playground(session: session);
      },
    ),
    WidgetbookUseCase(name: 'Configurations', builder: (ctx) => const _Configurations()),
  ],
);

const _options = ['Piccolo', 'Krillin', 'Roshi'];
const _choices = ['Choice #1', 'Choice #2', 'Choice #3'];
const _nestedOptions = ['Roshi100', 'Roshi60', 'Roshi10'];
const _dropdownGroup = 'dievas-dropdown-playground';

// Widgetbook remounts a use case when its knob URI changes. Keep interaction
// state per Widgetbook instance so an open menu can preview changes to knobs.
final _sessions = Expando<_DropdownSession>();

class _DropdownSession {
  String? value;
  List<String> selected = [];
  String menuValue = 'Piccolo';
  bool choicesOpen = false;
  bool menuOpen = false;
  bool submenuOpen = false;
}

class _Playground extends StatefulWidget {
  const _Playground({required this.session});

  final _DropdownSession session;

  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  _DropdownSession get _session => widget.session;

  @override
  Widget build(BuildContext context) {
    context.knobSection('Position and sizing');
    final anchor = context.knobs.object.dropdown<DievasDropdownAnchorPosition>(
      label: 'Anchor position',
      initialOption: .bottom,
      options: DievasDropdownAnchorPosition.values,
      labelBuilder: (value) => value.name,
    );
    final constrainWidth = context.knobs.boolean(label: 'Constrain width to trigger', initialValue: true);
    final width = context.knobs.double.slider(
      label: 'Maximum width',
      initialValue: context.sizing.width256,
      min: context.sizing.width128,
      max: context.sizing.width256 * 2,
    );
    final distance = context.knobs.double.slider(
      label: 'Distance to trigger',
      initialValue: context.spacing.sm,
      min: context.spacing.none,
      max: context.spacing.xl,
    );
    final maxHeight = context.knobs.double.slider(
      label: 'Maximum height',
      initialValue: context.sizing.height256,
      min: context.sizing.height80,
      max: context.sizing.height256 * 2,
    );

    context.knobSection('Surface');
    final overrideBackground = context.knobs.boolean(label: 'Override background colour');
    final background = context.tokenColourKnob(label: 'Background colour', role: .background, initialValue: .brand);
    final showBorder = context.knobs.boolean(label: 'Show border', initialValue: true);
    final overrideBorder = context.knobs.boolean(label: 'Override border colour');
    final border = context.tokenColourKnob(label: 'Border colour', role: .border, initialValue: .brand);
    final overrideRadius = context.knobs.boolean(label: 'Override border radius');
    final radius = context.knobs.object.dropdown<_DropdownRadius>(
      label: 'Border radius',
      initialOption: .md,
      options: _DropdownRadius.values,
      labelBuilder: (value) => value.name,
    );
    final showShadow = context.knobs.boolean(label: 'Show shadow', initialValue: true);

    context.knobSection('Behaviour');
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
    final multiSelect = context.knobs.boolean(label: 'Multiple choices', initialValue: true);
    final rtl = context.knobs.boolean(label: 'Right to left');

    final selectedRadius = switch (radius) {
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

    return Directionality(
      textDirection: rtl ? .rtl : .ltr,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: context.spacing.xl3, horizontal: context.spacing.sm),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            children: [
              const _SectionTitle('DievasDropdown with multiple choices'),
              Center(
                child: SizedBox(
                  width: context.sizing.width256 + context.spacing.md,
                  child: DievasDropdown<String>(
                    options: _choices,
                    show: _session.choicesOpen,
                    onOpenChanged: (open) => _session.choicesOpen = open,
                    value: _session.value,
                    selectedValues: multiSelect ? _session.selected : null,
                    onChanged: multiSelect ? null : (value) => setState(() => _session.value = value),
                    onMultiChanged: multiSelect ? (values) => setState(() => _session.selected = values) : null,
                    hint: 'Choose an option',
                    triggerBuilder: (context, open, toggle) => _ChoiceTrigger(
                      open: open,
                      onTap: toggle,
                      count: multiSelect ? _session.selected.length : 0,
                      label: multiSelect ? 'Choose an option' : (_session.value ?? 'Choose an option'),
                      onClear: enabled ? () => setState(() => _session.selected = []) : null,
                    ),
                    constrainWidthToChild: constrainWidth,
                    dropdownAnchorPosition: anchor,
                    maxWidth: width,
                    maxHeight: maxHeight,
                    distanceToTarget: distance,
                    backgroundColour: overrideBackground ? background : null,
                    borderColour: overrideBorder ? border : null,
                    showBorder: showBorder,
                    borderRadius: overrideRadius ? selectedRadius : null,
                    showShadow: showShadow,
                    enabled: enabled,
                    optionBuilder: (context, option, selected, select) => _ReferenceMenuItem(
                      label: option,
                      onTap: select,
                      trailing: multiSelect
                          ? DievasCheckbox(
                              value: selected ? .checked : .unchecked,
                              tapAreaSize: context.spacing.none,
                              onChanged: (_) => select(),
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.spacing.xl2),
              const _SectionTitle('DievasDropdown as a menu'),
              Center(
                child: DievasDropdown<String>(
                  groupId: _dropdownGroup,
                  show: _session.menuOpen,
                  onOpenChanged: (open) {
                    _session.menuOpen = open;
                    if (!open) _session.submenuOpen = false;
                  },
                  onChanged: (value) => setState(() => _session.menuValue = value),
                  contentBuilder: (context, select, dismiss) => Column(
                    mainAxisSize: .min,
                    children: [
                      for (final option in _options.take(2))
                        _ReferenceMenuItem(
                          label: option,
                          selected: _session.menuValue == option,
                          onTap: () => select(option),
                        ),
                      DievasDropdown<String>(
                        groupId: _dropdownGroup,
                        show: _session.submenuOpen,
                        onOpenChanged: (open) => _session.submenuOpen = open,
                        onChanged: select,
                        options: _nestedOptions,
                        value: _session.menuValue,
                        optionBuilder: (context, option, selected, select) =>
                            _ReferenceMenuItem(label: option, selected: selected, onTap: select),
                        dropdownAnchorPosition: .right,
                        targetAnchor: rtl ? .topLeft : .topRight,
                        followerAnchor: rtl ? .topRight : .topLeft,
                        offset: Offset(rtl ? -distance : distance, 0),
                        distanceToTarget: distance,
                        constrainWidthToChild: constrainWidth,
                        maxWidth: context.sizing.width160,
                        maxHeight: maxHeight,
                        backgroundColour: overrideBackground ? background : null,
                        borderColour: overrideBorder ? border : null,
                        showBorder: showBorder,
                        borderRadius: overrideRadius ? selectedRadius : null,
                        showShadow: showShadow,
                        enabled: enabled,
                        triggerBuilder: (context, open, toggle) => _ReferenceMenuItem(
                          label: 'Roshi',
                          selected: open,
                          onTap: toggle,
                          trailing: Icon(rtl ? Icons.chevron_left : Icons.chevron_right, size: context.sizing.iconSm),
                        ),
                      ),
                    ],
                  ),
                  dropdownAnchorPosition: anchor,
                  constrainWidthToChild: constrainWidth,
                  maxWidth: width,
                  maxHeight: maxHeight,
                  distanceToTarget: distance,
                  backgroundColour: overrideBackground ? background : null,
                  borderColour: overrideBorder ? border : null,
                  showBorder: showBorder,
                  borderRadius: overrideRadius ? selectedRadius : null,
                  showShadow: showShadow,
                  enabled: enabled,
                  triggerBuilder: (context, open, toggle) => SizedBox(
                    width: context.sizing.width128,
                    child: DievasFilledButton(
                      label: _session.menuValue,
                      size: .sm,
                      isFullWidth: true,
                      onPressed: toggle,
                      // Named swatches in this reference use the exact palette colours.
                      backgroundColor: switch (_session.menuValue) {
                        'Krillin' => const Color(DievasColourPrimitives.amberGold),
                        'Roshi100' => const Color(DievasColourPrimitives.leafGreen),
                        'Roshi60' => const Color(DievasColourPrimitives.leafGreenAlpha8F),
                        'Roshi10' => const Color(DievasColourPrimitives.leafGreenAlpha14),
                        _ => const Color(DievasColourPrimitives.royalPurple),
                      },
                      foregroundColor: switch (_session.menuValue) {
                        'Roshi60' || 'Roshi10' => context.colours.text.textPrimary,
                        _ => context.colours.text.buttonPrimaryText,
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Configurations extends StatelessWidget {
  const _Configurations();

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: .min,
      children: [
        const _DemoBlock(
          'Without label',
          child: SizedBox(
            width: 240,
            child: DievasDropdown<String>(options: _options, hint: 'Choose an option'),
          ),
        ),
        SizedBox(height: context.spacing.lg),
        const _DemoBlock(
          'With label',
          child: SizedBox(
            width: 240,
            child: DievasDropdown<String>(options: _options, value: 'Krillin', label: 'Choose option'),
          ),
        ),
        SizedBox(height: context.spacing.lg),
        const _DemoBlock(
          'Disabled',
          child: SizedBox(
            width: 240,
            child: DievasDropdown<String>(options: _options, hint: 'Choose an option', enabled: false),
          ),
        ),
      ],
    ),
  );
}

enum _DropdownRadius { none, xs, sm, md, lg, xl, xl2, xl3, r28, r32 }

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: context.spacing.xl),
    child: LayoutBuilder(
      builder: (context, constraints) => Row(
        children: [
          const Expanded(child: Divider()),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: constraints.maxWidth - context.spacing.xl),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
              child: Text(
                title,
                textAlign: .center,
                style: context.typography.bodyXs.copyWith(color: context.colours.text.textSecondary),
              ),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    ),
  );
}

class _DemoBlock extends StatelessWidget {
  const _DemoBlock(this.name, {required this.child});
  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    mainAxisSize: .min,
    children: [
      Text(name, style: context.typography.labelXs.copyWith(color: context.colours.text.textTertiary)),
      SizedBox(height: context.spacing.xs),
      ComponentBoundary(child: child),
    ],
  );
}

/// The same read-only input composition as the Moon preview: the placeholder
/// stays visible and the leading count tag clears all selected choices.
class _ChoiceTrigger extends StatelessWidget {
  const _ChoiceTrigger({
    required this.open,
    required this.onTap,
    required this.count,
    required this.label,
    required this.onClear,
  });

  final bool open;
  final VoidCallback? onTap;
  final int count;
  final String label;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).dropdown;
    return GestureDetector(
      behavior: .opaque,
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minHeight: context.sizing.height40),
        padding: theme.triggerPadding,
        decoration: BoxDecoration(
          color: theme.triggerBgColour,
          borderRadius: theme.borderRadius,
          border: Border.all(color: theme.triggerBorderColour, width: context.border.strokeThin),
        ),
        child: Row(
          children: [
            if (count > 0) ...[
              DievasTheme(
                data: DievasTheme.of(context).copyWith(
                  components: DievasTheme.componentsOf(context).copyWith(
                    tag: DievasTheme.componentsOf(context).tag.copyWith(
                      textStyle: context.typography.labelXs,
                      padding: EdgeInsets.all(context.spacing.xs),
                      minHeight: context.sizing.height24,
                      removeIconSize: context.sizing.iconXs,
                      borderWidth: context.border.strokeThin,
                    ),
                  ),
                ),
                child: DievasTag(
                  label: '$count',
                  style: .filled,
                  backgroundColor: context.colours.text.textPrimary,
                  foregroundColor: context.colours.text.textInverse,
                  borderRadius: .rounded(context.border.sm),
                  onPressed: onClear,
                  onRemove: onClear,
                ),
              ),
              SizedBox(width: context.spacing.sm),
            ],
            Expanded(child: Text(label, style: theme.hintStyle)),
            AnimatedRotation(
              turns: open ? -.5 : 0,
              duration: context.animation.quick,
              child: Icon(Icons.keyboard_arrow_down, size: theme.iconSize, color: theme.iconColour),
            ),
          ],
        ),
      ),
    );
  }
}

/// Keep selected and hovered menu rows visible without changing the component
/// currently scheduled for the separate MenuItem improvement pass.
class _ReferenceMenuItem extends StatefulWidget {
  const _ReferenceMenuItem({required this.label, this.onTap, this.trailing, this.selected = false});

  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool selected;

  @override
  State<_ReferenceMenuItem> createState() => _ReferenceMenuItemState();
}

class _ReferenceMenuItemState extends State<_ReferenceMenuItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: widget.onTap == null ? SystemMouseCursors.basic : SystemMouseCursors.click,
    onEnter: (_) => setState(() => _hovered = true),
    onExit: (_) => setState(() => _hovered = false),
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: _hovered || widget.selected ? context.colours.background.listItemSelectedBackground : null,
        borderRadius: context.border.md,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: context.sizing.touchMin),
        child: Align(
          heightFactor: 1,
          child: DievasMenuItem(label: widget.label, trailing: widget.trailing, onTap: widget.onTap),
        ),
      ),
    ),
  );
}
