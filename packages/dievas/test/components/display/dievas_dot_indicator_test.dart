import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasDotIndicator', () {
    testWidgets('defaults to equal 8px dots and 8px gaps', (tester) async {
      await tester.pumpWidget(const Harness(child: DievasDotIndicator(count: 4, activeIndex: 0)));
      final dots = find.descendant(of: find.byType(DievasDotIndicator), matching: find.byType(AnimatedContainer));
      for (final dot in dots.evaluate()) {
        expect(tester.getSize(find.byWidget(dot.widget)), const Size(8, 8));
      }
      expect(tester.getTopLeft(dots.at(1)).dx - tester.getTopLeft(dots.first).dx, 16);
    });

    testWidgets('instance overrides and reduced motion apply immediately', (tester) async {
      await tester.pumpWidget(
        const Harness(
          child: MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: DievasDotIndicator(
              count: 2,
              activeIndex: 0,
              size: 12,
              gap: 0,
              selectedColour: Color(0xFFFF0000),
              unselectedColour: Color(0xFF0000FF),
              transitionDuration: Duration(seconds: 2),
            ),
          ),
        ),
      );
      final dots = find.byType(AnimatedContainer);
      expect(tester.getSize(dots.first), const Size(12, 12));
      expect(tester.widget<AnimatedContainer>(dots.first).duration, Duration.zero);
      expect(
        tester.widget<AnimatedContainer>(dots.first).decoration,
        const BoxDecoration(color: Color(0xFFFF0000), shape: BoxShape.circle),
      );
      expect(tester.getTopLeft(dots.last).dx - tester.getTopLeft(dots.first).dx, 12);
    });

    testWidgets('interactive dots support keyboard selection and disabled state', (tester) async {
      int? selected;
      await tester.pumpWidget(
        Harness(child: DievasDotIndicator(count: 3, activeIndex: 0, onDotTap: (index) => selected = index)),
      );
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      expect(selected, 0);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      expect(selected, 1);
      await tester.pumpWidget(
        Harness(
          child: DievasDotIndicator(count: 3, activeIndex: 1, enabled: false, onDotTap: (index) => selected = index),
        ),
      );
      await tester.tap(find.byType(GestureDetector).first);
      expect(selected, 1);
    });

    testWidgets('supports empty and changing counts', (tester) async {
      for (final count in [5, 1, 0, 4]) {
        await tester.pumpWidget(Harness(child: DievasDotIndicator(count: count, activeIndex: 0)));
        await tester.pumpAndSettle();
        expect(find.byType(AnimatedContainer), findsNWidgets(count));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDotIndicator(count: 3, activeIndex: 0)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders different counts', (tester) async {
      for (int i = 1; i <= 5; i++) {
        await tester.pumpWidget(Harness(child: DievasDotIndicator(count: i, activeIndex: 0)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders different active indexes', (tester) async {
      for (int i = 0; i < 4; i++) {
        await tester.pumpWidget(Harness(child: DievasDotIndicator(count: 4, activeIndex: i)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('fires onDotTap with correct index', (tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        Harness(child: DievasDotIndicator(count: 3, activeIndex: 0, onDotTap: (i) => tappedIndex = i)),
      );
      await tester.tap(find.byType(GestureDetector).first);
      expect(tappedIndex, 0);
    });

    testWidgets('renders disabled state', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDotIndicator(count: 3, activeIndex: 0, enabled: false)));
      expect(tester.takeException(), isNull);
    });
  });
}
