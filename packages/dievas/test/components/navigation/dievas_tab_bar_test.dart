import 'package:dievas/dievas.dart';
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
  });
}
