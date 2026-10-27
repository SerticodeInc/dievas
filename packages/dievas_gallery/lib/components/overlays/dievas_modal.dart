import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';
import '../../widgets/component_boundary.dart';

final _sessions = Expando<Map<String, _ModalSession>>();

final modalComponent = WidgetbookComponent(
  name: 'Modal',
  useCases: [
    for (final name in ['Playground', 'With Actions', 'Content Only', 'Keyboard form', 'Long content'])
      WidgetbookUseCase(
        name: name,
        builder: (context) => _Playground(
          example: name,
          session: (_sessions[WidgetbookState.of(context)] ??= {}).putIfAbsent(name, _ModalSession.new),
        ),
      ),
  ],
);

class _ModalSession {
  bool open = false;
  String? result;
  String name = '';
}

enum _Radius { none, xs, sm, md, lg, xl, xl2, xl3, r28, r32 }

enum _Spacing { none, sm, md, lg, xl }

enum _Width { compact, regular, wide }

typedef _ModalOptions = ({
  Color? text,
  Color? titleColour,
  Color? contentColour,
  Color? icons,
  Color? background,
  Color? barrier,
  BorderRadius? radius,
  double padding,
  double inset,
  double maxWidth,
  bool reference,
  bool shadow,
  bool decoration,
  bool dismissible,
  bool safeArea,
  bool rootNavigator,
  bool close,
  bool actions,
  bool rtl,
  bool custom,
  bool keyboard,
  bool longContent,
  bool customHeader,
  bool customTrailing,
  String title,
  String body,
  Duration? duration,
  Curve? curve,
});

class _Playground extends StatelessWidget {
  const _Playground({required this.example, required this.session});
  final String example;
  final _ModalSession session;

