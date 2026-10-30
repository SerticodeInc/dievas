import 'package:flutter/material.dart' show TabController;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';
import 'package:dievas/src/theme/component/segmented_control/dievas_segmented_control_theme_data.dart';

/// Presets for the overall control height and segment content.
enum DievasSegmentedControlSize { sm, md }

/// Surface and foreground overrides for one segment state.
///
/// Non-null decoration fields merge with the inherited surface. Use transparent
/// colours, an empty shadow list or [BorderSide.none] to clear painted values.
/// Text styles merge with inherited typography; [iconColour] defaults to the
/// resolved text colour.
final class DievasSegmentAppearance {
  const DievasSegmentAppearance({this.decoration, this.textStyle, this.iconColour});

  final BoxDecoration? decoration;
  final TextStyle? textStyle;
  final Color? iconColour;
}

/// Appearance and spacing shared by the control and its segments.
///
/// Precedence is theme, legacy constructor inputs,
/// [DievasSegmentedControl.style], then each segment's style. Decorations merge non-null fields instead of replacing the surface.
final class DievasSegmentedControlStyle {
  const DievasSegmentedControlStyle({
    this.decoration,
    this.segmentStyle,
    this.padding,
    this.gap,
    this.transitionDuration,
    this.transitionCurve,
  }) : assert(gap == null || gap >= 0);

  final BoxDecoration? decoration;
  final DievasSegmentStyle? segmentStyle;
  final EdgeInsetsGeometry? padding;
  final double? gap;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
}

/// Shared segment defaults or overrides for one segment.
///
/// Within each layer, [appearance] applies first, followed by [selected],
/// [hovered], then [pressed] when applicable. Hover and press do not select a
/// segment. Each segment's layer applies after the control's shared layer.
final class DievasSegmentStyle {
  const DievasSegmentStyle({
    this.appearance,
    this.selected,
    this.hovered,
    this.pressed,
    this.padding,
    this.gap,
    this.focusColour,
    @Deprecated('Use selected.decoration.color instead.') this.selectedBackgroundColour,
    @Deprecated('Use appearance.textStyle.color instead.') this.textColour,
    @Deprecated('Use selected.textStyle.color instead.') this.selectedTextColour,
    @Deprecated('Use appearance.decoration.borderRadius instead.') this.borderRadius,
    @Deprecated('Use appearance.textStyle instead.') this.textStyle,
    @Deprecated('Use appearance.decoration instead.') this.decoration,
  }) : assert(gap == null || gap >= 0);

  final DievasSegmentAppearance? appearance;
  final DievasSegmentAppearance? selected;
  final DievasSegmentAppearance? hovered;
  final DievasSegmentAppearance? pressed;
  final EdgeInsetsGeometry? padding;
  final double? gap;
  final Color? focusColour;

  @Deprecated('Use selected.decoration.color instead.')
  final Color? selectedBackgroundColour;
  @Deprecated('Use appearance.textStyle.color instead.')
  final Color? textColour;
  @Deprecated('Use selected.textStyle.color instead.')
  final Color? selectedTextColour;
  @Deprecated('Use appearance.decoration.borderRadius instead.')
  final BorderRadiusGeometry? borderRadius;
  @Deprecated('Use appearance.textStyle instead.')
  final TextStyle? textStyle;

  /// Box decorations merge fields. Other legacy decorations replace painting.
  @Deprecated('Use appearance.decoration instead.')
  final Decoration? decoration;
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
    this.width,
    this.height,
    this.style,
    @Deprecated('Use style.decoration.color instead.') this.backgroundColour,
    @Deprecated('Use style.segmentStyle.selected.decoration.color instead.') this.selectedSegmentColour,
    @Deprecated('Use style.segmentStyle.appearance.textStyle.color instead.') this.textColour,
    @Deprecated('Use style.segmentStyle.selected.textStyle.color instead.') this.selectedTextColour,
    @Deprecated('Use style.decoration.borderRadius instead.') this.borderRadius,
    @Deprecated('Use style.segmentStyle.appearance.decoration.borderRadius instead.') this.segmentBorderRadius,
    @Deprecated('Use style.padding instead.') this.padding,
    @Deprecated('Use style.segmentStyle.padding instead.') this.segmentPadding,
    @Deprecated('Use style.gap instead.') this.gap,
    @Deprecated('Use style.segmentStyle.gap instead.') this.segmentGap,
    @Deprecated('Use style.decoration instead.') this.decoration,
    @Deprecated('Use style.transitionDuration instead.') this.transitionDuration,
    @Deprecated('Use style.transitionCurve instead.') this.transitionCurve,
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
  final double? width;
  final double? height;

