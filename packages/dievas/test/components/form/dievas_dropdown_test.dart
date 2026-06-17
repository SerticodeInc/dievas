import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasDropdown', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDropdown<String>(options: ['A', 'B', 'C'], onChanged: null)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('shows hint text when no value is selected', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasDropdown<String>(options: ['A', 'B', 'C'], hint: 'Pick one', onChanged: null),
        ),
      );
      expect(find.text('Pick one'), findsOneWidget);
    });

    testWidgets('shows selected value when value is provided', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasDropdown<String>(options: ['A', 'B', 'C'], value: 'B', onChanged: null),
        ),
      );
      expect(find.text('B'), findsOneWidget);
    });

    testWidgets('shows label when provided', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasDropdown<String>(options: ['A', 'B', 'C'], label: 'Fruit', onChanged: null),
        ),
      );
      expect(find.text('Fruit'), findsOneWidget);
    });

    testWidgets('uses labelBuilder for display text', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasDropdown<_Option>(
            options: [_Option.apple, _Option.banana],
            value: _Option.banana,
            onChanged: null,
            labelBuilder: (o) => o.label,
          ),
        ),
      );
      expect(find.text('Banana'), findsOneWidget);
    });

    testWidgets('opens overlay on tap', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasDropdown<String>(options: ['A', 'B', 'C'], onChanged: (_) {}),
        ),
      );

      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pump();

      expect(find.text('A'), findsWidgets);
      expect(find.text('B'), findsWidgets);
      expect(find.text('C'), findsWidgets);
    });

    testWidgets('fires onChanged when option is tapped', (tester) async {
      String? selected;
      await tester.pumpWidget(
        Harness(
          child: DievasDropdown<String>(options: ['A', 'B', 'C'], onChanged: (v) => selected = v),
        ),
      );

      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pump();

      await tester.tap(find.text('B').last);
      expect(selected, 'B');
    });

    testWidgets('does not open when disabled', (tester) async {
      String? selected;
      await tester.pumpWidget(
        Harness(
          child: DievasDropdown<String>(options: ['A', 'B', 'C'], onChanged: (v) => selected = v, enabled: false),
        ),
      );

      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pump();

      expect(find.text('A'), findsNothing);
      expect(selected, isNull);
    });

    testWidgets('does not respond to tap when onChanged is null', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDropdown<String>(options: ['A', 'B', 'C'], onChanged: null)));

      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pump();

      expect(find.text('A'), findsNothing);
    });
  });
}

class _Option {
  const _Option(this.label);
  final String label;
  static const apple = _Option('Apple');
  static const banana = _Option('Banana');
}
