import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasTag', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTag(label: 'Flutter')));
      expect(tester.takeException(), isNull);
      expect(find.text('Flutter'), findsOneWidget);
    });

    testWidgets('renders all styles', (tester) async {
      for (final style in DievasTagStyle.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasTag(label: style.name, style: style),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders with leading icon', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasTag(label: 'Active', leadingIcon: Icon(Icons.circle, size: 8)),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onPressed callback on tap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        Harness(
          child: DievasTag(label: 'Tap', onPressed: () => tapped = true),
        ),
      );
      await tester.tap(find.text('Tap'));
      expect(tapped, isTrue);
    });

    testWidgets('fires onRemove callback on dismiss tap', (tester) async {
      bool removed = false;
      await tester.pumpWidget(
        Harness(
          child: DievasTag(label: 'Dismiss', onRemove: () => removed = true),
        ),
      );
      await tester.tap(find.byIcon(Icons.close));
      expect(removed, isTrue);
    });

    testWidgets('renders as static when no callbacks', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTag(label: 'Static')));
      expect(tester.takeException(), isNull);
    });

    testWidgets('per-instance backgroundColor overrides style', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasTag(label: 'Colourful', backgroundColor: Colors.purple, foregroundColor: Colors.white),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('Colourful'), findsOneWidget);
    });

    testWidgets('per-instance borderColor applied to outlined style', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasTag(label: 'Bordered', style: DievasTagStyle.outlined, borderColor: Colors.red),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('stable width between filled and outlined styles', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: Row(
            children: [
              DievasTag(label: 'Same', style: DievasTagStyle.filled),
              DievasTag(label: 'Same', style: DievasTagStyle.outlined),
            ],
          ),
        ),
      );
      expect(tester.takeException(), isNull);

      final tags = find.byType(DievasTag);
      expect(tester.getSize(tags.first), tester.getSize(tags.last));
    });

    testWidgets('pill borderRadius resolves correctly', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasTag(label: 'Pill'),
          themeOverrides: (theme) => theme.copyWith(
            components: theme.components.copyWith(
              tag: theme.components.tag.copyWith(borderRadius: DievasTagBorderRadius.pill),
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('Pill'), findsOneWidget);
    });
  });

  for (final entry in const [(DievasTagSize.xxs, 16.0), (DievasTagSize.xs, 24.0), (DievasTagSize.sm, 32.0)]) {
    testWidgets('${entry.$1.name} matches Moon height', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: Center(
            child: DievasTag(label: 'Tag', tagSize: entry.$1),
          ),
        ),
      );
      expect(tester.getSize(find.byType(DievasTag)).height, entry.$2);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('rich label and leading slots override compatibility inputs', (tester) async {
    await tester.pumpWidget(
      Harness(
        child: const Center(
          child: DievasTag(
            label: 'Legacy',
            labelWidget: Text('Custom'),
            leadingIcon: Icon(Icons.star),
            leading: Icon(Icons.circle),
            trailing: Icon(Icons.check),
            textColour: Colors.red,
            iconColour: Colors.green,
          ),
        ),
      ),
    );
    expect(find.text('Legacy'), findsNothing);
    expect(find.text('Custom'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsNothing);
    final labelContext = tester.element(find.text('Custom'));
    final iconContext = tester.element(find.byIcon(Icons.circle));
    expect(DefaultTextStyle.of(labelContext).style.color, Colors.red);
    expect(IconTheme.of(iconContext).color, Colors.green);
  });

  testWidgets('tap and long press report independent actions', (tester) async {
    int taps = 0;
    int holds = 0;
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasTag(label: 'Tag', onPressed: () => taps++, onLongPress: () => holds++),
        ),
      ),
    );
    await tester.tap(find.text('Tag'));
    await tester.longPress(find.text('Tag'));
    expect(taps, 1);
    expect(holds, 1);
  });

  testWidgets('keyboard activation preserves caller-owned focus and removal stays independent', (tester) async {
    final node = FocusNode();
    addTearDown(node.dispose);
    int taps = 0;
    int removals = 0;
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasTag(label: 'Tag', focusNode: node, onPressed: () => taps++, onRemove: () => removals++),
        ),
      ),
    );
    node.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    expect(taps, 1);
    await tester.tap(find.byIcon(Icons.close));
    expect(removals, 1);
    expect(taps, 1);
    Focus.of(tester.element(find.byIcon(Icons.close))).requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    expect(removals, 2);
    expect(taps, 1);
    await tester.pumpWidget(const SizedBox());
    expect(() => node.addListener(() {}), returnsNormally);
  });

  testWidgets('disabled tags suppress all actions including custom children', (tester) async {
    int calls = 0;
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasTag(
            label: 'Tag',
            enabled: false,
            onPressed: () => calls++,
            onLongPress: () => calls++,
            onRemove: () => calls++,
            leading: GestureDetector(onTap: () => calls++, child: const Text('Child')),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Tag'));
    await tester.longPress(find.text('Tag'));
    await tester.tap(find.text('Child'));
    await tester.tap(find.byIcon(Icons.close));
    expect(calls, 0);
  });

  testWidgets('narrow RTL tag resolves directional padding and truncates long labels', (tester) async {
    await tester.pumpWidget(
      Harness(
        child: const Directionality(
          textDirection: .rtl,
          child: Center(
            child: DievasTag(
              label: 'A very long tag label that must fit',
              width: 120,
              padding: EdgeInsetsDirectional.only(start: 12, end: 4),
              borderRadius: DievasTagBorderRadius.rounded(BorderRadiusDirectional.only(topStart: Radius.circular(12))),
              leading: Icon(Icons.star),
            ),
          ),
        ),
      ),
    );
    expect(tester.getSize(find.byType(DievasTag)).width, 120);
    final surface = tester.widget<Container>(
      find.descendant(of: find.byType(DievasTag), matching: find.byType(Container)).first,
    );
    expect(surface.padding?.resolve(TextDirection.rtl).right, 12);
    expect(
      surface.decoration,
      isA<BoxDecoration>().having(
        (box) => box.borderRadius,
        'directional radius',
        const BorderRadius.only(topRight: Radius.circular(12)),
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('custom decoration and theme geometry remain authoritative', (tester) async {
    const decoration = BoxDecoration(color: Colors.blue, shape: BoxShape.circle);
    await tester.pumpWidget(
      Harness(
        themeOverrides: (theme) => theme.copyWith(
          components: theme.components.copyWith(tag: theme.components.tag.copyWith(minHeight: 40, iconSize: 20)),
        ),
        child: const Center(
          child: DievasTag(label: 'Tag', decoration: decoration),
        ),
      ),
    );
    expect(tester.getSize(find.byType(DievasTag)).height, 40);
    final surface = tester.widget<Container>(
      find.descendant(of: find.byType(DievasTag), matching: find.byType(Container)).first,
    );
    expect(surface.decoration, decoration);
  });

  testWidgets('remove semantics remain accessible with a custom tag label', (tester) async {
    final semantics = tester.ensureSemantics();
    try {
      await tester.pumpWidget(
        Harness(
          child: Center(
            child: DievasTag(
              label: 'Legacy',
              semanticLabel: 'Selected language',
              removeSemanticLabel: 'Remove language',
              onRemove: () {},
            ),
          ),
        ),
      );
      expect(find.bySemanticsLabel('Selected language'), findsOneWidget);
      expect(find.bySemanticsLabel('Remove language'), findsOneWidget);
    } finally {
      semantics.dispose();
    }
  });

  test('size presets copy and compare all fields', () {
    final theme = DievasLightThemeData().components.tag;
    final size = DievasTagSizeData(
      height: 24,
      iconSize: 16,
      gap: 2,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      borderRadius: theme.borderRadius,
      textStyle: theme.textStyle,
    );
    expect(size.copyWith(), size);
    final copy = theme.copyWith(xs: size, textColour: Colors.red, iconColour: Colors.blue, disabledOpacity: 0.2);
    expect(copy.copyWith(), copy);
    expect(copy.xs, size);
    expect(copy.textColour, Colors.red);
    expect(copy.iconColour, Colors.blue);
    expect(copy.disabledOpacity, 0.2);
  });
}
