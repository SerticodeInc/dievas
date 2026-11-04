import 'package:dievas/dievas.dart';
import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';
import '../../widgets/component_boundary.dart';

final _sessions = Expando<Map<String, _TabSession>>();
final tabBarComponent = WidgetbookComponent(
  name: 'TabBar',
  useCases: [
    for (final name in ['Playground', 'Configurations', 'Custom Content'])
      WidgetbookUseCase(
        name: name,
        builder: (context) => _Playground(
          example: name,
          session: (_sessions[WidgetbookState.of(context)] ??= {}).putIfAbsent(name, _TabSession.new),
        ),
      ),
  ],
);

class _TabSession {
  final selections = <int>[2, 0, 0];
  int controllerIndex = 1;
}

enum _Spacing {
  none,
  compact,
  regular,
  roomy;

  double resolve(DievasSpacingThemeData spacing) => switch (this) {
    .none => spacing.none,
    .compact => spacing.xs,
    .regular => spacing.sm,
    .roomy => spacing.smPlus,
  };
}

enum _Radius {
  square,
  xs,
  sm,
  md,
  lg;

  BorderRadius resolve(DievasBorderThemeData border) => switch (this) {
    .square => BorderRadius.zero,
    .xs => border.xs,
    .sm => border.sm,
    .md => border.md,
    .lg => border.lg,
  };
}

enum _Stroke { none, thin, regular, thick }

enum _Motion { standard, instant, slow }

