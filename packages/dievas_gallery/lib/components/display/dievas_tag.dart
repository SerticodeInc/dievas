import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';
import '../../widgets/component_boundary.dart';

final _sessions = Expando<Map<String, _TagSession>>();
final tagComponent = WidgetbookComponent(
  name: 'Tag',
  useCases: [
    for (final name in ['Playground', 'All Styles', 'Interactions'])
      WidgetbookUseCase(
        name: name,
        builder: (context) => _Playground(
          example: name,
          session: (_sessions[WidgetbookState.of(context)] ??= {}).putIfAbsent(name, _TagSession.new),
        ),
      ),
  ],
);

class _TagSession {
  int taps = 0;
  int longPresses = 0;
  bool removed = false;
}

enum _Radius {
  square,
  sm,
  md,
  lg,
  r32,
  pill;

  DievasTagBorderRadius resolve(DievasBorderThemeData border) => switch (this) {
    .square => .rounded(border.none),
    .sm => .rounded(border.sm),
    .md => .rounded(border.md),
    .lg => .rounded(border.lg),
    .r32 => .rounded(border.r32),
    .pill => .pill,
  };
}

enum _Spacing {
  none,
  compact,
  regular,
  roomy;

  double resolve(DievasSpacingThemeData spacing) => switch (this) {
    .none => spacing.none,
    .compact => spacing.xs / 2,
    .regular => spacing.xs,
    .roomy => spacing.sm,
  };
}

enum _Width { natural, compact, regular, wide }

