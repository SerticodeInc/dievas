import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// Size variants for [DievasLoader].
enum DievasLoaderSize {
  /// Small — 20 dp spinner.
  sm,

  /// Medium — 32 dp spinner (default).
  md,

  /// Large — 48 dp spinner.
  lg,
}

/// A standalone loading indicator — distinct from the inline button loading state.
///
/// Use when a full area or screen is loading. For button loading states, use the
/// [DievasFilledButton] / [DievasTextButton] `state` parameter instead.
///
/// ```dart
/// DievasLoader(size: .md, label: 'Loading…')
/// ```
///
/// Moon reference: Loader
class DievasLoader extends StatefulWidget {
  const DievasLoader({super.key, this.size = .md, this.label});

  /// Controls spinner diameter (sm / md / lg).
  final DievasLoaderSize size;

  /// Optional label shown below the spinner.
  final String? label;

  @override
  State<DievasLoader> createState() => _DievasLoaderState();
}

class _DievasLoaderState extends State<DievasLoader> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.duration = DievasTheme.componentsOf(context).loader.animationDuration;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).loader;

    final diameter = switch (widget.size) {
      .sm => theme.spinnerSizeSm,
      .md => theme.spinnerSizeMd,
      .lg => theme.spinnerSizeLg,
    };

    return Column(
      mainAxisSize: .min,
      children: [
        SizedBox.square(
          dimension: diameter,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, _) => CustomPaint(
              painter: _SpinnerPainter(
                progress: _controller.value,
                color: theme.color,
                trackColor: theme.trackColor,
                strokeWidth: theme.strokeWidth,
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
}

class _SpinnerPainter extends CustomPainter {
  const _SpinnerPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    // -π/2
    const startAngle = -1.5707963267948966;

    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..style = .stroke
      ..strokeCap = .round;

    final arcPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = .stroke
      ..strokeCap = .round;

    // Track
    canvas.drawCircle(center, radius, trackPaint);

    // Arc — sweeps 270° rotated by progress
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle + progress * 6.283185307179586, // 2π
      4.71238898038469, // 270° in radians
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(_SpinnerPainter old) =>
      progress != old.progress || color != old.color || trackColor != old.trackColor || strokeWidth != old.strokeWidth;
}