class _Playground extends StatefulWidget {
  const _Playground({required this.example, required this.session});
  final String example;
  final _TabSession session;

  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this, initialIndex: widget.session.controllerIndex);
    _controller.addListener(_rememberSelection);
  }

  @override
  void dispose() {
    _controller.removeListener(_rememberSelection);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.knobSection('Size and layout');
    final size = context.knobs.object.dropdown(
      label: 'Size',
      options: DievasTabBarSize.values,
      initialOption: DievasTabBarSize.md,
      labelBuilder: (value) => value.name,
    );
    final expanded = context.knobs.boolean(label: 'Expanded');
    final overrideGap = context.knobs.boolean(label: 'Override gap');
    final gap = context.knobs.object.dropdown(
      label: 'Gap',
      options: _Spacing.values,
      initialOption: _Spacing.compact,
      labelBuilder: (value) => value.name,
    );
    final overrideRadius = context.knobs.boolean(label: 'Override pill radius');
    final radius = context.knobs.object.dropdown(
      label: 'Pill radius',
      options: _Radius.values,
      initialOption: _Radius.md,
      labelBuilder: (value) => value.name,
    );
    final overrideIndicator = context.knobs.boolean(label: 'Override indicator height');
    final stroke = context.knobs.object.dropdown(
      label: 'Indicator height',
      options: _Stroke.values,
      initialOption: _Stroke.thick,
      labelBuilder: (value) => value.name,
    );
    final divider = context.knobs.boolean(label: 'Show baseline divider');
    context.knobSection('Colours');
    final overrideText = context.knobs.boolean(label: 'Override text colour');
    final text = context.tokenColourKnob(label: 'Text colour', role: .text, initialValue: .primaryText);
    final overrideSelected = context.knobs.boolean(label: 'Override selected text colour');
    final selected = context.tokenColourKnob(label: 'Selected text colour', role: .text, initialValue: .brand);
    final overrideIndicatorColour = context.knobs.boolean(label: 'Override indicator colour');
    final indicator = context.tokenColourKnob(label: 'Indicator colour', role: .border, initialValue: .brand);
    final overridePill = context.knobs.boolean(label: 'Override selected pill colour');
    final pill = context.tokenColourKnob(label: 'Selected pill colour', role: .background, initialValue: .page);
    context.knobSection('Content');
    final leading = context.knobs.boolean(label: 'Leading');
    final label = context.knobs.boolean(label: 'Label', initialValue: true);
    final trailing = context.knobs.boolean(label: 'Trailing');
    context.knobSection('Interaction');
    final disabled = context.knobs.boolean(label: 'Disabled');
    final rtl = context.knobs.boolean(label: 'Right to left');
    final motion = context.knobs.object.dropdown(
      label: 'Motion',
      options: _Motion.values,
      initialOption: _Motion.standard,
      labelBuilder: (value) => value.name,
    );
    final theme = DievasTheme.of(context);
    final duration = switch ((MediaQuery.disableAnimationsOf(context), motion)) {
      (true, _) || (_, .instant) => Duration.zero,
      (_, .standard) => theme.animation.standard,
      (_, .slow) => const Duration(milliseconds: 600),
    };
    final style = DievasTabStyle(
      textColour: overrideText ? text : null,
      selectedTextColour: overrideSelected ? selected : null,
      indicatorColour: overrideIndicatorColour ? indicator : null,
      selectedBackgroundColour: overridePill ? pill : null,
      borderRadius: overrideRadius ? radius.resolve(theme.border) : null,
      indicatorHeight: switch ((overrideIndicator, stroke)) {
        (false, _) => null,
        (_, .none) => 0,
        (_, .thin) => theme.border.strokeThin,
        (_, .regular) => theme.border.strokeDefault,
        (_, .thick) => theme.border.strokeThick,
      },
    );
    return Directionality(
      textDirection: rtl ? .rtl : .ltr,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: theme.spacing.xl3, horizontal: theme.spacing.md),
          child: Column(
            mainAxisSize: .min,
            children: [
              for (int example = 0; example < 3; example++) ...[
                _SectionTitle(
                  label: switch (example) {
                    0 => 'DievasTabBar',
                    1 => 'DievasTabBar with disabled tab',
                    _ => 'Pill DievasTabBar',
                  },
                  first: example == 0,
                ),
                ComponentBoundary(
                  child: DievasTabBar(
                    key: ValueKey('reference-$example'),
                    variant: switch ((widget.example, example)) {
                      ('Custom Content', _) => .custom,
                      (_, 2) => .pill,
                      _ => .underline,
                    },
                    selectedIndex: widget.session.selections.elementAt(example),
                    onChanged: (index) => setState(() => widget.session.selections[example] = index),
                    enabled: !disabled,
                    tabBarSize: size,
                    isExpanded: expanded,
                    gap: overrideGap ? gap.resolve(theme.spacing) : null,
                    tabStyle: style,
                    transitionDuration: duration,
                    showDivider: divider,
                    items: [
                      for (int index = 0; index < (example == 1 ? 4 : 3); index++)
                        DievasTab(
                          enabled: example != 1 || index != 1,
                          semanticLabel: 'Example ${example + 1}, tab ${index + 1}',
                          leading: leading && example != 1 ? const _FrameIcon() : null,
                          label: label && example != 1 ? Text('Tab${index + 1}') : null,
                          trailing: trailing || example == 1 ? const _FrameIcon() : null,
                          builder: widget.example == 'Custom Content'
                              ? (context, selected) => _CustomTab(index: index, selected: selected)
                              : null,
                        ),
                    ],
                  ),
                ),
              ],
              const _SectionTitle(label: 'Custom DievasTabBar with TabBarView'),
              ComponentBoundary(
                child: DievasTabBar(
                  key: const ValueKey('controller-tabs'),
                  tabs: const ['Tab1', 'Tab2', 'Tab3'],
                  tabController: _controller,
                  enabled: !disabled,
                  tabBarSize: size,
                  isExpanded: true,
                  tabStyle: style,
                  gap: overrideGap ? gap.resolve(theme.spacing) : null,
                  transitionDuration: duration,
                  showDivider: divider,
                ),
              ),
              SizedBox(
                height: theme.sizing.height96 + theme.spacing.md,
                child: TabBarView(
                  controller: _controller,
                  physics: disabled ? const NeverScrollableScrollPhysics() : null,
                  children: [
                    for (int index = 0; index < 3; index++)
                      _TabPage(index: index, controller: _controller, enabled: !disabled, duration: duration),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _rememberSelection() => widget.session.controllerIndex = _controller.index;
}

class _TabPage extends StatelessWidget {
  const _TabPage({required this.index, required this.controller, required this.enabled, required this.duration});
  final int index;
  final TabController controller;
  final bool enabled;
  final Duration duration;

  @override
  Widget build(BuildContext context) => ColoredBox(
    key: ValueKey('tab-page-$index'),
    color: Color(index == 1 ? DievasColourPrimitives.royalPurpleAlpha8F : DievasColourPrimitives.royalBlueAlpha8F),
    child: Padding(
      padding: EdgeInsets.all(context.spacing.md),
      child: Row(
        children: [
          SizedBox(
            width: context.sizing.width40,
            child: index > 0
                ? DievasIconButton(
                    icon: const _PageChevron(previous: true),
                    semanticLabel: 'Previous tab',
                    onPressed: enabled ? () => controller.animateTo(index - 1, duration: duration) : null,
                  )
                : null,
          ),
          Expanded(
            child: Center(child: Text('Tab${index + 1}', style: context.typography.bodyMd)),
          ),
          SizedBox(
            width: context.sizing.width40,
            child: index < 2
                ? DievasIconButton(
                    icon: const _PageChevron(previous: false),
                    semanticLabel: 'Next tab',
                    onPressed: enabled ? () => controller.animateTo(index + 1, duration: duration) : null,
                  )
                : null,
          ),
        ],
      ),
    ),
  );
}

class _CustomTab extends StatelessWidget {
  const _CustomTab({required this.index, required this.selected});
  final int index;
  final bool selected;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: context.spacing.sm),
    child: Row(
      mainAxisSize: .min,
      children: [
        Icon(selected ? Icons.star : Icons.star_border),
        SizedBox(width: context.spacing.xs),
        Text('${index + 1}'),
      ],
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.label, this.first = false});
  final String label;
  final bool first;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(top: first ? 0 : context.spacing.xl2, bottom: context.spacing.xl),
    child: LayoutBuilder(
      builder: (context, constraints) => Row(
        children: [
          const Expanded(child: DievasDivider()),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: constraints.maxWidth - context.spacing.xl),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
              child: Text(
                label,
                maxLines: 1,
                overflow: .ellipsis,
                style: context.typography.bodyXs.copyWith(color: context.colours.text.textSecondary),
              ),
            ),
          ),
          const Expanded(child: DievasDivider()),
        ],
      ),
    ),
  );
}

