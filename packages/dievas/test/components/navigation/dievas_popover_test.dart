import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasPopover', () {
    testWidgets('renders trigger without throwing', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasPopover(
            trigger: const Text('Open', key: Key('trigger')),
            content: const Text('Content'),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.byKey(const Key('trigger')), findsOneWidget);
    });

    testWidgets('shows content on trigger tap', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasPopover(
            trigger: const Text('Open', key: Key('trigger')),
            content: const Text('Popover Content'),
          ),
        ),
      );
      await tester.tap(find.byKey(const Key('trigger')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Popover Content'), findsOneWidget);
    });

    testWidgets('hides content on second tap', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasPopover(
            trigger: const Text('Open', key: Key('trigger')),
            content: const Text('Popover Content'),
          ),
        ),
      );
      await tester.tap(find.byKey(const Key('trigger')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Popover Content'), findsOneWidget);
      await tester.tap(find.byKey(const Key('trigger')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Popover Content'), findsNothing);
    });

    testWidgets('hides content on barrier tap', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasPopover(
            trigger: const Text('Open', key: Key('trigger')),
            content: const Text('Popover Content'),
          ),
        ),
      );
      await tester.tap(find.byKey(const Key('trigger')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Popover Content'), findsOneWidget);
      // Tap the barrier (GestureDetector filling the screen)
      await tester.tapAt(const Offset(10, 10));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Popover Content'), findsNothing);
    });

    testWidgets('renders with different positions', (tester) async {
      for (final position in DievasPopoverPosition.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasPopover(trigger: const Text('Open'), content: const Text('Content'), position: position),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });
  });
}
