import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  testWidgets('toggle and barrier dismissal report state and preserve width', (tester) async {
    final key = GlobalKey<DievasDrawerState>();
    final changes = <bool>[];
    await tester.pumpWidget(
      Harness(
        child: DievasDrawer(
          key: key,
          width: 200,
          onChanged: changes.add,
          drawer: const Text('Drawer content'),
          child: const SizedBox.expand(),
        ),
      ),
    );
    key.currentState?.toggle();
    await tester.pumpAndSettle();
    expect(key.currentState?.isOpen, isTrue);
    expect(tester.getSize(find.byType(Drawer)).width, 200);
    await tester.tapAt(const Offset(700, 300));
    await tester.pumpAndSettle();
    expect(key.currentState?.isOpen, isFalse);
    expect(changes, [true, false]);
    expect(tester.takeException(), isNull);
  });

  for (final direction in TextDirection.values) {
    testWidgets('end placement in $direction clips oversized drawers', (tester) async {
      final key = GlobalKey<DievasDrawerState>();
      await tester.pumpWidget(
        Harness(
          child: Directionality(
            textDirection: direction,
            child: DievasDrawer(
              key: key,
              alignment: .end,
              width: 1000,
              drawer: const Text('Drawer'),
              child: const SizedBox.expand(),
            ),
          ),
        ),
      );
      key.currentState?.open();
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(Drawer)).width, 800);
      expect(tester.takeException(), isNull);
    });
  }

  for (final direction in TextDirection.values) {
    testWidgets('end edge mirrors in $direction', (tester) async {
      final key = GlobalKey<DievasDrawerState>();
      await tester.pumpWidget(
        Harness(
          child: Directionality(
            textDirection: direction,
            child: DievasDrawer(
              key: key,
              width: 200,
              alignment: .end,
              drawer: const Text('Drawer'),
              child: const SizedBox.expand(),
            ),
          ),
        ),
      );
      key.currentState?.open();
      await tester.pumpAndSettle();
      expect(tester.getTopLeft(find.byType(Drawer)).dx, direction == .ltr ? 600 : 0);
    });
  }

  testWidgets('locked barrier keeps drawer open and close remains available', (tester) async {
    final key = GlobalKey<DievasDrawerState>();
    await tester.pumpWidget(
      Harness(
        child: DievasDrawer(
          key: key,
          width: 200,
          barrierDismissible: false,
          backgroundColour: Colors.red,
          barrierColour: Colors.blue,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          shadow: const [],
          semanticLabel: 'Navigation',
          drawer: const Text('Drawer'),
          child: const SizedBox.expand(),
        ),
      ),
    );
    key.currentState?.open();
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(700, 300));
    await tester.pumpAndSettle();
    expect(key.currentState?.isOpen, isTrue);
    expect(tester.widget<Drawer>(find.byType(Drawer)).semanticLabel, 'Navigation');
    expect(tester.widget<DrawerController>(find.byType(DrawerController)).scrimColor, Colors.blue);
    key.currentState?.close();
    await tester.pumpAndSettle();
    expect(key.currentState?.isOpen, isFalse);
  });
}
