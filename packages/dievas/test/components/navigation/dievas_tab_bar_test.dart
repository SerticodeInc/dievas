import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasTabBar', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(
        Harness(child: const DievasTabBar(tabs: ['A', 'B', 'C'], selectedIndex: 0, onChanged: null)),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
    });

    testWidgets('highlights the selected tab', (tester) async {
      await tester.pumpWidget(
        Harness(child: const DievasTabBar(tabs: ['A', 'B', 'C'], selectedIndex: 1, onChanged: null)),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onChanged with correct index on tap', (tester) async {
      int? selected;
      await tester.pumpWidget(
        Harness(
          child: DievasTabBar(tabs: ['A', 'B', 'C'], selectedIndex: 0, onChanged: (i) => selected = i),
        ),
      );
      await tester.tap(find.text('B'));
      expect(selected, 1);
    });

    testWidgets('does not fire onChanged when disabled', (tester) async {
      int? selected;
      await tester.pumpWidget(
        Harness(
          child: DievasTabBar(tabs: ['A', 'B', 'C'], selectedIndex: 0, onChanged: (i) => selected = i, enabled: false),
        ),
      );
      await tester.tap(find.text('B'));
      expect(selected, isNull);
    });

    testWidgets('does not fire onChanged when onChanged is null', (tester) async {
      await tester.pumpWidget(
        Harness(child: const DievasTabBar(tabs: ['A', 'B', 'C'], selectedIndex: 0, onChanged: null)),
      );
      await tester.tap(find.text('B'));
      // No exception means it completed without firing
    });

    testWidgets('slides the indicator under the tapped tab', (tester) async {
      var selected = 0;
      await tester.pumpWidget(
        Harness(
          child: StatefulBuilder(
            builder: (context, setState) => DievasTabBar(
              tabs: ['A', 'B', 'C'],
              selectedIndex: selected,
              onChanged: (i) => setState(() => selected = i),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final indicator = find.byKey(const ValueKey('dievas_tab_bar_indicator'));
      final startLeft = tester.getTopLeft(indicator).dx;

      await tester.tap(find.text('B'));
      await tester.pumpAndSettle();

      // A single indicator now sits under tab B rather than a per-tab border.
      expect(find.byKey(const ValueKey('dievas_tab_bar_indicator')), findsOneWidget);
      expect(tester.getTopLeft(indicator).dx, greaterThan(startLeft));
      expect((tester.getRect(indicator).center.dx - tester.getRect(find.text('B')).center.dx).abs(), lessThan(1.5));
    });
  });
}
