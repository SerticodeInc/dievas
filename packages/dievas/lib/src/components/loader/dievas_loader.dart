import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

enum DievasLoaderSize { sm, md, lg }

/// A rounded circular arc whose head grows and tail catches up as it rotates.
///
/// Uses the same loader for standalone feedback and inline button loading.
/// Reduced motion displays a static arc. The track is transparent by default.
class DievasLoader extends StatefulWidget {
  const DievasLoader({
    super.key,
    this.size = .md,
    this.label,
    this.colour,
    this.trackColour,
    this.diameter,
    this.strokeWidth,
    this.animationDuration,
  }) : assert(diameter == null || diameter > 0),
       assert(strokeWidth == null || strokeWidth > 0),
       assert(animationDuration == null || animationDuration > Duration.zero);

  final DievasLoaderSize size;
  final String? label;
  final Color? colour;
  final Color? trackColour;

  /// Exact diameter override, useful for inline icon slots.
  final double? diameter;
  final double? strokeWidth;

  /// Duration of one rotation. Overrides the loader theme's duration.
  final Duration? animationDuration;

  @override
  State<DievasLoader> createState() => _DievasLoaderState();
}

class _DievasLoaderState extends State<DievasLoader> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _configureAnimation();
  }

  @override
  void didUpdateWidget(DievasLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animationDuration != widget.animationDuration) _configureAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).loader;
    final diameter = switch ((widget.diameter, widget.size)) {
      (final diameter?, _) => diameter,
      (_, .sm) => theme.spinnerSizeSm,
      (_, .md) => theme.spinnerSizeMd,
      (_, .lg) => theme.spinnerSizeLg,
    };

    return Column(
      mainAxisSize: .min,
      children: [
        RepaintBoundary(
          child: SizedBox.square(
            dimension: diameter,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => CustomPaint(
                painter: _SpinnerPainter(
                  progress: MediaQuery.disableAnimationsOf(context) ? null : _controller.value,
                  colour: widget.colour ?? theme.color,
                  trackColour: widget.trackColour ?? theme.trackColour,
                  strokeWidth: widget.strokeWidth ?? theme.strokeWidth,
                ),
              ),
            ),
          ),
        ),
        if (widget.label case final label?) ...[
          SizedBox(height: theme.labelSpacing),
          Text(label, style: theme.labelStyle, textAlign: .center),
        ],
      ],
    );
  }

  void _configureAnimation() {
    // Five head/tail cycles and three rotations share one seamless timeline.
    _controller.duration = (widget.animationDuration ?? DievasTheme.componentsOf(context).loader.animationDuration) * 3;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }
}

class _SpinnerPainter extends CustomPainter {
  const _SpinnerPainter({
    required this.progress,
    required this.colour,
    required this.trackColour,
    required this.strokeWidth,
  });

  final double? progress;
  final Color colour;
  final Color trackColour;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final phase = ((progress ?? 0) * 5) % 1;
    final head = const Interval(0, 0.5, curve: Curves.fastOutSlowIn).transform(phase);
    final tail = const Interval(0.5, 1, curve: Curves.fastOutSlowIn).transform(phase);
    final (start, sweep) = switch (progress) {
      final progress? => (
        -math.pi / 2 + tail * math.pi * 1.5 + progress * math.pi * 6 + phase * math.pi * 0.5,
        math.max((head - tail) * math.pi * 1.5, 0.001),
      ),
      _ => (-math.pi / 2, math.pi * 1.5),
    };
    final bounds = (Offset.zero & size).deflate(strokeWidth / 2);
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = .stroke
      ..strokeCap = .round;
    canvas.drawCircle(bounds.center, bounds.shortestSide / 2, paint..color = trackColour);
    canvas.drawArc(bounds, start, sweep, false, paint..color = colour);
  }

  @override
  bool shouldRepaint(_SpinnerPainter old) =>
      progress != old.progress ||
      colour != old.colour ||
      trackColour != old.trackColour ||
      strokeWidth != old.strokeWidth;
}
