import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _harness(Widget child) => DievasScope(
  lightTheme: DievasLightThemeData(),
  darkTheme: DievasDarkThemeData(),
  child: MaterialApp(home: Scaffold(body: child)),
);

void main() {
  group('DievasTag', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(_harness(const DievasTag(label: 'Flutter')));
      expect(tester.takeException(), isNull);
      expect(find.text('Flutter'), findsOneWidget);
    });

    testWidgets('renders all styles', (tester) async {
      for (final style in DievasTagStyle.values) {
        await tester.pumpWidget(_harness(DievasTag(label: style.name, style: style)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders with leading icon', (tester) async {
      await tester.pumpWidget(_harness(const DievasTag(label: 'Active', leadingIcon: Icon(Icons.circle, size: 8))));
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onPressed callback on tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_harness(DievasTag(label: 'Tap', onPressed: () => tapped = true)));
      await tester.tap(find.text('Tap'));
      expect(tapped, isTrue);
    });

    testWidgets('fires onRemove callback on dismiss tap', (tester) async {
      var removed = false;
      await tester.pumpWidget(_harness(DievasTag(label: 'Dismiss', onRemove: () => removed = true)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders as static when no callbacks', (tester) async {
      await tester.pumpWidget(_harness(const DievasTag(label: 'Static')));
      expect(tester.takeException(), isNull);
    });
  });
}
