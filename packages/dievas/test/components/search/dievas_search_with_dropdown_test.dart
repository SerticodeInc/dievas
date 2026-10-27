import 'dart:ui' show PointerDeviceKind;
import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _items = ['Apple', 'Apricot', 'Banana'];

Future<void> _pump(
  WidgetTester tester, {
  ValueChanged<String>? onSelected,
  double? gap,
  DievasSearchSize? size,
  Color? active,
  Color? inactive,
  Color? hover,
  bool floating = false,
  bool enabled = true,
  TextEditingController? controller,
  bool Function(String, String)? filter,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: DievasTheme(
        data: DievasLightThemeData(),
        child: Scaffold(
          body: Align(
            alignment: .topCenter,
            child: SizedBox(
              width: 320,
              child: DievasSearchWithDropdown<String>(
                items: _items,
                displayString: (value) => value,
                onSelected: onSelected ?? (_) {},
                hint: 'Search fruits',
                distanceToTarget: gap,
                size: size,
                activeBorderColour: active,
                inactiveBorderColour: inactive,
                hoverBorderColour: hover,
                hasFloatingLabel: floating,
                enabled: enabled,
                controller: controller,
                filter: filter,
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Finder get _surface => find
    .ancestor(
      of: find.byType(ListView),
      matching: find.byWidgetPredicate(
        (widget) => switch (widget) {
          Container(decoration: BoxDecoration(color: final Color _)) => true,
          _ => false,
        },
      ),
    )
    .first;

Finder get _inputSurface => find
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

void main() {
  testWidgets('input tap opens all results with the theme below the navigator', (tester) async {
    await _pump(tester);
    expect(find.text('Clear'), findsOneWidget);
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();
    for (final item in _items) {
      expect(find.text(item), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });
  testWidgets('search trims whitespace and ignores case; empty results remain visible', (tester) async {
    await _pump(tester);
    await tester.enterText(find.byType(TextField), '  AP  ');
    await tester.pumpAndSettle();
    expect(find.text('Apple'), findsOneWidget);
    expect(find.text('Apricot'), findsOneWidget);
    expect(find.text('Banana'), findsNothing);
    await tester.enterText(find.byType(TextField), 'not-a-fruit');
    await tester.pumpAndSettle();
    expect(find.text('No results found.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('selection stays in the field, closes the menu and releases focus', (tester) async {
    String? selected;
    await _pump(tester, onSelected: (value) => selected = value);
    await tester.enterText(find.byType(TextField), 'Ap');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Apple'));
    await tester.pumpAndSettle();
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(selected, 'Apple');
    expect(field.controller?.text, 'Apple');
    expect(field.focusNode?.hasFocus, isFalse);
    expect(find.byType(ListView), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets('Clear restores all items without closing an open menu', (tester) async {
    await _pump(tester);
    await tester.enterText(find.byType(TextField), 'Ban');
    await tester.pumpAndSettle();
    expect(find.text('Apple'), findsNothing);
    await tester.tap(find.text('Clear'));
    await tester.pumpAndSettle();
    expect(tester.widget<TextField>(find.byType(TextField)).controller?.text, isEmpty);
    for (final item in _items) {
      expect(find.text(item), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });
  testWidgets('outside dismissal clears an unselected query', (tester) async {
    await _pump(tester);
    await tester.enterText(find.byType(TextField), 'Ap');
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(20, 500));
    await tester.pumpAndSettle();
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller?.text, isEmpty);
    expect(field.focusNode?.hasFocus, isFalse);
    expect(find.byType(ListView), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets('zero gap joins corners and positive gap restores full radii', (tester) async {
    await _pump(tester);
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();
    final joined = tester.widget<Container>(_inputSurface).decoration as BoxDecoration;
    expect((joined.borderRadius as BorderRadius).bottomLeft, Radius.zero);
    expect(tester.getTopLeft(_surface).dy, tester.getBottomLeft(_inputSurface).dy);
    expect(tester.getSize(_inputSurface).height, 40);
    final style = tester.widget<Text>(find.text('Apple')).style;
    expect(style?.fontWeight, FontWeight.w400);
    final theme = DievasTheme.of(tester.element(_inputSurface));
    expect((tester.widget<Container>(_surface).decoration as BoxDecoration).boxShadow, theme.elevation.xs);
    expect(tester.getSize(_surface).height, lessThanOrEqualTo(256));
    await _pump(tester, gap: 8, floating: true);
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();
    final separated = tester.widget<TextField>(find.byType(TextField));
    expect(separated.decoration?.labelText, 'Search fruits');
    final detached = tester.widget<Container>(_inputSurface).decoration as BoxDecoration;
    expect((detached.borderRadius as BorderRadius).bottomLeft, const Radius.circular(8));
    expect(tester.getTopLeft(_surface).dy - tester.getBottomLeft(_inputSurface).dy, 8);
    expect(tester.takeException(), isNull);
  });
  testWidgets('disabled input does not open and external controller stays caller-owned', (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    await _pump(tester, enabled: false, controller: controller);
    expect(tester.widget<TextField>(find.byType(TextField)).enabled, isFalse);
    expect(find.byType(ListView), findsNothing);
    await tester.pumpWidget(const SizedBox());
    controller.text = 'Still usable';
    expect(controller.text, 'Still usable');
    expect(tester.takeException(), isNull);
  });
  testWidgets('semantic input sizes and independent border states paint on the outer surface', (tester) async {
    final theme = DievasLightThemeData();
    for (final size in DievasSearchSize.values) {
      await _pump(tester, size: size, floating: true);
      expect(tester.getSize(_inputSurface).height, switch (size) {
        .sm => theme.sizing.height32,
        .md => theme.sizing.height40,
        .lg => theme.sizing.height48,
        .xl => theme.sizing.height56,
      });
      expect(tester.takeException(), isNull);
    }
    final active = theme.colours.core.primary;
    final inactive = theme.colours.text.textPrimary;
    final hover = theme.colours.text.textSecondary;
    await _pump(tester, active: active, inactive: inactive, hover: hover);
    expect(
      ((tester.widget<Container>(_inputSurface).decoration as BoxDecoration).border as Border).top.color,
      inactive,
    );
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: const Offset(10, 500));
    await mouse.moveTo(tester.getCenter(_inputSurface));
    await tester.pumpAndSettle();
    expect(((tester.widget<Container>(_inputSurface).decoration as BoxDecoration).border as Border).top.color, hover);
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();
    expect(((tester.widget<Container>(_inputSurface).decoration as BoxDecoration).border as Border).top.color, active);
    await mouse.removePointer();
    expect(tester.takeException(), isNull);
  });
  testWidgets('custom filtering receives a trimmed query', (tester) async {
    await _pump(tester, filter: (item, query) => item.startsWith(query));
    await tester.enterText(find.byType(TextField), '  B  ');
    await tester.pumpAndSettle();
    expect(find.text('Banana'), findsOneWidget);
    expect(find.text('Apple'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
