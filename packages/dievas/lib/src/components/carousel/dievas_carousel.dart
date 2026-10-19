import 'dart:async';
import 'dart:math' as math;

import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// Controls a single [DievasCarousel]. Item indices are zero based.
class DievasCarouselController extends ScrollController {
  DievasCarouselController({this.initialItem = 0}) : assert(initialItem >= 0);

  final int initialItem;
  double _step = 1;
  int _count = 0;
  double _end = 0;
  double _velocityFactor = .5;
  bool _loop = false;
  bool _reduceMotion = false;
  Duration _duration = DievasDurationPrimitives.d800;
  Curve _curve = Curves.fastOutSlowIn;

  /// Logical item nearest the carousel's anchor.
  int get selectedItem => _count == 0 ? 0 : _realItem % _count;
  int get _realItem => hasClients ? (offset / _step).round() : initialItem;

  void jumpToItem(int index) {
    if (hasClients && _count > 0) jumpTo(_target(index));
  }

  Future<void> animateToItem(int index) async {
    if (!hasClients || _count == 0) return;
    await _move(_target(index));
  }

  Future<void> nextItem() => _moveReal(_realItem + 1);
  Future<void> previousItem() => _moveReal(_realItem - 1);

  @override
  ScrollPosition createScrollPosition(ScrollPhysics physics, ScrollContext context, ScrollPosition? oldPosition) =>
      _CarouselPosition(
        carousel: this,
        physics: physics,
        context: context,
        oldPosition: oldPosition,
        initialPixels: initialItem.clamp(0, math.max(0, _count - 1)) * _step,
      );

  double _target(int index) {
    final logical = index.clamp(0, _count - 1);
    final real = _loop ? logical + ((_realItem - logical) / _count).round() * _count : logical;
    return (real * _step).clamp(position.minScrollExtent, position.maxScrollExtent);
  }

  Future<void> _moveReal(int index) async {
    if (!hasClients || _count == 0) return;
    await _move((index * _step).clamp(position.minScrollExtent, position.maxScrollExtent));
  }

  Future<void> _move(double pixels) async {
    if (_reduceMotion || _duration == Duration.zero) {
      jumpTo(pixels);
      return;
    }
    await animateTo(pixels, duration: _duration, curve: _curve);
  }
}

/// A lazy, snapping strip of fixed extent items, with optional infinite scrolling.
///
/// Constrain the viewport along both axes. [itemBuilder] receives the logical
/// item index and the real scroll index (which may be negative when looping).
/// Navigation controls and item decoration are composed outside the carousel.
class DievasCarousel extends StatefulWidget {
  const DievasCarousel({
    super.key,
    required this.itemCount,
    required this.itemExtent,
    required this.itemBuilder,
    this.controller,
    this.axisDirection = Axis.horizontal,
    this.gap,
    this.anchor = 0,
    this.isCentered = true,
    this.clampMaxExtent = false,
    this.loop = false,
    this.autoPlay = false,
    this.velocityFactor = .5,
    this.autoPlayDelay,
    this.transitionDuration,
    this.transitionCurve,
    this.onIndexChanged,
    this.physics,
    this.scrollBehavior,
  }) : assert(itemCount >= 0),
       assert(itemExtent > 0),
       assert(gap == null || gap >= 0),
       assert(anchor >= 0 && anchor <= 1),
       assert(velocityFactor > 0 && velocityFactor <= 1),
       assert(autoPlayDelay == null || autoPlayDelay > Duration.zero);

  final int itemCount;
  final double itemExtent;
  final Widget Function(BuildContext context, int index, int realIndex) itemBuilder;
  final DievasCarouselController? controller;
  final Axis axisDirection;
  final double? gap;
  final double anchor;
  final bool isCentered;
  final bool clampMaxExtent;
  final bool loop;
  final bool autoPlay;
  final double velocityFactor;
  final Duration? autoPlayDelay;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final ValueChanged<int>? onIndexChanged;
  final ScrollPhysics? physics;
  final ScrollBehavior? scrollBehavior;

