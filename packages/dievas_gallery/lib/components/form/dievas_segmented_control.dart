import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';
import '../../widgets/component_boundary.dart';

final _sessions = Expando<Map<String, _SegmentSession>>();
final segmentedControlComponent = WidgetbookComponent(
  name: 'SegmentedControl',
  useCases: [
    for (final name in ['Playground', 'Configurations', 'Custom content', 'Controller'])
      WidgetbookUseCase(
        name: name,
        builder: (context) => _Playground(
          example: name,
          session: (_sessions[WidgetbookState.of(context)] ??= {}).putIfAbsent(name, _SegmentSession.new),
        ),
      ),
  ],
);

enum _TextTab { tab1, tab2, tab3 }

enum _IconTab { first, second, third, fourth }

class _SegmentSession {
  _TextTab text = .tab1;
  _IconTab icon = .first;
}

enum _Radius {
  none,
  sm,
  md,
  lg,
  xl,
  r32;

  BorderRadius resolve(DievasBorderThemeData border) => switch (this) {
    .none => border.none,
    .sm => border.sm,
    .md => border.md,
    .lg => border.lg,
    .xl => border.xl,
    .r32 => border.r32,
  };
}

enum _Spacing {
  none,
  xs,
  sm,
  smPlus,
  md;

  double resolve(DievasSpacingThemeData spacing) => switch (this) {
    .none => 0,
    .xs => spacing.xs,
    .sm => spacing.sm,
    .smPlus => spacing.smPlus,
    .md => spacing.md,
  };
}

class _Playground extends StatefulWidget {
  const _Playground({required this.example, required this.session});
  final String example;
  final _SegmentSession session;
  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.of(context);
    context.knobSection('Surface');
    final overrideBackground = context.knobs.boolean(label: 'Override background colour');
    final background = context.tokenColourKnob(label: 'Background colour', role: .background);
    final overrideSelected = context.knobs.boolean(label: 'Override selected background colour');
    final selected = context.tokenColourKnob(
      label: 'Selected background colour',
      role: .background,
      initialValue: .page,
    );
    final overrideText = context.knobs.boolean(label: 'Override text colour');
    final text = context.tokenColourKnob(label: 'Text colour', role: .text);
    final overrideSelectedText = context.knobs.boolean(label: 'Override selected text colour');
    final selectedText = context.tokenColourKnob(label: 'Selected text colour', role: .text);
    final overrideRadius = context.knobs.boolean(label: 'Override container radius');
    final radius = context.knobs.object.dropdown(
      label: 'Container radius',
      options: _Radius.values,
      initialOption: _Radius.lg,
      labelBuilder: (value) => value.name,
    );
    final overrideSegmentRadius = context.knobs.boolean(label: 'Override segment radius');
    final segmentRadius = context.knobs.object.dropdown(
      label: 'Segment radius',
      options: _Radius.values,
      initialOption: _Radius.md,
      labelBuilder: (value) => value.name,
    );
    final decoration = context.knobs.boolean(label: 'Custom segment decoration');
    context.knobSection('Layout');
    final size = context.knobs.object.dropdown(
      label: 'Size',
      options: DievasSegmentedControlSize.values,
      initialOption: DievasSegmentedControlSize.md,
      labelBuilder: (value) => value.name,
    );
    final gap = context.knobs.object.dropdown(
      label: 'Gap',
      options: _Spacing.values,
      initialOption: _Spacing.xs,
      labelBuilder: (value) => value.name,
    );
    final containerPadding = context.knobs.object.dropdown(
      label: 'Container padding',
      options: _Spacing.values,
      initialOption: _Spacing.xs,
      labelBuilder: (value) => value.name,
    );
    final expanded = context.knobs.boolean(label: 'Expanded');
    final rtl = context.knobs.boolean(label: 'Right to left');
    context.knobSection('Content');
    final leading = context.knobs.boolean(label: 'Leading');
    final label = context.knobs.boolean(label: 'Label', initialValue: true);
    final trailing = context.knobs.boolean(label: 'Trailing');
    context.knobSection('Interaction');
    final disabled = context.knobs.boolean(label: 'Disabled');
    final animate = context.knobs.boolean(label: 'Animate', initialValue: true);
    final style = DievasSegmentStyle(
      selectedBackgroundColour: overrideSelected ? selected : null,
      textColour: overrideText ? text : null,
      selectedTextColour: overrideSelectedText ? selectedText : null,
      borderRadius: overrideSegmentRadius ? segmentRadius.resolve(theme.border) : null,
      decoration: switch (decoration) {
        true => BoxDecoration(
          color: selected,
          borderRadius: segmentRadius.resolve(theme.border),
          border: Border.all(color: text, width: theme.border.strokeThin),
        ),
        false => null,
      },
    );
    final appearance = (
      style: style,
      background: overrideBackground ? background : null,
      radius: overrideRadius ? radius.resolve(theme.border) : null,
      size: size,
      gap: gap.resolve(theme.spacing),
      padding: EdgeInsets.all(containerPadding.resolve(theme.spacing)),
      expanded: expanded,
      enabled: !disabled,
      duration: animate ? null : Duration.zero,
    );

