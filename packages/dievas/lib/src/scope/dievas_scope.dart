import 'dart:async';

import 'package:flutter/material.dart';

import 'package:dievas/l10n/dievas_localizations.dart';
import 'package:dievas/src/theme.dart';
import 'package:dievas/src/themes.dart';

/// How long a banner stays visible before auto-dismissing.
const Duration kDievasBannerAutoDismissDuration = Duration(seconds: 5);

/// How long a snackbar stays visible before auto-dismissing.
const Duration kDievasSnackbarAutoDismissDuration = Duration(seconds: 4);

/// Builds an app subtree with access to the resolved Dievas theme.
typedef DievasAppBuilder = Widget Function(BuildContext context, DievasThemeData theme, Widget? child);

/// Builds a transient overlay surface such as a banner or snackbar.
typedef DievasOverlayBuilder = Widget Function(BuildContext context, Animation<double> animation);

/// The entry-point widget for the Dievas design system.
///
/// [DievasScope] must wrap your application (or the subtree consuming Dievas).
/// It resolves the active theme based on [themeMode] + platform brightness,
/// inserts [DievasTheme] into the widget tree, and bridges to Material via
/// [MaterialApp]'s [theme] parameter.
///
/// ```dart
/// DievasScope(
///   lightTheme: CadenceLightThemeData(),
///   darkTheme: CadenceDarkThemeData(),
///   themeMode: ThemeMode.system,
///   child: MaterialApp.router(...),
/// )
/// ```
///
/// If no [lightTheme] / [darkTheme] is provided, the defaults
/// ([DievasLightThemeData] / [DievasDarkThemeData]) are used — suitable for
/// the gallery and quick prototypes.
class DievasScope extends StatefulWidget {
  DievasScope({
    super.key,
    DievasThemeData? lightTheme,
    DievasThemeData? darkTheme,
    this.themeMode = .system,
    this.onThemeChanged,
    this.builder,
    this.child,
  }) : lightTheme = lightTheme ?? DievasLightThemeData(),
       darkTheme = darkTheme ?? DievasDarkThemeData();

  /// Theme data for light mode. Defaults to [DievasLightThemeData].
  final DievasThemeData lightTheme;

  /// Theme data for dark mode. Defaults to [DievasDarkThemeData].
  final DievasThemeData darkTheme;

  /// Controls which theme is active. Defaults to [ThemeMode.system].
  final ThemeMode themeMode;

  /// Called whenever [DievasScopeController.themeMode] changes.
  final ValueChanged<ThemeMode>? onThemeChanged;

  /// Allows app-level wrappers to be built with the resolved Dievas theme.
  final DievasAppBuilder? builder;

  /// The subtree this scope provides the theme to.
  final Widget? child;

  /// Returns the [DievasScopeController] from the nearest [DievasScope] ancestor.
  ///
  /// Establishing a dependency on the scope, so the calling widget rebuilds
  /// whenever the active [themeMode] changes. Use this to call
  /// [DievasScopeController.setThemeMode] programmatically, e.g. from a settings
  /// screen.
  static DievasScopeController of(BuildContext context) {
    if (context.dependOnInheritedWidgetOfExactType<_DievasScopeStateMarker>() case final result?) {
      return result.state;
    }

    throw FlutterError('No DievasScope found in context.');
  }

  @override
  State<DievasScope> createState() => DievasScopeState();
}