  @override
  Widget build(BuildContext context) {
    context.knobSection('Surface');
    final overrideText = context.knobs.boolean(label: 'Override text colour');
    final text = context.tokenColourKnob(label: 'Text colour', role: .text, initialValue: .brand);
    final overrideTitle = context.knobs.boolean(label: 'Override title colour');
    final titleColour = context.tokenColourKnob(label: 'Title colour', role: .text, initialValue: .brand);
    final overrideContent = context.knobs.boolean(label: 'Override content colour');
    final contentColour = context.tokenColourKnob(label: 'Content colour', role: .text, initialValue: .secondaryText);
    final overrideIcons = context.knobs.boolean(label: 'Override icon colour');
    final icons = context.tokenColourKnob(label: 'Icon colour', role: .icon);
    final overrideBackground = context.knobs.boolean(label: 'Override background colour');
    final background = context.tokenColourKnob(label: 'Background colour', role: .background);
    final overrideBarrier = context.knobs.boolean(label: 'Override barrier colour');
    final barrier = context.tokenColourKnob(label: 'Barrier colour', role: .background, initialValue: .brand);
    final opacity = context.knobs.object.dropdown<double>(
      label: 'Barrier opacity',
      options: const [0, 0.2, 0.4, 0.56, 0.8, 1],
      initialOption: 0.56,
      labelBuilder: (value) => '$value',
    );
    final overrideRadius = context.knobs.boolean(label: 'Override border radius');
    final radius = context.knobs.object.dropdown<_Radius>(
      label: 'Border radius',
      options: _Radius.values,
      initialOption: .md,
      labelBuilder: (value) => value.name,
    );
    final shadow = context.knobs.boolean(label: 'Show shadow');
    final decoration = context.knobs.boolean(label: 'Custom decoration');
    context.knobSection('Layout');
    final padding = context.knobs.object.dropdown<_Spacing>(
      label: 'Content padding',
      options: _Spacing.values,
      initialOption: .lg,
      labelBuilder: (value) => value.name,
    );
    final inset = context.knobs.object.dropdown<_Spacing>(
      label: 'Viewport inset',
      options: _Spacing.values,
      initialOption: .lg,
      labelBuilder: (value) => value.name,
    );
    final width = context.knobs.object.dropdown<_Width>(
      label: 'Maximum width',
      options: _Width.values,
      initialOption: .regular,
      labelBuilder: (value) => value.name,
    );
    final rtl = context.knobs.boolean(label: 'Right to left');
    context.knobSection('Content');
    final title = context.knobs.string(
      label: 'Title',
      initialValue: example == 'Playground' ? 'DievasModal title' : 'Confirm action',
    );
    final body = context.knobs.string(
      label: 'Body',
      initialValue: example == 'Playground'
          ? 'Re-open the DievasModal to view the updated knob value.'
          : 'Are you sure you want to continue?',
    );
    final close = context.knobs.boolean(label: 'Show close button', initialValue: example != 'Playground');
    final actions = context.knobs.boolean(label: 'Show actions', initialValue: example != 'Content Only');
    final custom = context.knobs.boolean(label: 'Content only', initialValue: example == 'Content Only');
    final keyboard = context.knobs.boolean(label: 'Keyboard form', initialValue: example == 'Keyboard form');
    final longContent = context.knobs.boolean(label: 'Long content', initialValue: example == 'Long content');
    final customHeader = context.knobs.boolean(label: 'Custom header');
    final customTrailing = context.knobs.boolean(label: 'Custom trailing action');
    context.knobSection('Route and motion');
    final dismissible = context.knobs.boolean(label: 'Barrier and Escape dismissal', initialValue: true);
    final safeArea = context.knobs.boolean(label: 'Use safe area', initialValue: true);
    final rootNavigator = context.knobs.boolean(label: 'Use root navigator');
    final overrideMotion = context.knobs.boolean(label: 'Override transition duration');
    final duration = context.knobs.object.dropdown<int>(
      label: 'Transition milliseconds',
      options: const [0, 100, 200, 300, 500, 800],
      initialOption: 300,
      labelBuilder: (value) => '$value',
    );
    final overrideCurve = context.knobs.boolean(label: 'Override transition curve');
    final curve = context.knobs.object.dropdown<Curve>(
      label: 'Transition curve',
      options: const [Curves.easeOutCubic, Curves.easeInOut, Curves.linear],
      labelBuilder: (value) => value.toString(),
    );
    return Navigator(
      pages: [
        MaterialPage(
          child: _Launcher(
            session: session,
            options: (
              reference: example == 'Playground' && !custom,
              text: overrideText ? text : null,
              titleColour: overrideTitle ? titleColour : null,
              contentColour: overrideContent ? contentColour : null,
              icons: overrideIcons ? icons : null,
              background: overrideBackground ? background : null,
              barrier: overrideBarrier ? barrier.withValues(alpha: opacity) : null,
              radius: overrideRadius
                  ? switch (radius) {
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
                    }
                  : null,
              padding: switch (padding) {
                .none => context.spacing.none,
                .sm => context.spacing.sm,
                .md => context.spacing.md,
                .lg => context.spacing.lg,
                .xl => context.spacing.xl,
              },
              inset: switch (inset) {
                .none => context.spacing.none,
                .sm => context.spacing.sm,
                .md => context.spacing.md,
                .lg => context.spacing.lg,
                .xl => context.spacing.xl,
              },
              maxWidth: switch (width) {
                .compact => context.sizing.width256,
                .regular => context.sizing.width256 + context.sizing.width44,
                .wide => context.sizing.width256 * 2,
              },
              shadow: shadow,
              decoration: decoration,
              dismissible: dismissible,
              safeArea: safeArea,
              rootNavigator: rootNavigator,
              close: close,
              actions: actions,
              rtl: rtl,
              custom: custom,
              keyboard: keyboard,
              longContent: longContent,
              customHeader: customHeader,
              customTrailing: customTrailing,
              title: title,
              body: body,
              duration: overrideMotion ? Duration(milliseconds: duration) : null,
              curve: overrideCurve ? curve : null,
            ),
          ),
        ),
      ],
      onDidRemovePage: (_) {},
    );
  }
}

