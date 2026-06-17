import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _harness(Widget child) => DievasScope(
  lightTheme: DievasLightThemeData(),
  darkTheme: DievasDarkThemeData(),
  child: MaterialApp(home: Scaffold(body: child)),
);

void main() {
  group('DievasDivider', () {
    testWidgets('renders horizontal without throwing', (tester) async {
      await tester.pumpWidget(_harness(const DievasDivider()));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders vertical without throwing', (tester) async {
      await tester.pumpWidget(_harness(const DievasDivider(orientation: DievasDividerOrientation.vertical)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with indent', (tester) async {
      await tester.pumpWidget(_harness(const DievasDivider(indent: 16)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with endIndent', (tester) async {
      await tester.pumpWidget(_harness(const DievasDivider(endIndent: 16)));
      expect(tester.takeException(), isNull);
    });
  });
}
