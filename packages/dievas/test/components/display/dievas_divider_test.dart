import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasDivider', () {
    testWidgets('centres the label between equal thin strokes', (tester) async {
      await tester.pumpWidget(
        const Harness(
          child: Center(
            child: SizedBox(width: 280, child: DievasDivider(label: 'Section')),
          ),
        ),
      );
      final strokes = find.descendant(of: find.byType(DievasDivider), matching: find.byType(ColoredBox));
      expect(strokes, findsNWidgets(2));
      expect(tester.getSize(strokes.first).height, 1.5);
      expect(tester.getSize(strokes.first).width, tester.getSize(strokes.last).width);
      expect(tester.getCenter(find.text('Section')).dx, tester.getCenter(find.byType(DievasDivider)).dx);
    });

    testWidgets('tight parent height does not thicken the painted stroke', (tester) async {
      await tester.pumpWidget(
        const Harness(
          child: Center(child: SizedBox(width: 280, height: 12, child: DievasDivider())),
        ),
      );
      final stroke = find.descendant(of: find.byType(DievasDivider), matching: find.byType(ColoredBox));
      expect(tester.getSize(stroke).height, 1.5);
    });

    testWidgets('vertical label and a long horizontal label fit bounded layouts', (tester) async {
      for (final orientation in DievasDividerOrientation.values) {
        await tester.pumpWidget(
          Harness(
            child: Center(
              child: SizedBox(
                width: 120,
                height: 180,
                child: DievasDivider(
                  orientation: orientation,
                  label: 'A longer section label that wraps',
                  thickness: 2,
                ),
              ),
            ),
          ),
        );
        expect(find.text('A longer section label that wraps'), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders horizontal without throwing', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDivider()));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders vertical without throwing', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDivider(orientation: DievasDividerOrientation.vertical)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with indent', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDivider(indent: DievasDividerIndent.MD)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with endIndent', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDivider(endIndent: DievasDividerIndent.MD)));
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
