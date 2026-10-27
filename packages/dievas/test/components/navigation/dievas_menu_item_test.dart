import 'dart:ui' show PointerDeviceKind;

import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasMenuItem', () {
    testWidgets('hover uses neutral Moon Heles in both themes and retains overrides', (tester) async {
      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await mouse.addPointer(location: const Offset(799, 599));
      addTearDown(mouse.removePointer);
      for (final (dark, overrideColour, expected) in [
        (false, null, const Color(0x0A000000)),
        (true, null, const Color(0x14FFFFFF)),
        (false, const Color(0xFF00FF00), const Color(0xFF00FF00)),
      ]) {
        await mouse.moveTo(const Offset(799, 599));
        await tester.pumpWidget(
          Harness(
            themeOverrides: (_) => dark ? DievasDarkThemeData() : DievasLightThemeData(),
            child: Center(
              child: DievasMenuItem(label: 'Hover', onTap: () {}, hoverEffectColour: overrideColour),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await mouse.moveTo(tester.getCenter(find.byType(DievasMenuItem)));
        await tester.pumpAndSettle();
        final surface = tester.widget<AnimatedContainer>(
          find.descendant(of: find.byType(DievasMenuItem), matching: find.byType(AnimatedContainer)),
        );
        expect((surface.decoration as BoxDecoration).color, expected);
      }
    });

    testWidgets('keyboard activates long-press-only rows', (tester) async {
      int count = 0;
      final focus = FocusNode();
      addTearDown(focus.dispose);
      await tester.pumpWidget(
        Harness(
          child: DievasMenuItem(label: 'Action', focusNode: focus, onLongPress: () => count++),
        ),
      );
      focus.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      expect(count, 2);
      await tester.longPress(find.text('Action'));
      expect(count, 3);
    });

    testWidgets('child gestures, absorbed gestures and disabled rows', (tester) async {
      int rowTaps = 0;
      int childTaps = 0;
      for (final (absorb, enabled) in [(false, true), (true, true), (false, false)]) {
        await tester.pumpWidget(
          Harness(
            child: DievasMenuItem(
              label: 'Selection',
              enabled: enabled,
              absorbGestures: absorb,
              onTap: () => rowTaps++,
              trailing: DievasCheckbox(value: .unchecked, onChanged: (_) => childTaps++),
            ),
          ),
        );
        await tester.tapAt(tester.getCenter(find.byType(DievasCheckbox)));
        await tester.pump();
      }
      expect(childTaps, 1);
      expect(rowTaps, 1);
    });

    testWidgets('custom slots wrap within a narrow RTL row', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: Directionality(
            textDirection: .rtl,
            child: Center(
              child: SizedBox(
                width: 220,
                child: DievasMenuItem(
                  label: 'Hidden label',
                  subtitle: 'Hidden subtitle',
                  labelWidget: const Text('A long custom label that wraps over several lines'),
                  content: const Text('Custom content'),
                  leadingIcon: const Icon(Icons.person),
                  leading: const Icon(Icons.star),
                  trailing: const Icon(Icons.chevron_left),
                  labelColour: Colors.green,
                ),
              ),
            ),
          ),
        ),
      );
      expect(find.text('Hidden label'), findsNothing);
      expect(find.text('Hidden subtitle'), findsNothing);
      expect(find.byIcon(Icons.person), findsNothing);
      expect(tester.takeException(), isNull);
      expect(DefaultTextStyle.of(tester.element(find.text('Custom content'))).style.color, isNotNull);
      expect(
        tester.getTopLeft(find.byIcon(Icons.star)).dx,
        greaterThan(tester.getTopLeft(find.byIcon(Icons.chevron_left)).dx),
      );
    });

    testWidgets('divider helper omits outer separators', (tester) async {
      expect(DievasMenuItem.divideMenuItems(menuItems: []).toList(), isEmpty);
      await tester.pumpWidget(
        Harness(
          child: Column(
            children: DievasMenuItem.divideMenuItems(
              menuItems: const [
                DievasMenuItem(label: 'One'),
                DievasMenuItem(label: 'Two'),
              ],
            ).toList(),
          ),
        ),
      );
      expect(find.byType(DievasDivider), findsOneWidget);
    });

    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasMenuItem(label: 'Profile')));
      expect(tester.takeException(), isNull);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('renders with leading icon', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasMenuItem(label: 'Settings', leadingIcon: Icon(Icons.settings)),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('renders with subtitle', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasMenuItem(label: 'Delete', subtitle: 'This cannot be undone'),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('This cannot be undone'), findsOneWidget);
    });

    testWidgets('renders with trailing widget', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasMenuItem(label: 'Profile', trailing: Icon(Icons.chevron_right)),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('fires onTap callback', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        Harness(
          child: DievasMenuItem(label: 'Tap me', onTap: () => tapped = true),
        ),
      );
      await tester.tap(find.text('Tap me'));
      expect(tapped, isTrue);
    });

    testWidgets('does not fire onTap when disabled', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        Harness(
          child: DievasMenuItem(label: 'Disabled', onTap: () => tapped = true, enabled: false),
        ),
      );
      await tester.tapAt(tester.getCenter(find.text('Disabled')));
      expect(tapped, isFalse);
    });

    testWidgets('renders dense variant', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasMenuItem(label: 'Dense', dense: true)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders disabled state', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasMenuItem(label: 'Disabled', enabled: false)));
      expect(tester.takeException(), isNull);
    });
  });
}
