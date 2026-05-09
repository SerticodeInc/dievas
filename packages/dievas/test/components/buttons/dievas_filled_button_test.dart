import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Minimal harness: wraps a widget in DievasScope so component theme lookups
// resolve without a real app around them.
Widget _harness(Widget child) => DievasScope(
  lightTheme: DievasLightThemeData(),
  darkTheme: DievasDarkThemeData(),
  child: MaterialApp(home: Scaffold(body: child)),
);

void main() {
  group('DievasFilledButton', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(_harness(DievasFilledButton(label: 'Continue', onPressed: () {})));
      expect(tester.takeException(), isNull);
      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('renders all three styles', (tester) async {
      for (final style in DievasFilledButtonStyle.values) {
        await tester.pumpWidget(_harness(DievasFilledButton(label: style.name, style: style, onPressed: () {})));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders all three sizes', (tester) async {
      for (final size in DievasButtonSize.values) {
        await tester.pumpWidget(_harness(DievasFilledButton(label: 'Label', size: size, onPressed: () {})));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(_harness(const DievasFilledButton(label: 'Disabled')));
      expect(tester.takeException(), isNull);
    });

    testWidgets('loading state renders without throwing', (tester) async {
      await tester.pumpWidget(_harness(const DievasFilledButton(label: 'Saving', state: .loading)));
      await tester.pump(const Duration(milliseconds: 200));
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onPressed callback on tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_harness(DievasFilledButton(label: 'Go', onPressed: () => tapped = true)));
      await tester.tap(find.byType(DievasFilledButton));
      expect(tapped, isTrue);
    });

    testWidgets('does not fire onPressed when loading', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _harness(DievasFilledButton(label: 'Go', state: .loading, onPressed: () => tapped = true)),
      );

      await tester.tap(find.byType(DievasFilledButton));
      expect(tapped, isFalse);
    });

    testWidgets('renders both shapes', (tester) async {
      for (final shape in DievasButtonShape.values) {
        await tester.pumpWidget(_harness(DievasFilledButton(label: 'Shape', shape: shape, onPressed: () {})));
        expect(tester.takeException(), isNull);
      }
    });
  });
}
