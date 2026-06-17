import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasBadge', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasBadge(label: 'New')));
      expect(tester.takeException(), isNull);
      expect(find.text('New'), findsOneWidget);
    });

    testWidgets('renders all styles', (tester) async {
      for (final style in DievasBadgeStyle.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasBadge(label: style.name, style: style),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders all tones', (tester) async {
      for (final tone in DievasBadgeTone.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasBadge(label: tone.name, tone: tone),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders all style × tone combinations', (tester) async {
      for (final style in DievasBadgeStyle.values) {
        for (final tone in DievasBadgeTone.values) {
          await tester.pumpWidget(
            Harness(
              child: DievasBadge(label: '$style-$tone', style: style, tone: tone),
            ),
          );
          expect(tester.takeException(), isNull);
        }
      }
    });

    testWidgets('renders with leading icon', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasBadge(label: 'Active', leadingIcon: Icon(Icons.circle)),
        ),
      );
      expect(tester.takeException(), isNull);
    });
  });
}