/// Controller API exposed by [DievasScope.of].
mixin DievasScopeController on TickerProviderStateMixin<DievasScope> {
  late final AnimationController _bannerAnimationController;
  late final AnimationController _snackbarAnimationController;
  late final ValueNotifier<ThemeMode> _themeModeNotifier;
  late final ValueNotifier<DievasOverlayBuilder?> _bannerNotifier;
  late final ValueNotifier<DievasOverlayBuilder?> _snackbarNotifier;
  Timer? _bannerDismissTimer;
  Timer? _snackbarDismissTimer;
  int _bannerGeneration = 0;
  int _snackbarGeneration = 0;

  /// The currently selected theme mode.
  ThemeMode get themeMode => _themeModeNotifier.value;

  set themeMode(ThemeMode mode) {
    if (_themeModeNotifier.value == mode) return;

    _themeModeNotifier.value = mode;
    widget.onThemeChanged?.call(mode);
  }

  @override
  void initState() {
    super.initState();

    _themeModeNotifier = ValueNotifier(widget.themeMode);
    _bannerNotifier = ValueNotifier(null);
    _snackbarNotifier = ValueNotifier(null);
    _bannerAnimationController = AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _snackbarAnimationController = AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  @override
  void dispose() {
    _bannerDismissTimer?.cancel();
    _snackbarDismissTimer?.cancel();
    _bannerAnimationController.dispose();
    _snackbarAnimationController.dispose();
    _themeModeNotifier.dispose();
    _bannerNotifier.dispose();
    _snackbarNotifier.dispose();
    super.dispose();
  }

  /// Sets the active theme mode.
  void setThemeMode(ThemeMode mode) => themeMode = mode;

  /// Shows a banner overlay built by [builder].
  ///
  /// The banner auto-dismisses after [duration], defaulting to
  /// [kDievasBannerAutoDismissDuration]. Pass [Duration.zero] to keep it
  /// visible until [hideBanner] is called. Showing again while visible
  /// restarts both the entrance and the countdown.
  void showBanner(DievasOverlayBuilder builder, {Duration? duration}) {
    if (_bannerNotifier.value == builder) return;

    _bannerGeneration++;
    _bannerDismissTimer?.cancel();
    _bannerNotifier.value = builder;
    _bannerAnimationController.forward(from: 0);

    final effectiveDuration = duration ?? kDievasBannerAutoDismissDuration;
    if (effectiveDuration <= Duration.zero) return;
    _bannerDismissTimer = Timer(effectiveDuration, hideBanner);
  }

  /// Hides the active banner overlay.
  void hideBanner() {
    if (_bannerNotifier.value == null) return;
    _bannerDismissTimer?.cancel();

    // A show during the exit animation cancels this ticker, which would fire
    // the callback and clear the freshly shown overlay — only clear if this
    // exit still belongs to the current generation.
    final generation = _bannerGeneration;
    _bannerAnimationController.reverse(from: 1).whenCompleteOrCancel(() {
      if (_bannerGeneration != generation) return;
      _bannerNotifier.value = null;
    });
  }

  /// Shows a snackbar overlay built by [builder].
  ///
  /// The snackbar auto-dismisses after [duration], defaulting to
  /// [kDievasSnackbarAutoDismissDuration]. Pass [Duration.zero] to keep it
  /// visible until [hideSnackbar] is called. Showing again while visible
  /// restarts both the entrance and the countdown.
  void showSnackbar(DievasOverlayBuilder builder, {Duration? duration}) {
    if (_snackbarNotifier.value == builder) return;

    _snackbarGeneration++;
    _snackbarDismissTimer?.cancel();
    _snackbarNotifier.value = builder;
    _snackbarAnimationController.forward(from: 0);

    final effectiveDuration = duration ?? kDievasSnackbarAutoDismissDuration;
    if (effectiveDuration <= Duration.zero) return;
    _snackbarDismissTimer = Timer(effectiveDuration, hideSnackbar);
  }

  /// Hides the active snackbar overlay.
  void hideSnackbar() {
    if (_snackbarNotifier.value == null) return;
    _snackbarDismissTimer?.cancel();

    // See hideBanner — same generation guard against a concurrent show.
    final generation = _snackbarGeneration;
    _snackbarAnimationController.reverse(from: 1).whenCompleteOrCancel(() {
      if (_snackbarGeneration != generation) return;
      _snackbarNotifier.value = null;
    });
  }
}

/// Mutable state for [DievasScope].
class DievasScopeState extends State<DievasScope>
    with TickerProviderStateMixin, WidgetsBindingObserver, DievasScopeController {
  late Brightness _brightness;

  @override
  void initState() {
    super.initState();

    final widgetsBinding = WidgetsBinding.instance..addObserver(this);
    _brightness = widgetsBinding.platformDispatcher.platformBrightness;
  }

  @override
  void didUpdateWidget(DievasScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.themeMode != oldWidget.themeMode) {
      _themeModeNotifier.value = widget.themeMode;
    }
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    setState(() => _brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<ThemeMode>(
    valueListenable: _themeModeNotifier,
    builder: (context, mode, child) {
      final theme = _themeFor(mode);
      final content = widget.builder?.call(context, theme, widget.child) ?? widget.child ?? child ?? const SizedBox();

      return _DievasScopeStateMarker(
        state: this,
        themeMode: mode,
        child: DievasTheme(
          data: theme,
          child: Stack(
            alignment: Alignment.topCenter,
            fit: .expand,
            children: [
              content,
              _DievasOverlaySlot(
                alignment: .topCenter,
                animation: _bannerAnimationController,
                notifier: _bannerNotifier,
              ),
              _DievasOverlaySlot(
                alignment: .bottomCenter,
                animation: _snackbarAnimationController,
                notifier: _snackbarNotifier,
              ),
            ],
          ),
        ),
      );
    },
    child: widget.child,
  );

  DievasThemeData _themeFor(ThemeMode mode) => switch (mode) {
    .light => widget.lightTheme,
    .dark => widget.darkTheme,
    .system => _brightness == .dark ? widget.darkTheme : widget.lightTheme,
  };
}

class _DievasScopeStateMarker extends InheritedWidget {
  const _DievasScopeStateMarker({required super.child, required this.state, required this.themeMode});

  final DievasScopeController state;
  final ThemeMode themeMode;

  @override
  bool updateShouldNotify(_DievasScopeStateMarker oldWidget) =>
      oldWidget.state != state || oldWidget.themeMode != themeMode;
}

class _DievasOverlaySlot extends StatelessWidget {
  const _DievasOverlaySlot({required this.alignment, required this.animation, required this.notifier});
  final AlignmentGeometry alignment;
  final Animation<double> animation;
  final ValueNotifier<DievasOverlayBuilder?> notifier;

  @override
  Widget build(BuildContext context) {
    // Overlays render beside — not inside — MaterialApp, so the Directionality
    // and MediaQuery the app provides never reach this subtree. Supply them or
    // every Text/SafeArea below throws.
    //
    // Deliberately no Localizations here: mounting one outside MaterialApp
    // defers the first frame and breaks semantics compilation. Component copy
    // resolves through DievasLocalizations' built-in English fallback instead,
    // so direction follows the same locale resolution the copy would.
    final locale = basicLocaleListResolution(
      WidgetsBinding.instance.platformDispatcher.locales,
      DievasLocalizations.supportedLocales,
    );
    final textDirection = _textDirectionOf(locale);

    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: Directionality(
          textDirection: textDirection,
          child: MediaQuery.fromView(
            view: View.of(context),
            child: ValueListenableBuilder<DievasOverlayBuilder?>(
              valueListenable: notifier,
              builder: (context, builder, _) {
                if (builder == null) {
                  return const SizedBox.shrink();
                }

                return IgnorePointer(
                  ignoring: false,
                  child: FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0, 0.1), end: .zero).animate(
                        CurvedAnimation(parent: animation, curve: DievasTheme.animationOf(context).easingEnter),
                      ),
                      child: builder(context, animation),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

TextDirection _textDirectionOf(Locale locale) => switch (locale.languageCode) {
  'ar' || 'ckb' || 'dv' || 'fa' || 'he' || 'ps' || 'sd' || 'ug' || 'ur' || 'yi' => .rtl,
  _ => .ltr,
};
