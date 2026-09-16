import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasDivider', () {
    testWidgets('renders horizontal without throwing', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDivider()));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders vertical without throwing', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDivider(orientation: DievasDividerOrientation.vertical)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with indent', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDivider(indent: DievasDividerIndent.md)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with endIndent', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDivider(endIndent: DievasDividerIndent.md)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with color override', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDivider(colour: Colors.red)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with thickness override', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDivider(thickness: 4)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with custom indent', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDivider(indent: DievasDividerIndent.custom(6))));
      expect(tester.takeException(), isNull);
    });
  });
}
