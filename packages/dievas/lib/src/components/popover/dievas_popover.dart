import 'package:flutter/material.dart' show Theme;
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// Preferred placement relative to the trigger. Corner names follow Moon's
/// convention: topLeft extends to the left of the target's trailing edge.
enum DievasPopoverPosition {
  bottom,
  top,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  vertical,
  horizontal,
}

/// An anchored, nonmodal panel. Omit [show] for automatic trigger toggling.
/// With [show], the caller owns visibility and handles [onOpenChanged].
class DievasPopover extends StatefulWidget {
  const DievasPopover({
    super.key,
    required this.trigger,
    required this.content,
    this.position = .bottom,
    this.show,
    this.onOpenChanged,
    this.onTapOutside,
    this.dismissOnTapOutside = true,
    this.enabled = true,
    this.backgroundColour,
    this.textColour,
    this.iconColour,
    this.borderColour,
    this.borderWidth,
    this.borderRadius,
    this.contentPadding,
    this.decoration,
    this.shadow,
    this.distanceToTarget,
    this.popoverMargin,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.transitionDuration,
    this.transitionCurve,
    this.semanticLabel,
    this.routeObserver,
  });

  /// Target content. In automatic mode pointer taps also reach its own handlers.
  /// In controlled mode an interactive trigger owns its activation callback.
  final Widget trigger;
  final Widget content;
  final DievasPopoverPosition position;

  /// Caller owned visibility. Null enables automatic trigger toggling.
  final bool? show;

  /// Reports requested visibility changes; update [show] when controlling it.
  final ValueChanged<bool>? onOpenChanged;
  final VoidCallback? onTapOutside;
  final bool dismissOnTapOutside;
  final bool enabled;
  final Color? backgroundColour;
  final Color? textColour;
  final Color? iconColour;
  final Color? borderColour;
  final double? borderWidth;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  /// Owns the entire painted surface when supplied.
  final Decoration? decoration;

  /// Overrides theme shadows. Supply an empty list to omit them.
  final List<BoxShadow>? shadow;
  final double? distanceToTarget;
  final double? popoverMargin;
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final String? semanticLabel;

  /// Register this observer on the owning Navigator to hide covered routes.
  final RouteObserver<PageRoute<dynamic>>? routeObserver;

  @override
  State<DievasPopover> createState() => _DievasPopoverState();
}

