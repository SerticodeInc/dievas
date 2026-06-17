import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasAlert', () {
    for (final tone in DievasAlertTone.values) {
      testWidgets('renders $tone tone without throwing', (tester) async {
        await tester.pumpWidget(
          Harness(
            child: DievasAlert(tone: tone, title: 'Title'),
          ),
        );
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('renders title text', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasAlert(tone: .info, title: 'Hello Alert'),
        ),
      );
      expect(find.text('Hello Alert'), findsOneWidget);
    });

    testWidgets('renders description when provided', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasAlert(tone: .info, title: 'Title', description: 'Description text'),
        ),
      );
      expect(find.text('Description text'), findsOneWidget);
    });

    testWidgets('renders dismiss button when onDismiss provided', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasAlert(tone: .info, title: 'Title', onDismiss: () {}),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onDismiss when close icon tapped', (tester) async {
      bool dismissed = false;
      await tester.pumpWidget(
        Harness(
          child: DievasAlert(tone: .info, title: 'Title', onDismiss: () => dismissed = true),
        ),
      );
      await tester.tap(find.byType(GestureDetector));
      expect(dismissed, isTrue);
    });

    testWidgets('renders custom leading icon', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasAlert(
            tone: .info,
            title: 'Title',
            leadingIcon: const Icon(Icons.star, key: Key('custom_icon')),
          ),
        ),
      );
      expect(find.byKey(const Key('custom_icon')), findsOneWidget);
    });

    testWidgets('renders default icon for each tone', (tester) async {
      for (final tone in DievasAlertTone.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasAlert(tone: tone, title: 'Title'),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });
  });
}
