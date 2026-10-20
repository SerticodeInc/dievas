import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:dievas/src/extensions/dievas_theme_context_extension.dart';
import 'package:dievas/src/components/divider/dievas_divider.dart';
import 'package:dievas/src/components/buttons/dievas_icon_button.dart';
import 'package:dievas/src/theme/dievas_theme.dart';
import 'package:dievas/src/theme/dievas_theme_data.dart';

/// Shows a themed modal sheet and returns the value passed when it closes.
///
/// Size it with [height], [heightFactor], or [maxHeightFactor] for full sheets;
/// [fitContent] wraps content up to the cap. [enableResize] lets upward drags
/// grow it, and lazy lists must set shrinkWrap.
///
/// A released drag below [closeProgressThreshold] or a fast fling closes it;
/// [isDismissible] gates barrier and Escape dismissal. Nested lists can hand a
/// top-of-list drag to the sheet.
Future<T?> showDievasBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isDismissible = true,
  bool enableDrag = true,
  bool isScrollControlled = false,
  bool isExpanded = false,
  bool fitContent = false,
  bool enableResize = true,
  double maxHeightFactor = 0.93,
  bool useRootNavigator = false,
  bool useSafeArea = true,
  double? height,
  double? heightFactor,
  double? closeProgressThreshold,
  Color? backgroundColour,
  Color? barrierColour,
  BorderRadiusGeometry? borderRadius,
  Duration? transitionDuration,
  Curve? transitionCurve,
  String? semanticLabel,
  String? barrierLabel,
  RouteSettings? routeSettings,
}) {
  assert(maxHeightFactor > 0 && maxHeightFactor <= 1);
  assert(height == null || height > 0);
  assert(heightFactor == null || (heightFactor > 0 && heightFactor <= 1));
  assert(height == null || heightFactor == null);
  assert(closeProgressThreshold == null || (closeProgressThreshold > 0 && closeProgressThreshold < 1));
  final data = DievasTheme.of(context);
  final theme = data.components.bottomSheet;
  final navigator = Navigator.of(context, rootNavigator: useRootNavigator);
  return navigator.push<T>(
    _DievasSheetRoute<T>(
      builder: builder,
      data: data,
      themes: InheritedTheme.capture(from: context, to: navigator.context),
      materialTheme: Theme.of(context),
      dismissible: isDismissible,
      enableDrag: enableDrag,
      scrollControlled: isScrollControlled,
      expanded: isExpanded,
      fitContent: fitContent,
      resize: enableResize,
      maxHeightFactor: maxHeightFactor,
      safeArea: useSafeArea,
      height: height,
      heightFactor: heightFactor,
      threshold: closeProgressThreshold ?? theme.closeProgressThreshold,
      background: backgroundColour ?? theme.backgroundColour,
      barrier: barrierColour ?? theme.barrierColour,
      radius: borderRadius ?? theme.borderRadius,
      duration: MediaQuery.disableAnimationsOf(context)
          ? .zero
          : switch ((transitionDuration, theme.transitionDuration)) {
              (final duration?, _) || (_, final duration?) => duration,
              _ => data.animation.standard,
            },
      curve: switch ((transitionCurve, theme.transitionCurve)) {
        (final curve?, _) || (_, final curve?) => curve,
        _ => data.animation.easingEnter,
      },
      label: semanticLabel,
      barrierText: switch (barrierLabel) {
        final label? => label,
        _ => MaterialLocalizations.of(context).modalBarrierDismissLabel,
      },
      settings: routeSettings,
    ),
  );
}

/// Closes the current sheet with an optional result.
void closeDievasBottomSheet<T>(BuildContext context, [T? result]) => Navigator.of(context).pop<T>(result);

