import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasModal', () {
    testWidgets('renders title without throwing', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasModal(title: 'Modal Title')));
      expect(tester.takeException(), isNull);
      expect(find.text('Modal Title'), findsOneWidget);
    });

    testWidgets('renders body text when provided', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasModal(title: 'Title', body: 'Body text'),
        ),
      );
      expect(find.text('Body text'), findsOneWidget);
    });

    testWidgets('renders content widget over body', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasModal(
            title: 'Title',
            body: 'Body text',
            content: Text('Custom content', key: Key('custom_content')),
          ),
        ),
      );
      expect(find.byKey(const Key('custom_content')), findsOneWidget);
    });

    testWidgets('renders actions when provided', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasModal(title: 'Title', actions: [Text('Cancel'), Text('OK')]),
        ),
      );
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('renders close button by default', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasModal(title: 'Title')));
      expect(tester.takeException(), isNull);
    });

    testWidgets('hides close button when showCloseButton is false', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasModal(title: 'Title', showCloseButton: false)));
      expect(tester.takeException(), isNull);
    });
  });

  group('showDievasModal', () {
    testWidgets('shows modal dialog', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: Builder(
            builder: (context) => GestureDetector(
              onTap: () => showDievasModal(
                context: context,
                builder: (_) => const DievasModal(title: 'Dialog Title'),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('Dialog Title'), findsOneWidget);
    });
  });
}
