import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _harness(Widget child) => DievasScope(
  lightTheme: DievasLightThemeData(),
  darkTheme: DievasDarkThemeData(),
  child: MaterialApp(home: Scaffold(body: child)),
);

void main() {
  group('DievasDotIndicator', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(_harness(const DievasDotIndicator(count: 3, activeIndex: 0)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders different counts', (tester) async {
      for (var i = 1; i <= 5; i++) {
        await tester.pumpWidget(_harness(DievasDotIndicator(count: i, activeIndex: 0)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders different active indexes', (tester) async {
      for (var i = 0; i < 4; i++) {
        await tester.pumpWidget(_harness(DievasDotIndicator(count: 4, activeIndex: i)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('fires onDotTap with correct index', (tester) async {
      var tappedIndex = -1;
      await tester.pumpWidget(_harness(DievasDotIndicator(count: 3, activeIndex: 0, onDotTap: (i) => tappedIndex = i)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders disabled state', (tester) async {
      await tester.pumpWidget(_harness(const DievasDotIndicator(count: 3, activeIndex: 0, enabled: false)));
      expect(tester.takeException(), isNull);
    });
  });
}
