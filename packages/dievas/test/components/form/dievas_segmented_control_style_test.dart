// Compatibility cases intentionally exercise the deprecated constructor inputs.
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

import 'package:dievas/dievas.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

const _border = Border.fromBorderSide(BorderSide(color: Colors.purple));
const _radius = BorderRadiusDirectional.only(topStart: Radius.circular(12), bottomEnd: Radius.circular(4));

void main() {
  testWidgets('partial decorations retain theme fills and local text overrides win', (tester) async {
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasSegmentedControl<String>(
            value: 'One',
            onChanged: (_) {},
            style: const DievasSegmentedControlStyle(
              decoration: BoxDecoration(border: _border),
              padding: EdgeInsets.all(8),
              gap: 10,
              segmentStyle: DievasSegmentStyle(
                appearance: DievasSegmentAppearance(
                  decoration: BoxDecoration(border: _border, borderRadius: _radius),
                  textStyle: TextStyle(fontSize: 18, color: Colors.red),
                ),
                selected: DievasSegmentAppearance(textStyle: TextStyle(color: Colors.green)),
              ),
            ),
            segments: const [
              DievasSegment(
                value: 'One',
                label: Text('One'),
                leading: Icon(Icons.star),
                style: DievasSegmentStyle(
                  selected: DievasSegmentAppearance(textStyle: TextStyle(color: Colors.blue)),
                ),
              ),
              DievasSegment(value: 'Two', label: Text('Two')),
            ],
          ),
        ),
      ),
    );
    final context = tester.element(find.text('One'));
    final theme = DievasTheme.componentsOf(context).segmentedControl;
    final outer = tester.widget<DecoratedBox>(
      find.descendant(of: find.byType(DievasSegmentedControl<String>), matching: find.byType(DecoratedBox)).first,
    );
    expect(outer.decoration, BoxDecoration(color: theme.bgColour, borderRadius: theme.borderRadius, border: _border));
    expect(
      _surface(tester, 'One').decoration,
      BoxDecoration(color: theme.selectedBgColour, border: _border, borderRadius: _radius),
    );
    expect(_surface(tester, 'Two').decoration, const BoxDecoration(border: _border, borderRadius: _radius));
    expect(DefaultTextStyle.of(context).style.color, Colors.blue);
    expect(DefaultTextStyle.of(context).style.fontSize, 18);
    expect(IconTheme.of(tester.element(find.byIcon(Icons.star))).color, Colors.blue);
    expect(DefaultTextStyle.of(tester.element(find.text('Two'))).style.color, Colors.red);
    expect(
      tester.getRect(find.byKey(const ValueKey('Two'))).left - tester.getRect(find.byKey(const ValueKey('One'))).right,
      10,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('selected, hover and press appearances resolve independently', (tester) async {
    String selected = 'One';
    await tester.pumpWidget(
      Harness(
        child: StatefulBuilder(
          builder: (context, setState) => Center(
            child: DievasSegmentedControl<String>(
              options: const ['One', 'Two'],
              value: selected,
              onChanged: (value) => setState(() => selected = value),
              style: const DievasSegmentedControlStyle(
                segmentStyle: DievasSegmentStyle(
                  appearance: DievasSegmentAppearance(
                    decoration: BoxDecoration(border: _border),
                    textStyle: TextStyle(color: Colors.red),
                  ),
                  selected: DievasSegmentAppearance(
                    decoration: BoxDecoration(color: Colors.green),
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  hovered: DievasSegmentAppearance(decoration: BoxDecoration(color: Colors.yellow)),
                  pressed: DievasSegmentAppearance(
                    decoration: BoxDecoration(color: Colors.blue),
                    textStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: Offset.zero);
    addTearDown(mouse.removePointer);
    await mouse.moveTo(tester.getCenter(find.text('Two')));
    await tester.pumpAndSettle();
    expect(selected, 'One');
    expect(_box(tester, 'Two').color, Colors.yellow);
    expect(_box(tester, 'Two').border, _border);
    expect(DefaultTextStyle.of(tester.element(find.text('Two'))).style.color, Colors.red);
    await mouse.down(tester.getCenter(find.text('Two')));
    await tester.pump(const Duration(milliseconds: 150));
    await tester.pumpAndSettle();
    expect(_box(tester, 'Two').color, Colors.blue);
    expect(DefaultTextStyle.of(tester.element(find.text('Two'))).style.color, Colors.black);
    await mouse.up();
    await mouse.moveTo(Offset.zero);
    await tester.pumpAndSettle();
    expect(selected, 'Two');
    expect(_box(tester, 'Two').color, Colors.green);
    expect(DefaultTextStyle.of(tester.element(find.text('Two'))).style.color, Colors.white);
    expect(DefaultTextStyle.of(tester.element(find.text('One'))).style.color, Colors.red);
  });

  testWidgets('default hover retains unselected foreground', (tester) async {
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasSegmentedControl<String>(options: const ['One', 'Two'], value: 'One', onChanged: (_) {}),
        ),
      ),
    );
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: Offset.zero);
    addTearDown(mouse.removePointer);
    await mouse.moveTo(tester.getCenter(find.text('Two')));
    await tester.pumpAndSettle();
    final context = tester.element(find.text('Two'));
    expect(_box(tester, 'Two').color, DievasTheme.coloursOf(context).background.menuHoveredBackground);
    expect(DefaultTextStyle.of(context).style.color, DievasTheme.componentsOf(context).segmentedControl.textColour);
  });

  for (final circle in [false, true]) {
    testWidgets('focus follows ${circle ? 'circular' : 'directional'} decoration across layers', (tester) async {
      final focus = FocusNode();
      addTearDown(focus.dispose);
      await tester.pumpWidget(
        Harness(
          child: Directionality(
            textDirection: .rtl,
            child: Center(
              child: DievasSegmentedControl<String>(
                value: 'One',
                onChanged: (_) {},
                style: DievasSegmentedControlStyle(
                  segmentStyle: DievasSegmentStyle(
                    appearance: DievasSegmentAppearance(
                      decoration: circle
                          ? const BoxDecoration(shape: BoxShape.circle)
                          : const BoxDecoration(borderRadius: _radius),
                    ),
                    selected: const DievasSegmentAppearance(decoration: BoxDecoration(color: Colors.green)),
                  ),
                ),
                segments: [
                  DievasSegment(
                    value: 'One',
                    label: const Text('One'),
                    focusNode: focus,
                    style: const DievasSegmentStyle(
                      appearance: DievasSegmentAppearance(decoration: BoxDecoration(border: _border)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      focus.requestFocus();
      await tester.pumpAndSettle();
      final surface = _surface(tester, 'One');
      switch ((surface.decoration, surface.foregroundDecoration)) {
        case (
          BoxDecoration(:final shape, :final borderRadius),
          BoxDecoration(shape: final focusShape, borderRadius: final focusRadius),
        ):
          expect(shape, circle ? BoxShape.circle : BoxShape.rectangle);
          expect(focusShape, shape);
          expect(focusRadius, borderRadius);
          expect(borderRadius, circle ? null : _radius);
        default:
          fail('Expected box surface and focus outline');
      }
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('icon override and disabled custom content retain shared typography and reduced motion', (tester) async {
    await tester.pumpWidget(
      Harness(
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: Center(
            child: DievasSegmentedControl<String>(
              value: 'One',
              enabled: false,
              style: const DievasSegmentedControlStyle(
                transitionDuration: Duration(seconds: 1),
                segmentStyle: DievasSegmentStyle(
                  appearance: DievasSegmentAppearance(
                    textStyle: TextStyle(color: Colors.blue, fontSize: 18),
                    iconColour: Colors.orange,
                  ),
                ),
              ),
              segments: const [DievasSegment(value: 'One', label: Text('Unused'))],
              segmentBuilder: (context, value, selected) =>
                  const Row(mainAxisSize: .min, children: [Icon(Icons.star), Text('Custom')]),
            ),
          ),
        ),
      ),
    );
    expect(DefaultTextStyle.of(tester.element(find.text('Custom'))).style.color, Colors.blue);
    expect(DefaultTextStyle.of(tester.element(find.text('Custom'))).style.fontSize, 18);
    expect(IconTheme.of(tester.element(find.byIcon(Icons.star))).color, Colors.orange);
    expect(_surface(tester, 'One').duration, Duration.zero);
    expect(
      tester
          .widget<AnimatedDefaultTextStyle>(
            find.descendant(of: find.byKey(const ValueKey('One')), matching: find.byType(AnimatedDefaultTextStyle)),
          )
          .duration,
      Duration.zero,
    );
  });

  testWidgets('state shape changes snap safely without remounting custom content', (tester) async {
    String selected = 'One';
    await tester.pumpWidget(
      Harness(
        child: StatefulBuilder(
          builder: (context, setState) => Center(
            child: DievasSegmentedControl<String>(
              options: const ['One', 'Two'],
              value: selected,
              onChanged: (value) => setState(() => selected = value),
              style: const DievasSegmentedControlStyle(
                transitionDuration: Duration(milliseconds: 200),
                segmentStyle: DievasSegmentStyle(
                  appearance: DievasSegmentAppearance(decoration: BoxDecoration(borderRadius: _radius)),
                  selected: DievasSegmentAppearance(decoration: BoxDecoration(shape: BoxShape.circle)),
                ),
              ),
              segmentBuilder: (context, value, selected) => Text(value, key: ValueKey('content-$value')),
            ),
          ),
        ),
      ),
    );
    final original = tester.element(find.byKey(const ValueKey('content-One')));
    await tester.tapAt(tester.getCenter(find.byKey(const ValueKey('Two'))));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));
    expect(tester.takeException(), isNull);
    expect(selected, 'Two');
    expect(_box(tester, 'One').shape, BoxShape.rectangle);
    expect(_box(tester, 'Two').shape, BoxShape.circle);
    expect(tester.element(find.byKey(const ValueKey('content-One'))), same(original));
    await tester.pumpAndSettle();
    await tester.tapAt(tester.getCenter(find.byKey(const ValueKey('One'))));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));
    expect(tester.takeException(), isNull);
    expect(_box(tester, 'One').shape, BoxShape.circle);
    expect(_box(tester, 'Two').shape, BoxShape.rectangle);
  });

  testWidgets('legacy non-box decoration survives an empty local style layer', (tester) async {
    const decoration = ShapeDecoration(color: Colors.orange, shape: StadiumBorder());
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasSegmentedControl<String>(
            value: 'One',
            style: const DievasSegmentedControlStyle(segmentStyle: DievasSegmentStyle(decoration: decoration)),
            segments: const [DievasSegment(value: 'One', label: Text('One'))],
          ),
        ),
      ),
    );
    expect(_surface(tester, 'One').decoration, decoration);
  });

  testWidgets('legacy border keeps selected fill and state text colour beats textStyle.color', (tester) async {
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasSegmentedControl<String>(
            value: 'One',
            backgroundColour: Colors.orange,
            decoration: const BoxDecoration(border: _border),
            selectedSegmentColour: Colors.green,
            segments: const [
              DievasSegment(
                value: 'One',
                label: Text('One'),
                style: DievasSegmentStyle(
                  decoration: BoxDecoration(border: _border),
                  textStyle: TextStyle(color: Colors.red),
                  selectedTextColour: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    expect(_box(tester, 'One').color, Colors.green);
    expect(_box(tester, 'One').border, _border);
    expect(DefaultTextStyle.of(tester.element(find.text('One'))).style.color, Colors.blue);
    expect(tester.takeException(), isNull);
  });
}

AnimatedContainer _surface(WidgetTester tester, String value) => tester.widget<AnimatedContainer>(
  find.descendant(of: find.byKey(ValueKey(value)), matching: find.byType(AnimatedContainer)).first,
);

BoxDecoration _box(WidgetTester tester, String value) => switch (_surface(tester, value).decoration) {
  final BoxDecoration decoration => decoration,
  _ => throw StateError('Expected box decoration'),
};