/// Sheet content with an optional handle, fixed header/footer, and flexible body.
///
/// Header, body and footer share [padding] horizontally (default: theme sm).
/// List tiles inherit zero internal content padding to avoid double insets.
/// Place a ListView in [child] to scroll the body without moving the header.
/// The modal helper supplies the surface, clipping, drag behaviour and insets.
class DievasBottomSheet extends StatelessWidget {
  const DievasBottomSheet({
    super.key,
    required this.child,
    this.showDragHandle = true,
    this.header,
    this.title,
    this.trailing,
    this.footer,
    this.showCloseButton = false,
    this.onClose,
    this.padding,
    this.closeButtonBackgroundColour,
    this.handleColour,
    this.showHeaderDivider = false,
  });

  final Widget child;
  final bool showDragHandle;
  final Widget? header;
  final String? title;

  /// Custom header action. Takes precedence over the built-in close button.
  final Widget? trailing;
  final Widget? footer;
  final bool showCloseButton;
  final VoidCallback? onClose;

  /// Shared body/footer padding and header horizontal insets.
  final EdgeInsetsGeometry? padding;
  final Color? closeButtonBackgroundColour;
  final Color? handleColour;
  final bool showHeaderDivider;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).bottomSheet;
    final insets = (padding ?? .symmetric(horizontal: DievasTheme.spacingOf(context).sm)).resolve(
      Directionality.of(context),
    );
    final body = ListTileTheme.merge(
      contentPadding: .zero,
      child: Theme(
        data: Theme.of(context).copyWith(hoverColor: Colors.transparent),
        child: Padding(padding: insets, child: child),
      ),
    );
    final heading = switch ((header, title)) {
      (final widget?, _) => widget,
      (_, final text?) => Text(text, textAlign: .center, style: DievasTheme.typographyOf(context).titleMd),
      _ => null,
    };
    final action = switch ((trailing, showCloseButton)) {
      (final widget?, _) => widget,
      (_, true) => Tooltip(
        message: context.dievasL10n.bottomSheetCloseLabel,
        excludeFromSemantics: true,
        child: DievasIconButton(
          style: .tinted,
          size: .sm,
          semanticLabel: context.dievasL10n.bottomSheetCloseLabel,
          backgroundColor: closeButtonBackgroundColour ?? DievasTheme.coloursOf(context).border.dividerColour,
          foregroundColor: DievasTheme.coloursOf(context).icon.iconPrimary,
          shape: const CircleBorder(),
          onPressed: onClose ?? () => closeDievasBottomSheet(context),
          icon: const Icon(Icons.close),
        ),
      ),
      _ => null,
    };
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          if (showDragHandle)
            Padding(
              padding: .only(top: theme.handleTopInset),
              child: Center(
                child: Semantics(
                  label: context.dievasL10n.bottomSheetDragHandleLabel,
                  child: Container(
                    width: theme.handleWidth,
                    height: theme.handleHeight,
                    decoration: BoxDecoration(
                      borderRadius: theme.handleRadius,
                      color: switch ((handleColour, theme.handleColour)) {
                        (final colour?, _) || (_, final colour?) => colour,
                        _ => DievasTheme.coloursOf(context).border.dividerColour,
                      },
                    ),
                  ),
                ),
              ),
            ),
          if (heading != null || action != null)
            Padding(
              padding: .fromLTRB(
                insets.left,
                DievasTheme.spacingOf(context).sm,
                insets.right,
                DievasTheme.spacingOf(context).sm,
              ),
              child: SizedBox(
                height: DievasTheme.sizingOf(context).touchMin,
                child: NavigationToolbar(centerMiddle: true, middleSpacing: 0, middle: heading, trailing: action),
              ),
            ),
          if (showHeaderDivider) const DievasDivider(),
          if (constraints.hasBoundedHeight)
            Flexible(fit: constraints.hasTightHeight ? .tight : .loose, child: body)
          else
            body,
          if (footer case final child?) Padding(padding: insets, child: child),
        ],
      ),
    );
  }
}

class _DievasSheetRoute<T> extends PopupRoute<T> {
  _DievasSheetRoute({
    required this.builder,
    required this.data,
    required this.themes,
    required this.materialTheme,
    required this.dismissible,
    required this.enableDrag,
    required this.scrollControlled,
    required this.expanded,
    required this.fitContent,
    required this.resize,
    required this.maxHeightFactor,
    required this.safeArea,
    required this.height,
    required this.heightFactor,
    required this.threshold,
    required this.background,
    required this.barrier,
    required this.radius,
    required this.duration,
    required this.curve,
    required this.label,
    required this.barrierText,
    super.settings,
  });

