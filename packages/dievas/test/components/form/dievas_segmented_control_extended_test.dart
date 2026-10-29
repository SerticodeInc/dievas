import 'package:dievas/dievas.dart';
import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

const _options = ['One', 'Two', 'Three'];

void main() {
  testWidgets('selection remains controlled and repeated activation is silent', (tester) async {
    String selected = 'One';
    int calls = 0;
    await tester.pumpWidget(
      Harness(
        child: StatefulBuilder(
          builder: (context, setState) => Center(
            child: DievasSegmentedControl<String>(
              options: _options,
              value: selected,
              onChanged: (value) => setState(() {
                selected = value;
                calls++;
              }),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('One'));
    await tester.pumpAndSettle();
    expect(calls, 0);
    await tester.tap(find.text('Two'));
    await tester.pumpAndSettle();
    expect(selected, 'Two');
    expect(calls, 1);
  });

  for (final size in DievasSegmentedControlSize.values) {
    testWidgets('${size.name} uses preset height and expanded segments fill available width', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: Center(
            child: SizedBox(
              width: 300,
              child: DievasSegmentedControl<String>(
                options: _options,
                value: 'One',
                size: size,
                isExpanded: true,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );
      final control = find.byType(DievasSegmentedControl<String>);
      expect(tester.getSize(control), Size(300, size == DievasSegmentedControlSize.sm ? 40 : 48));
      final first = tester.getRect(find.byKey(const ValueKey('One')));
      final second = tester.getRect(find.byKey(const ValueKey('Two')));
      expect(first.width, closeTo(second.width, 0.01));
      expect(second.left - first.right, closeTo(4, 0.01));
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('arrow keys respect RTL, skip disabled segments and support Home and End', (tester) async {
    String selected = 'One';
    final firstNode = FocusNode();
    addTearDown(firstNode.dispose);
    await tester.pumpWidget(
      Harness(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: StatefulBuilder(
            builder: (context, setState) => Center(
              child: DievasSegmentedControl<String>(
                value: selected,
                onChanged: (value) => setState(() => selected = value),
                segments: [
                  DievasSegment(value: 'One', label: const Text('One'), focusNode: firstNode),
                  const DievasSegment(value: 'Two', label: Text('Two'), enabled: false),
                  const DievasSegment(value: 'Three', label: Text('Three')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    firstNode.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    await tester.pumpAndSettle();
    expect(selected, 'Three');
    await tester.sendKeyEvent(LogicalKeyboardKey.home);
    await tester.pumpAndSettle();
    expect(selected, 'One');
    await tester.sendKeyEvent(LogicalKeyboardKey.end);
    await tester.pumpAndSettle();
    expect(selected, 'Three');
    await tester.pumpWidget(const SizedBox());
    firstNode.requestFocus(); // The caller-owned node remains usable after removal.
  });

  testWidgets('controller synchronizes external and pointer changes and survives replacement', (tester) async {
    final first = TabController(length: 3, vsync: tester);
    final second = TabController(length: 3, vsync: tester, initialIndex: 1);
    addTearDown(first.dispose);
    addTearDown(second.dispose);
    TabController current = first;
    final changes = <String>[];
    late StateSetter update;
    await tester.pumpWidget(
      Harness(
        child: StatefulBuilder(
          builder: (context, setState) {
            update = setState;
            return Center(
              child: DievasSegmentedControl<String>(
                options: _options,
                value: 'One',
                tabController: current,
                onChanged: changes.add,
              ),
            );
          },
        ),
      ),
    );
    first.animateTo(2);
    await tester.pumpAndSettle();
    expect(changes, ['Three']);
    await tester.tap(find.text('Two'));
    await tester.pumpAndSettle();
    expect(first.index, 1);
    expect(changes.last, 'Two');
    update(() => current = second);
    await tester.pumpAndSettle();
    final count = changes.length;
    first.animateTo(0);
    await tester.pumpAndSettle();
    expect(changes.length, count);
    await tester.pumpWidget(const SizedBox());
    second.index = 2;
    expect(tester.takeException(), isNull);
  });

  testWidgets('custom segments inherit style, expose semantics and cannot activate when disabled', (tester) async {
    int activations = 0;
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasSegmentedControl<int>(
            value: 1,
            enabled: false,
            onChanged: (_) => activations++,
            segments: const [DievasSegment(value: 1, leading: Icon(Icons.star), semanticLabel: 'Star')],
            segmentBuilder: (context, value, selected) =>
                TextButton(onPressed: () => activations++, child: const Text('Custom')),
          ),
        ),
      ),
    );
    await tester.tapAt(tester.getCenter(find.byType(DievasSegmentedControl<int>)));
    await tester.pumpAndSettle();
    expect(activations, 0);
    expect(find.bySemanticsLabel('Star'), findsOneWidget);
    semantics.dispose();
    expect(tester.takeException(), isNull);
  });

  testWidgets('custom content leaves selection gestures with the segment', (tester) async {
    int selected = 1;
    int childTaps = 0;
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasSegmentedControl<int>(
            options: const [1, 2],
            value: selected,
            onChanged: (value) => selected = value,
            segmentBuilder: (context, value, selected) =>
                TextButton(onPressed: () => childTaps++, child: Text('$value')),
          ),
        ),
      ),
    );
    await tester.tapAt(tester.getCenter(find.byKey(const ValueKey(2))));
    await tester.pumpAndSettle();
    expect(selected, 2);
    expect(childTaps, 0);
  });

  testWidgets('narrow natural-width controls scroll instead of overflowing', (tester) async {
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: SizedBox(
            width: 120,
            child: DievasSegmentedControl<String>(options: _options, value: 'One', onChanged: (_) {}),
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    await tester.drag(find.byType(SingleChildScrollView), const Offset(-200, 0));
    await tester.pumpAndSettle();
    expect(
      tester.getRect(find.text('Three')).right,
      lessThanOrEqualTo(tester.getRect(find.byType(DievasSegmentedControl<String>)).right),
    );
  });

  testWidgets('reduced motion disables both surface and foreground transitions', (tester) async {
    await tester.pumpWidget(
      Harness(
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: Center(
            child: DievasSegmentedControl<String>(options: _options, value: 'One', onChanged: (_) {}),
          ),
        ),
      ),
    );
    final control = find.byType(DievasSegmentedControl<String>);
    for (final surface in tester.widgetList<AnimatedContainer>(
      find.descendant(of: control, matching: find.byType(AnimatedContainer)),
    )) {
      expect(surface.duration, Duration.zero);
    }
    for (final text in tester.widgetList<AnimatedDefaultTextStyle>(
      find.descendant(of: control, matching: find.byType(AnimatedDefaultTextStyle)),
    )) {
      expect(text.duration, Duration.zero);
    }
  });

  test('brand application preserves custom neutral segment colours in both themes', () {
    for (final theme in [DievasLightThemeData(), DievasDarkThemeData()]) {
      final custom = theme.colours.copyWith(
        action: theme.colours.action.copyWith(
          segmentedControlSelectedBackground: Colors.teal,
          segmentedControlSelectedText: Colors.yellow,
        ),
      );
      final branded = applyBrandPalette(custom, DievasBrandPalettes.amber);
      expect(branded.action.segmentedControlSelectedBackground, Colors.teal);
      expect(branded.action.segmentedControlSelectedText, Colors.yellow);
    }
    final theme = DievasLightThemeData().components.segmentedControl;
    expect(theme.copyWith(), theme);
    expect(theme.copyWith(gap: 12, containerPadding: EdgeInsets.zero), isNot(theme));
  });
}
