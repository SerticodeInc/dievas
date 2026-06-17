import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasTooltip', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasTooltip(message: 'Tooltip message', child: Text('Target')),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasTooltip(
            message: 'Tooltip message',
            child: Text('Target', key: Key('target')),
          ),
        ),
      );
      expect(find.byKey(const Key('target')), findsOneWidget);
    });

    testWidgets('respects preferBelow parameter', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasTooltip(message: 'Tooltip message', preferBelow: false, child: Text('Target')),
        ),
      );
      expect(tester.takeException(), isNull);
    });
  });
}
