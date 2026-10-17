import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';
import '../../widgets/component_boundary.dart';

final bottomSheetComponent = WidgetbookComponent(
  name: 'BottomSheet',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (_) => const _Playground()),
    WidgetbookUseCase(name: 'With Drag Handle', builder: (_) => const _Playground()),
    WidgetbookUseCase(name: 'No Handle', builder: (_) => const _Playground(initialHandle: false)),
    WidgetbookUseCase(name: 'Content fit', builder: (_) => const _Playground(initialFit: true, initialCount: 3)),
    WidgetbookUseCase(name: 'Keyboard form', builder: (_) => const _Playground(keyboard: true)),
  ],
);

typedef _SheetOptions = ({
  bool handle,
  bool close,
  bool customTrailing,
  bool divider,
  bool footer,
  bool keyboard,
  bool dismissible,
  bool drag,
  bool expanded,
  bool safeArea,
  bool scrollControlled,
  bool fitContent,
  bool resize,
  double maxHeightFactor,
  double padding,
  int itemCount,
  Color? closeBackground,
  Color? background,
  Color? barrier,
  Color? handleColour,
  BorderRadius? radius,
  double? heightFactor,
  double? threshold,
  Duration? duration,
  Curve? curve,
  String title,
});

class _Playground extends StatelessWidget {
  const _Playground({
    this.initialHandle = true,
    this.keyboard = false,
    this.initialFit = false,
    this.initialCount = 30,
  });
  final bool initialHandle;
  final bool keyboard;
  final bool initialFit;
  final int initialCount;

  @override
  Widget build(BuildContext context) {
    context.knobSection('Surface');
    final overrideBackground = context.knobs.boolean(label: 'Override background colour');
    final background = context.tokenColourKnob(label: 'Background colour', role: .background);
    final overrideBarrier = context.knobs.boolean(label: 'Override barrier colour');
    final barrier = context.tokenColourKnob(label: 'Barrier colour', role: .background);
    final barrierOpacity = context.knobs.double.slider(label: 'Barrier opacity', initialValue: 0.56, min: 0, max: 1);
    final overrideRadius = context.knobs.boolean(label: 'Override border radius');
    final radius = context.knobs.double.slider(label: 'Border radius', initialValue: 8, min: 0, max: 48);
    context.knobSection('Layout');
    final fitContent = context.knobs.boolean(label: 'Fit content', initialValue: initialFit);
    final resize = context.knobs.boolean(label: 'Allow upward expansion', initialValue: true);
    final maxHeight = context.knobs.double.slider(
      label: 'Maximum height fraction',
      initialValue: 0.9,
      min: 0.5,
      max: 1,
    );
    final expanded = context.knobs.boolean(label: 'Expanded');
    final overrideHeight = context.knobs.boolean(label: 'Override height', initialValue: true);
    final height = context.knobs.double.slider(label: 'Height fraction', initialValue: 0.64, min: 0.2, max: 1);
    final safeArea = context.knobs.boolean(label: 'Use safe area', initialValue: true);
    final scrollControlled = context.knobs.boolean(label: 'Scroll controlled', initialValue: true);
    context.knobSection('Dismissal');
    final dismissible = context.knobs.boolean(label: 'Barrier and Escape dismissal', initialValue: true);
    final drag = context.knobs.boolean(label: 'Enable drag', initialValue: true);
    final overrideThreshold = context.knobs.boolean(label: 'Override close progress threshold');
    final threshold = context.knobs.double.slider(
      label: 'Close progress threshold',
      initialValue: 0.6,
      min: 0.1,
      max: 0.9,
    );
    context.knobSection('Header and content');
    final title = context.knobs.string(label: 'Title', initialValue: 'Pick your choice!');
    final itemCount = context.knobs.object.dropdown<int>(
      label: 'Item count',
      options: const [3, 6, 12, 30],
      initialOption: initialCount,
      labelBuilder: (value) => '$value',
    );
    final padding = context.knobs.double.slider(
      label: 'General horizontal padding',
      initialValue: context.spacing.SM,
      min: 0,
      max: 40,
    );
    final handle = context.knobs.boolean(label: 'Show drag handle', initialValue: initialHandle);
    final overrideHandle = context.knobs.boolean(label: 'Override handle colour');
    final handleColour = context.tokenColourKnob(label: 'Handle colour', role: .border);
    final customTrailing = context.knobs.boolean(label: 'Custom trailing action');
    final close = context.knobs.boolean(label: 'Show close button', initialValue: true);
    final overrideCloseBackground = context.knobs.boolean(label: 'Override close button background');
    final closeBackground = context.tokenColourKnob(label: 'Close button background', role: .background);
    final divider = context.knobs.boolean(label: 'Show header divider', initialValue: true);
    final footer = context.knobs.boolean(label: 'Show footer');
    final form = context.knobs.boolean(label: 'Keyboard form', initialValue: keyboard);
    context.knobSection('Motion');
    final overrideMotion = context.knobs.boolean(label: 'Override transition duration');
    final duration = context.knobs.double.slider(label: 'Transition milliseconds', initialValue: 300, min: 0, max: 800);
    final overrideCurve = context.knobs.boolean(label: 'Override transition curve');
    final curve = context.knobs.object.dropdown<Curve>(
      label: 'Transition curve',
      options: const [Curves.easeOutCubic, Curves.easeInOut, Curves.linear],
      labelBuilder: (value) => value.toString(),
    );
    final options = (
      fitContent: fitContent,
      resize: resize,
      maxHeightFactor: maxHeight,
      padding: padding,
      itemCount: itemCount,
      closeBackground: overrideCloseBackground ? closeBackground : null,
      handle: handle,
      close: close,
      customTrailing: customTrailing,
      divider: divider,
      footer: footer,
      keyboard: form,
      dismissible: dismissible,
      drag: drag,
      expanded: expanded,
      safeArea: safeArea,
      scrollControlled: scrollControlled,
      background: overrideBackground ? background : null,
      barrier: overrideBarrier ? barrier.withValues(alpha: barrierOpacity) : null,
      handleColour: overrideHandle ? handleColour : null,
      radius: overrideRadius ? BorderRadius.vertical(top: Radius.circular(radius)) : null,
      heightFactor: overrideHeight ? height : null,
      threshold: overrideThreshold ? threshold : null,
      duration: overrideMotion ? Duration(milliseconds: duration.round()) : null,
      curve: overrideCurve ? curve : null,
      title: title,
    );
    // The local navigator keeps the modal inside Widgetbook's device preview.
    return Navigator(
      pages: [MaterialPage(child: _LaunchPanel(options: options))],
      onDidRemovePage: (_) {},
    );
  }
}

