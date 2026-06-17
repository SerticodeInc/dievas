import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _harness(Widget child) => DievasScope(
  lightTheme: DievasLightThemeData(),
  darkTheme: DievasDarkThemeData(),
  child: MaterialApp(home: Scaffold(body: child)),
);

void main() {
  group('DievasCircularProgress', () {
    testWidgets('renders indeterminate without throwing', (tester) async {
      await tester.pumpWidget(_harness(const DievasCircularProgress()));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders determinate value', (tester) async {
      await tester.pumpWidget(_harness(const DievasCircularProgress(value: 0.4)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders all sizes', (tester) async {
      for (final size in DievasCircularProgressSize.values) {
        await tester.pumpWidget(_harness(DievasCircularProgress(size: size)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders both styles', (tester) async {
      for (final style in DievasCircularProgressStyle.values) {
        await tester.pumpWidget(_harness(DievasCircularProgress(style: style)));
        expect(tester.takeException(), isNull);
      }
    });
  });
}
