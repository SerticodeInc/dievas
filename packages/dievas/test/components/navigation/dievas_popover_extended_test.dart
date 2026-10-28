import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../cross_cutting_concerns/harness.dart';

void main() {
  testWidgets('button trigger supports tap, keyboard activation and Escape', (tester) async {
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasPopover(
            trigger: DievasFilledButton(label: 'Open', onPressed: () {}),
            content: const Text('Panel'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Panel'), findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(find.text('Panel'), findsNothing);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.text('Panel'), findsOneWidget);
  });

  for (final position in DievasPopoverPosition.values) {
    testWidgets('${position.name} opens with correct geometry', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: Center(
            child: DievasPopover(
              show: true,
              position: position,
              distanceToTarget: 16,
              contentPadding: EdgeInsets.zero,
              trigger: const SizedBox(key: Key('target'), width: 80, height: 40),
              content: const SizedBox(key: Key('panel'), width: 100, height: 60),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final target = tester.getRect(find.byKey(const Key('target')));
      final panel = tester.getRect(find.byKey(const Key('panel')));
      expect(panel.size, const Size(100, 60));
      expect(panel.left, greaterThanOrEqualTo(8));
      expect(panel.right, lessThanOrEqualTo(792));
      expect(panel.top, greaterThanOrEqualTo(8));
      expect(panel.bottom, lessThanOrEqualTo(592));
      switch (position) {
        case .top || .topLeft || .topRight:
          expect(panel.bottom, closeTo(target.top - 16, 0.01));
        case .bottom || .bottomLeft || .bottomRight:
          expect(panel.top, closeTo(target.bottom + 16, 0.01));
        case .left:
          expect(panel.right, closeTo(target.left - 16, 0.01));
        case .right:
          expect(panel.left, closeTo(target.right + 16, 0.01));
        default:
          break;
      }
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('controlled panel updates content and preserves caller-local theme and RTL', (tester) async {
    var show = true;
    var label = 'First';
    late StateSetter update;
    final localTheme = DievasDarkThemeData();
    await tester.pumpWidget(
      Harness(
        child: StatefulBuilder(
          builder: (context, setState) {
            update = setState;
            return MediaQuery(
              data: const MediaQueryData(disableAnimations: true),
              child: DievasTheme(
                data: localTheme,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: DievasPopover(
                      show: show,
                      onOpenChanged: (value) => setState(() => show = value),
                      position: .left,
                      trigger: const Text('Open'),
                      content: Text(label),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(DievasTheme.of(tester.element(find.text('First'))), same(localTheme));
    expect(Directionality.of(tester.element(find.text('First'))), TextDirection.rtl);
    expect(tester.getTopLeft(find.text('First')).dx, greaterThan(tester.getTopLeft(find.text('Open')).dx));
    update(() => label = 'Updated');
    await tester.pumpAndSettle();
    expect(find.text('First'), findsNothing);
    expect(find.text('Updated'), findsOneWidget);
    await tester.tapAt(const Offset(20, 20));
    await tester.pumpAndSettle();
    expect(show, isFalse);
    expect(find.text('Updated'), findsNothing);
  });

  testWidgets('edge placement stays inside viewport and disposal clears panel', (tester) async {
    await tester.pumpWidget(
      Harness(
        child: Align(
          alignment: Alignment.topRight,
          child: DievasPopover(
            show: true,
            trigger: const Text('Open'),
            content: const SizedBox(width: 200, height: 100, child: Text('Panel')),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.getRect(find.text('Panel')).right, lessThanOrEqualTo(792));
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
    expect(find.text('Panel'), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets('covered routes hide panels and restore controlled visibility', (tester) async {
    final observer = RouteObserver<PageRoute<dynamic>>();
    final navigator = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      DievasScope(
        lightTheme: DievasLightThemeData(),
        darkTheme: DievasDarkThemeData(),
        child: MaterialApp(
          navigatorKey: navigator,
          navigatorObservers: [observer],
          home: Scaffold(
            body: Center(
              child: DievasPopover(
                show: true,
                routeObserver: observer,
                trigger: const Text('Open'),
                content: const Text('Panel'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Panel'), findsOneWidget);
    navigator.currentState!.push(MaterialPageRoute<void>(builder: (_) => const Scaffold(body: Text('Next'))));
    await tester.pumpAndSettle();
    expect(find.text('Panel'), findsNothing);
    navigator.currentState!.pop();
    await tester.pumpAndSettle();
    expect(find.text('Panel'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('outside taps pass through while dismissal can be disabled', (tester) async {
    var taps = 0;
    var outside = 0;
    await tester.pumpWidget(
      Harness(
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 20,
              child: TextButton(onPressed: () => taps++, child: const Text('Other')),
            ),
            Center(
              child: DievasPopover(
                show: true,
                dismissOnTapOutside: false,
                onTapOutside: () => outside++,
                trigger: const Text('Open'),
                content: const Text('Panel'),
              ),
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Other'));
    await tester.pumpAndSettle();
    expect(taps, 1);
    expect(outside, 1);
    expect(find.text('Panel'), findsOneWidget);
  });

  testWidgets('rapid visibility reversal keeps the active overlay', (tester) async {
    var show = true;
    late StateSetter update;
    await tester.pumpWidget(
      Harness(
        child: StatefulBuilder(
          builder: (context, setState) {
            update = setState;
            return Center(
              child: DievasPopover(show: show, trigger: const Text('Open'), content: const Text('Panel')),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    update(() => show = false);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 20));
    update(() => show = true);
    await tester.pumpAndSettle();
    expect(find.text('Panel'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test('popover theme copyWith includes appearance and motion in equality', () {
    final theme = DievasLightThemeData().components.popover;
    expect(theme.copyWith(), theme);
    final changed = theme.copyWith(
      borderColour: const Color(0xFF123456),
      borderWidth: 2,
      iconColour: const Color(0xFF654321),
      popoverMargin: 16,
      transitionCurve: Curves.linear,
    );
    expect(changed, isNot(theme));
    expect(changed.copyWith(), changed);
    expect(changed.borderWidth, 2);
    expect(changed.popoverMargin, 16);
  });
}
