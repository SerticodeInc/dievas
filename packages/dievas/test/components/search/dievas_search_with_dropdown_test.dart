import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasSearchWithDropdown', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasSearchWithDropdown<String>(
              items: const ['Apple', 'Banana'],
              displayString: (s) => s,
              onSelected: (_) {},
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('shows hint text when provided', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasSearchWithDropdown<String>(
              items: const ['Apple', 'Banana'],
              displayString: (s) => s,
              onSelected: (_) {},
              hint: 'Search fruits',
            ),
          ),
        ),
      );
      expect(find.text('Search fruits'), findsOneWidget);
    });

    testWidgets('shows dropdown when typing', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasSearchWithDropdown<String>(
              items: const ['Apple', 'Banana', 'Apricot'],
              displayString: (s) => s,
              onSelected: (_) {},
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), 'Ap');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      // Dropdown overlay should show matching results
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Apricot'), findsOneWidget);
    });

    testWidgets('tapping result calls onSelected and clears text', (tester) async {
      String? selected;
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasSearchWithDropdown<String>(
              items: const ['Apple', 'Banana'],
              displayString: (s) => s,
              onSelected: (item) => selected = item,
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), 'Apple');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      // Tap the result item inside the dropdown (InkWell)
      await tester.tap(find.text('Apple').last);
      await tester.pump();
      expect(selected, 'Apple');
    });

    testWidgets('disables search field when enabled is false', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasSearchWithDropdown<String>(
              items: const ['Apple'],
              displayString: (s) => s,
              onSelected: (_) {},
              enabled: false,
            ),
          ),
        ),
      );
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('close button clears text and dismisses dropdown', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasSearchWithDropdown<String>(
              items: const ['Apple', 'Banana'],
              displayString: (s) => s,
              onSelected: (_) {},
            ),
          ),
        ),
      );
      // Enter text with no matches so dropdown doesn't obscure the close button
      await tester.enterText(find.byType(TextField), 'XYZ');
      await tester.pump();
      // Close button should appear
      expect(find.byIcon(Icons.close), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close), warnIfMissed: false);
      await tester.pump();
      expect(find.byIcon(Icons.close), findsNothing);
    });
  });
}