  /// Container appearance and shared segment defaults.
  final DievasSegmentedControlStyle? style;
  @Deprecated('Use style.decoration.color instead.')
  final Color? backgroundColour;
  @Deprecated('Use style.segmentStyle.selected.decoration.color instead.')
  final Color? selectedSegmentColour;
  @Deprecated('Use style.segmentStyle.appearance.textStyle.color instead.')
  final Color? textColour;
  @Deprecated('Use style.segmentStyle.selected.textStyle.color instead.')
  final Color? selectedTextColour;
  @Deprecated('Use style.decoration.borderRadius instead.')
  final BorderRadiusGeometry? borderRadius;
  @Deprecated('Use style.segmentStyle.appearance.decoration.borderRadius instead.')
  final BorderRadiusGeometry? segmentBorderRadius;
  @Deprecated('Use style.padding instead.')
  final EdgeInsetsGeometry? padding;
  @Deprecated('Use style.segmentStyle.padding instead.')
  final EdgeInsetsGeometry? segmentPadding;
  @Deprecated('Use style.gap instead.')
  final double? gap;
  @Deprecated('Use style.segmentStyle.gap instead.')
  final double? segmentGap;
  @Deprecated('Use style.decoration instead.')
  final Decoration? decoration;
  @Deprecated('Use style.transitionDuration instead.')
  final Duration? transitionDuration;
  @Deprecated('Use style.transitionCurve instead.')
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
      containerPadding: widget.style?.padding ?? widget.padding,
      gap: widget.style?.gap ?? widget.gap,
      animationDuration: widget.style?.transitionDuration ?? widget.transitionDuration,
      animationCurve: widget.style?.transitionCurve ?? widget.transitionCurve,
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
          decoration: _mergeDecoration(
            _mergeDecoration(
              BoxDecoration(
                color: theme.bgColour,
                borderRadius: theme.borderRadius,
                border: .all(color: theme.borderColour, width: DievasTheme.borderOf(context).strokeThin),
              ),
              widget.decoration,
            ),
            widget.style?.decoration,
          ),
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
                sharedStyle: widget.style?.segmentStyle,
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
    required this.sharedStyle,
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
  final DievasSegmentStyle? sharedStyle;
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
          sharedStyle: sharedStyle,
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
    required this.sharedStyle,
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
  final DievasSegmentStyle? sharedStyle;
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
  BoxShape _surfaceShape = .rectangle;

