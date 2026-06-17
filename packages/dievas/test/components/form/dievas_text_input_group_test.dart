import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasTextInputGroup', () {
    testWidgets('renders without throwing — single child', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextInputGroup(children: [Text('item')])));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with multiple children', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextInputGroup(children: [Text('a'), Text('b'), Text('c')])));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders all sizes', (tester) async {
      for (final size in DievasTextInputGroupSize.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasTextInputGroup(size: size, children: const [Text('x'), Text('y')]),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders disabled state', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextInputGroup(enabled: false, children: [Text('x')])));
      expect(tester.takeException(), isNull);
    });
  });
}
