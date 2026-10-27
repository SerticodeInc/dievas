import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(
  WidgetTester tester, {
  bool enabled = true,
  ValueChanged<String>? onSelected,
  TextEditingController? controller,
  bool Function(String, String)? filter,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: DievasTheme(
        data: DievasLightThemeData(),
        child: Scaffold(
          body: SizedBox(
            width: 360,
            child: DievasSearchWithList<String>(
              items: const ['Apple', 'Apricot', 'Banana'],
              displayString: (value) => value,
              onSelected: onSelected ?? (_) {},
              enabled: enabled,
              controller: controller,
              filter: filter,
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('tap empty input opens flat inline results using the remaining page height', (tester) async {
    await _pump(tester);
    expect(find.text('Search results displayed as a list.'), findsOneWidget);
    await tester.tapAt(const Offset(5, 20));
    await tester.pumpAndSettle();
    expect(find.text('Apple'), findsOneWidget);
    expect(find.text('Banana'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(Divider), findsNothing);
    expect(tester.getSize(find.byType(ListView)).height, greaterThan(256));
    final decorations = tester.widgetList<Container>(
      find.ancestor(of: find.byType(ListView), matching: find.byType(Container)),
    );
    expect(decorations.where((widget) => widget.decoration != null), isEmpty);
    final inputSurface = find
        .ancestor(
          of: find.byType(TextField),
          matching: find.byWidgetPredicate(
            (widget) => switch (widget) {
              Container(decoration: BoxDecoration(color: final Color _)) => true,
              _ => false,
            },
          ),
        )
        .first;
    final decoration = tester.widget<Container>(inputSurface).decoration as BoxDecoration;
    expect((decoration.borderRadius as BorderRadius).bottomLeft, const Radius.circular(8));
    expect(tester.widget<Text>(find.text('Apple')).style?.fontWeight, FontWeight.w400);
    expect(tester.takeException(), isNull);
  });

  testWidgets('trimmed search filters, Clear restores results, Close hides and releases focus', (tester) async {
    await _pump(tester);
    await tester.enterText(find.byType(TextField), '  AP  ');
    await tester.pumpAndSettle();
    expect(find.text('Apple'), findsOneWidget);
    expect(find.text('Apricot'), findsOneWidget);
    expect(find.text('Banana'), findsNothing);
    await tester.tap(find.text('Clear'));
    await tester.pumpAndSettle();
    expect(find.text('Banana'), findsOneWidget);
    expect(tester.widget<TextField>(find.byType(TextField)).controller?.text, isEmpty);
    await tester.tap(find.bySemanticsLabel('Close search'));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsNothing);
    expect(find.text('Search results displayed as a list.'), findsOneWidget);
    expect(tester.widget<TextField>(find.byType(TextField)).focusNode?.hasFocus, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('no match is centered and selection preserves the query and results', (tester) async {
    String? selected;
    await _pump(tester, onSelected: (value) => selected = value);
    await tester.enterText(find.byType(TextField), 'No match');
    await tester.pumpAndSettle();
    expect(find.text('No results found.'), findsOneWidget);
    expect(
      tester.getCenter(find.text('No results found.')),
      tester.getCenter(find.byType(DievasSearchWithList<String>)),
    );
    await tester.enterText(find.byType(TextField), 'App');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Apple'));
    await tester.pumpAndSettle();
    expect(selected, 'Apple');
    expect(tester.widget<TextField>(find.byType(TextField)).controller?.text, 'App');
    expect(find.byType(ListView), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('disabled input stays closed and external controller remains caller owned', (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    await _pump(tester, enabled: false, controller: controller);
    expect(tester.widget<TextField>(find.byType(TextField)).enabled, isFalse);
    expect(find.byType(ListView), findsNothing);
    await tester.pumpWidget(const SizedBox());
    controller.text = 'usable';
    expect(controller.text, 'usable');
    expect(tester.takeException(), isNull);
  });

  testWidgets('custom filter receives a trimmed query', (tester) async {
    await _pump(tester, filter: (item, query) => item.startsWith(query));
    await tester.enterText(find.byType(TextField), '  B  ');
    await tester.pumpAndSettle();
    expect(find.text('Banana'), findsOneWidget);
    expect(find.text('Apple'), findsNothing);
  });
}