  final WidgetBuilder builder;
  final DievasThemeData data;
  final CapturedThemes themes;
  final ThemeData materialTheme;
  final bool dismissible, enableDrag, scrollControlled, expanded, safeArea, fitContent, resize;
  final double maxHeightFactor;
  final double? height, heightFactor;
  final double threshold;
  final Color background, barrier;
  final BorderRadiusGeometry radius;
  final Duration duration;
  final Curve curve;
  final String? label;
  final String barrierText;
  late AnimationController motion;

  @override
  bool get barrierDismissible => dismissible;
  @override
  Color get barrierColor => barrier;
  @override
  String get barrierLabel => barrierText;
  @override
  Duration get transitionDuration => duration;
  @override
  AnimationController createAnimationController() => motion = super.createAnimationController();

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
      themes.wrap(
        DievasTheme(
          data: data,
          child: Theme(
            data: materialTheme,
            child: _ModalSheet<T>(route: this),
          ),
        ),
      );
}

class _ModalSheet<T> extends StatefulWidget {
  const _ModalSheet({required this.route});
  final _DievasSheetRoute<T> route;
  @override
  State<_ModalSheet<T>> createState() => _ModalSheetState<T>();
}

class _ModalSheetState<T> extends State<_ModalSheet<T>> {
  final _surfaceKey = GlobalKey();
  final _scrollController = ScrollController();
  bool _dragging = false;
  double? _resizedHeight;
  double? _initialExtent;
  double? _lastViewport;
  double _maxExtent = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final route = widget.route;
    return SafeArea(
      top: route.safeArea,
      left: route.safeArea,
      right: route.safeArea,
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxHeight = constraints.maxHeight * route.maxHeightFactor;
            _maxExtent = maxHeight;
            if (_lastViewport != constraints.maxHeight) {
              _lastViewport = constraints.maxHeight;
              _initialExtent = null;
              _resizedHeight = null;
            }
            final targetHeight = switch ((
              _resizedHeight,
              route.fitContent,
              route.expanded,
              route.height,
              route.heightFactor,
            )) {
              (final height?, _, _, _, _) => math.min(height, maxHeight),
              (_, true, _, _, _) => null,
              (_, _, true, _, _) => maxHeight,
              (_, _, _, final height?, _) => math.min(height, maxHeight),
              (_, _, _, _, final factor?) => math.min(constraints.maxHeight * factor, maxHeight),
              _ => null,
            };
            final limit = switch ((targetHeight, route.scrollControlled || route.fitContent)) {
              (final height?, _) => height,
              (_, true) => maxHeight,
              _ => math.min(maxHeight, constraints.maxHeight * 9 / 16),
            };
            return Align(
              alignment: .bottomCenter,
              child: AnimatedBuilder(
                animation: route.motion,
                builder: (context, child) => FractionalTranslation(
                  translation: Offset(
                    0,
                    1 - (_dragging ? route.motion.value : route.curve.transform(route.motion.value)),
                  ),
                  child: child,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: limit),
                  child: SizedBox(
                    height: targetHeight,
                    width: double.infinity,
                    child: GestureDetector(
                      onVerticalDragUpdate: route.enableDrag ? (details) => _drag(details.primaryDelta ?? 0) : null,
                      onVerticalDragEnd: route.enableDrag ? (details) => _finish(details.primaryVelocity ?? 0) : null,
                      onVerticalDragCancel: route.enableDrag ? () => _finish(0) : null,
                      child: NotificationListener<ScrollEndNotification>(
                        onNotification: (notification) {
                          if (notification.depth == 0 && _dragging) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted) _finish(notification.dragDetails?.primaryVelocity ?? 0);
                            });
                          }
                          return false;
                        },
                        child: PrimaryScrollController(
                          controller: _scrollController,
                          child: ScrollConfiguration(
                            behavior: const ScrollBehavior().copyWith(
                              scrollbars: false,
                              dragDevices: {...const ScrollBehavior().dragDevices, PointerDeviceKind.mouse},
                              physics: route.enableDrag
                                  ? _SheetScrollPhysics(
                                      onDelta: _drag,
                                      canExpand: () => route.motion.value < 1 || _canGrow,
                                    )
                                  : const ClampingScrollPhysics(),
                            ),
                            child: Shortcuts(
                              shortcuts: {LogicalKeySet(LogicalKeyboardKey.escape): const DismissIntent()},
                              child: Actions(
                                actions: {
                                  DismissIntent: CallbackAction<DismissIntent>(
                                    onInvoke: (_) {
                                      if (route.dismissible) Navigator.of(context).maybePop();
                                      return null;
                                    },
                                  ),
                                },
                                child: Focus(
                                  autofocus: true,
                                  child: Semantics(
                                    scopesRoute: true,
                                    namesRoute: true,
                                    explicitChildNodes: true,
                                    label: route.label,
                                    child: Container(
                                      key: _surfaceKey,
                                      decoration: BoxDecoration(
                                        color: route.background,
                                        borderRadius: route.radius.resolve(Directionality.of(context)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: route.radius,
                                        child: SafeArea(
                                          top: false,
                                          left: false,
                                          right: false,
                                          bottom: route.safeArea,
                                          child: Material(
                                            type: .transparency,
                                            child: Builder(builder: route.builder),
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
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool get _canGrow =>
      widget.route.resize &&
      switch (_surfaceKey.currentContext?.findRenderObject()) {
        RenderBox(:final size) => (_resizedHeight ?? size.height) < _maxExtent - 0.5,
        _ => false,
      };

  void _drag(double delta) {
    final route = widget.route;
    if (route.motion.status == .reverse || !route.isCurrent) return;
    if (_surfaceKey.currentContext?.findRenderObject() case RenderBox(:final size) when size.height > 0) {
      _initialExtent ??= size.height;
      final baseline = _initialExtent ?? size.height;
      final currentHeight = _resizedHeight ?? size.height;
      if (!_dragging) setState(() => _dragging = true);
      if (route.motion.value >= 1 && route.resize) {
        if (delta < 0 && _canGrow) {
          setState(() => _resizedHeight = math.min(currentHeight - delta, _maxExtent));
          return;
        }
        if (delta > 0 && currentHeight > baseline) {
          final consumed = math.min(delta, currentHeight - baseline);
          setState(() => _resizedHeight = currentHeight - consumed);
          delta -= consumed;
          if (delta == 0) return;
        }
      }
      route.motion.value -= delta / size.height;
    }
  }

  void _finish(double velocity) {
    if (!_dragging || !widget.route.isCurrent) return;
    final route = widget.route;
    if (route.motion.value >= 1) {
      setState(() => _dragging = false);
      return;
    }
    if (velocity > 700 || route.motion.value < route.threshold) {
      Navigator.of(context).pop();
    } else {
      // Keep the linear drag position while settling to avoid a curve jump.
      route.motion.animateTo(1, curve: route.curve).whenComplete(() {
        if (mounted) setState(() => _dragging = false);
      });
    }
  }
}

class _SheetScrollPhysics extends ClampingScrollPhysics {
  const _SheetScrollPhysics({required this.onDelta, required this.canExpand, super.parent});
  final ValueChanged<double> onDelta;
  final bool Function() canExpand;

  @override
  _SheetScrollPhysics applyTo(ScrollPhysics? ancestor) =>
      _SheetScrollPhysics(onDelta: onDelta, canExpand: canExpand, parent: buildParent(ancestor));

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if (position.axisDirection == .down && position.pixels <= position.minScrollExtent && (offset > 0 || canExpand())) {
      onDelta(offset);
      return 0;
    }
    return super.applyPhysicsToUserOffset(position, offset);
  }
}