    return Directionality(
      textDirection: rtl ? .rtl : .ltr,
      child: Center(
        child: SingleChildScrollView(
          padding: .symmetric(vertical: theme.spacing.xl3, horizontal: theme.spacing.md),
          child: Column(
            mainAxisSize: .min,
            children: [
              const _SectionTitle(label: 'Segmented control'),
              ComponentBoundary(
                child: DievasSegmentedControl<_TextTab>(
                  value: widget.session.text,
                  onChanged: (value) => setState(() => widget.session.text = value),
                  segments: [
                    for (final tab in _TextTab.values)
                      DievasSegment(
                        value: tab,
                        leading: leading ? const _FrameIcon() : null,
                        label: label ? Text('Tab${tab.index + 1}') : null,
                        trailing: trailing ? const _FrameIcon() : null,
                        semanticLabel: 'Tab ${tab.index + 1}',
                        style: appearance.style,
                      ),
                  ],
                  size: appearance.size,
                  enabled: appearance.enabled,
                  isExpanded: appearance.expanded,
                  backgroundColour: appearance.background,
                  borderRadius: appearance.radius,
                  padding: appearance.padding,
                  gap: appearance.gap,
                  transitionDuration: appearance.duration,
                  segmentBuilder: switch (widget.example) {
                    'Custom content' => (context, tab, selected) => _CustomContent(label: tab.name, selected: selected),
                    _ => null,
                  },
                ),
              ),
              SizedBox(height: theme.spacing.xl3),
              const _SectionTitle(label: 'With icons'),
              ComponentBoundary(
                child: DievasSegmentedControl<_IconTab>(
                  value: widget.session.icon,
                  onChanged: (value) => setState(() => widget.session.icon = value),
                  segments: [
                    for (final tab in _IconTab.values)
                      DievasSegment(
                        value: tab,
                        trailing: const _FrameIcon(),
                        semanticLabel: 'Icon ${tab.index + 1}',
                        style: appearance.style,
                      ),
                  ],
                  size: appearance.size,
                  enabled: appearance.enabled,
                  isExpanded: appearance.expanded,
                  backgroundColour: appearance.background,
                  borderRadius: appearance.radius,
                  padding: appearance.padding,
                  gap: appearance.gap,
                  transitionDuration: appearance.duration,
                ),
              ),
              if (widget.example == 'Configurations') ...[
                SizedBox(height: theme.spacing.xl3),
                DievasSegmentedControl<_TextTab>(
                  options: _TextTab.values,
                  value: widget.session.text,
                  size: .sm,
                  enabled: false,
                  labelBuilder: (tab) => tab.name,
                ),
              ],
              if (widget.example == 'Controller') ...[SizedBox(height: theme.spacing.xl3), const _ControllerExample()],
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Padding(
    padding: .only(bottom: context.spacing.xl),
    child: Row(
      children: [
        const Expanded(child: DievasDivider()),
        Padding(
          padding: .symmetric(horizontal: context.spacing.md),
          child: Text(label, style: context.typography.bodyXs.copyWith(color: context.colours.text.textSecondary)),
        ),
        const Expanded(child: DievasDivider()),
      ],
    ),
  );
}

class _CustomContent extends StatelessWidget {
  const _CustomContent({required this.label, required this.selected});
  final String label;
  final bool selected;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: .min,
    children: [
      if (selected) ...[const Icon(Icons.check), SizedBox(width: context.spacing.xs)],
      Text(label),
    ],
  );
}

class _ControllerExample extends StatefulWidget {
  const _ControllerExample();
  @override
  State<_ControllerExample> createState() => _ControllerExampleState();
}

class _ControllerExampleState extends State<_ControllerExample> with SingleTickerProviderStateMixin {
  late final _controller = TabController(length: _TextTab.values.length, vsync: this);
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    children: [
      DievasSegmentedControl<_TextTab>(
        options: _TextTab.values,
        value: .tab1,
        tabController: _controller,
        labelBuilder: (tab) => tab.name,
      ),
      DievasTextButton(label: 'Select third tab', onPressed: () => _controller.animateTo(_TextTab.tab3.index)),
    ],
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
