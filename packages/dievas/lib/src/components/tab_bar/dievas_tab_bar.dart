import 'package:flutter/material.dart' show TabController;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';
import 'package:dievas/src/theme/component/tab_bar/dievas_tab_bar_theme_data.dart';
import 'dievas_tab_types.dart';

export 'dievas_tab_types.dart';

/// Controlled tabs with underline, pill, and custom content variants.
/// Supply either string [tabs] or rich [items]. A supplied [tabController]
/// takes selection precedence and remains owned by the caller.
class DievasTabBar extends StatefulWidget {
  const DievasTabBar({
    super.key,
    this.tabs = const [],
    this.items,
    this.selectedIndex = 0,
    this.onChanged,
    this.enabled = true,
    this.variant = .underline,
    this.tabBarSize,
    this.isExpanded = false,
    this.gap,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.tabStyle = const DievasTabStyle(),
    this.tabController,
    this.transitionDuration,
    this.transitionCurve,
    this.showDivider,
  }) : assert((tabs.length > 0) != (items != null)),
       assert(items == null || items.length > 0),
       assert(selectedIndex >= 0),
       assert(width == null || width > 0),
       assert(height == null || height > 0),
       assert(gap == null || gap >= 0);

  /// String-label convenience API; mutually exclusive with [items].
  final List<String> tabs;
  final List<DievasTab>? items;
  final int selectedIndex;

  /// Null is read-only unless a controller is supplied.
  final ValueChanged<int>? onChanged;
  final bool enabled;
  final DievasTabBarVariant variant;
  final DievasTabBarSize? tabBarSize;
  final bool isExpanded;
  final double? gap;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final DievasTabStyle tabStyle;
  final TabController? tabController;
  final Duration? transitionDuration;
  final Curve? transitionCurve;

  /// Optional baseline below the tabs. Defaults to the component theme.
  final bool? showDivider;

  @override
  State<DievasTabBar> createState() => _DievasTabBarState();
}

class _DievasTabBarState extends State<DievasTabBar> {
  final _layerKey = GlobalKey();
  final _tabKeys = <GlobalKey>[];
  final _nodes = <FocusNode>[];
  final _scroll = ScrollController();
  Rect? _indicator;
  bool _syncScheduled = false;
  int _controllerIndex = 0;
  (int, Rect, double, TextDirection)? _visibleLayout;

  List<DievasTab> get _items => switch (widget.items) {
    final items? => items,
    null => [for (final text in widget.tabs) DievasTab(label: Text(text), semanticLabel: text)],
  };
  int get _selected => widget.tabController?.index ?? widget.selectedIndex;
  bool get _canChange => widget.enabled && (widget.onChanged != null || widget.tabController != null);

  @override
  void initState() {
    super.initState();
    _syncResources();
    _controllerIndex = widget.tabController?.index ?? 0;
    widget.tabController?.addListener(_controllerChanged);
  }

