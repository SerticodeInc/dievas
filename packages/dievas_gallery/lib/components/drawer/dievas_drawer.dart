import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';

final drawerComponent = WidgetbookComponent(
  name: 'Drawer',
  useCases: [WidgetbookUseCase(name: 'Playground', builder: (ctx) => const _Playground())],
);

class _Playground extends StatefulWidget {
  const _Playground();

  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  final _drawerKey = GlobalKey<DievasDrawerState>();
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    context.knobSection('Colours');
    final overrideBackground = context.knobs.boolean(label: 'Override background colour');
    final background = context.tokenColourKnob(label: 'Background colour', role: .background);
    final overrideBarrier = context.knobs.boolean(label: 'Override barrier colour');
    final barrier = context.tokenColourKnob(label: 'Barrier colour', role: .background);
    context.knobSection('Layout');
    final overrideRadius = context.knobs.boolean(label: 'Override border radius');
    final radius = context.knobs.object.dropdown<_DrawerRadius>(
      label: 'Border radius',
      options: _DrawerRadius.values,
      labelBuilder: (value) => '${value.name} (${value.resolve(context).topRight.x.toStringAsFixed(0)} px)',
    );
    final overrideWidth = context.knobs.boolean(label: 'Override width');
    final width = context.knobs.double.slider(label: 'Width', initialValue: 200, min: 120, max: 440);
    final alignment = context.knobs.object.dropdown<DrawerAlignment>(
      label: 'Placement',
      options: DrawerAlignment.values,
      labelBuilder: (value) => value.name,
    );
    final rtl = context.knobs.boolean(label: 'Right to left');
    context.knobSection('Interaction');
    final drag = context.knobs.boolean(label: 'Edge swipe to open', initialValue: true);
    final dismiss = context.knobs.boolean(label: 'Dismiss on barrier tap', initialValue: true);
    final shadows = context.knobs.boolean(label: 'Show shadows', initialValue: false);

    return Directionality(
      textDirection: rtl ? .rtl : .ltr,
      child: DievasDrawer(
        key: _drawerKey,
        width: overrideWidth ? width : MediaQuery.sizeOf(context).width * 0.8,
        backgroundColour: overrideBackground ? background : null,
        barrierColour: overrideBarrier ? barrier : null,
        borderRadius: switch ((overrideRadius, alignment)) {
          (false, _) => context.border.none,
          (true, .start) => BorderRadiusDirectional.horizontal(end: radius.resolve(context).topRight),
          (true, .end) => BorderRadiusDirectional.horizontal(start: radius.resolve(context).topLeft),
        },
        shadow: shadows ? null : const [],
        alignment: alignment,
        semanticLabel: 'Example navigation',
        enableOpenDragGesture: drag,
        barrierDismissible: dismiss,
        onChanged: (value) => setState(() => _isOpen = value),
        drawer: Center(
          child: Column(
            mainAxisSize: .min,
            children: [
              const Text('DievasDrawer'),
              SizedBox(height: context.spacing.xl),
              DievasFilledButton(label: 'Close', onPressed: () => _drawerKey.currentState?.close()),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: .min,
            children: [
              Text(_isOpen ? 'Drawer open' : 'Drawer closed'),
              SizedBox(height: context.spacing.xl),
              DievasFilledButton(label: 'Open drawer', onPressed: () => _drawerKey.currentState?.open()),
            ],
          ),
        ),
      ),
    );
  }
}

/// Semantic radius choices supported by the drawer playground.
enum _DrawerRadius {
  none,
  xs,
  sm,
  md,
  lg,
  xl,
  xl2,
  xl3,
  r28,
  r32;

  BorderRadius resolve(BuildContext context) => switch (this) {
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
}
