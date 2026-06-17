import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasBanner', () {
    for (final tone in DievasAlertTone.values) {
      testWidgets('renders $tone tone without throwing', (tester) async {
        await tester.pumpWidget(
          Harness(
            child: DievasBanner(tone: tone, message: 'Message'),
          ),
        );
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('renders message text', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasBanner(tone: .info, message: 'Banner message'),
        ),
      );
      expect(find.text('Banner message'), findsOneWidget);
    });

    testWidgets('renders dismiss button when onDismiss provided', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasBanner(tone: .info, message: 'Message', onDismiss: () {}),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onDismiss when close icon tapped', (tester) async {
      var dismissed = false;
      await tester.pumpWidget(
        Harness(
          child: DievasBanner(tone: .info, message: 'Message', onDismiss: () => dismissed = true),
        ),
      );
      await tester.tap(find.byType(GestureDetector));
      expect(dismissed, isTrue);
    });

    testWidgets('renders action widget when provided', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasBanner(
            tone: .info,
            message: 'Message',
            action: const Text('Action', key: Key('banner_action')),
          ),
        ),
      );
      expect(find.byKey(const Key('banner_action')), findsOneWidget);
    });
  });
}
