import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// A row of page indicators with optional pointer and keyboard selection.
///
/// Defaults to equal 8px dots with 8px gaps. Selection fades between colours.
/// Existing custom themes may retain a distinct active dot size. Reduced motion
/// applies visual changes immediately.
class DievasDotIndicator extends StatelessWidget {
  const DievasDotIndicator({
    super.key,
    required this.count,
    required this.activeIndex,
    this.onDotTap,
    this.enabled = true,
    this.selectedColour,
    this.unselectedColour,
    this.size,
    this.gap,
    this.transitionDuration,
    this.transitionCurve,
    this.semanticLabelBuilder,
  }) : assert(count >= 0),
       assert(count == 0 || (activeIndex >= 0 && activeIndex < count)),
       assert(size == null || size > 0),
       assert(gap == null || gap >= 0);

  final int count;
  final int activeIndex;
  final ValueChanged<int>? onDotTap;
  final bool enabled;

  /// Per instance colours override the active theme.
  final Color? selectedColour;
  final Color? unselectedColour;

  /// Diameter of every dot. Null preserves the theme's dot sizes.
  final double? size;

  /// Edge to edge spacing between dots.
  final double? gap;
  final Duration? transitionDuration;
  final Curve? transitionCurve;

  /// Accessible label for a zero based index and the total page count.
  final String Function(int index, int count)? semanticLabelBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).dotIndicator;
    return Opacity(
      opacity: enabled ? 1 : theme.disabledOpacity,
      child: Row(
        mainAxisSize: .min,
        children: [
          for (int index = 0; index < count; index++) ...[
            if (index > 0) SizedBox(width: gap ?? theme.dotSpacing),
            _Dot(
              selected: index == activeIndex,
              enabled: enabled,
              label: semanticLabelBuilder?.call(index, count) ?? 'Page ${index + 1} of $count',
              size: size ?? (index == activeIndex ? theme.activeDotSize : theme.dotSize),
              colour: switch ((index == activeIndex, selectedColour, unselectedColour)) {
                (true, final colour?, _) || (false, _, final colour?) => colour,
                (true, _, _) => theme.colourActive,
                _ => theme.colourInactive,
              },
              duration: MediaQuery.disableAnimationsOf(context) ? .zero : transitionDuration ?? theme.animationDuration,
              curve: transitionCurve ?? theme.transitionCurve,
              onTap: switch ((enabled, onDotTap)) {
                (true, final callback?) => () => callback(index),
                _ => null,
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _Dot extends StatefulWidget {
  const _Dot({
    required this.selected,
    required this.enabled,
    required this.label,
    required this.size,
    required this.colour,
    required this.duration,
    required this.curve,
    required this.onTap,
  });

  final bool selected;
  final bool enabled;
  final String label;
  final double size;
  final Color colour;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onTap;

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> {
  bool _showFocus = false;

  @override
  Widget build(BuildContext context) => Semantics(
    label: widget.label,
    selected: widget.selected,
    enabled: widget.enabled,
    button: widget.onTap != null,
    onTap: widget.onTap,
    child: FocusableActionDetector(
      enabled: widget.onTap != null,
      onShowFocusHighlight: (value) => setState(() => _showFocus = value),
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
      },
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            widget.onTap?.call();
            return null;
          },
        ),
      },
      child: GestureDetector(
        excludeFromSemantics: true,
        behavior: .opaque,
        onTap: widget.onTap,
        child: DecoratedBox(
          position: .foreground,
          decoration: BoxDecoration(
            shape: .circle,
            border: _showFocus
                ? Border.all(
                    color: DievasTheme.coloursOf(context).core.primary,
                    width: DievasTheme.borderOf(context).strokeDefault,
                  )
                : null,
          ),
          child: AnimatedContainer(
            duration: widget.duration,
            curve: widget.curve,
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(color: widget.colour, shape: .circle),
          ),
        ),
      ),
    ),
  );
}
