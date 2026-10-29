import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  testWidgets('selected radio ignores repeated activation unless toggleable', (tester) async {
    int calls = 0;
    String? result = 'a';
    for (final toggleable in [false, true]) {
      await tester.pumpWidget(
        Harness(
          child: Center(
            child: DievasRadio<String>(
              value: 'a',
              groupValue: 'a',
              toggleable: toggleable,
              onChanged: (value) {
                calls++;
                result = value;
              },
            ),
          ),
        ),
      );
      await tester.tap(find.byType(DievasRadio<String>));
      await tester.pumpAndSettle();
      expect(calls, toggleable ? 1 : 0);
      expect(result, toggleable ? null : 'a');
    }
  });

  testWidgets('controlled group selects, clears and restores through keyboard', (tester) async {
    String? selected = 'a';
    final focus = FocusNode();
    addTearDown(focus.dispose);
    await tester.pumpWidget(
      Harness(
        child: StatefulBuilder(
          builder: (context, setState) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final value in ['a', 'b'])
                  DievasRadio<String>(
                    value: value,
                    groupValue: selected,
                    toggleable: true,
                    focusNode: value == 'b' ? focus : null,
                    onChanged: (value) => setState(() => selected = value),
                    label: value,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('b'));
    await tester.pumpAndSettle();
    expect(selected, 'b');
    focus.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pumpAndSettle();
    expect(selected, isNull);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(selected, 'b');
    expect(tester.takeException(), isNull);
  });

  testWidgets('semantics expose selection, group membership and disabled state', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      const Harness(
        child: DievasRadio<String>(value: 'a', groupValue: 'a', onChanged: null, semanticLabel: 'Option A'),
      ),
    );
    expect(
      tester.getSemantics(find.bySemanticsLabel('Option A')),
      matchesSemantics(
        label: 'Option A',
        hasCheckedState: true,
        isChecked: true,
        hasEnabledState: true,
        isEnabled: false,
        isInMutuallyExclusiveGroup: true,
      ),
    );
    handle.dispose();
  });

  testWidgets('disabled radio blocks pointer and keyboard activation', (tester) async {
    final focus = FocusNode();
    addTearDown(focus.dispose);
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasRadio<String>(value: 'a', groupValue: null, onChanged: null, focusNode: focus),
        ),
      ),
    );
    await tester.tap(find.byType(DievasRadio<String>));
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pumpAndSettle();
    expect(focus.hasFocus, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('40px hit target surrounds a 16px circle and can be removed', (tester) async {
    int calls = 0;
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasRadio<String>(value: 'a', groupValue: null, onChanged: (_) => calls++),
        ),
      ),
    );
    final radio = find.byType(DievasRadio<String>);
    expect(tester.getSize(radio), const Size(40, 40));
    expect(tester.getSize(find.descendant(of: radio, matching: find.byType(CustomPaint))), const Size(16, 16));
    await tester.tapAt(tester.getTopLeft(radio) + const Offset(2, 2));
    expect(calls, 1);
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasRadio<String>(value: 'a', groupValue: null, onChanged: (_) {}, tapAreaSize: 0),
        ),
      ),
    );
    expect(tester.getSize(radio), const Size(16, 16));
  });

  testWidgets('long labels wrap in a narrow RTL row without parent-data errors', (tester) async {
    await tester.pumpWidget(
      Harness(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: SizedBox(
              width: 120,
              child: DievasRadio<String>(
                value: 'a',
                groupValue: null,
                onChanged: (_) {},
                label: 'A long label that wraps across multiple lines',
              ),
            ),
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    final circle = find.descendant(of: find.byType(DievasRadio<String>), matching: find.byType(CustomPaint));
    expect(
      tester.getCenter(circle).dx,
      greaterThan(tester.getCenter(find.text('A long label that wraps across multiple lines')).dx),
    );
  });

  testWidgets('reduced motion settles a changed selection immediately', (tester) async {
    String? selected;
    await tester.pumpWidget(
      Harness(
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: StatefulBuilder(
            builder: (context, setState) => Center(
              child: DievasRadio<String>(
                value: 'a',
                groupValue: selected,
                onChanged: (value) => setState(() => selected = value),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.byType(DievasRadio<String>));
    await tester.pump();
    expect(selected, 'a');
    expect(tester.binding.hasScheduledFrame, isFalse);
  });

  test('default geometry, palette and custom theme copies remain consistent', () {
    final theme = DievasLightThemeData();
    final radio = theme.components.radio;
    expect(radio.size, 16);
    expect(radio.strokeWidth, 1);
    expect(radio.dotSize, 8);
    expect(radio.dotColour, radio.colourSelected);
    expect(radio.copyWith(), radio);
    final changed = radio.copyWith(
      size: 24,
      dotSize: 10,
      colourSelected: const Color(0xFF123456),
      animationDuration: Duration.zero,
      animationCurve: Curves.linear,
    );
    expect(changed, isNot(radio));
    expect(changed.copyWith(), changed);
    expect(changed.size, 24);
  });
}