class _LaunchPanel extends StatefulWidget {
  const _LaunchPanel({required this.options});
  final _SheetOptions options;
  @override
  State<_LaunchPanel> createState() => _LaunchPanelState();
}

class _LaunchPanelState extends State<_LaunchPanel> {
  bool _open = false;
  String? _result;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: .min,
      children: [
        ComponentBoundary(
          child: DievasFilledButton(label: 'Open bottom sheet', onPressed: _open ? null : _show),
        ),
        if (_result case final text?) Padding(padding: EdgeInsets.all(context.spacing.LG), child: Text(text)),
      ],
    ),
  );

  Future<void> _show() async {
    setState(() => _open = true);
    final options = widget.options;
    final result = await showDievasBottomSheet<int>(
      context: context,
      isDismissible: options.dismissible,
      enableDrag: options.drag,
      isExpanded: options.expanded,
      fitContent: options.fitContent,
      enableResize: options.resize,
      maxHeightFactor: options.maxHeightFactor,
      useSafeArea: options.safeArea,
      isScrollControlled: options.scrollControlled,
      backgroundColour: options.background,
      barrierColour: options.barrier,
      borderRadius: options.radius,
      heightFactor: options.heightFactor,
      closeProgressThreshold: options.threshold,
      transitionDuration: options.duration,
      transitionCurve: options.curve,
      semanticLabel: options.title,
      builder: (_) => _SheetContents(options: options),
    );
    if (mounted) {
      setState(() {
        _open = false;
        _result = switch (result) {
          final index? => 'Selected item $index',
          _ => 'Sheet dismissed',
        };
      });
    }
  }
}

class _SheetContents extends StatelessWidget {
  const _SheetContents({required this.options});
  final _SheetOptions options;

  @override
  Widget build(BuildContext context) => DievasBottomSheet(
    title: options.title,
    trailing: options.customTrailing
        ? DievasTextButton(label: 'Done', onPressed: () => closeDievasBottomSheet(context))
        : null,
    padding: EdgeInsets.symmetric(horizontal: options.padding),
    closeButtonBackgroundColour: options.closeBackground,
    showCloseButton: options.close,
    showDragHandle: options.handle,
    showHeaderDivider: options.divider,
    handleColour: options.handleColour,
    footer: options.footer
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: context.spacing.MD),
            child: DievasFilledButton(label: 'Done', onPressed: () => closeDievasBottomSheet(context)),
          )
        : null,
    child: options.keyboard
        ? const _SheetForm()
        : ListView.builder(
            itemCount: options.itemCount,
            padding: EdgeInsets.zero,
            shrinkWrap: options.fitContent,
            itemBuilder: (context, index) => ListTile(
              contentPadding: EdgeInsets.zero,
              hoverColor: Colors.transparent,
              title: const Text('Item nr:'),
              trailing: Text('$index'),
              onTap: () => closeDievasBottomSheet(context, index),
            ),
          ),
  );
}

class _SheetForm extends StatelessWidget {
  const _SheetForm();
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.symmetric(vertical: context.spacing.LG),
    child: Column(
      mainAxisSize: .min,
      children: [
        const TextField(decoration: InputDecoration(labelText: 'Name')),
        SizedBox(height: context.spacing.LG),
        const TextField(
          decoration: InputDecoration(labelText: 'Email'),
          keyboardType: .emailAddress,
        ),
        SizedBox(height: context.spacing.LG),
        DievasFilledButton(label: 'Save', onPressed: () => closeDievasBottomSheet(context)),
      ],
    ),
  );
}
