import 'package:flutter/material.dart' show TabController;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';
import 'package:dievas/src/theme/component/segmented_control/dievas_segmented_control_theme_data.dart';

/// Presets for the overall control height and segment content.
enum DievasSegmentedControlSize { sm, md }

/// Optional appearance overrides for one segment.
final class DievasSegmentStyle {
  const DievasSegmentStyle({
    this.selectedBackgroundColour,
    this.textColour,
    this.selectedTextColour,
    this.borderRadius,
    this.padding,
    this.gap,
    this.textStyle,
    this.decoration,
    this.focusColour,
  });

  final Color? selectedBackgroundColour;
  final Color? textColour;
  final Color? selectedTextColour;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? gap;
  final TextStyle? textStyle;
  final Decoration? decoration;
  final Color? focusColour;
}

/// Typed segment content. Supply a semantic label for icon only segments.
final class DievasSegment<T> {
  const DievasSegment({
    required this.value,
    this.leading,
    this.label,
    this.trailing,
    this.style,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
  });

  final T value;
  final Widget? leading;
  final Widget? label;
  final Widget? trailing;
  final DievasSegmentStyle? style;
  final bool enabled;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? semanticLabel;
}

/// A controlled row of mutually exclusive values with text or custom segments.
///
/// Keep [value] updated through [onChanged]. A supplied [tabController] owns
/// selection instead; its length must match the number of options or segments.
/// Null [onChanged] keeps the control read only unless a controller is supplied.
class DievasSegmentedControl<T> extends StatefulWidget {
  const DievasSegmentedControl({
    super.key,
    this.options = const [],
    required this.value,
    this.onChanged,
    this.labelBuilder,
    this.segments,
    this.segmentBuilder,
    this.enabled = true,
    this.isExpanded = false,
    this.size = .md,
    this.tabController,
    this.backgroundColour,
    this.selectedSegmentColour,
    this.textColour,
    this.selectedTextColour,
    this.borderRadius,
    this.segmentBorderRadius,
    this.padding,
    this.segmentPadding,
    this.gap,
    this.segmentGap,
    this.width,
    this.height,
    this.decoration,
    this.transitionDuration,
    this.transitionCurve,
  }) : assert(segments == null || options.length == 0),
       assert(width == null || width > 0),
       assert(height == null || height > 0),
       assert(gap == null || gap >= 0),
       assert(segmentGap == null || segmentGap >= 0);

  final List<T> options;
  final T value;
  final ValueChanged<T>? onChanged;
  final String Function(T)? labelBuilder;
  final List<DievasSegment<T>>? segments;

  /// Replaces a segment's content while retaining selection, focus and styling.
  final Widget Function(BuildContext context, T value, bool selected)? segmentBuilder;
  final bool enabled;
  final bool isExpanded;
  final DievasSegmentedControlSize size;
  final TabController? tabController;
  final Color? backgroundColour;
  final Color? selectedSegmentColour;
  final Color? textColour;
  final Color? selectedTextColour;
  final BorderRadiusGeometry? borderRadius;
  final BorderRadiusGeometry? segmentBorderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? segmentPadding;
  final double? gap;
  final double? segmentGap;
  final double? width;
  final double? height;
  final Decoration? decoration;
  final Duration? transitionDuration;
  final Curve? transitionCurve;

  @override
  State<DievasSegmentedControl<T>> createState() => _DievasSegmentedControlState<T>();
}

class _DievasSegmentedControlState<T> extends State<DievasSegmentedControl<T>> {
  final _focusNodes = <T, FocusNode>{};
  int _controllerIndex = 0;

  @override
  void initState() {
    super.initState();
    _controllerIndex = widget.tabController?.index ?? 0;
    widget.tabController?.addListener(_controllerChanged);
  }