class _Playground extends StatefulWidget {
  const _Playground({required this.example, required this.session});
  final String example;
  final _TagSession session;

  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  @override
  Widget build(BuildContext context) {
    context.knobSection('Content');
    final label = context.knobs.string(label: 'Tag label text', initialValue: 'DievasTag');
    final showLeading = context.knobs.boolean(label: 'Leading');
    final showLabel = context.knobs.boolean(label: 'Label', initialValue: true);
    final showTrailing = context.knobs.boolean(label: 'Trailing', initialValue: true);
    context.knobSection('Size and layout');
    final size = context.knobs.object.dropdown(
      label: 'Size',
      options: DievasTagSize.values,
      initialOption: DievasTagSize.xs,
      labelBuilder: (value) => value.name,
    );
    final style = context.knobs.object.dropdown(
      label: 'Style',
      options: DievasTagStyle.values,
      initialOption: DievasTagStyle.filled,
      labelBuilder: (value) => value.name,
    );
    final overrideRadius = context.knobs.boolean(label: 'Override radius');
    final radius = context.knobs.object.dropdown(
      label: 'Radius',
      options: _Radius.values,
      initialOption: _Radius.sm,
      labelBuilder: (value) => value.name,
    );
    final overrideGap = context.knobs.boolean(label: 'Override gap');
    final gap = context.knobs.object.dropdown(
      label: 'Gap',
      options: _Spacing.values,
      initialOption: _Spacing.compact,
      labelBuilder: (value) => value.name,
    );
    final overridePadding = context.knobs.boolean(label: 'Override padding');
    final padding = context.knobs.object.dropdown(
      label: 'Padding',
      options: _Spacing.values,
      initialOption: _Spacing.roomy,
      labelBuilder: (value) => value.name,
    );
    final width = context.knobs.object.dropdown(
      label: 'Width',
      options: _Width.values,
      initialOption: _Width.natural,
      labelBuilder: (value) => value.name,
    );
    context.knobSection('Colours');
    final overrideText = context.knobs.boolean(label: 'Override text colour');
    final text = context.tokenColourKnob(label: 'Text colour', role: .text, initialValue: .primaryText);
    final overrideIcon = context.knobs.boolean(label: 'Override icon colour');
    final icon = context.tokenColourKnob(label: 'Icon colour', role: .icon, initialValue: .primaryIcon);
    final overrideBackground = context.knobs.boolean(label: 'Override background colour');
    final background = context.tokenColourKnob(label: 'Background colour', role: .background, initialValue: .page);
    final overrideBorder = context.knobs.boolean(label: 'Override border colour');
    final border = context.tokenColourKnob(label: 'Border colour', role: .border, initialValue: .divider);
    context.knobSection('Interaction');
    final tappable = context.knobs.boolean(label: 'Tappable', initialValue: true);
    final longPress = context.knobs.boolean(label: 'Long press', initialValue: true);
    final removable = context.knobs.boolean(label: 'Remove action', initialValue: widget.example == 'Interactions');
    final disabled = context.knobs.boolean(label: 'Disabled');
    final rtl = context.knobs.boolean(label: 'Right to left');
    final theme = DievasTheme.of(context);
    return Directionality(
      textDirection: rtl ? .rtl : .ltr,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: theme.spacing.xl3, horizontal: theme.spacing.md),
          child: Column(
            mainAxisSize: .min,
            children: [
              if (widget.session.removed)
                DievasTextButton(label: 'Restore tag', onPressed: () => setState(() => widget.session.removed = false))
              else
                Wrap(
                  spacing: theme.spacing.md,
                  runSpacing: theme.spacing.md,
                  alignment: .center,
                  children: [
                    for (final variant in widget.example == 'All Styles' ? DievasTagStyle.values : [style])
                      ComponentBoundary(
                        child: DievasTag(
                          key: ValueKey('tag-${variant.name}'),
                          label: showLabel ? label : '',
                          semanticLabel: label,
                          tagSize: size,
                          style: variant,
                          enabled: !disabled,
                          leading: showLeading ? const _CloseGlyph() : null,
                          trailing: showTrailing ? const _CloseGlyph() : null,
                          textColour: overrideText ? text : null,
                          iconColour: overrideIcon ? icon : null,
                          backgroundColor: overrideBackground ? background : null,
                          borderColor: overrideBorder ? border : null,
                          borderRadius: overrideRadius ? radius.resolve(theme.border) : null,
                          gap: overrideGap ? gap.resolve(theme.spacing) : null,
                          padding: overridePadding
                              ? EdgeInsetsDirectional.symmetric(horizontal: padding.resolve(theme.spacing))
                              : null,
                          width: switch (width) {
                            .natural => null,
                            .compact => theme.sizing.width96,
                            .regular => theme.sizing.width160,
                            .wide => theme.sizing.width256,
                          },
                          onPressed: tappable ? () => setState(() => widget.session.taps++) : null,
                          onLongPress: longPress ? () => setState(() => widget.session.longPresses++) : null,
                          onRemove: removable ? () => setState(() => widget.session.removed = true) : null,
                        ),
                      ),
                  ],
                ),
              if (widget.example == 'Interactions' && (widget.session.taps > 0 || widget.session.longPresses > 0))
                Padding(
                  padding: EdgeInsets.only(top: theme.spacing.md),
                  child: Text(
                    'Taps: ${widget.session.taps} · Long presses: ${widget.session.longPresses}',
                    style: theme.typography.bodyXs.copyWith(color: theme.colours.text.textSecondary),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small, light close glyph matching the reference tag's decorative slots.
class _CloseGlyph extends StatelessWidget {
  const _CloseGlyph();

  @override
  Widget build(BuildContext context) {
    final icons = IconTheme.of(context);
    return SizedBox.square(
      dimension: icons.size ?? context.sizing.iconXs,
      child: CustomPaint(
        painter: _ClosePainter(
          colour: icons.color ?? context.colours.icon.iconPrimary,
          stroke: context.border.strokeThin,
        ),
      ),
    );
  }
}

class _ClosePainter extends CustomPainter {
  const _ClosePainter({required this.colour, required this.stroke});
  final Color colour;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = (Offset.zero & size).deflate(size.shortestSide / 4);
    final paint = Paint()
      ..color = colour
      ..style = .stroke
      ..strokeWidth = stroke
      ..strokeCap = .round;
    canvas.drawLine(bounds.topLeft, bounds.bottomRight, paint);
    canvas.drawLine(bounds.topRight, bounds.bottomLeft, paint);
  }

  @override
  bool shouldRepaint(_ClosePainter old) => colour != old.colour || stroke != old.stroke;
}
