import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasIcon', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasIcon(Icons.star)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders all sizes', (tester) async {
      for (final size in DievasIconSize.values) {
        await tester.pumpWidget(Harness(child: DievasIcon(Icons.star, size: size)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders with explicit colour', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasIcon(Icons.star, color: Colors.red)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with semantic label', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasIcon(Icons.close, semanticLabel: 'Close')));
      expect(tester.takeException(), isNull);
      expect(find.bySemanticsLabel('Close'), findsOneWidget);
    });
  });
}