class _Launcher extends StatefulWidget {
  const _Launcher({required this.session, required this.options});
  final _ModalSession session;
  final _ModalOptions options;
  @override
  State<_Launcher> createState() => _LauncherState();
}

class _LauncherState extends State<_Launcher> {
  late final ValueNotifier<_ModalOptions> _options = ValueNotifier(widget.options);

  @override
  void initState() {
    super.initState();
    if (widget.session.open) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _show();
        }
      });
    }
  }

  @override
  void didUpdateWidget(_Launcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _options.value = widget.options;
      }
    });
  }

  @override
  void dispose() {
    _options.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: .min,
      children: [
        ComponentBoundary(
          child: DievasFilledButton(label: 'Tap me', onPressed: _show),
        ),
        if (widget.session.result case final result?)
          Padding(padding: EdgeInsets.all(context.spacing.md), child: Text(result)),
      ],
    ),
  );

  Future<void> _show() async {
    widget.session.open = true;
    final result = await showDievasModal<String>(
      context: context,
      useRootNavigator: widget.options.rootNavigator,
      useSafeArea: widget.options.safeArea,
      barrierDismissible: widget.options.dismissible,
      barrierColour: widget.options.barrier,
      transitionDuration: widget.options.duration,
      transitionCurve: widget.options.curve,
      builder: (_) => ValueListenableBuilder<_ModalOptions>(
        valueListenable: _options,
        builder: (_, options, _) => Directionality(
          textDirection: options.rtl ? .rtl : .ltr,
          child: _ModalContent(options: options, session: widget.session),
        ),
      ),
    );
    if (mounted) {
      setState(() {
        widget.session.open = false;
        widget.session.result = result ?? 'Modal dismissed';
      });
    }
  }
}

class _ModalContent extends StatelessWidget {
  const _ModalContent({required this.options, required this.session});
  final _ModalOptions options;
  final _ModalSession session;

  @override
  Widget build(BuildContext context) => DievasModal(
    title: options.custom || options.reference ? null : options.title,
    header: options.customHeader && !options.custom && !options.reference ? const Text('Custom modal header') : null,
    trailing: options.customTrailing && !options.custom && !options.reference
        ? DievasTextButton(label: 'Done', onPressed: () => closeDievasModal(context, 'Done'))
        : null,
    body: options.custom || options.reference ? null : options.body,
    showCloseButton: options.close,
    backgroundColour: options.background,
    textColour: options.text,
    titleColour: options.titleColour,
    contentColour: options.contentColour,
    iconColour: options.icons,
    borderRadius: options.radius,
    shadow: options.shadow ? context.elevation.sm : const [],
    decoration: options.decoration
        ? BoxDecoration(
            color: options.background ?? context.colours.background.dialogBackground,
            borderRadius: options.radius ?? context.border.md,
            border: Border.all(
              color: options.text ?? context.colours.border.dividerColour,
              width: context.border.strokeDefault,
            ),
          )
        : null,
    padding: options.reference ? EdgeInsets.zero : EdgeInsets.all(options.padding),
    insetPadding: EdgeInsets.all(options.inset),
    constraints: BoxConstraints(maxWidth: options.maxWidth),
    semanticLabel: 'Modal example',
    content: switch ((options.custom || options.reference, options.keyboard, options.longContent)) {
      (true, _, _) => null,
      (_, true, _) => _ModalForm(session: session),
      (_, _, true) => Column(
        mainAxisSize: .min,
        children: [
          for (int i = 1; i <= 30; i++)
            Padding(padding: EdgeInsets.all(context.spacing.sm), child: Text('Modal content row $i')),
        ],
      ),
      _ => null,
    },
    actions: options.actions && !options.custom && !options.reference
        ? [
            DievasTextButton(label: 'Cancel', onPressed: () => closeDievasModal(context, 'Cancelled')),
            DievasFilledButton(label: 'Confirm', onPressed: () => closeDievasModal(context, 'Confirmed')),
          ]
        : const [],
    child: switch ((options.reference, options.custom)) {
      (true, _) => _ReferenceContent(options: options, session: session),
      (_, true) => Column(
        mainAxisSize: .min,
        children: [
          Text(options.body),
          SizedBox(height: context.spacing.md),
          DievasFilledButton(label: 'Close', onPressed: () => closeDievasModal(context, 'Closed')),
        ],
      ),
      _ => null,
    },
  );
}