  @override
  State<DievasCarousel> createState() => _DievasCarouselState();
}

class _DievasCarouselState extends State<DievasCarousel> with WidgetsBindingObserver {
  late DievasCarouselController _controller = widget.controller ?? DievasCarouselController();
  final GlobalKey _forwardKey = GlobalKey();
  Timer? _timer;
  int? _lastIndex;
  bool _pointerDown = false;
  bool _resumed = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didUpdateWidget(DievasCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller == null) _controller.dispose();
      _controller = widget.controller ?? DievasCarouselController();
      _lastIndex = null;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _resumed = state == AppLifecycleState.resumed;
    _schedule();
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).carousel;
    _controller._velocityFactor = widget.velocityFactor;
    _controller._reduceMotion = MediaQuery.disableAnimationsOf(context);
    _controller._duration = widget.transitionDuration ?? theme.transitionDuration;
    _controller._curve = widget.transitionCurve ?? theme.transitionCurve;
    _timer?.cancel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _schedule();
    });
    if (widget.itemCount == 0) return const SizedBox.shrink();
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewport = widget.axisDirection == Axis.horizontal ? constraints.maxWidth : constraints.maxHeight;
        assert(viewport.isFinite, 'DievasCarousel needs a bounded scroll axis.');
        if (viewport == 0) {
          return const SizedBox.shrink();
        }
        final extent = math.min(widget.itemExtent, viewport);
        final gap = widget.gap ?? theme.gap;
        final step = extent + gap;
        final anchor = widget.isCentered && viewport > 0 ? (viewport - extent) / (2 * viewport) : widget.anchor;
        final previous = _controller.selectedItem;
        final changed =
            _controller._step != step || _controller._count != widget.itemCount || _controller._loop != widget.loop;
        _controller
          .._step = step
          .._count = widget.itemCount
          .._loop = widget.loop;
        if (changed && _controller.hasClients) {
          _controller.position.correctPixels(previous.clamp(0, widget.itemCount - 1) * step);
        }
        final end = widget.clampMaxExtent
            ? math.max(0.0, widget.itemCount * step - gap - viewport + 2 * anchor * viewport)
            : (widget.itemCount - 1) * step;
        _controller._end = end;
        return Focus(
          onKeyEvent: (_, event) {
            if (event case KeyDownEvent()) {
              final reverse =
                  widget.axisDirection == Axis.horizontal && Directionality.of(context) == TextDirection.rtl;
              final forward = widget.axisDirection == Axis.horizontal
                  ? LogicalKeyboardKey.arrowRight
                  : LogicalKeyboardKey.arrowDown;
              final backward = widget.axisDirection == Axis.horizontal
                  ? LogicalKeyboardKey.arrowLeft
                  : LogicalKeyboardKey.arrowUp;
              if (event.logicalKey == forward || event.logicalKey == backward) {
                unawaited(
                  (event.logicalKey == forward) != reverse ? _controller.nextItem() : _controller.previousItem(),
                );
                return KeyEventResult.handled;
              }
            }
            return KeyEventResult.ignored;
          },
          child: Listener(
            onPointerDown: (_) {
              _pointerDown = true;
              _timer?.cancel();
            },
            onPointerUp: (_) {
              _pointerDown = false;
              _schedule();
            },
            onPointerCancel: (_) {
              _pointerDown = false;
              _schedule();
            },
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.depth != 0) return false;
                final index = _controller.selectedItem;
                if (_lastIndex != index) {
                  _lastIndex = index;
                  widget.onIndexChanged?.call(index);
                }
                if (notification case ScrollStartNotification()) {
                  _timer?.cancel();
                }
                if (notification case ScrollEndNotification()) _schedule();
                return false;
              },
              child: DefaultTextStyle.merge(
                style: theme.textStyle,
                child: CustomScrollView(
                  key: ObjectKey(_controller),
                  controller: _controller,
                  scrollDirection: widget.axisDirection,
                  anchor: anchor,
                  center: _forwardKey,
                  scrollBehavior: widget.scrollBehavior ?? const _CarouselScrollBehavior(),
                  physics: _CarouselPhysics(state: this, parent: widget.physics ?? const ClampingScrollPhysics()),
                  slivers: [
                    if (widget.loop)
                      SliverFixedExtentList(
                        itemExtent: step,
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _CarouselItem(
                            axis: widget.axisDirection,
                            gap: gap,
                            child: widget.itemBuilder(context, (-index - 1) % widget.itemCount, -index - 1),
                          ),
                        ),
                      ),
                    SliverFixedExtentList(
                      key: _forwardKey,
                      itemExtent: step,
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _CarouselItem(
                          axis: widget.axisDirection,
                          gap: gap,
                          child: widget.itemBuilder(context, index % widget.itemCount, index),
                        ),
                        childCount: widget.loop ? null : widget.itemCount,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _schedule() {
    _timer?.cancel();
    if (!mounted ||
        !widget.autoPlay ||
        widget.itemCount < 2 ||
        _pointerDown ||
        !_resumed ||
        _controller._reduceMotion ||
        !TickerMode.valuesOf(context).enabled ||
        !_controller.hasClients) {
      return;
    }
    _timer = Timer(widget.autoPlayDelay ?? DievasTheme.componentsOf(context).carousel.autoPlayDelay, () async {
      if (_controller.position.isScrollingNotifier.value) return;
      if (!widget.loop && _controller.offset >= _controller.position.maxScrollExtent) {
        await _controller.animateToItem(0);
      } else {
        await _controller.nextItem();
      }
      if (mounted) _schedule();
    });
  }
}

class _CarouselItem extends StatelessWidget {
  const _CarouselItem({required this.axis, required this.gap, required this.child});
  final Axis axis;
  final double gap;
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: axis == .horizontal ? EdgeInsetsDirectional.only(end: gap) : .only(bottom: gap),
    child: child,
  );
}

class _CarouselPhysics extends ScrollPhysics {
  const _CarouselPhysics({required this.state, super.parent});

  final _DievasCarouselState state;
  DievasCarouselController get controller => state._controller;
  double get step => controller._step;
  double get end => controller._end;
  bool get loop => controller._loop;
  double get velocityFactor => controller._velocityFactor;

  @override
  _CarouselPhysics applyTo(ScrollPhysics? ancestor) => _CarouselPhysics(state: state, parent: buildParent(ancestor));

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (loop) return super.applyBoundaryConditions(position, value);
    if (value < 0) return value - math.min(0, position.pixels);
    if (value > end) return value - math.max(end, position.pixels);
    return 0;
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final tolerance = toleranceFor(position);
    if (!loop && velocity.abs() < tolerance.velocity && (position.pixels == 0 || position.pixels == end)) {
      return null;
    }
    final projected = FrictionSimulation(.135, position.pixels, velocity * velocityFactor).finalX;
    final target = ((projected / step).round() * step).clamp(
      loop ? double.negativeInfinity : 0.0,
      loop ? double.infinity : end,
    );
    if ((target - position.pixels).abs() < tolerance.distance && velocity.abs() < tolerance.velocity) {
      return null;
    }
    return ScrollSpringSimulation(spring, position.pixels, target, velocity * velocityFactor, tolerance: tolerance);
  }
}

class _CarouselScrollBehavior extends ScrollBehavior {
  const _CarouselScrollBehavior();
  @override
  Set<PointerDeviceKind> get dragDevices => {.touch, .mouse, .stylus, .trackpad};
  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) => child;
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) => child;
}

class _CarouselPosition extends ScrollPositionWithSingleContext {
  _CarouselPosition({
    required this.carousel,
    required super.physics,
    required super.context,
    required super.initialPixels,
    super.oldPosition,
  });

  final DievasCarouselController carousel;

  @override
  bool applyContentDimensions(double minScrollExtent, double maxScrollExtent) => super.applyContentDimensions(
    carousel._loop ? minScrollExtent : 0,
    carousel._loop ? maxScrollExtent : carousel._end,
  );
}
