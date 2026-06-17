import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasSearchWithList', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasSearchWithList<String>(
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
            child: DievasSearchWithList<String>(
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

    testWidgets('shows filtered results when typing', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasSearchWithList<String>(
              items: const ['Apple', 'Banana', 'Apricot'],
              displayString: (s) => s,
              onSelected: (_) {},
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), 'Ap');
      await tester.pump();
      // Should match Apple and Apricot (but not Banana)
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Apricot'), findsOneWidget);
      expect(find.text('Banana'), findsNothing);
    });

    testWidgets('tapping result calls onSelected and clears text', (tester) async {
      String? selected;
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasSearchWithList<String>(
              items: const ['Apple', 'Banana'],
              displayString: (s) => s,
              onSelected: (item) => selected = item,
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), 'Apple');
      await tester.pump();
      await tester.tap(find.text('Apple').last);
      expect(selected, 'Apple');
    });

    testWidgets('disables search field when enabled is false', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasSearchWithList<String>(
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

    testWidgets('shows no results when query matches nothing', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasSearchWithList<String>(
              items: const ['Apple', 'Banana'],
              displayString: (s) => s,
              onSelected: (_) {},
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), 'XYZ');
      await tester.pump();
      expect(find.text('Apple'), findsNothing);
      expect(find.text('Banana'), findsNothing);
    });

    testWidgets('renders custom leading icon', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasSearchWithList<String>(
              items: const ['Apple'],
              displayString: (s) => s,
              onSelected: (_) {},
              leadingIcon: const Icon(Icons.star, key: Key('custom_icon')),
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('custom_icon')), findsOneWidget);
    });

    testWidgets('uses custom filter predicate', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasSearchWithList<String>(
              items: const ['Apple', 'Banana'],
              displayString: (s) => s,
              onSelected: (_) {},
              filter: (item, query) => item.length == query.length,
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), 'Banana');
      await tester.pump();
      // One InkWell result (not counting EditableText)
      expect(find.byType(InkWell), findsOneWidget);
      expect(find.text('Apple'), findsNothing);
    });
  });
}