  @override
  void didUpdateWidget(DievasSegmentedControl<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabController != widget.tabController) {
      oldWidget.tabController?.removeListener(_controllerChanged);
      _controllerIndex = widget.tabController?.index ?? 0;
      widget.tabController?.addListener(_controllerChanged);
    }
    for (final value in _focusNodes.keys.where((value) => !_values.contains(value)).toList()) {
      _focusNodes.remove(value)?.dispose();
    }
  }

  @override
  void dispose() {
    widget.tabController?.removeListener(_controllerChanged);
    for (final node in _focusNodes.values) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).segmentedControl.copyWith(
      bgColour: widget.backgroundColour,
      selectedBgColour: widget.selectedSegmentColour,
      textColour: widget.textColour,
      selectedTextColour: widget.selectedTextColour,
      borderRadius: widget.borderRadius,
      containerPadding: widget.padding,
      gap: widget.gap,
      animationDuration: widget.transitionDuration,
      animationCurve: widget.transitionCurve,
    );

    final values = _values;
    assert(values.isNotEmpty, 'A segmented control needs at least one segment.');
    assert(values.toSet().length == values.length, 'Segment values must be unique.');
    assert(widget.tabController == null || widget.tabController?.length == values.length);
    assert(widget.tabController != null || values.contains(widget.value), 'The selected value must be an option.');
    final selectedIndex = widget.tabController?.index ?? values.indexOf(widget.value);
    final size = switch ((widget.size, theme.sizes)) {
      (.sm, final sizes?) => sizes.sm,
      (.md, final sizes?) => sizes.md,
      (_, null) => DievasSegmentedControlSizeData(
        height: theme.minHeight,
        iconSize: DievasTheme.sizingOf(context).iconMd,
        padding: theme.padding,
        gap: DievasTheme.spacingOf(context).sm,
        borderRadius: theme.segmentBorderRadius ?? theme.borderRadius,
      ),
    };

    final segments = switch (widget.segments) {
      final segments? => segments,
      null => [
        for (final value in values)
          DievasSegment<T>(
            value: value,
            label: Text(switch (widget.labelBuilder) {
              final label? => label(value),
              null => value.toString(),
            }),
          ),
      ],
    };
    final canChange = widget.enabled && (widget.onChanged != null || widget.tabController != null);
    final duration = switch (MediaQuery.disableAnimationsOf(context)) {
      true => Duration.zero,
      false => theme.animationDuration,
    };

    return Opacity(
      opacity: widget.enabled ? DievasTheme.opacityOf(context).opaque : theme.disabledOpacity,
      child: SizedBox(
        width: widget.width,
        height: widget.height ?? size.height,
        child: DecoratedBox(
          decoration: switch (widget.decoration) {
            final decoration? => decoration,
            null => BoxDecoration(
              color: theme.bgColour,
              borderRadius: theme.borderRadius.resolve(Directionality.of(context)),
              border: .all(color: theme.borderColour, width: DievasTheme.borderOf(context).strokeThin),
            ),
          },
          child: Padding(
            padding: theme.containerPadding,
            child: LayoutBuilder(
              builder: (context, constraints) => _SegmentRow<T>(
                segments: segments,
                selectedIndex: selectedIndex,
                theme: theme,
                size: size,
                expanded: widget.isExpanded && constraints.hasBoundedWidth,
                canChange: canChange,
                controlEnabled: widget.enabled,
                duration: duration,
                curve: theme.animationCurve ?? DievasTheme.animationOf(context).easingStandard,
                segmentBorderRadius: widget.segmentBorderRadius ?? theme.segmentBorderRadius,
                segmentPadding: widget.segmentPadding,
                segmentGap: widget.segmentGap,
                segmentBuilder: widget.segmentBuilder,
                nodes: [
                  for (final segment in segments)
                    segment.focusNode ?? _focusNodes.putIfAbsent(segment.value, FocusNode.new),
                ],
                select: _select,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _controllerChanged() {
    if (widget.tabController case final controller? when controller.index != _controllerIndex) {
      setState(() => _controllerIndex = controller.index);
      widget.onChanged?.call(_values.elementAt(controller.index));
    }
  }

  void _select(int index) => switch ((
    widget.tabController,
    widget.onChanged,
    index == (widget.tabController?.index ?? _values.indexOf(widget.value)),
  )) {
    (_, _, true) => null,
    (final controller?, _, false) => controller.animateTo(index),
    (null, final changed?, false) => changed(_values.elementAt(index)),
    _ => null,
  };

  List<T> get _values => switch (widget.segments) {
    final segments? => [for (final segment in segments) segment.value],
    null => widget.options,
  };
}

class _SegmentRow<T> extends StatelessWidget {
  const _SegmentRow({
    required this.segments,
    required this.selectedIndex,
    required this.theme,
    required this.size,
    required this.expanded,
    required this.canChange,
    required this.controlEnabled,
    required this.duration,
    required this.curve,
    required this.segmentBorderRadius,
    required this.segmentPadding,
    required this.segmentGap,
    required this.segmentBuilder,
    required this.nodes,
    required this.select,
  });

  final List<DievasSegment<T>> segments;
  final int selectedIndex;
  final DievasSegmentedControlThemeData theme;
  final DievasSegmentedControlSizeData size;
  final bool expanded;
  final bool canChange;
  final bool controlEnabled;
  final Duration duration;
  final Curve curve;
  final BorderRadiusGeometry? segmentBorderRadius;
  final EdgeInsetsGeometry? segmentPadding;
  final double? segmentGap;
  final Widget Function(BuildContext, T, bool)? segmentBuilder;
  final List<FocusNode> nodes;
  final ValueChanged<int> select;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      for (final (index, segment) in segments.indexed) ...[
        if (index > 0) SizedBox(width: theme.gap),
        _SegmentTile<T>(
          key: ValueKey(segment.value),
          segment: segment,
          selected: index == selectedIndex,
          enabled: canChange && segment.enabled,
          dimmed: controlEnabled && !segment.enabled,
          theme: theme,
          size: size,
          duration: duration,
          curve: curve,
          borderRadius: segmentBorderRadius,
          padding: segmentPadding,
          gap: segmentGap,
          builder: segmentBuilder,
          node: nodes.elementAt(index),
          select: () => select(index),
          move: (key) => _move(context, index, key),
        ),
      ],
    ];
    return switch (expanded) {
      true => Row(
        children: [
          for (final child in children)
            switch (child) {
              SizedBox() => child,
              _ => Expanded(child: child),
            },
        ],
      ),
      false => SingleChildScrollView(
        scrollDirection: .horizontal,
        child: Row(mainAxisSize: .min, children: children),
      ),
    };
  }

  void _move(BuildContext context, int index, LogicalKeyboardKey key) {
    final enabled = [
      for (final (index, segment) in segments.indexed)
        if (segment.enabled) index,
    ];
    final next = switch (key) {
      LogicalKeyboardKey.home => enabled.first,
      LogicalKeyboardKey.end => enabled.last,
      _ => switch ((key == LogicalKeyboardKey.arrowRight, Directionality.of(context))) {
        (true, .ltr) || (false, .rtl) => enabled.elementAt((enabled.indexOf(index) + 1) % enabled.length),
        _ => enabled.elementAt((enabled.indexOf(index) - 1 + enabled.length) % enabled.length),
      },
    };
    nodes.elementAt(next).requestFocus();
    select(next);
  }
}

class _SegmentMoveIntent extends Intent {
  const _SegmentMoveIntent(this.key);
  final LogicalKeyboardKey key;
}

class _SegmentTile<T> extends StatefulWidget {
  const _SegmentTile({
    super.key,
    required this.segment,
    required this.selected,
    required this.enabled,
    required this.dimmed,
    required this.theme,
    required this.size,
    required this.duration,
    required this.curve,
    required this.borderRadius,
    required this.padding,
    required this.gap,
    required this.builder,
    required this.node,
    required this.select,
    required this.move,
  });

  final DievasSegment<T> segment;
  final bool selected;
  final bool enabled;
  final bool dimmed;
  final DievasSegmentedControlThemeData theme;
  final DievasSegmentedControlSizeData size;
  final Duration duration;
  final Curve curve;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? gap;
  final Widget Function(BuildContext, T, bool)? builder;
  final FocusNode node;
  final VoidCallback select;
  final ValueChanged<LogicalKeyboardKey> move;

  @override
  State<_SegmentTile<T>> createState() => _SegmentTileState<T>();
}

class _SegmentTileState<T> extends State<_SegmentTile<T>> {
  bool _focused = false;
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final segment = widget.segment;
    final style = segment.style;
    final active = widget.selected || (widget.enabled && (_hovered || _pressed));
    final foreground = switch ((style?.textStyle?.color, active, style?.selectedTextColour, style?.textColour)) {
      (final colour?, _, _, _) => colour,
      (_, true, final colour?, _) || (_, false, _, final colour?) => colour,
      (_, true, _, _) => widget.theme.selectedTextColour,
      _ => widget.theme.textColour,
    };
    final defaultPadding = widget.size.padding.resolve(Directionality.of(context));
    final radius = switch ((style?.borderRadius, widget.borderRadius)) {
      (final radius?, _) || (null, final radius?) => radius,
      _ => widget.size.borderRadius,
    };

    return FocusableActionDetector(
      focusNode: widget.node,
      descendantsAreFocusable: false,
      autofocus: segment.autofocus,
      enabled: widget.enabled,
      mouseCursor: widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onShowFocusHighlight: (value) => setState(() => _focused = value),
      onShowHoverHighlight: (value) => setState(() => _hovered = value),
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.arrowLeft): _SegmentMoveIntent(LogicalKeyboardKey.arrowLeft),
        SingleActivator(LogicalKeyboardKey.arrowRight): _SegmentMoveIntent(LogicalKeyboardKey.arrowRight),
        SingleActivator(LogicalKeyboardKey.home): _SegmentMoveIntent(LogicalKeyboardKey.home),
        SingleActivator(LogicalKeyboardKey.end): _SegmentMoveIntent(LogicalKeyboardKey.end),
      },
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            widget.select();
            return null;
          },
        ),
        _SegmentMoveIntent: CallbackAction<_SegmentMoveIntent>(
          onInvoke: (intent) {
            widget.move(intent.key);
            return null;
          },
        ),
      },
      child: Semantics(
        container: true,
        excludeSemantics: segment.semanticLabel != null,
        selected: widget.selected,
        enabled: widget.enabled,
        button: true,
        inMutuallyExclusiveGroup: true,
        label: segment.semanticLabel,
        onTap: widget.enabled ? widget.select : null,
        child: GestureDetector(
          behavior: .opaque,
          excludeFromSemantics: true,
          onTap: widget.enabled ? widget.select : null,
          onTapDown: widget.enabled ? (_) => setState(() => _pressed = true) : null,
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: IgnorePointer(
            ignoring: !widget.enabled,
            child: Opacity(
              opacity: widget.dimmed ? widget.theme.disabledOpacity : DievasTheme.opacityOf(context).opaque,
              child: AnimatedContainer(
                duration: widget.duration,
                curve: widget.curve,
                constraints: BoxConstraints(minWidth: widget.theme.minSegmentWidth),
                decoration: switch (style?.decoration) {
                  final decoration? => decoration,
                  null => BoxDecoration(
                    color: switch ((active, style?.selectedBackgroundColour)) {
                      (true, final colour?) => colour,
                      (true, null) => widget.theme.selectedBgColour,
                      _ => null,
                    },
                    borderRadius: radius.resolve(Directionality.of(context)),
                  ),
                },
                foregroundDecoration: switch ((_focused, widget.enabled)) {
                  (true, true) => BoxDecoration(
                    borderRadius: radius.resolve(Directionality.of(context)),
                    border: Border.all(
                      color: style?.focusColour ?? DievasTheme.coloursOf(context).border.focusIndicatorColour,
                      width: DievasTheme.borderOf(context).strokeThin,
                    ),
                  ),
                  _ => null,
                },
                child: IconTheme(
                  data: IconThemeData(size: widget.size.iconSize, color: foreground),
                  child: AnimatedDefaultTextStyle(
                    duration: widget.duration,
                    curve: widget.curve,
                    style: (widget.selected ? widget.theme.selectedLabelStyle : widget.theme.labelStyle)
                        .merge(style?.textStyle)
                        .copyWith(color: foreground),
                    maxLines: 1,
                    overflow: .ellipsis,
                    child: Padding(
                      padding: switch ((style?.padding, widget.padding, segment.label)) {
                        (final padding?, _, _) || (null, final padding?, _) => padding,
                        (_, _, null) => .symmetric(horizontal: widget.size.gap),
                        _ => EdgeInsetsDirectional.only(
                          start: segment.leading == null ? defaultPadding.left : widget.size.gap,
                          end: segment.trailing == null ? defaultPadding.right : widget.size.gap,
                          top: defaultPadding.top,
                          bottom: defaultPadding.bottom,
                        ),
                      },
                      child: Center(
                        widthFactor: 1,
                        child: switch (widget.builder) {
                          final builder? => AbsorbPointer(child: builder(context, segment.value, widget.selected)),
                          null => _SegmentContent(
                            segment: segment,
                            gap: switch ((style?.gap, widget.gap)) {
                              (final gap?, _) || (null, final gap?) => gap,
                              _ => widget.size.gap,
                            },
                          ),
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SegmentContent<T> extends StatelessWidget {
  const _SegmentContent({required this.segment, required this.gap});
  final DievasSegment<T> segment;
  final double gap;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: .min,
    mainAxisAlignment: .center,
    children: [
      if (segment.leading case final leading?) ...[
        leading,
        if (segment.label != null || segment.trailing != null) SizedBox(width: gap),
      ],
      if (segment.label case final label?) Flexible(child: label),
      if (segment.trailing case final trailing?) ...[if (segment.label != null) SizedBox(width: gap), trailing],
    ],
  );
}
