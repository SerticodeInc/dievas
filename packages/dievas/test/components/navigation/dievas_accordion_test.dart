import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasAccordion', () {
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