  @override
  Widget build(BuildContext context) {
    final segment = widget.segment;
    final style = segment.style;
    final sharedStyle = widget.sharedStyle;
    final defaultPadding = widget.size.padding.resolve(Directionality.of(context));
    final radius = widget.borderRadius ?? widget.size.borderRadius;
    final appearance =
        _ResolvedSegmentAppearance(
              decoration: BoxDecoration(
                color: switch ((widget.selected, widget.enabled && (_hovered || _pressed))) {
                  (true, _) => widget.theme.selectedBgColour,
                  (_, true) => DievasTheme.coloursOf(context).background.menuHoveredBackground,
                  _ => null,
                },
                borderRadius: radius,
              ),
              textStyle: (widget.selected ? widget.theme.selectedLabelStyle : widget.theme.labelStyle).copyWith(
                color: widget.selected ? widget.theme.selectedTextColour : widget.theme.textColour,
              ),
            )
            .apply(
              sharedStyle,
              selected: widget.selected,
              hovered: widget.enabled && _hovered,
              pressed: widget.enabled && _pressed,
            )
            .apply(
              style,
              selected: widget.selected,
              hovered: widget.enabled && _hovered,
              pressed: widget.enabled && _pressed,
            );

    final BoxShape shape = switch (appearance.decoration) {
      BoxDecoration(:final shape) => shape,
      _ => .rectangle,
    };
    // Flutter cannot interpolate a rounded rectangle into a circle safely.
    // Snap that geometry change without remounting the segment's content.
    final surfaceDuration = shape == _surfaceShape ? widget.duration : Duration.zero;
    _surfaceShape = shape;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: FocusableActionDetector(
        focusNode: widget.node,
        descendantsAreFocusable: false,
        autofocus: segment.autofocus,
        enabled: widget.enabled,
        mouseCursor: widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onShowFocusHighlight: (value) => setState(() => _focused = value),
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
                  duration: surfaceDuration,
                  curve: widget.curve,
                  constraints: BoxConstraints(minWidth: widget.theme.minSegmentWidth),
                  decoration: appearance.decoration,
                  foregroundDecoration: switch ((_focused, widget.enabled)) {
                    (true, true) => BoxDecoration(
                      shape: shape,
                      borderRadius: switch (appearance.decoration) {
                        BoxDecoration(:final borderRadius) => borderRadius,
                        _ => radius,
                      },
                      border: Border.all(
                        color: switch ((style?.focusColour, sharedStyle?.focusColour)) {
                          (final colour?, _) || (_, final colour?) => colour,
                          _ => DievasTheme.coloursOf(context).border.focusIndicatorColour,
                        },
                        width: DievasTheme.borderOf(context).strokeThin,
                      ),
                    ),
                    _ => null,
                  },
                  child: IconTheme(
                    data: IconThemeData(
                      size: widget.size.iconSize,
                      color: appearance.iconColour ?? appearance.textStyle.color,
                    ),
                    child: AnimatedDefaultTextStyle(
                      duration: widget.duration,
                      curve: widget.curve,
                      style: appearance.textStyle,
                      maxLines: 1,
                      overflow: .ellipsis,
                      child: Padding(
                        padding: switch ((style?.padding, sharedStyle?.padding, widget.padding, segment.label)) {
                          (final padding?, _, _, _) ||
                          (_, final padding?, _, _) ||
                          (_, _, final padding?, _) => padding,
                          (_, _, _, null) => .symmetric(horizontal: widget.size.gap),
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
                              gap: switch ((style?.gap, sharedStyle?.gap, widget.gap)) {
                                (final gap?, _, _) || (_, final gap?, _) || (_, _, final gap?) => gap,
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

// Sparse box overrides inherit shape unless they provide a circle or a radius.
// An explicit radius (including zero) restores rectangular geometry.
Decoration _mergeDecoration(Decoration base, Decoration? override) => switch ((base, override)) {
  (_, null) => base,
  (final BoxDecoration base, final BoxDecoration override) => BoxDecoration(
    color: override.color ?? base.color,
    image: override.image ?? base.image,
    border: override.border ?? base.border,
    borderRadius: switch ((override.shape, override.borderRadius, base.shape)) {
      (.circle, _, _) => null,
      (_, final radius?, _) => radius,
      (_, _, .circle) => null,
      _ => base.borderRadius,
    },
    boxShadow: override.boxShadow ?? base.boxShadow,
    gradient: override.gradient ?? base.gradient,
    backgroundBlendMode: override.backgroundBlendMode ?? base.backgroundBlendMode,
    shape: switch ((override.shape, override.borderRadius)) {
      (.circle, _) => .circle,
      (_, final _?) => .rectangle,
      _ => base.shape,
    },
  ),
  (_, final decoration?) => decoration,
};

class _ResolvedSegmentAppearance {
  const _ResolvedSegmentAppearance({required this.decoration, required this.textStyle, this.iconColour});

  final Decoration decoration;
  final TextStyle textStyle;
  final Color? iconColour;

  _ResolvedSegmentAppearance apply(
    DievasSegmentStyle? style, {
    required bool selected,
    required bool hovered,
    required bool pressed,
  }) {
    final legacyText = textStyle
        .merge(style?.textStyle)
        .copyWith(
          color: switch ((selected, style?.selectedTextColour, style?.textColour)) {
            (true, final colour?, _) || (false, _, final colour?) => colour,
            _ => null,
          },
        );
    return _ResolvedSegmentAppearance(
          decoration: _mergeDecoration(
            _mergeDecoration(decoration, switch ((
              selected ? style?.selectedBackgroundColour : null,
              style?.borderRadius,
            )) {
              (null, null) => null,
              (final colour, final radius) => BoxDecoration(color: colour, borderRadius: radius),
            }),
            style?.decoration,
          ),
          textStyle: legacyText,
          iconColour: iconColour,
        )
        .merge(style?.appearance)
        .merge(selected ? style?.selected : null)
        .merge(hovered ? style?.hovered : null)
        .merge(pressed ? style?.pressed : null);
  }

  _ResolvedSegmentAppearance merge(DievasSegmentAppearance? appearance) => _ResolvedSegmentAppearance(
    decoration: _mergeDecoration(decoration, appearance?.decoration),
    textStyle: textStyle.merge(appearance?.textStyle),
    iconColour: appearance?.iconColour ?? iconColour,
  );
}
