import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

Future<void> openSheet(
  WidgetTester tester, {
  WidgetBuilder? builder,
  double? heightFactor = 0.64,
  double? height,
  double threshold = 0.6,
  bool drag = true,
  bool dismissible = true,
  bool expanded = false,
  bool fitContent = false,
  bool resize = true,
  bool reducedMotion = false,
  Color? background,
  Color? barrier,
  BorderRadius? radius,
  ValueChanged<int?>? onResult,
}) async {
  if (reducedMotion) {
    tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
  }
  await tester.pumpWidget(
    Harness(
      child: Builder(
        builder: (context) => TextButton(
          onPressed: () async {
            final result = await showDievasBottomSheet<int>(
              context: context,
              heightFactor: heightFactor,
              height: height,
              closeProgressThreshold: threshold,
              enableDrag: drag,
              isDismissible: dismissible,
              isExpanded: expanded,
              fitContent: fitContent,
              enableResize: resize,
              maxHeightFactor: 0.9,
              backgroundColour: background,
              barrierColour: barrier,
              borderRadius: radius,
              routeSettings: const RouteSettings(name: '/sheet'),
              semanticLabel: 'Choices',
              builder:
                  builder ??
                  (_) => const DievasBottomSheet(
                    title: 'Choices',
                    showCloseButton: true,
                    child: SizedBox.expand(child: Text('Sheet body')),
                  ),
            );
            onResult?.call(result);
          },
          child: const Text('Open'),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('height fraction, clipping, colours and named route are applied', (tester) async {
    await openSheet(
      tester,
      background: Colors.orange,
      barrier: Colors.red.withValues(alpha: 0.4),
      radius: const BorderRadius.vertical(top: Radius.circular(28)),
    );
    expect(tester.getSize(find.byType(DievasBottomSheet)).height, closeTo(600 * 0.64, 1));
    expect(
      tester.widget<ClipRRect>(find.byType(ClipRRect)).borderRadius,
      const BorderRadius.vertical(top: Radius.circular(28)),
    );
    expect(tester.widget<ModalBarrier>(find.byType(ModalBarrier).last).color, Colors.red.withValues(alpha: 0.4));
    expect(ModalRoute.of(tester.element(find.byType(DievasBottomSheet)))?.settings.name, '/sheet');
    expect(
      tester
          .widgetList<Container>(find.byType(Container))
          .any(
            (container) => switch (container.decoration) {
              BoxDecoration(color: Colors.orange) => true,
              _ => false,
            },
          ),
      isTrue,
    );
  });

  testWidgets('short content wraps naturally and tall lists stay bounded', (tester) async {
    await openSheet(
      tester,
      heightFactor: null,
      builder: (_) => const DievasBottomSheet(child: SizedBox(height: 80, child: Text('Short'))),
    );
    expect(tester.getSize(find.byType(DievasBottomSheet)).height, lessThan(130));
    await tester.tapAt(const Offset(10, 20));
    await tester.pumpAndSettle();
    await openSheet(
      tester,
      heightFactor: null,
      builder: (_) => DievasBottomSheet(
        child: ListView.builder(itemCount: 100, itemBuilder: (_, index) => ListTile(title: Text('Row $index'))),
      ),
    );
    expect(tester.getSize(find.byType(DievasBottomSheet)).height, lessThanOrEqualTo(600 * 9 / 16));
    expect(tester.takeException(), isNull);
  });

  testWidgets('pixel height clamps to viewport and expanded fills it', (tester) async {
    await openSheet(tester, heightFactor: null, height: 2000);
    expect(tester.getSize(find.byType(DievasBottomSheet)).height, 540);
    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    await openSheet(tester, expanded: true);
    expect(tester.getSize(find.byType(DievasBottomSheet)).height, 540);
  });

  testWidgets('row actions return results and close button dismisses', (tester) async {
    int? result;
    await openSheet(
      tester,
      onResult: (value) => result = value,
      builder: (context) => DievasBottomSheet(
        showCloseButton: true,
        child: TextButton(onPressed: () => closeDievasBottomSheet(context, 7), child: const Text('Choose 7')),
      ),
    );
    await tester.tap(find.text('Choose 7'));
    await tester.pumpAndSettle();
    expect(result, 7);
    expect(find.byType(DievasBottomSheet), findsNothing);
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(find.byType(DievasBottomSheet), findsNothing);
  });

  testWidgets('barrier and Escape dismissal are independently controllable from drag', (tester) async {
    await openSheet(tester, dismissible: false, drag: false);
    await tester.tapAt(const Offset(10, 20));
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(find.byType(DievasBottomSheet), findsOneWidget);
    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    await openSheet(tester);
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(find.byType(DievasBottomSheet), findsNothing);
  });

  testWidgets('slow drags snap back or close according to remaining progress threshold', (tester) async {
    await openSheet(tester);
    final start = tester.getTopLeft(find.byType(DievasBottomSheet)) + const Offset(120, 20);
    await tester.timedDragFrom(start, const Offset(0, 70), const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.byType(DievasBottomSheet), findsOneWidget);
    expect(tester.getTopLeft(find.byType(DievasBottomSheet)).dy, closeTo(start.dy - 20, 1));
    await tester.timedDragFrom(start, const Offset(0, 220), const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.byType(DievasBottomSheet), findsNothing);
  });

  testWidgets('disabled drag leaves sheet in place', (tester) async {
    await openSheet(tester, drag: false);
    final origin = tester.getTopLeft(find.byType(DievasBottomSheet));
    await tester.dragFrom(origin + const Offset(120, 20), const Offset(0, 260));
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(find.byType(DievasBottomSheet)), origin);
  });

  testWidgets('scrolling a list preserves header and hands downward drags at the top to sheet', (tester) async {
    await openSheet(
      tester,
      resize: false,
      builder: (_) => DievasBottomSheet(
        title: 'Pinned header',
        child: ListView.builder(itemCount: 50, itemBuilder: (_, index) => ListTile(title: Text('Row $index'))),
      ),
    );
    final origin = tester.getTopLeft(find.byType(DievasBottomSheet));
    final header = tester.getTopLeft(find.text('Pinned header'));
    await tester.drag(find.byType(ListView), const Offset(0, -200));
    await tester.pumpAndSettle();
    expect(find.byType(DievasBottomSheet), findsOneWidget);
    expect(tester.getTopLeft(find.text('Pinned header')), header);
    final scrollable = tester.state<ScrollableState>(
      find.descendant(of: find.byType(ListView), matching: find.byType(Scrollable)),
    );
    scrollable.position.jumpTo(0);
    await tester.pump();
    await tester.timedDrag(find.byType(ListView), const Offset(0, 240), const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.byType(DievasBottomSheet), findsNothing);
    expect(origin.dy, greaterThan(0));
    expect(tester.takeException(), isNull);
  });

  testWidgets('keyboard insets reduce available height and keep content above keyboard', (tester) async {
    await openSheet(tester);
    tester.view.viewInsets = FakeViewPadding(bottom: 200 * tester.view.devicePixelRatio);
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpAndSettle();
    final bounds = tester.getRect(find.byType(DievasBottomSheet));
    expect(bounds.bottom, closeTo(400, 1));
    expect(bounds.height, closeTo(400 * 0.64, 1));
  });

  testWidgets('zero-duration transitions open and close without pending animation', (tester) async {
    await openSheet(tester, reducedMotion: true);
    expect(find.byType(DievasBottomSheet), findsOneWidget);
    expect(ModalRoute.of(tester.element(find.byType(DievasBottomSheet)))?.transitionDuration, Duration.zero);
    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(find.byType(DievasBottomSheet), findsNothing);
  });

  testWidgets('caller-local Dievas theme survives opening through a root navigator', (tester) async {
    final custom = DievasLightThemeData();
    final changed = custom.copyWith(
      components: custom.components.copyWith(
        bottomSheet: custom.components.bottomSheet.copyWith(backgroundColour: Colors.pink),
      ),
    );
    await tester.pumpWidget(
      Harness(
        child: DievasTheme(
          data: changed,
          child: Builder(
            builder: (context) => TextButton(
              onPressed: () => showDievasBottomSheet(
                context: context,
                useRootNavigator: true,
                builder: (context) {
                  expect(DievasTheme.componentsOf(context).bottomSheet.backgroundColour, Colors.pink);
                  return const DievasBottomSheet(child: Text('Local theme'));
                },
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Local theme'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('custom thresholds and fast flings trigger different dismissal paths', (tester) async {
    await openSheet(tester, threshold: 0.9);
    await tester.timedDragFrom(
      tester.getTopLeft(find.byType(DievasBottomSheet)) + const Offset(120, 20),
      const Offset(0, 80),
      const Duration(seconds: 2),
    );
    await tester.pumpAndSettle();
    expect(find.byType(DievasBottomSheet), findsNothing);
    await openSheet(tester, threshold: 0.1);
    await tester.flingFrom(
      tester.getTopLeft(find.byType(DievasBottomSheet)) + const Offset(120, 20),
      const Offset(0, 80),
      1500,
    );
    await tester.pumpAndSettle();
    expect(find.byType(DievasBottomSheet), findsNothing);
  });

  testWidgets('root navigator option chooses the correct overlay bounds', (tester) async {
    for (final root in [false, true]) {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            height: 300,
            child: Navigator(
              pages: [
                MaterialPage(
                  child: Builder(
                    builder: (context) => TextButton(
                      onPressed: () => showDievasBottomSheet(
                        context: context,
                        useRootNavigator: root,
                        heightFactor: 0.5,
                        builder: (_) => const DievasBottomSheet(showCloseButton: true, child: SizedBox.expand()),
                      ),
                      child: const Text('Open'),
                    ),
                  ),
                ),
              ],
              onDidRemovePage: (_) {},
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(DievasBottomSheet)).height, root ? 300 : 150);
      await tester.tap(find.byTooltip('Close'));
      await tester.pumpAndSettle();
    }
  });
  testWidgets('close button has a filled circle, centered title and shared horizontal insets', (tester) async {
    await openSheet(
      tester,
      builder: (_) => const DievasBottomSheet(
        title: 'Header',
        showCloseButton: true,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListTile(title: Text('Body')),
      ),
    );
    final bounds = tester.getRect(find.byType(DievasBottomSheet));
    expect(tester.getTopLeft(find.text('Body')).dx, bounds.left + 20);
    expect(tester.getRect(find.byType(NavigationToolbar)).left, bounds.left + 20);
    expect(tester.getRect(find.byType(NavigationToolbar)).right, bounds.right - 20);
    final button = tester.widget<DievasIconButton>(find.byType(DievasIconButton));
    expect(button.backgroundColor, isNotNull);
    expect(button.shape, isA<CircleBorder>());
    expect(tester.getCenter(find.text('Header')).dx, tester.getCenter(find.byType(DievasBottomSheet)).dx);
  });

  testWidgets('custom trailing replaces close action while keeping title centered', (tester) async {
    await openSheet(
      tester,
      builder: (context) => DievasBottomSheet(
        title: 'Header',
        showCloseButton: true,
        trailing: TextButton(onPressed: () => closeDievasBottomSheet(context), child: const Text('Finish')),
        child: const SizedBox.expand(),
      ),
    );
    expect(find.byTooltip('Close'), findsNothing);
    expect(tester.getCenter(find.text('Header')).dx, tester.getCenter(find.byType(DievasBottomSheet)).dx);
    await tester.tap(find.text('Finish'));
    await tester.pumpAndSettle();
    expect(find.byType(DievasBottomSheet), findsNothing);
  });

  testWidgets('upward dragging expands to 90 percent and downward dragging restores initial size', (tester) async {
    await openSheet(tester);
    final initial = tester.getSize(find.byType(DievasBottomSheet)).height;
    final start = tester.getTopLeft(find.byType(DievasBottomSheet)) + const Offset(120, 20);
    await tester.timedDragFrom(start, const Offset(0, -300), const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byType(DievasBottomSheet)).height, closeTo(540, 1));
    expect(find.byType(DievasBottomSheet), findsOneWidget);
    await tester.timedDragFrom(
      tester.getTopLeft(find.byType(DievasBottomSheet)) + const Offset(120, 20),
      Offset(0, 540 - initial),
      const Duration(seconds: 2),
    );
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byType(DievasBottomSheet)).height, closeTo(initial, 3));
  });

  testWidgets('fit content ignores initial height and wraps a short list with header and footer', (tester) async {
    await openSheet(
      tester,
      fitContent: true,
      builder: (_) => DievasBottomSheet(
        title: 'Small sheet',
        showCloseButton: true,
        footer: const Text('Footer'),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: const [
            ListTile(title: Text('One')),
            ListTile(title: Text('Two')),
          ],
        ),
      ),
    );
    expect(tester.getSize(find.byType(DievasBottomSheet)).height, lessThan(300));
    expect(find.text('Footer'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('list drags expand before scrolling and content scrolls when maximum is reached', (tester) async {
    await openSheet(
      tester,
      builder: (_) => DievasBottomSheet(
        title: 'Resizable list',
        child: ListView.builder(itemCount: 50, itemBuilder: (_, index) => ListTile(title: Text('Row $index'))),
      ),
    );
    final scrollable = tester.state<ScrollableState>(
      find.descendant(of: find.byType(ListView), matching: find.byType(Scrollable)),
    );
    await tester.timedDrag(find.byType(ListView), const Offset(0, -100), const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byType(DievasBottomSheet)).height, greaterThan(384));
    expect(scrollable.position.pixels, 0);
    await tester.timedDrag(find.byType(ListView), const Offset(0, -300), const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byType(DievasBottomSheet)).height, closeTo(540, 1));
    expect(scrollable.position.pixels, greaterThan(0));
    expect(tester.takeException(), isNull);
  });

  testWidgets('upward resize can be disabled independently of drag dismissal', (tester) async {
    await openSheet(tester, resize: false);
    final initial = tester.getSize(find.byType(DievasBottomSheet)).height;
    await tester.timedDragFrom(
      tester.getTopLeft(find.byType(DievasBottomSheet)) + const Offset(120, 20),
      const Offset(0, -200),
      const Duration(seconds: 2),
    );
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byType(DievasBottomSheet)).height, initial);
  });
  testWidgets('resize cap respects the safe viewport and content-fit long lists remain bounded', (tester) async {
    tester.view.viewPadding = FakeViewPadding(
      top: 60 * tester.view.devicePixelRatio,
      bottom: 20 * tester.view.devicePixelRatio,
    );
    tester.view.padding = tester.view.viewPadding;
    addTearDown(tester.view.resetViewPadding);
    addTearDown(tester.view.resetPadding);
    await openSheet(
      tester,
      fitContent: true,
      builder: (_) => DievasBottomSheet(
        title: 'Bounded content',
        showCloseButton: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 50,
          itemBuilder: (_, index) => ListTile(title: Text('Row $index')),
        ),
      ),
    );
    final rect = tester.getRect(find.byType(ClipRRect));
    expect(rect.height, closeTo((600 - 60) * 0.9, 1));
    expect(rect.top, greaterThanOrEqualTo(60));
    expect(tester.takeException(), isNull);
  });
}
