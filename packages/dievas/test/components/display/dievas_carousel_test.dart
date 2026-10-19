import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  testWidgets('fixed extent, gap, finite navigation and callbacks', (tester) async {
    final controller = DievasCarouselController();
    final changes = <int>[];
    await tester.pumpWidget(_Example(controller: controller, onChanged: changes.add));
    expect(tester.getSize(find.byKey(const ValueKey(0))).width, 100);
    expect(
      tester.getTopLeft(find.byKey(const ValueKey(1))).dx - tester.getTopLeft(find.byKey(const ValueKey(0))).dx,
      108,
    );
    controller.jumpToItem(4);
    await tester.pumpAndSettle();
    expect(controller.offset, 432);
    expect(controller.selectedItem, 4);
    expect(changes.last, 4);
    controller.jumpToItem(20);
    expect(controller.selectedItem, 4);
    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });

  testWidgets('looping reaches negative indices and wraps logical selection', (tester) async {
    final controller = DievasCarouselController();
    await tester.pumpWidget(_Example(controller: controller, loop: true));
    final animation = controller.previousItem();
    await tester.pumpAndSettle();
    await animation;
    expect(controller.offset, closeTo(-108, .01));
    expect(controller.selectedItem, 4);
    expect(find.text('4:-1'), findsOneWidget);
    controller.jumpToItem(0);
    await tester.pumpAndSettle();
    expect(controller.selectedItem, 0);
    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });

  testWidgets('clamps the trailing edge and snaps after dragging', (tester) async {
    final controller = DievasCarouselController();
    await tester.pumpWidget(_Example(controller: controller, clamp: true));
    controller.jumpToItem(4);
    await tester.pumpAndSettle();
    expect(controller.offset, 232);
    await tester.drag(find.byType(DievasCarousel), const Offset(160, 0));
    await tester.pumpAndSettle();
    expect(controller.offset % 108, closeTo(0, .01));
    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });

  testWidgets('live extent and count changes retain a valid selection', (tester) async {
    final controller = DievasCarouselController(initialItem: 3);
    await tester.pumpWidget(_Example(controller: controller));
    expect(controller.selectedItem, 3);
    await tester.pumpWidget(_Example(controller: controller, extent: 80));
    await tester.pumpAndSettle();
    expect(controller.offset, 264);
    await tester.pumpWidget(_Example(controller: controller, count: 2));
    await tester.pumpAndSettle();
    expect(controller.selectedItem, 1);
    await tester.pumpWidget(_Example(controller: controller, count: 0));
    expect(find.byType(CustomScrollView), findsNothing);
    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });

  testWidgets('replacing an external controller uses the new geometry and physics', (tester) async {
    final first = DievasCarouselController();
    final second = DievasCarouselController(initialItem: 1);
    await tester.pumpWidget(_Example(controller: first));
    await tester.pumpWidget(_Example(controller: second, extent: 80, loop: true));
    await tester.pumpAndSettle();
    expect(first.hasClients, isFalse);
    expect(second.selectedItem, 1);
    await tester.drag(find.byType(DievasCarousel), const Offset(-100, 0));
    await tester.pumpAndSettle();
    expect(second.offset % 88, closeTo(0, .01));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
    first.dispose();
    second.dispose();
  });

  testWidgets('autoplay advances and is cancelled on disposal', (tester) async {
    final controller = DievasCarouselController();
    await tester.pumpWidget(_Example(controller: controller, autoplay: true));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(controller.selectedItem, 1);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 5));
    expect(tester.takeException(), isNull);
    controller.dispose();
  });

  testWidgets('reduced motion disables autoplay and makes navigation instant', (tester) async {
    final controller = DievasCarouselController();
    await tester.pumpWidget(_Example(controller: controller, autoplay: true, reduced: true));
    await tester.pump(const Duration(seconds: 3));
    expect(controller.selectedItem, 0);
    await controller.nextItem();
    expect(controller.selectedItem, 1);
    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });

  for (final axis in Axis.values) {
    testWidgets('supports $axis with RTL direction', (tester) async {
      final controller = DievasCarouselController();
      await tester.pumpWidget(_Example(controller: controller, axis: axis, rtl: true));
      controller.jumpToItem(2);
      await tester.pumpAndSettle();
      expect(controller.selectedItem, 2);
      expect(find.text('2:2'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      controller.dispose();
    });
  }

  test('theme supports equality and copyWith', () {
    const theme = DievasCarouselThemeData();
    expect(theme.copyWith(), theme);
    expect(theme.copyWith(gap: 12).gap, 12);
  });
}

class _Example extends StatelessWidget {
  const _Example({
    required this.controller,
    this.loop = false,
    this.clamp = false,
    this.count = 5,
    this.extent = 100,
    this.autoplay = false,
    this.reduced = false,
    this.rtl = false,
    this.axis = Axis.horizontal,
    this.onChanged,
  });
  final DievasCarouselController controller;
  final bool loop, clamp, autoplay, reduced, rtl;
  final int count;
  final double extent;
  final Axis axis;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) => Harness(
    child: MediaQuery(
      data: MediaQueryData(disableAnimations: reduced),
      child: Directionality(
        textDirection: rtl ? .rtl : .ltr,
        child: Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: DievasCarousel(
              controller: controller,
              itemCount: count,
              itemExtent: extent,
              gap: 8,
              isCentered: false,
              loop: loop,
              clampMaxExtent: clamp,
              autoPlay: autoplay,
              autoPlayDelay: const Duration(seconds: 1),
              axisDirection: axis,
              onIndexChanged: onChanged,
              itemBuilder: (_, index, real) => SizedBox(key: ValueKey(real), child: Text('$index:$real')),
            ),
          ),
        ),
      ),
    ),
  );
}
