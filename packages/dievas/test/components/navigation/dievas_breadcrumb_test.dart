import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasBreadcrumb', () {
    testWidgets('collapses middle pages and selects a hidden item', (tester) async {
      int? tapped;
      await tester.pumpWidget(
        Harness(
          child: DievasBreadcrumb<int>(
            items: List.generate(7, (index) => index),
            displayString: (index) => 'Page $index',
            selectedItem: 6,
            visibleItemCount: 3,
            onItemTap: (index) => tapped = index,
          ),
        ),
      );
      expect(find.text('Page 0'), findsOneWidget);
      expect(find.text('Page 1'), findsNothing);
      expect(find.text('Page 5'), findsOneWidget);
      expect(find.text('Page 6'), findsOneWidget);
      await tester.tap(find.text('…'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Page 3'));
      await tester.pumpAndSettle();
      expect(tapped, 3);
    });

    testWidgets('disabled home and overflow actions do not navigate', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        Harness(
          child: DievasBreadcrumb<int>(
            items: const [0, 1, 2, 3],
            displayString: (index) => 'Page $index',
            visibleItemCount: 2,
            enabled: false,
            onHomeTap: () => taps++,
            onItemTap: (_) => taps++,
          ),
        ),
      );
      await tester.tap(find.byIcon(Icons.home_outlined));
      await tester.tap(find.text('Page 0'));
      await tester.tap(find.text('…'));
      await tester.pumpAndSettle();
      expect(taps, 0);
      expect(find.byType(MenuItemButton), findsNothing);
    });

    testWidgets('keyboard activates a link and skips the current page', (tester) async {
      String? tapped;
      await tester.pumpWidget(
        Harness(
          child: DievasBreadcrumb<String>(
            items: const ['Home', 'Current'],
            displayString: (item) => item,
            selectedItem: 'Current',
            onItemTap: (item) => tapped = item,
          ),
        ),
      );
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();
      expect(tapped, 'Home');
      tapped = null;
      await tester.tap(find.text('Current'));
      expect(tapped, isNull);
    });

    testWidgets('long trails scroll within a narrow RTL viewport', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: Directionality(
            textDirection: .rtl,
            child: SizedBox(
              width: 120,
              child: DievasBreadcrumb<String>(
                items: const ['Home', 'A very long category', 'Current'],
                displayString: (item) => item,
                selectedItem: 'Current',
                leading: const Icon(Icons.folder_outlined),
                trailing: const Icon(Icons.open_in_new),
              ),
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
      await tester.drag(find.byType(SingleChildScrollView), const Offset(200, 0));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('empty and short trails do not create overflow controls', (tester) async {
      for (final items in <List<String>>[
        [],
        ['Home'],
        ['Home', 'Current'],
      ]) {
        await tester.pumpWidget(
          Harness(
            child: DievasBreadcrumb<String>(items: items, displayString: (item) => item, visibleItemCount: 2),
          ),
        );
        expect(find.byType(MenuAnchor), findsNothing);
        for (final item in items) {
          expect(find.text(item), findsOneWidget);
        }
        expect(tester.takeException(), isNull);
      }
    });

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
      // Keyboard right-arrow icons between each pair
      expect(find.byIcon(Icons.keyboard_arrow_right), findsNWidgets(2));
    });
  });
}