class _FrameIcon extends StatelessWidget {
  const _FrameIcon();
  @override
  Widget build(BuildContext context) {
    final icons = IconTheme.of(context);
    return SizedBox.square(
      dimension: icons.size ?? context.sizing.iconMd,
      child: CustomPaint(
        painter: _FramePainter(
          colour: icons.color ?? context.colours.icon.iconPrimary,
          stroke: context.border.strokeThin,
        ),
      ),
    );
  }
}

class _FramePainter extends CustomPainter {
  const _FramePainter({required this.colour, required this.stroke});
  final Color colour;
  final double stroke;
  @override
  void paint(Canvas canvas, Size size) {
    final bounds = (Offset.zero & size).deflate(size.shortestSide / 4);
    final paint = Paint()
      ..color = colour
      ..style = .stroke
      ..strokeWidth = stroke;
    final radius = size.shortestSide / 12;
    canvas.drawLine(bounds.topLeft + Offset(radius, 0), bounds.topRight - Offset(radius, 0), paint);
    canvas.drawLine(bounds.bottomLeft + Offset(radius, 0), bounds.bottomRight - Offset(radius, 0), paint);
    canvas.drawLine(bounds.topLeft + Offset(0, radius), bounds.bottomLeft - Offset(0, radius), paint);
    canvas.drawLine(bounds.topRight + Offset(0, radius), bounds.bottomRight - Offset(0, radius), paint);
    for (final point in [bounds.topLeft, bounds.topRight, bounds.bottomLeft, bounds.bottomRight]) {
      canvas.drawCircle(point, radius, paint);
    }
  }

  @override
  bool shouldRepaint(_FramePainter old) => colour != old.colour || stroke != old.stroke;
}

class _PageChevron extends StatelessWidget {
  const _PageChevron({required this.previous});
  final bool previous;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: context.sizing.iconMd,
    child: CustomPaint(
      painter: _ChevronPainter(
        colour: context.colours.text.textPrimary,
        stroke: context.border.strokeThin,
        pointsLeft: previous != (Directionality.of(context) == TextDirection.rtl),
      ),
    ),
  );
}

class _ChevronPainter extends CustomPainter {
  const _ChevronPainter({required this.colour, required this.stroke, required this.pointsLeft});
  final Color colour;
  final double stroke;
  final bool pointsLeft;

  @override
  void paint(Canvas canvas, Size size) {
    final outerX = size.width * (pointsLeft ? 0.625 : 0.375);
    final innerX = size.width * (pointsLeft ? 0.375 : 0.625);
    canvas.drawPath(
      Path()
        ..moveTo(outerX, size.height / 4)
        ..lineTo(innerX, size.height / 2)
        ..lineTo(outerX, size.height * 3 / 4),
      Paint()
        ..color = colour
        ..style = .stroke
        ..strokeWidth = stroke
        ..strokeCap = .round
        ..strokeJoin = .round,
    );
  }

  @override
  bool shouldRepaint(_ChevronPainter old) =>
      colour != old.colour || stroke != old.stroke || pointsLeft != old.pointsLeft;
}
