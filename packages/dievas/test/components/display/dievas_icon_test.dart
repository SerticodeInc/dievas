import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _harness(Widget child) => DievasScope(
  lightTheme: DievasLightThemeData(),
  darkTheme: DievasDarkThemeData(),
  child: MaterialApp(home: Scaffold(body: child)),
);

void main() {
  group('DievasIcon', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(_harness(const DievasIcon(Icons.star)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders all sizes', (tester) async {
      for (final size in DievasIconSize.values) {
        await tester.pumpWidget(_harness(DievasIcon(Icons.star, size: size)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders with explicit colour', (tester) async {
      await tester.pumpWidget(_harness(const DievasIcon(Icons.star, color: Colors.red)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with semantic label', (tester) async {
      await tester.pumpWidget(_harness(const DievasIcon(Icons.close, semanticLabel: 'Close')));
      expect(tester.takeException(), isNull);
      expect(find.bySemanticsLabel('Close'), findsOneWidget);
    });
  });
}
