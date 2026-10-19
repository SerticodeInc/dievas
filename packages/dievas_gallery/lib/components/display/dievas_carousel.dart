import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';

final carouselComponent = WidgetbookComponent(
  name: 'Carousel',
  useCases: [WidgetbookUseCase(name: 'Playground', builder: (_) => const _Playground())],
);

class _Playground extends StatefulWidget {
  const _Playground();
  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  final DievasCarouselController _controller = DievasCarouselController(initialItem: 2);
  int _selected = 2;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.knobSection('Appearance');
    final overrideBackground = context.knobs.boolean(label: 'Override background colour');
    final background = context.tokenColourKnob(label: 'Background colour', role: .background);
    context.knobSection('Layout');
    final extent = context.knobs.double.slider(label: 'Item extent', initialValue: 114, min: 48, max: 240);
    final gap = context.knobs.double.slider(label: 'Gap', initialValue: 8, min: 0, max: 40);
    final anchor = context.knobs.double.slider(label: 'Anchor', initialValue: .04, min: 0, max: 1);
    final centered = context.knobs.boolean(label: 'Centered');
    final clamp = context.knobs.boolean(label: 'Clamp max extent', initialValue: true);
    final rtl = context.knobs.boolean(label: 'Right to left');
    context.knobSection('Motion');
    final velocity = context.knobs.double.slider(label: 'Velocity factor', initialValue: .5, min: .1, max: 1);
    final autoplay = context.knobs.boolean(label: 'Auto play');
    final loop = context.knobs.boolean(label: 'Loop');
    final delay = context.knobs.double.slider(label: 'Auto play delay (seconds)', initialValue: 3, min: 1, max: 10);
    final duration = context.knobs.double.slider(
      label: 'Transition duration (ms)',
      initialValue: 800,
      min: 0,
      max: 2000,
    );
    final colour = overrideBackground ? background : context.colours.background.pageBackground;

    return Directionality(
      textDirection: rtl ? .rtl : .ltr,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.spacing.md),
          child: Column(
            mainAxisSize: .min,
            children: [
              const _SectionTitle(label: 'Carousel'),
              SizedBox(
                height: extent,
                child: DievasCarousel(
                  itemCount: 5,
                  itemExtent: extent,
                  gap: gap,
                  anchor: anchor,
                  isCentered: centered,
                  clampMaxExtent: clamp,
                  velocityFactor: velocity,
                  autoPlay: autoplay,
                  loop: loop,
                  autoPlayDelay: Duration(milliseconds: (delay * 1000).round()),
                  transitionDuration: Duration(milliseconds: duration.round()),
                  itemBuilder: (_, index, _) => _Card(index: index, colour: colour),
                ),
              ),
              const _SectionTitle(label: 'Carousel with controls'),
              LayoutBuilder(
                builder: (context, constraints) => SizedBox(
                  height: 180,
                  child: Stack(
                    clipBehavior: .none,
                    alignment: .center,
                    children: [
                      DievasCarousel(
                        controller: _controller,
                        itemCount: 5,
                        itemExtent: constraints.maxWidth - context.sizing.height32,
                        gap: context.sizing.height32,
                        isCentered: true,
                        clampMaxExtent: clamp,
                        velocityFactor: velocity,
                        autoPlay: autoplay,
                        loop: loop,
                        autoPlayDelay: Duration(milliseconds: (delay * 1000).round()),
                        transitionDuration: Duration(milliseconds: duration.round()),
                        onIndexChanged: (index) => setState(() => _selected = index),
                        itemBuilder: (_, index, _) => _Card(index: index, colour: colour),
                      ),
                      Align(
                        alignment: .centerLeft,
                        child: _NavigationButton(
                          semanticLabel: 'Previous item',
                          icon: Icons.keyboard_arrow_left,
                          onPressed: !loop && _selected == 0 ? null : () => _controller.previousItem(),
                        ),
                      ),
                      Align(
                        alignment: .centerRight,
                        child: _NavigationButton(
                          semanticLabel: 'Next item',
                          icon: Icons.keyboard_arrow_right,
                          onPressed: !loop && _selected == 4 ? null : () => _controller.nextItem(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: context.spacing.md),
              _CarouselDots(activeIndex: _selected, onDotTap: _controller.animateToItem),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.index, required this.colour});
  final int index;
  final Color colour;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(color: colour, borderRadius: context.border.lg),
    child: Center(child: Text('${index + 1}')),
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: context.spacing.xl),
    child: Row(
      children: [
        const Expanded(child: DievasDivider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
          child: Text(label, style: context.typography.labelXs.copyWith(color: context.colours.text.textSecondary)),
        ),
        const Expanded(child: DievasDivider()),
      ],
    ),
  );
}

class _NavigationButton extends StatelessWidget {
  const _NavigationButton({required this.semanticLabel, required this.icon, required this.onPressed});

  final String semanticLabel;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Opacity(
    opacity: onPressed == null ? DievasTheme.componentsOf(context).iconButton.ghost.disabledOpacity : 1,
    child: DecoratedBox(
      decoration: ShapeDecoration(
        color: context.colours.background.pageBackground,
        shape: RoundedSuperellipseBorder(borderRadius: context.border.md),
        shadows: context.elevation.sm,
      ),
      child: SizedBox.square(
        dimension: context.sizing.height32,
        child: DievasIconButton(
          semanticLabel: semanticLabel,
          size: .SM,
          shape: RoundedSuperellipseBorder(borderRadius: context.border.md),
          backgroundColor: context.colours.background.pageBackground,
          icon: SizedBox.square(
            dimension: context.sizing.iconMd,
            child: CustomPaint(
              painter: _ChevronPainter(
                pointsLeft: icon == Icons.keyboard_arrow_left,
                colour: context.colours.text.textPrimary,
                strokeWidth: context.border.strokeThin,
              ),
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    ),
  );
}

class _CarouselDots extends StatelessWidget {
  const _CarouselDots({required this.activeIndex, required this.onDotTap});

  final int activeIndex;
  final ValueChanged<int> onDotTap;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.of(context);
    final dots = theme.components.dotIndicator;
    return DievasTheme(
      data: theme.copyWith(
        components: theme.components.copyWith(
          dotIndicator: DievasDotIndicatorThemeData(
            dotSize: (context.sizing.height4 + context.sizing.height8) / 2,
            activeDotSize: (context.sizing.height4 + context.sizing.height8) / 2,
            dotSpacing: context.spacing.sm,
            colourActive: dots.colourActive,
            colourInactive: dots.colourInactive,
            animationDuration: dots.animationDuration,
            disabledOpacity: dots.disabledOpacity,
          ),
        ),
      ),
      child: DievasDotIndicator(count: 5, activeIndex: activeIndex, onDotTap: onDotTap),
    );
  }
}

class _ChevronPainter extends CustomPainter {
  const _ChevronPainter({required this.pointsLeft, required this.colour, required this.strokeWidth});
  final bool pointsLeft;
  final Color colour;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final outerX = size.width * (pointsLeft ? .6 : .4);
    final innerX = size.width * (pointsLeft ? .4 : .6);
    canvas.drawPath(
      Path()
        ..moveTo(outerX, size.height * .25)
        ..lineTo(innerX, size.height * .5)
        ..lineTo(outerX, size.height * .75),
      Paint()
        ..color = colour
        ..style = .stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = .round
        ..strokeJoin = .round,
    );
  }

  @override
  bool shouldRepaint(_ChevronPainter oldDelegate) =>
      pointsLeft != oldDelegate.pointsLeft || colour != oldDelegate.colour || strokeWidth != oldDelegate.strokeWidth;
}
