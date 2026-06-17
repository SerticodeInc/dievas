import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasTag', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTag(label: 'Flutter')));
      expect(tester.takeException(), isNull);
      expect(find.text('Flutter'), findsOneWidget);
    });

    testWidgets('renders all styles', (tester) async {
      for (final style in DievasTagStyle.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasTag(label: style.name, style: style),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders with leading icon', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasTag(label: 'Active', leadingIcon: Icon(Icons.circle, size: 8)),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onPressed callback on tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        Harness(
          child: DievasTag(label: 'Tap', onPressed: () => tapped = true),
        ),
      );
      await tester.tap(find.text('Tap'));
      expect(tapped, isTrue);
    });

    testWidgets('fires onRemove callback on dismiss tap', (tester) async {
      bool removed = false;
      await tester.pumpWidget(
        Harness(
          child: DievasTag(label: 'Dismiss', onRemove: () => removed = true),
        ),
      );
      // The remove button is a GestureDetector with the close icon.
      await tester.tap(find.byType(GestureDetector));
      expect(removed, isTrue);
    });

    testWidgets('renders as static when no callbacks', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTag(label: 'Static')));
      expect(tester.takeException(), isNull);
    });
  });
}