class _ModalForm extends StatefulWidget {
  const _ModalForm({required this.session});
  final _ModalSession session;
  @override
  State<_ModalForm> createState() => _ModalFormState();
}

class _ModalFormState extends State<_ModalForm> {
  late final TextEditingController _controller = TextEditingController(text: widget.session.name);
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      DievasTextInput(label: 'Name', controller: _controller, onChanged: (value) => widget.session.name = value);
}

/// Composition from Moon Design 1.1.0's published modal story.
class _ReferenceContent extends StatelessWidget {
  const _ReferenceContent({required this.options, required this.session});
  final _ModalOptions options;
  final _ModalSession session;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: options.maxWidth,
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                options.padding,
                context.spacing.mdPlus,
                options.padding +
                    switch ((options.customTrailing, options.close)) {
                      (true, _) => context.sizing.width64,
                      (_, true) => context.sizing.width20 + context.spacing.sm,
                      _ => 0,
                    },
                context.spacing.md,
              ),
              child: Text(
                options.customHeader ? 'Custom modal header' : options.title,
                style: context.typography.titleLg.copyWith(
                  fontWeight: .w500,
                  color: switch ((
                    options.titleColour,
                    options.text,
                    DievasTheme.componentsOf(context).modal.titleColour,
                  )) {
                    (final colour?, _, _) || (_, final colour?, _) || (_, _, final colour?) => colour,
                    _ => DievasTheme.componentsOf(context).modal.textColour ?? context.colours.text.textPrimary,
                  },
                ),
              ),
            ),
            if (options.customTrailing)
              PositionedDirectional(
                end: options.padding,
                top: context.spacing.xs,
                bottom: 0,
                child: Center(
                  child: DievasTextButton(label: 'Done', onPressed: () => closeDievasModal(context, 'Done')),
                ),
              )
            else if (options.close)
              PositionedDirectional(
                end: options.padding - context.spacing.smPlus,
                top: context.spacing.xs,
                bottom: 0,
                child: Center(
                  child: SizedBox.square(
                    dimension: context.sizing.width44,
                    child: DievasTextButton(
                      size: .sm,
                      semanticLabel: context.dievasL10n.modalCloseLabel,
                      foregroundColor: IconTheme.of(context).color,
                      onPressed: () => closeDievasModal(context),
                      child: Icon(Icons.close, size: context.sizing.width20, color: IconTheme.of(context).color),
                    ),
                  ),
                ),
              ),
          ],
        ),
        DievasDivider(thickness: context.border.strokeThin, colour: context.colours.text.textSecondary),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: options.padding, vertical: context.spacing.md),
          child: switch ((options.keyboard, options.longContent)) {
            (true, _) => _ModalForm(session: session),
            (_, true) => Column(
              mainAxisSize: .min,
              children: [
                for (int i = 1; i <= 30; i++)
                  Padding(padding: EdgeInsets.all(context.spacing.sm), child: Text('Modal content row $i')),
              ],
            ),
            _ => Text(options.body),
          },
        ),
        if (options.actions)
          Padding(
            padding: EdgeInsets.fromLTRB(options.padding, context.spacing.md, options.padding, options.padding),
            child: SizedBox(
              height: context.sizing.height40,
              child: DievasFilledButton(
                label: 'Okay',
                isFullWidth: true,
                onPressed: () => closeDievasModal(context, 'Okay'),
              ),
            ),
          ),
      ],
    ),
  );
}
