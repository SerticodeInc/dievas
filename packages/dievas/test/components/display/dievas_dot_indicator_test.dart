import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasDotIndicator', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDotIndicator(count: 3, activeIndex: 0)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders different counts', (tester) async {
      for (var i = 1; i <= 5; i++) {
        await tester.pumpWidget(Harness(child: DievasDotIndicator(count: i, activeIndex: 0)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders different active indexes', (tester) async {
      for (var i = 0; i < 4; i++) {
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
