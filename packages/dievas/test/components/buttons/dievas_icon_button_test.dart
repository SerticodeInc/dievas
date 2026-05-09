import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _harness(Widget child) => DievasScope(
  lightTheme: DievasLightThemeData(),
  darkTheme: DievasDarkThemeData(),
  child: MaterialApp(home: Scaffold(body: child)),
);

void main() {
  group('DievasIconButton', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(_harness(DievasIconButton(icon: const Icon(Icons.close), onPressed: () {})));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders both styles', (tester) async {
      for (final style in DievasIconButtonStyle.values) {
        await tester.pumpWidget(
          _harness(DievasIconButton(icon: const Icon(Icons.settings), style: style, onPressed: () {})),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders all three sizes', (tester) async {
      for (final size in DievasButtonSize.values) {
        await tester.pumpWidget(_harness(DievasIconButton(icon: const Icon(Icons.star), size: size, onPressed: () {})));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders both shapes', (tester) async {
      for (final shape in DievasButtonShape.values) {
        await tester.pumpWidget(
          _harness(DievasIconButton(icon: const Icon(Icons.star), shape: shape, onPressed: () {})),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(_harness(const DievasIconButton(icon: Icon(Icons.close))));
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onPressed on tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _harness(DievasIconButton(icon: const Icon(Icons.close), onPressed: () => tapped = true)),
      );
      await tester.tap(find.byType(DievasIconButton));
      expect(tapped, isTrue);
    });

    testWidgets('semantic label is forwarded', (tester) async {
      await tester.pumpWidget(
        _harness(DievasIconButton(icon: const Icon(Icons.close), semanticLabel: 'Close dialog', onPressed: () {})),
      );
      expect(tester.takeException(), isNull);
      expect(find.bySemanticsLabel('Close dialog'), findsOneWidget);
    });
  });
}
