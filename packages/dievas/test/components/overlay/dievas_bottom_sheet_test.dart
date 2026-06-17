import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasBottomSheet', () {
    testWidgets('renders without throwing — default drag handle', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasBottomSheet(child: Text('Content'))));
      expect(tester.takeException(), isNull);
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('renders without drag handle', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasBottomSheet(showDragHandle: false, child: Text('Content'))));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasBottomSheet(showDragHandle: false, child: Text('Sheet body', key: Key('sheet_body'))),
        ),
      );
      expect(find.byKey(const Key('sheet_body')), findsOneWidget);
    });
  });

  group('showDievasBottomSheet', () {
    testWidgets('shows modal bottom sheet', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: Builder(
            builder: (context) => GestureDetector(
              onTap: () => showDievasBottomSheet(
                context: context,
                builder: (_) => const DievasBottomSheet(child: Text('Sheet')),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('Sheet'), findsOneWidget);
    });
  });
}