  @override
  void didUpdateWidget(DievasTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabController != widget.tabController) {
      oldWidget.tabController?.removeListener(_controllerChanged);
      _controllerIndex = widget.tabController?.index ?? 0;
      widget.tabController?.addListener(_controllerChanged);
      _visibleLayout = null;
    }
    _syncResources();
  }

  @override
  void dispose() {
    widget.tabController?.removeListener(_controllerChanged);
    for (final node in _nodes) {
      node.dispose();
    }
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;
    assert(_selected < items.length, 'The selected tab must exist.');
    assert(widget.tabController == null || widget.tabController?.length == items.length);
    final theme = DievasTheme.componentsOf(context).tabBar;
    final sizing = DievasTheme.sizingOf(context);
    final spacing = DievasTheme.spacingOf(context);
    final height = switch ((widget.height, widget.tabBarSize)) {
      (final value?, _) => value,
      (_, .sm) => theme.smallHeight ?? sizing.height32,
      _ => theme.height,
    };
    final tabPadding = switch (widget.tabBarSize) {
      .sm => theme.smallTabPadding ?? EdgeInsets.symmetric(horizontal: spacing.smPlus),
      _ => theme.tabPadding,
    };
    final slotGap = switch (widget.tabBarSize) {
      .sm => theme.smallSlotGap ?? spacing.xs,
      _ => theme.slotGap ?? spacing.sm,
    };
    final radius = switch (widget.tabBarSize) {
      .sm => theme.smallBorderRadius ?? DievasTheme.borderOf(context).sm,
      _ => theme.borderRadius ?? DievasTheme.borderOf(context).md,
    };
    final duration = _duration(context);
    final curve = widget.transitionCurve ?? DievasTheme.animationOf(context).easingStandard;
    final selectedStyle = widget.tabStyle.merge(items.elementAt(_selected).style);
    final cells = [
      for (int index = 0; index < items.length; index++)
        _TabCell(
          key: _tabKeys.elementAt(index),
          item: items.elementAt(index),
          selected: index == _selected,
          variant: widget.variant,
          theme: theme,
          style: widget.tabStyle.merge(items.elementAt(index).style),
          tabPadding: tabPadding,
          slotGap: slotGap,
          radius: radius,
          duration: duration,
          curve: curve,
          enabled: items.elementAt(index).enabled,
          canChange: _canChange,
          node: items.elementAt(index).focusNode ?? _nodes.elementAt(index),
          onSelect: () => _select(index),
          onNavigate: (offset, end) => _navigate(index, offset, end),
        ),
    ];
    _scheduleSync();

    return Opacity(
      opacity: widget.enabled ? DievasTheme.opacityOf(context).opaque : theme.disabledOpacity,
      child: DecoratedBox(
        decoration: widget.decoration ?? const BoxDecoration(),
        child: Padding(
          padding: widget.padding ?? EdgeInsets.zero,
          child: SizedBox(
            width: widget.width,
            height: height,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final expanded = widget.isExpanded && constraints.hasBoundedWidth;
                return Stack(
                  children: [
                    SingleChildScrollView(
                      controller: _scroll,
                      scrollDirection: .horizontal,
                      child: SizedBox(
                        width: expanded ? constraints.maxWidth : null,
                        height: height,
                        child: Stack(
                          key: _layerKey,
                          children: [
                            Row(
                              mainAxisSize: .min,
                              crossAxisAlignment: .stretch,
                              children: [
                                for (final (index, cell) in cells.indexed) ...[
                                  if (index > 0) SizedBox(width: widget.gap ?? theme.gap),
                                  if (expanded) Expanded(child: cell) else cell,
                                ],
                              ],
                            ),
                            if ((_indicator, widget.variant) case (final rect?, .underline))
                              AnimatedPositioned(
                                key: const ValueKey('dievas_tab_bar_indicator'),
                                duration: duration,
                                curve: curve,
                                left: rect.left,
                                width: rect.width,
                                bottom: 0,
                                height: selectedStyle.indicatorHeight ?? theme.indicatorHeight,
                                child: IgnorePointer(
                                  child: ColoredBox(color: selectedStyle.indicatorColour ?? theme.indicatorColour),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (widget.showDivider ?? theme.showDivider)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: IgnorePointer(
                          child: ColoredBox(
                            color: theme.dividerColour,
                            child: SizedBox(height: DievasTheme.borderOf(context).strokeThin),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Duration _duration(BuildContext context) => switch (MediaQuery.disableAnimationsOf(context)) {
    true => Duration.zero,
    false => widget.transitionDuration ?? DievasTheme.componentsOf(context).tabBar.animationDuration,
  };

  void _syncResources() {
    while (_tabKeys.length < _items.length) {
      _tabKeys.add(GlobalKey());
      _nodes.add(FocusNode());
    }
    while (_tabKeys.length > _items.length) {
      _tabKeys.removeLast();
      _nodes.removeLast().dispose();
    }
  }

  void _controllerChanged() {
    if (widget.tabController case final controller? when controller.index != _controllerIndex) {
      setState(() => _controllerIndex = controller.index);
      widget.onChanged?.call(controller.index);
    }
  }

  void _select(int index) {
    if (!_canChange || !_items.elementAt(index).enabled || index == _selected) return;
    switch (widget.tabController) {
      case final controller?:
        controller.animateTo(index, duration: _duration(context));
      case null:
        widget.onChanged?.call(index);
    }
  }

  void _navigate(int from, int offset, bool end) {
    if (!_canChange) return;
    final items = _items;
    int index = end ? (offset > 0 ? items.length - 1 : 0) : (from + offset) % items.length;
    for (int attempt = 0; attempt < items.length; attempt++) {
      final item = items.elementAt(index);
      if (item.enabled && item.isFocusable) {
        (item.focusNode ?? _nodes.elementAt(index)).requestFocus();
        _select(index);
        return;
      }
      index = (index + (offset > 0 ? 1 : -1)) % items.length;
    }
  }

  void _scheduleSync() {
    if (_syncScheduled) return;
    _syncScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncScheduled = false;
      if (!mounted) return;
      if ((
            _layerKey.currentContext?.findRenderObject(),
            _tabKeys.elementAt(_selected).currentContext?.findRenderObject(),
          )
          case (final RenderBox layer, final RenderBox tab) when layer.hasSize && tab.hasSize) {
        final rect = tab.localToGlobal(Offset.zero, ancestor: layer) & tab.size;
        if (_indicator != rect) setState(() => _indicator = rect);
        if (_scroll.hasClients) {
          final viewport = _scroll.position.viewportDimension;
          final layout = (_selected, rect, viewport, Directionality.of(context));
          if (_visibleLayout == layout) return;
          _visibleLayout = layout;
          final offset = switch (Directionality.of(context)) {
            .ltr => rect.left,
            .rtl => layer.size.width - rect.right,
          };
          final target = (offset - (viewport - rect.width) / 2).clamp(0.0, _scroll.position.maxScrollExtent);
          switch (_duration(context)) {
            case Duration.zero:
              _scroll.jumpTo(target);
            case final duration:
              _scroll.animateTo(target, duration: duration, curve: Curves.linear);
          }
        }
      }
    });
  }
}

class _TabCell extends StatefulWidget {
  const _TabCell({
    super.key,
    required this.item,
    required this.selected,
    required this.variant,
    required this.theme,
    required this.style,
    required this.tabPadding,
    required this.slotGap,
    required this.radius,
    required this.duration,
    required this.curve,
    required this.enabled,
    required this.canChange,
    required this.node,
    required this.onSelect,
    required this.onNavigate,
  });
  final DievasTab item;
  final bool selected;
  final DievasTabBarVariant variant;
  final DievasTabBarThemeData theme;
  final DievasTabStyle style;
  final EdgeInsetsGeometry tabPadding;
  final double slotGap;
  final BorderRadiusGeometry radius;
  final Duration duration;
  final Curve curve;
  final bool enabled;
  final bool canChange;
  final FocusNode node;
  final VoidCallback onSelect;
  final void Function(int offset, bool end) onNavigate;

  @override
  State<_TabCell> createState() => _TabCellState();
}

class _TabCellState extends State<_TabCell> {
  bool _hovered = false;
  bool _pressed = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    final theme = widget.theme;
    final colours = DievasTheme.coloursOf(context);
    final active = widget.selected || (widget.canChange && widget.enabled && (_hovered || _pressed));
    final foreground = switch ((
      active,
      style.selectedTextColour,
      style.textColour,
      style.textStyle?.color,
      widget.variant,
    )) {
      (true, final colour?, _, _, _) => colour,
      (false, _, final colour?, _, _) => colour,
      (_, _, _, final colour?, _) => colour,
      (true, _, _, _, .pill) => theme.pillSelectedTextColour ?? colours.text.textPrimary,
      (true, _, _, _, _) => theme.selectedLabelStyle.color,
      _ => theme.labelStyle.color,
    };
    final pillColour = switch ((style.selectedBackgroundColour, theme.pillSelectedColour, colours.brightness)) {
      (final colour?, _, _) || (_, final colour?, _) => colour,
      (_, _, .light) => colours.staticColours.staticWhite,
      (_, _, .dark) => colours.staticColours.staticBlack,
    };
    final radius = (style.borderRadius ?? widget.radius).resolve(Directionality.of(context));
    final direction = Directionality.of(context) == TextDirection.rtl ? -1 : 1;
    final interactive = widget.enabled && widget.canChange;
    final padding = switch (style.padding) {
      final padding? => padding,
      null => EdgeInsetsDirectional.only(
        top: widget.tabPadding.resolve(Directionality.of(context)).top,
        bottom: widget.tabPadding.resolve(Directionality.of(context)).bottom,
        start: widget.item.leading == null && widget.item.label != null
            ? widget.tabPadding.resolve(Directionality.of(context)).left
            : 0,
        end: widget.item.trailing == null && widget.item.label != null
            ? widget.tabPadding.resolve(Directionality.of(context)).right
            : 0,
      ),
    };
    return FocusableActionDetector(
      enabled: interactive && widget.item.isFocusable,
      focusNode: widget.node,
      autofocus: widget.item.autofocus,
      mouseCursor: interactive ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onShowFocusHighlight: (value) => setState(() => _focused = value),
      onShowHoverHighlight: (value) => setState(() => _hovered = value),
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.arrowRight): _MoveIntent(1),
        SingleActivator(LogicalKeyboardKey.arrowLeft): _MoveIntent(-1),
        SingleActivator(LogicalKeyboardKey.home): _MoveIntent(-1, end: true),
        SingleActivator(LogicalKeyboardKey.end): _MoveIntent(1, end: true),
      },
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            widget.onSelect();
            return null;
          },
        ),
        _MoveIntent: CallbackAction<_MoveIntent>(
          onInvoke: (intent) {
            widget.onNavigate(intent.end ? intent.offset : intent.offset * direction, intent.end);
            return null;
          },
        ),
      },
      child: Semantics(
        selected: widget.selected,
        enabled: interactive,
        button: true,
        label: widget.item.semanticLabel,
        excludeSemantics: widget.item.semanticLabel != null,
        onTap: interactive ? widget.onSelect : null,
        child: GestureDetector(
          excludeFromSemantics: true,
          behavior: .opaque,
          onTap: interactive ? widget.onSelect : null,
          onTapDown: interactive ? (_) => setState(() => _pressed = true) : null,
          onTapUp: interactive ? (_) => setState(() => _pressed = false) : null,
          onTapCancel: () => setState(() => _pressed = false),
          child: Opacity(
            opacity: widget.enabled ? DievasTheme.opacityOf(context).opaque : theme.disabledOpacity,
            child: IgnorePointer(
              child: ExcludeFocus(
                child: AnimatedContainer(
                  duration: widget.duration,
                  curve: widget.curve,
                  constraints: BoxConstraints(minWidth: theme.minTabWidth),
                  decoration: BoxDecoration(
                    // Preserve RGB at the transparent endpoint so interrupted fades
                    // cannot interpolate through grey or another unintended hue.
                    color: switch ((widget.variant, active)) {
                      (.pill, true) => pillColour,
                      (.pill, false) => pillColour.withValues(alpha: 0),
                      _ => colours.staticColours.staticTransparent,
                    },
                    borderRadius: radius,
                    boxShadow: switch ((_focused, widget.item.showFocusEffect)) {
                      (true, true) => [
                        BoxShadow(
                          color: style.focusColour ?? colours.border.focusIndicatorColour,
                          spreadRadius: DievasTheme.borderOf(context).strokeThick,
                        ),
                      ],
                      _ => const [],
                    },
                  ),
                  foregroundDecoration: style.decoration,
                  child: Stack(
                    alignment: .center,
                    children: [
                      Padding(
                        padding: padding,
                        child: IconTheme(
                          data: IconThemeData(
                            color: switch ((active, style.selectedIconColour, style.iconColour)) {
                              (true, final colour?, _) => colour,
                              (_, _, final colour?) => colour,
                              _ => foreground,
                            },
                            size: theme.iconSize ?? DievasTheme.sizingOf(context).iconMd,
                          ),
                          child: AnimatedDefaultTextStyle(
                            duration: widget.duration,
                            curve: widget.curve,
                            style: (widget.selected ? theme.selectedLabelStyle : theme.labelStyle)
                                .merge(style.textStyle)
                                .copyWith(color: foreground),
                            child: switch (widget.item.builder) {
                              final builder? => builder(context, widget.selected),
                              null => Row(
                                mainAxisSize: .min,
                                mainAxisAlignment: .center,
                                children: [
                                  if (widget.item.leading case final leading?)
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: style.gap ?? widget.slotGap),
                                      child: leading,
                                    ),
                                  if (widget.item.label case final label?) Flexible(child: label),
                                  if (widget.item.trailing case final trailing?)
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: style.gap ?? widget.slotGap),
                                      child: trailing,
                                    ),
                                ],
                              ),
                            },
                          ),
                        ),
                      ),
                      if (widget.variant == DievasTabBarVariant.underline && !widget.selected)
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Align(
                            child: AnimatedFractionallySizedBox(
                              duration: widget.duration,
                              curve: widget.curve,
                              widthFactor: active ? 1 : 0,
                              child: ColoredBox(
                                color: style.indicatorColour ?? theme.indicatorColour,
                                child: SizedBox(height: style.indicatorHeight ?? theme.indicatorHeight),
                              ),
                            ),
                          ),
                        ),
                    ],
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

class _MoveIntent extends Intent {
  const _MoveIntent(this.offset, {this.end = false});
  final int offset;
  final bool end;
}
