import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:flutter/material.dart';

import 'button_types/dievas_button_state.dart';

/// Attaches the rotating loader animation to a [StatefulWidget].
///
/// Apply to the [StatefulWidget] class:
/// ```dart
/// class MyButton extends StatefulWidget with DievasButtonStateAnimatedLoaderMixin { ... }
/// ```
///
/// Then mix [DievasButtonStateAnimatedLoaderProviderMixin] into its [State]:
/// ```dart
/// class _MyButtonState extends State<MyButton>
///   with SingleTickerProviderStateMixin, DievasButtonStateAnimatedLoaderProviderMixin { ... }
/// ```
mixin DievasButtonStateAnimatedLoaderMixin on StatefulWidget {
  /// The current button state. Drives loader start/stop.
  DievasButtonState get state;

  /// Duration of one full loader rotation cycle.
  Duration get loaderRotationDuration;
}

/// Provides the loader [AnimationController] and the pre-built [animatedLoader]
/// widget to the [State] that mixes it in.
///
/// IMPORTANT: The mixing class MUST also mix in [SingleTickerProviderStateMixin]
/// to provide the [vsync] source. This is required because Dart mixins cannot
/// enforce multiple `on` clauses. Usage:
///
/// ```dart
/// class _MyButtonState extends State<MyButton>
///   with SingleTickerProviderStateMixin, DievasButtonStateAnimatedLoaderProviderMixin {
///   // ...
/// }
/// ```
mixin DievasButtonStateAnimatedLoaderProviderMixin<T extends DievasButtonStateAnimatedLoaderMixin> on State<T>
    implements SingleTickerProviderStateMixin<T> {
  @visibleForTesting
  AnimationController get loaderController => _loaderController;

  late final _loaderController = AnimationController(duration: widget.loaderRotationDuration, vsync: this);

  /// A spinning [RotationTransition] sized to its parent. Wire this into the
  /// button's build tree when [DievasButtonState.loading] is active.
  late final Widget animatedLoader = RotationTransition(
    turns: _loaderController,
    child: const FittedBox(child: _LoaderIcon()),
  );

  @override
  void initState() {
    super.initState();
    if (widget.state == .loading) {
      _loaderController.repeat();
    }
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    final wasLoading = oldWidget.state == .loading;
    final isLoading = widget.state == .loading;
    if (isLoading && !wasLoading) {
      _loaderController.repeat();
    } else if (!isLoading && wasLoading) {
      _loaderController.stop();
    }
  }

  @override
  void dispose() {
    _loaderController.dispose();
    super.dispose();
  }
}

/// Minimal circular loader rendered as a thin ring.
///
/// Sized via [FittedBox] by the parent so it inherits the icon slot dimensions.
/// Reads its size from the parent [IconTheme] and derives a proportional stroke.
class _LoaderIcon extends StatelessWidget {
  const _LoaderIcon();

  static const double _kStrokeRatio = 0.1;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final size = iconTheme.size ?? DievasSizingPrimitives.s20;
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator.adaptive(strokeWidth: size * _kStrokeRatio),
    );
  }
}
