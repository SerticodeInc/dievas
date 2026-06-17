import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

Widget _drawerHarness(Widget child) => MediaQuery(
  data: const MediaQueryData(size: Size(800, 600)),
  child: Harness(child: child),
);

void main() {
  group('DievasDrawer', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(_drawerHarness(const DievasDrawer(child: Text('Body'), drawer: Text('Drawer'))));
      expect(find.text('Body'), findsOneWidget);
    });

    testWidgets('renders drawer widget without throwing', (tester) async {
      await tester.pumpWidget(_drawerHarness(const DievasDrawer(child: Text('Body'), drawer: Text('Drawer'))));
      expect(tester.takeException(), isNull);
    });

    testWidgets('drawer is hidden initially outside the viewport', (tester) async {
      await tester.pumpWidget(_drawerHarness(const DievasDrawer(child: Text('Body'), drawer: Text('Drawer'))));
      expect(tester.takeException(), isNull);
    });

    testWidgets('open and close via state key', (tester) async {
      final key = GlobalKey<DievasDrawerState>();
      await tester.pumpWidget(
        _drawerHarness(DievasDrawer(key: key, child: const Text('Body'), drawer: const Text('Drawer'))),
      );
      key.currentState?.open();
      await tester.pumpAndSettle();
      key.currentState?.close();
      await tester.pumpAndSettle();
    });

    testWidgets('renders with custom width', (tester) async {
      await tester.pumpWidget(
        _drawerHarness(const DievasDrawer(child: Text('Body'), drawer: Text('Drawer'), width: 300)),
      );
      expect(tester.takeException(), isNull);
    });
  });
}
