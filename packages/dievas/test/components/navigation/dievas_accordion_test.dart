import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasAccordion', () {
    for (final layout in DievasAccordionLayout.values) {
      testWidgets('${layout.name} places content on the expected surface', (tester) async {
        await tester.pumpWidget(
          Harness(
            child: SizedBox(
              width: 400,
              child: DievasAccordion(
                layout: layout,
                items: const [
                  DievasAccordionItem(title: Text('Header'), content: Text('Body'), initiallyExpanded: true),
                ],
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final headerSurface = tester.widget<Material>(
          find.ancestor(of: find.text('Header'), matching: find.byType(Material)).first,
        );
        final bodySurface = tester.widget<Material>(
          find.ancestor(of: find.text('Body'), matching: find.byType(Material)).first,
        );
        expect(identical(headerSurface, bodySurface), layout == DievasAccordionLayout.grouped);
        expect(find.byType(Divider), layout == DievasAccordionLayout.grouped ? findsOneWidget : findsNothing);
        expect(
          tester
              .widget<RotationTransition>(
                find.ancestor(of: find.byIcon(Icons.expand_more), matching: find.byType(RotationTransition)).first,
              )
              .turns
              .value,
          0.5,
        );

        await tester.tap(find.text('Header'));
        await tester.pumpAndSettle();
        expect(find.text('Body'), findsNothing);
        await tester.tap(find.text('Header'));
        await tester.pumpAndSettle();
        expect(find.text('Body'), findsOneWidget);
      });
    }

    testWidgets('size variants increase header height and divider can be hidden', (tester) async {
      final heights = <double>[];
      for (final size in DievasAccordionSize.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasAccordion(
              size: size,
              showDivider: false,
              items: const [DievasAccordionItem(title: Text('Header'), content: Text('Body'), initiallyExpanded: true)],
            ),
          ),
        );
        await tester.pumpAndSettle();
        heights.add(tester.getSize(find.byType(InkWell)).height);
        expect(find.byType(Divider), findsNothing);
      }
      expect(heights[0], lessThan(heights[1]));
      expect(heights[1], lessThan(heights[2]));
    });

    testWidgets('applies surface and expanded colour overrides', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasAccordion(
            showBorder: true,
            showShadows: true,
            borderColour: Colors.red,
            dividerColour: Colors.green,
            borderRadius: BorderRadius.circular(24),
            backgroundColour: Colors.white,
            expandedBackgroundColour: Colors.blue,
            textColour: Colors.red,
            expandedTextColour: Colors.yellow,
            iconColour: Colors.black,
            expandedIconColour: Colors.orange,
            contentTextColour: Colors.purple,
            items: const [DievasAccordionItem(title: Text('Header'), content: Text('Body'))],
          ),
        ),
      );
      final surface = find.ancestor(of: find.text('Header'), matching: find.byType(Material)).first;
      expect(tester.widget<Material>(surface).color, Colors.white);
      await tester.tap(find.text('Header'));
      await tester.pumpAndSettle();
      expect(tester.widget<Material>(surface).color, Colors.blue);
      expect(tester.widget<Divider>(find.byType(Divider)).color, Colors.green);
      expect(tester.widget<Icon>(find.byIcon(Icons.expand_more)).color, Colors.orange);
      expect(DefaultTextStyle.of(tester.element(find.text('Header'))).style.color, Colors.yellow);
      expect(DefaultTextStyle.of(tester.element(find.text('Body'))).style.color, Colors.purple);
      final shape = tester.widget<Material>(surface).shape;
      expect(shape, isA<RoundedRectangleBorder>());
      if (shape case RoundedRectangleBorder(:final side, :final borderRadius)) {
        expect(side.color, Colors.red);
        expect(borderRadius, BorderRadius.circular(24));
      }
    });

    for (final maintainState in [false, true]) {
      testWidgets('maintainState $maintainState controls form persistence', (tester) async {
        await tester.pumpWidget(
          Harness(
            child: DievasAccordion(
              maintainState: maintainState,
              items: const [DievasAccordionItem(title: Text('Header'), content: TextField(), initiallyExpanded: true)],
            ),
          ),
        );
        await tester.enterText(find.byType(TextField), 'Saved value');
        await tester.tap(find.text('Header'));
        await tester.pumpAndSettle();
        expect(find.byType(TextField), findsNothing);
        await tester.tap(find.text('Header'));
        await tester.pumpAndSettle();
        expect(find.text('Saved value'), maintainState ? findsOneWidget : findsNothing);
      });
    }

    testWidgets('controlled expansion waits for the parent update', (tester) async {
      var indices = <int>{};
      final changes = <(int, bool)>[];
      late StateSetter update;
      await tester.pumpWidget(
        Harness(
          child: StatefulBuilder(
            builder: (context, setState) {
              update = setState;
              return DievasAccordion(
                expandedIndices: indices,
                onExpansionChanged: (index, expanded) => changes.add((index, expanded)),
                items: const [DievasAccordionItem(title: Text('Header'), content: Text('Body'))],
              );
            },
          ),
        ),
      );
      await tester.tap(find.text('Header'));
      await tester.pumpAndSettle();
      expect(changes, [(0, true)]);
      expect(find.text('Body'), findsNothing);
      update(() => indices = {0});
      await tester.pumpAndSettle();
      expect(find.text('Body'), findsOneWidget);
    });

    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasAccordion(
              items: [DievasAccordionItem(title: const Text('Item 1'), content: const Text('Content 1'))],
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('shows content when header is tapped', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasAccordion(
              items: [DievasAccordionItem(title: const Text('Item 1'), content: const Text('Content 1'))],
            ),
          ),
        ),
      );
      expect(find.text('Content 1'), findsNothing);
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();
      expect(find.text('Content 1'), findsOneWidget);
    });

    testWidgets('collapses on second tap', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasAccordion(
              items: [DievasAccordionItem(title: const Text('Item 1'), content: const Text('Content 1'))],
            ),
          ),
        ),
      );
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();
      expect(find.text('Content 1'), findsOneWidget);
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();
      expect(find.text('Content 1'), findsNothing);
    });

    testWidgets('multiple items default allowMultiple false collapses others', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasAccordion(
              items: [
                DievasAccordionItem(title: const Text('Item 1'), content: const Text('Content 1')),
                DievasAccordionItem(title: const Text('Item 2'), content: const Text('Content 2')),
              ],
            ),
          ),
        ),
      );
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();
      expect(find.text('Content 1'), findsOneWidget);
      await tester.tap(find.text('Item 2'));
      await tester.pumpAndSettle();
      expect(find.text('Content 1'), findsNothing);
      expect(find.text('Content 2'), findsOneWidget);
    });

    testWidgets('allowMultiple keeps both open', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasAccordion(
              allowMultiple: true,
              items: [
                DievasAccordionItem(title: const Text('Item 1'), content: const Text('Content 1')),
                DievasAccordionItem(title: const Text('Item 2'), content: const Text('Content 2')),
              ],
            ),
          ),
        ),
      );
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Item 2'));
      await tester.pumpAndSettle();
      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsOneWidget);
    });

    testWidgets('disabled item does not expand', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasAccordion(
              items: [
                DievasAccordionItem(title: const Text('Item 1'), content: const Text('Content 1'), disabled: true),
              ],
            ),
          ),
        ),
      );
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();
      expect(find.text('Content 1'), findsNothing);
    });

    testWidgets('renders initially expanded item', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasAccordion(
              items: [
                DievasAccordionItem(
                  title: const Text('Item 1'),
                  content: const Text('Content 1'),
                  initiallyExpanded: true,
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Content 1'), findsOneWidget);
    });

    testWidgets('renders leading and trailing widgets', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasAccordion(
              items: [
                DievasAccordionItem(
                  title: const Text('Item 1'),
                  content: const Text('Content 1'),
                  leading: const Icon(Icons.star, key: Key('leading_icon')),
                  trailing: const Text('Extra', key: Key('trailing_text')),
                ),
              ],
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('leading_icon')), findsOneWidget);
      expect(find.byKey(const Key('trailing_text')), findsOneWidget);
    });

    testWidgets('hides trailing arrow when showTrailingArrow is false', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasAccordion(
              items: [
                DievasAccordionItem(
                  title: const Text('Item 1'),
                  content: const Text('Content 1'),
                  showTrailingArrow: false,
                ),
              ],
            ),
          ),
        ),
      );
      // No expand_more icon should be rendered
      expect(find.byIcon(Icons.expand_more), findsNothing);
    });

    testWidgets('renders with allowMultiple and initiallyExpanded', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: SizedBox(
            width: 400,
            child: DievasAccordion(
              allowMultiple: true,
              items: [
                DievasAccordionItem(
                  title: const Text('Item 1'),
                  content: const Text('Content 1'),
                  initiallyExpanded: true,
                ),
                DievasAccordionItem(
                  title: const Text('Item 2'),
                  content: const Text('Content 2'),
                  initiallyExpanded: true,
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsOneWidget);
    });
  });
}
