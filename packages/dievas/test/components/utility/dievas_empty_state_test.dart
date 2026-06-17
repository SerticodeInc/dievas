import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasEmptyState', () {
    testWidgets('renders without throwing — defaults', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasEmptyState()));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders custom title', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasEmptyState(title: 'Custom Title')));
      expect(find.text('Custom Title'), findsOneWidget);
    });

    testWidgets('renders custom description', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasEmptyState(description: 'Custom description')));
      expect(find.text('Custom description'), findsOneWidget);
    });

    testWidgets('renders custom icon', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasEmptyState(icon: Icon(Icons.inbox, key: Key('empty_icon'))),
        ),
      );
      expect(find.byKey(const Key('empty_icon')), findsOneWidget);
    });

    testWidgets('renders action widget', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasEmptyState(
            action: TextButton(onPressed: () {}, child: const Text('CTA')),
          ),
        ),
      );
      expect(find.text('CTA'), findsOneWidget);
    });

    testWidgets('renders default title and description when not provided', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasEmptyState()));
      expect(tester.takeException(), isNull);
      // Default l10n fallback strings
      expect(find.text('Nothing here yet'), findsOneWidget);
      expect(find.text('Check back later or try a different filter.'), findsOneWidget);
    });
  });
}
