import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Shared press-behaviour infrastructure for interactive Dievas components.
///
/// Mix into a [State] class alongside the widget's other mixins to get:
/// - A [WidgetStatesController] with correct lifecycle management (auto-disposed)
/// - Apple-platform detection via [isApplePlatform]
/// - Shared press-animation constants
///
/// ```dart
/// class _MyButtonState extends State<MyButton>
///     with SingleTickerProviderStateMixin, DievasButtonPressMixin {
///   @override
///   Widget build(BuildContext context) {
///     return InkWell(
///       statesController: statesController,
///       splashFactory: isApplePlatform
///           ? NoSplash.splashFactory
///           : InkRipple.splashFactory,
///       ...
///     );
///   }
/// }
/// ```
@internal
mixin DievasButtonPressMixin<T extends StatefulWidget> on State<T> {
  /// Tracks hover, pressed, and focused states for the interactive surface.
  ///
  /// Pass to [InkWell.statesController] and listen via [ValueListenableBuilder].
  /// Disposed automatically when the [State] is disposed.
  late final WidgetStatesController statesController = WidgetStatesController();

  /// Whether the current platform uses Apple press semantics (opacity fade
  /// rather than an ink ripple).
  ///
  /// Only valid inside [build] — reads from [context].
  bool get isApplePlatform {
    final platform = Theme.of(context).platform;
    return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
  }

  @override
  void dispose() {
    statesController.dispose();
    super.dispose();
  }
}
