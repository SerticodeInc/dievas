import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _harness(Widget child) => DievasScope(
  lightTheme: DievasLightThemeData(),
  darkTheme: DievasDarkThemeData(),
  child: MaterialApp(home: Scaffold(body: child)),
);

void main() {
  group('DievasOutlinedButton', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(_harness(DievasOutlinedButton(label: 'Cancel', onPressed: () {})));
      expect(tester.takeException(), isNull);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('renders both styles', (tester) async {
      for (final style in DievasOutlinedButtonStyle.values) {
        await tester.pumpWidget(_harness(DievasOutlinedButton(label: style.name, style: style, onPressed: () {})));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders all three sizes', (tester) async {
      for (final size in DievasButtonSize.values) {
        await tester.pumpWidget(_harness(DievasOutlinedButton(label: 'Label', size: size, onPressed: () {})));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(_harness(const DievasOutlinedButton(label: 'Disabled')));
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onPressed callback on tap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(_harness(DievasOutlinedButton(label: 'Go', onPressed: () => tapped = true)));
      await tester.tap(find.byType(DievasOutlinedButton));
      expect(tapped, isTrue);
    });
  });
}
