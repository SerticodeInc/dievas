import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasBreadcrumb', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasBreadcrumb<String>(items: const ['Home', 'Products'], displayString: (s) => s),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders item text via displayString', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasBreadcrumb<String>(
            items: const ['Home', 'Products', 'Shoes'],
            displayString: (s) => s.toUpperCase(),
          ),
        ),
      );
      expect(find.text('HOME'), findsOneWidget);
      expect(find.text('PRODUCTS'), findsOneWidget);
      expect(find.text('SHOES'), findsOneWidget);
    });

    testWidgets('renders selected item', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasBreadcrumb<String>(
            items: const ['Home', 'Products', 'Shoes'],
            displayString: (s) => s,
            selectedItem: 'Shoes',
          ),
        ),
      );
      expect(find.text('Shoes'), findsOneWidget);
    });

    testWidgets('calls onItemTap when crumb tapped', (tester) async {
      String? tapped;
      await tester.pumpWidget(
        Harness(
          child: DievasBreadcrumb<String>(
            items: const ['Home', 'Products'],
            displayString: (s) => s,
            onItemTap: (item) => tapped = item,
          ),
        ),
      );
      await tester.tap(find.byType(GestureDetector).first);
      expect(tapped, 'Home');
    });

    testWidgets('calls onHomeTap when home icon tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        Harness(
          child: DievasBreadcrumb<String>(
            items: const ['Home'],
            displayString: (s) => s,
            onHomeTap: () => tapped = true,
            homeIcon: const Icon(Icons.home, key: Key('home_icon')),
          ),
        ),
      );
      await tester.tap(find.byKey(const Key('home_icon')));
      expect(tapped, isTrue);
    });

    testWidgets('renders custom separator', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasBreadcrumb<String>(
            items: const ['Home', 'Products'],
            displayString: (s) => s,
            separator: const Text('>', key: Key('custom_sep')),
          ),
        ),
      );
      expect(find.byKey(const Key('custom_sep')), findsOneWidget);
    });

    testWidgets('renders home icon', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasBreadcrumb<String>(
            items: const ['Home'],
            displayString: (s) => s,
            homeIcon: const Icon(Icons.home, key: Key('home_icon')),
          ),
        ),
      );
      expect(find.byKey(const Key('home_icon')), findsOneWidget);
    });

    testWidgets('applies disabled opacity', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasBreadcrumb<String>(items: const ['Home', 'Products'], displayString: (s) => s, enabled: false),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders separator between items', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasBreadcrumb<String>(items: const ['A', 'B', 'C'], displayString: (s) => s),
        ),
      );
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
      // Chevron icons between each pair
      expect(find.byIcon(Icons.chevron_right_rounded), findsNWidgets(2));
    });
  });
}
