import 'dart:ui' show PointerDeviceKind, Tristate;

import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart' show TabController;
import 'package:flutter/services.dart';
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
      int selected = 0;
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

  for (final size in DievasTabBarSize.values) {
    testWidgets('${size.name} matches reference height and expanded widths', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: Center(
            child: SizedBox(
              width: 300,
              child: DievasTabBar(tabs: const ['A', 'B', 'C'], tabBarSize: size, isExpanded: true, onChanged: (_) {}),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final height = tester.getSize(find.byType(DievasTabBar)).height;
      expect(height, size == DievasTabBarSize.sm ? 32 : 40);
      await tester.tap(find.text('C'));
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('disabled custom content cannot handle pointer events', (tester) async {
    int calls = 0;
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasTabBar(
            variant: .custom,
            onChanged: (_) => calls++,
            items: [
              const DievasTab(label: Text('A')),
              DievasTab(
                enabled: false,
                semanticLabel: 'Disabled',
                builder: (context, selected) => GestureDetector(onTap: () => calls++, child: const Text('Blocked')),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.tap(find.text('Blocked'));
    expect(calls, 0);
  });

  for (final rtl in [false, true]) {
    testWidgets('keyboard skips disabled tabs in ${rtl ? 'RTL' : 'LTR'}', (tester) async {
      final first = FocusNode();
      final last = FocusNode();
      addTearDown(first.dispose);
      addTearDown(last.dispose);
      int selected = 0;
      await tester.pumpWidget(
        Harness(
          child: Directionality(
            textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
            child: Center(
              child: StatefulBuilder(
                builder: (context, setState) => DievasTabBar(
                  selectedIndex: selected,
                  onChanged: (index) => setState(() => selected = index),
                  items: [
                    DievasTab(label: const Text('A'), focusNode: first),
                    const DievasTab(label: Text('B'), enabled: false),
                    DievasTab(label: const Text('C'), focusNode: last),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      first.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(rtl ? LogicalKeyboardKey.arrowLeft : LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();
      expect(selected, 2);
      expect(last.hasFocus, isTrue);
      await tester.sendKeyEvent(LogicalKeyboardKey.home);
      await tester.pumpAndSettle();
      expect(selected, 0);
      await tester.sendKeyEvent(LogicalKeyboardKey.end);
      await tester.pumpAndSettle();
      expect(selected, 2);
    });
  }

  testWidgets('Enter and Space request selection while controlled values stay authoritative', (tester) async {
    final node = FocusNode();
    addTearDown(node.dispose);
    final requests = <int>[];
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasTabBar(
            selectedIndex: 0,
            onChanged: requests.add,
            items: [
              const DievasTab(label: Text('A')),
              DievasTab(label: const Text('B'), focusNode: node),
            ],
          ),
        ),
      ),
    );
    node.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    expect(requests, [1, 1]);
    expect(tester.widget<DievasTabBar>(find.byType(DievasTabBar)).selectedIndex, 0);
    await tester.pumpWidget(const SizedBox());
    expect(() => node.addListener(() {}), returnsNormally);
  });

  testWidgets('controller precedence, replacement, notification and ownership', (tester) async {
    final vsync = TestVSync();
    final first = TabController(length: 3, initialIndex: 1, vsync: vsync);
    final second = TabController(length: 3, vsync: vsync);
    addTearDown(first.dispose);
    addTearDown(second.dispose);
    final requests = <int>[];
    await tester.pumpWidget(
      Harness(
        child: DievasTabBar(
          tabs: const ['A', 'B', 'C'],
          selectedIndex: 0,
          tabController: first,
          onChanged: requests.add,
        ),
      ),
    );
    await tester.pumpAndSettle();
    final indicator = find.byKey(const ValueKey('dievas_tab_bar_indicator'));
    expect((tester.getRect(indicator).center.dx - tester.getRect(find.text('B')).center.dx).abs(), lessThan(1));
    await tester.tap(find.text('C'));
    await tester.pumpAndSettle();
    expect(first.index, 2);
    expect(requests, [2]);
    await tester.pumpWidget(
      Harness(
        child: DievasTabBar(tabs: const ['A', 'B', 'C'], tabController: second, onChanged: requests.add),
      ),
    );
    await tester.pumpAndSettle();
    first.index = 0;
    await tester.pumpAndSettle();
    expect(requests, [2]);
    second.index = 1;
    await tester.pumpAndSettle();
    expect(requests, [2, 1]);
    await tester.pumpWidget(const SizedBox());
    expect(() => second.index = 2, returnsNormally);
  });

  testWidgets('pill selection uses a neutral surface with no underline', (tester) async {
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasTabBar(tabs: const ['A', 'B'], selectedIndex: 1, variant: .pill, onChanged: (_) {}),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('dievas_tab_bar_indicator')), findsNothing);
    final selected = tester.widget<AnimatedContainer>(
      find.ancestor(of: find.text('B'), matching: find.byType(AnimatedContainer)).first,
    );
    expect(
      selected.decoration,
      isA<BoxDecoration>().having((value) => value.color, 'selected surface', const Color(0xFFFFFFFF)),
    );
  });

  testWidgets('selected semantics and per-tab styling survive shared overrides', (tester) async {
    final semantics = tester.ensureSemantics();
    try {
      const local = Color(0xFF123456);
      await tester.pumpWidget(
        Harness(
          child: Center(
            child: DievasTabBar(
              selectedIndex: 1,
              onChanged: (_) {},
              tabStyle: const DievasTabStyle(selectedTextColour: Color(0xFF654321)),
              items: const [
                DievasTab(label: Text('A')),
                DievasTab(
                  label: Text('B'),
                  semanticLabel: 'Activity',
                  style: DievasTabStyle(selectedTextColour: local),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final style = tester.widget<AnimatedDefaultTextStyle>(
        find.ancestor(of: find.text('B'), matching: find.byType(AnimatedDefaultTextStyle)).first,
      );
      expect(style.style.color, local);
      expect(
        tester.getSemantics(find.bySemanticsLabel('Activity')).getSemanticsData().flagsCollection.isSelected,
        Tristate.isTrue,
      );
    } finally {
      semantics.dispose();
    }
  });

  testWidgets('narrow RTL tabs scroll selected content into view with reduced motion', (tester) async {
    int selected = 0;
    late StateSetter update;
    await tester.pumpWidget(
      Harness(
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: Directionality(
            textDirection: .rtl,
            child: Center(
              child: SizedBox(
                width: 120,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    update = setState;
                    return DievasTabBar(
                      tabs: const ['First long tab', 'Second long tab', 'Third long tab'],
                      selectedIndex: selected,
                      onChanged: (index) => setState(() => selected = index),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    update(() => selected = 2);
    await tester.pumpAndSettle();
    final viewport = tester.getRect(find.byType(DievasTabBar));
    expect(viewport.overlaps(tester.getRect(find.text('Third long tab'))), isTrue);
    expect(tester.hasRunningAnimations, isFalse);
    expect(tester.takeException(), isNull);
  });

  test('tab theme copies preserve additional geometry and appearance', () {
    final theme = DievasLightThemeData().components.tabBar;
    expect(theme.copyWith(), theme);
    final changed = theme.copyWith(gap: 12, showDivider: true, smallHeight: 36);
    expect(changed.gap, 12);
    expect(changed.showDivider, isTrue);
    expect(changed.smallHeight, 36);
    expect(changed, isNot(theme));
  });

  testWidgets('disabling the bar dims enabled tabs only once', (tester) async {
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasTabBar(tabs: const ['A', 'B'], enabled: false, onChanged: (_) {}),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final opacity = tester.widgetList<Opacity>(
      find.descendant(of: find.byType(DievasTabBar), matching: find.byType(Opacity)),
    );
    final disabled = DievasLightThemeData().components.tabBar.disabledOpacity;
    expect(opacity.where((widget) => widget.opacity == disabled), hasLength(1));
  });

  for (final fill in [const Color(0xFFFFFFFF), const Color(0xFF8855CC)]) {
    testWidgets('pill hover preserves fill hue through exit and rapid reversal ($fill)', (tester) async {
      final highlightStrategy = FocusManager.instance.highlightStrategy;
      FocusManager.instance.highlightStrategy = FocusHighlightStrategy.alwaysTraditional;
      addTearDown(() => FocusManager.instance.highlightStrategy = highlightStrategy);

      await tester.pumpWidget(
        Harness(
          child: Center(
            child: DievasTabBar(
              tabs: const ['A', 'B'],
              variant: .pill,
              onChanged: (_) {},
              tabStyle: DievasTabStyle(selectedBackgroundColour: fill),
              transitionDuration: const Duration(milliseconds: 200),
              transitionCurve: Curves.linear,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      Color hoveredFill() => switch (tester
          .widget<DecoratedBox>(find.ancestor(of: find.text('B'), matching: find.byType(DecoratedBox)).first)
          .decoration) {
        BoxDecoration(color: final colour?) => colour,
        _ => throw StateError('Expected a pill surface'),
      };
      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(mouse.removePointer);
      await mouse.addPointer(location: Offset.zero);
      await mouse.moveTo(tester.getCenter(find.text('B')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(hoveredFill().a, closeTo(0.5, 0.01));
      expect(hoveredFill().r, closeTo(fill.r, 0.001));
      expect(hoveredFill().g, closeTo(fill.g, 0.001));
      expect(hoveredFill().b, closeTo(fill.b, 0.001));
      await mouse.moveTo(Offset.zero);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(hoveredFill().a, lessThan(0.5));
      expect(hoveredFill().r, closeTo(fill.r, 0.001));
      await mouse.moveTo(tester.getCenter(find.text('B')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(hoveredFill().g, closeTo(fill.g, 0.001));
      expect(hoveredFill().b, closeTo(fill.b, 0.001));
      await mouse.moveTo(Offset.zero);
      await tester.pumpAndSettle();
      expect(hoveredFill().a, 0);
      expect(tester.widget<DievasTabBar>(find.byType(DievasTabBar)).selectedIndex, 0);
      expect(tester.takeException(), isNull);
    });
  }
}