class _DievasPopoverState extends State<DievasPopover> with SingleTickerProviderStateMixin, RouteAware {
  final _link = LayerLink();
  final _targetKey = GlobalKey();
  final _group = Object();
  final _triggerFocus = FocusNode();
  final _panelFocus = FocusScopeNode();
  late final AnimationController _controller;
  late final CurvedAnimation _animation;
  OverlayEntry? _entry;
  PageRoute<dynamic>? _route;
  bool _open = false;
  bool _routeVisible = true;
  bool _scheduled = false;
  bool _focusVisible = false;
  (int, Offset)? _pointer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration.zero);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _subscribe();
    _schedule();
  }

  @override
  void didUpdateWidget(DievasPopover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.routeObserver != widget.routeObserver) {
      oldWidget.routeObserver?.unsubscribe(this);
      _route = null;
      _subscribe();
    }
    _schedule();
  }

  @override
  void didPushNext() {
    _routeVisible = false;
    _remove();
  }

  @override
  void didPopNext() {
    _routeVisible = true;
    _schedule();
  }

  @override
  void didPop() {
    _routeVisible = false;
    _remove();
  }

  @override
  void deactivate() {
    _remove();
    super.deactivate();
  }

  @override
  void activate() {
    super.activate();
    _schedule();
  }

  @override
  void dispose() {
    widget.routeObserver?.unsubscribe(this);
    _remove();
    _animation.dispose();
    _controller.dispose();
    _triggerFocus.dispose();
    _panelFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TapRegion(
    groupId: _group,
    child: CompositedTransformTarget(
      key: _targetKey,
      link: _link,
      child: FocusableActionDetector(
        focusNode: _triggerFocus,
        enabled: widget.enabled,
        onShowFocusHighlight: (value) => setState(() => _focusVisible = value),
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              _request(!_open);
              return null;
            },
          ),
          DismissIntent: CallbackAction<DismissIntent>(
            onInvoke: (_) {
              _request(false);
              return null;
            },
          ),
        },
        child: Semantics(
          button: true,
          enabled: widget.enabled,
          expanded: _open,
          onTap: widget.enabled ? () => _request(!_open) : null,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: DievasTheme.borderOf(context).md,
              border: switch (_focusVisible) {
                true => Border.all(
                  color: DievasTheme.coloursOf(context).core.primary,
                  width: DievasTheme.borderOf(context).strokeThin,
                ),
                false => null,
              },
            ),
            child: Listener(
              behavior: .opaque,
              onPointerDown: (event) => _pointer = (event.pointer, event.position),
              onPointerMove: (event) {
                if (_pointer case (
                  final pointer,
                  final origin,
                ) when pointer == event.pointer && (event.position - origin).distance > kTouchSlop) {
                  _pointer = null;
                }
              },
              onPointerCancel: (_) => _pointer = null,
              onPointerUp: (event) {
                if (_pointer case (final pointer, _) when pointer == event.pointer && widget.show == null) {
                  _request(!_open);
                }
                _pointer = null;
              },
              child: switch ((widget.enabled, widget.show)) {
                (false, _) => ExcludeFocus(child: IgnorePointer(child: widget.trigger)),
                (true, null) => ExcludeFocus(child: widget.trigger),
                _ => GestureDetector(behavior: .opaque, onTap: () => _request(!_open), child: widget.trigger),
              },
            ),
          ),
        ),
      ),
    ),
  );

  void _subscribe() {
    switch (ModalRoute.of(context)) {
      case final PageRoute<dynamic> route when route != _route:
        widget.routeObserver?.unsubscribe(this);
        _route = route;
        widget.routeObserver?.subscribe(this, route);
      default:
        break;
    }
  }

  void _request(bool open) {
    if (!widget.enabled || open == _open) return;
    if (widget.show == null) setState(() => _open = open);
    widget.onOpenChanged?.call(open);
    if (!open && _panelFocus.hasFocus) _triggerFocus.requestFocus();
    _schedule();
  }

  void _schedule() {
    if (_scheduled) return;
    _scheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scheduled = false;
      if (!mounted) return;
      final theme = DievasTheme.componentsOf(context).popover;
      _controller.duration = switch ((MediaQuery.disableAnimationsOf(context), widget.transitionDuration)) {
        (true, _) => Duration.zero,
        (false, final duration?) => duration,
        (false, null) => theme.animationDuration,
      };
      _animation.curve = switch ((widget.transitionCurve, theme.transitionCurve)) {
        (final curve?, _) || (null, final curve?) => curve,
        (null, null) => DievasTheme.animationOf(context).easingStandard,
      };
      final visible = widget.enabled && _routeVisible && (widget.show ?? _open);
      if (!visible && _panelFocus.hasFocus) _triggerFocus.requestFocus();
      if (_open != visible) setState(() => _open = visible);
      switch ((visible, _entry)) {
        case (true, null):
          _insert();
          _controller.forward();
        case (true, final entry?):
          _controller.forward();
          entry.markNeedsBuild();
        case (false, final entry?):
          _controller.reverse().whenCompleteOrCancel(() {
            if (mounted && !_open && identical(_entry, entry)) _remove();
          });
        default:
          break;
      }
    });
  }

  void _insert() {
    _entry = OverlayEntry(
      builder: (overlayContext) => InheritedTheme.captureAll(
        context,
        DievasTheme(
          data: DievasTheme.of(context),
          child: Theme(
            data: Theme.of(context),
            child: Directionality(
              textDirection: Directionality.of(context),
              child: _PopoverPanel(
                popover: widget,
                sourceContext: context,
                targetKey: _targetKey,
                link: _link,
                group: _group,
                animation: _animation,
                focusNode: _panelFocus,
                dismiss: () => _request(false),
                tapOutside: () {
                  widget.onTapOutside?.call();
                  if (widget.dismissOnTapOutside) _request(false);
                },
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_entry as OverlayEntry);
  }

  void _remove() {
    _entry?.remove();
    _entry?.dispose();
    _entry = null;
  }
}

class _PopoverPanel extends StatelessWidget {
  const _PopoverPanel({
    required this.popover,
    required this.sourceContext,
    required this.targetKey,
    required this.link,
    required this.group,
    required this.animation,
    required this.focusNode,
    required this.dismiss,
    required this.tapOutside,
  });

  final DievasPopover popover;
  final BuildContext sourceContext;
  final GlobalKey targetKey;
  final LayerLink link;
  final Object group;
  final Animation<double> animation;
  final FocusScopeNode focusNode;
  final VoidCallback dismiss;
  final VoidCallback tapOutside;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).popover;
    final overlay = Overlay.of(sourceContext).context.findRenderObject() as RenderBox;
    final target = targetKey.currentContext!.findRenderObject() as RenderBox;
    final origin = target.localToGlobal(Offset.zero, ancestor: overlay);
    final bounds = origin & target.size;
    final margin = popover.popoverMargin ?? theme.popoverMargin;
    final position = switch ((popover.position, Directionality.of(context))) {
      (.vertical, _) =>
        bounds.center.dy < overlay.size.height / 2 ? DievasPopoverPosition.bottom : DievasPopoverPosition.top,
      (.horizontal, _) =>
        bounds.center.dx < overlay.size.width / 2 ? DievasPopoverPosition.right : DievasPopoverPosition.left,
      (.left, .rtl) => DievasPopoverPosition.right,
      (.right, .rtl) => DievasPopoverPosition.left,
      (.topLeft, .rtl) => DievasPopoverPosition.topRight,
      (.topRight, .rtl) => DievasPopoverPosition.topLeft,
      (.bottomLeft, .rtl) => DievasPopoverPosition.bottomRight,
      (.bottomRight, .rtl) => DievasPopoverPosition.bottomLeft,
      (final position, _) => position,
    };
    final distance = switch ((popover.distanceToTarget, position)) {
      (final distance?, _) => distance,
      (null, .left || .right) => theme.horizontalOffset,
      (null, _) => theme.verticalOffset,
    };
    final availableWidth = switch (position) {
      .left => bounds.left - distance - margin,
      .right => overlay.size.width - bounds.right - distance - margin,
      _ => overlay.size.width - margin * 2,
    }.clamp(0.0, overlay.size.width);
    final availableHeight = switch (position) {
      .top || .topLeft || .topRight => bounds.top - distance - margin,
      .bottom || .bottomLeft || .bottomRight => overlay.size.height - bounds.bottom - distance - margin,
      _ => overlay.size.height - margin * 2,
    }.clamp(0.0, overlay.size.height);
    final maxWidth = (popover.maxWidth ?? theme.maxWidth).clamp(0.0, availableWidth);
    final maxHeight = (popover.maxHeight ?? availableHeight).clamp(0.0, availableHeight);

    return Positioned.fill(
      child: CompositedTransformFollower(
        link: link,
        showWhenUnlinked: false,
        offset: -origin,
        child: CustomSingleChildLayout(
          delegate: _PopoverLayout(
            bounds: bounds,
            viewport: overlay.size,
            position: position,
            distance: distance,
            margin: margin,
          ),
          child: TapRegion(
            groupId: group,
            onTapOutside: (event) {
              if ((overlay.localToGlobal(Offset.zero) & overlay.size).contains(event.position)) tapOutside();
            },
            child: FocusScope(
              node: focusNode,
              child: Shortcuts(
                shortcuts: const {SingleActivator(LogicalKeyboardKey.escape): DismissIntent()},
                child: Actions(
                  actions: {
                    DismissIntent: CallbackAction<DismissIntent>(
                      onInvoke: (_) {
                        dismiss();
                        return null;
                      },
                    ),
                  },
                  child: FadeTransition(
                    opacity: animation,
                    child: Semantics(
                      label: popover.semanticLabel,
                      container: true,
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: (popover.minWidth ?? 0).clamp(0.0, maxWidth),
                          maxWidth: maxWidth,
                          minHeight: (popover.minHeight ?? 0).clamp(0.0, maxHeight),
                          maxHeight: maxHeight,
                        ),
                        padding: popover.contentPadding ?? theme.padding,
                        decoration: switch (popover.decoration) {
                          final decoration? => decoration,
                          null => BoxDecoration(
                            color: popover.backgroundColour ?? theme.backgroundColour,
                            borderRadius: (popover.borderRadius ?? theme.borderRadius).resolve(
                              Directionality.of(context),
                            ),
                            border: Border.all(
                              color: popover.borderColour ?? theme.borderColour,
                              width: popover.borderWidth ?? theme.borderWidth,
                            ),
                            boxShadow: popover.shadow ?? theme.shadow,
                          ),
                        },
                        child: DefaultTextStyle(
                          style: theme.textStyle.copyWith(color: popover.textColour ?? theme.textStyle.color),
                          child: IconTheme(
                            data: IconThemeData(
                              color: switch ((popover.iconColour, theme.iconColour)) {
                                (final colour?, _) || (null, final colour?) => colour,
                                (null, null) => DievasTheme.coloursOf(context).icon.iconPrimary,
                              },
                            ),
                            child: SingleChildScrollView(child: popover.content),
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
      ),
    );
  }
}

class _PopoverLayout extends SingleChildLayoutDelegate {
  const _PopoverLayout({
    required this.bounds,
    required this.viewport,
    required this.position,
    required this.distance,
    required this.margin,
  });

  final Rect bounds;
  final Size viewport;
  final DievasPopoverPosition position;
  final double distance;
  final double margin;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) => constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final offset = switch (position) {
      .top => Offset(bounds.center.dx - childSize.width / 2, bounds.top - distance - childSize.height),
      .topLeft => Offset(bounds.right - childSize.width, bounds.top - distance - childSize.height),
      .topRight => Offset(bounds.left, bounds.top - distance - childSize.height),
      .bottomLeft => Offset(bounds.right - childSize.width, bounds.bottom + distance),
      .bottomRight => Offset(bounds.left, bounds.bottom + distance),
      .left => Offset(bounds.left - distance - childSize.width, bounds.center.dy - childSize.height / 2),
      .right => Offset(bounds.right + distance, bounds.center.dy - childSize.height / 2),
      _ => Offset(bounds.center.dx - childSize.width / 2, bounds.bottom + distance),
    };

    return Offset(
      offset.dx.clamp(margin, (size.width - childSize.width - margin).clamp(margin, .infinity)),
      offset.dy.clamp(margin, (size.height - childSize.height - margin).clamp(margin, .infinity)),
    );
  }

  @override
  bool shouldRelayout(_PopoverLayout oldDelegate) =>
      bounds != oldDelegate.bounds ||
      viewport != oldDelegate.viewport ||
      position != oldDelegate.position ||
      distance != oldDelegate.distance ||
      margin != oldDelegate.margin;
}
