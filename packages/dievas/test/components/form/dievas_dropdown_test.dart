import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasDropdown', () {
    testWidgets('default rows need no Material and support Enter and Space', (tester) async {
      for (final key in [LogicalKeyboardKey.enter, LogicalKeyboardKey.space]) {
        String? selected;
        await tester.pumpWidget(
          Harness(
            child: Center(
              child: DievasDropdown<String>(
                show: true,
                options: const ['Alpha', 'Beta'],
                onChanged: (value) => selected = value,
                child: const SizedBox(width: 160, child: Text('Target')),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        final option = find.text('Alpha');
        expect(find.ancestor(of: option, matching: find.byType(Material)), findsNothing);
        expect(find.ancestor(of: option, matching: find.byType(InkWell)), findsNothing);
        final semantics = tester.ensureSemantics();
        expect(
          tester.getSemantics(option),
          matchesSemantics(
            label: 'Alpha',
            isButton: true,
            hasSelectedState: true,
            hasTapAction: true,
            hasFocusAction: true,
            isFocusable: true,
          ),
        );
        semantics.dispose();
        Focus.of(tester.element(option)).requestFocus();
        await tester.pump();
        await tester.sendKeyEvent(key);
        await tester.pumpAndSettle();
        expect(selected, 'Alpha');
        expect(find.text('Alpha'), findsNothing);
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('supports the reference show, child and content composition', (tester) async {
      final show = ValueNotifier(true);
      addTearDown(show.dispose);
      await tester.pumpWidget(
        Harness(
          child: Center(
            child: ValueListenableBuilder<bool>(
              valueListenable: show,
              builder: (context, visible, _) => DievasDropdown<void>(
                show: visible,
                content: const Text('Caller menu'),
                child: const SizedBox(width: 160, child: Text('Target')),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Caller menu'), findsOneWidget);
      show.value = false;
      await tester.pumpAndSettle();
      expect(find.text('Caller menu'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('menu defaults follow active spacing, sizing and stroke tokens', (tester) async {
      await tester.pumpWidget(
        Harness(
          themeOverrides: (theme) => DievasGlobalThemeData(
            colours: theme.colours,
            spacing: theme.spacing.copyWith(sm: 12, xs: 6),
            sizing: theme.sizing.copyWith(height256: 320),
            border: theme.border.copyWith(strokeThin: 2),
          ),
          child: Center(
            child: SizedBox(
              width: 240,
              child: DievasDropdown<String>(
                hint: 'Token defaults',
                options: List.generate(30, (index) => 'Item $index'),
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Token defaults'));
      await tester.pumpAndSettle();
      final surface = find
          .ancestor(
            of: find.text('Item 0'),
            matching: find.byWidgetPredicate(
              (widget) => switch (widget) {
                Container(decoration: BoxDecoration(color: final Color _)) => true,
                _ => false,
              },
            ),
          )
          .first;
      expect(tester.widget<Container>(surface).padding, const EdgeInsets.all(6));
      expect(tester.getSize(surface).height, 320);
      expect(tester.getTopLeft(surface).dy - tester.getBottomLeft(find.byType(DievasDropdown<String>)).dy, 12);
      if (tester.widget<Container>(surface).decoration case BoxDecoration(border: final Border border)) {
        expect(border.top.width, 2);
      } else {
        fail('Expected semantic border stroke');
      }
      expect(tester.takeException(), isNull);
    });

    testWidgets('updates an open overlay after its parent rebuilds', (tester) async {
      final selected = ValueNotifier<List<String>>([]);
      addTearDown(selected.dispose);
      await tester.pumpWidget(
        Harness(
          child: Center(
            child: SizedBox(
              width: 240,
              child: ValueListenableBuilder<List<String>>(
                valueListenable: selected,
                builder: (context, values, _) => DievasDropdown<String>(
                  options: const ['A', 'B'],
                  selectedValues: values,
                  onMultiChanged: (values) => selected.value = values,
                  hint: 'Choose',
                  optionBuilder: (context, option, checked, select) =>
                      GestureDetector(onTap: select, child: Text('$option: $checked')),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Choose'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('A: false'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(selected.value, ['A']);
      expect(find.text('A: true'), findsOneWidget);
      await tester.tap(find.text('B: false'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(selected.value, ['A', 'B']);
      expect(find.text('B: true'), findsOneWidget);
    });

    testWidgets('reopening during the close animation leaves one overlay', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: Center(
            child: SizedBox(
              width: 240,
              child: DievasDropdown<String>(options: const ['A', 'B'], hint: 'Choose', onChanged: (_) {}),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Choose'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 16));
      await tester.tap(find.text('Choose'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 16));
      await tester.tap(find.text('Choose'));
      await tester.pumpAndSettle();
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('opens with the Dievas theme scoped below the navigator overlay', (tester) async {
      String? selected;
      await tester.pumpWidget(
        MaterialApp(
          home: DievasTheme(
            data: DievasLightThemeData(),
            child: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 240,
                  child: DievasDropdown<String>(
                    options: const ['A', 'B'],
                    hint: 'Choose',
                    onChanged: (value) => selected = value,
                    contentBuilder: (context, select, dismiss) => Padding(
                      padding: EdgeInsets.all(context.spacing.sm),
                      child: GestureDetector(onTap: () => select('B'), child: const Text('Select B')),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Choose'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('Select B'), findsOneWidget);
      await tester.tap(find.text('Select B'));
      await tester.pumpAndSettle();
      expect(selected, 'B');
      expect(find.text('Select B'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDropdown<String>(options: ['A', 'B', 'C'], onChanged: null)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('shows hint text when no value is selected', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasDropdown<String>(options: ['A', 'B', 'C'], hint: 'Pick one', onChanged: null),
        ),
      );
      expect(find.text('Pick one'), findsOneWidget);
    });

    testWidgets('shows selected value when value is provided', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasDropdown<String>(options: ['A', 'B', 'C'], value: 'B', onChanged: null),
        ),
      );
      expect(find.text('B'), findsOneWidget);
    });

    testWidgets('shows label when provided', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasDropdown<String>(options: ['A', 'B', 'C'], label: 'Fruit', onChanged: null),
        ),
      );
      expect(find.text('Fruit'), findsOneWidget);
    });

    testWidgets('uses labelBuilder for display text', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasDropdown<_Option>(
            options: [_Option.apple, _Option.banana],
            value: _Option.banana,
            onChanged: null,
            labelBuilder: (o) => o.label,
          ),
        ),
      );
      expect(find.text('Banana'), findsOneWidget);
    });

    testWidgets('opens overlay on tap', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasDropdown<String>(options: ['A', 'B', 'C'], onChanged: (_) {}),
        ),
      );

      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pump();

      expect(find.text('A'), findsWidgets);
      expect(find.text('B'), findsWidgets);
      expect(find.text('C'), findsWidgets);
    });

    testWidgets('fires onChanged when option is tapped', (tester) async {
      String? selected;
      await tester.pumpWidget(
        Harness(
          child: DievasDropdown<String>(options: ['A', 'B', 'C'], onChanged: (v) => selected = v),
        ),
      );

      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pump();

      await tester.tap(find.text('B').last);
      expect(selected, 'B');
    });

    testWidgets('does not open when disabled', (tester) async {
      String? selected;
      await tester.pumpWidget(
        Harness(
          child: DievasDropdown<String>(options: ['A', 'B', 'C'], onChanged: (v) => selected = v, enabled: false),
        ),
      );

      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pump();

      expect(find.text('A'), findsNothing);
      expect(selected, isNull);
    });

    testWidgets('does not respond to tap when onChanged is null', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDropdown<String>(options: ['A', 'B', 'C'], onChanged: null)));

      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pump();

      expect(find.text('A'), findsNothing);
    });
  });
}

class _Option {
  const _Option(this.label);
  final String label;
  static const apple = _Option('Apple');
  static const banana = _Option('Banana');
}
