import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/search/dievas_search_with_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

Finder _surfaceFor(String text) => find
    .ancestor(
      of: find.text(text).last,
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

Rect _rect(WidgetTester tester, Finder finder) {
  final box = tester.renderObject<RenderBox>(finder);
  return Rect.fromPoints(box.localToGlobal(Offset.zero), box.localToGlobal(box.size.bottomRight(Offset.zero)));
}

Future<void> _pump(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(1600, 1200));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    Widgetbook.material(
      initialRoute: '/?path=searchwithdropdown/playground',
      directories: [searchWithDropdownComponent],
      addons: [DievasThemeAddon()],
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('reference search retains selection and clear/dismiss follows the Moon flow', (tester) async {
    await _pump(tester);
    expect(find.text('Search results displayed within DievasDropdown.'), findsOneWidget);
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();
    expect(find.text('Accordion'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'button');
    await tester.pumpAndSettle();
    expect(find.text('Button'), findsOneWidget);
    expect(find.text('Accordion'), findsNothing);
    final inputRect = _rect(tester, _inputSurface);
    final popupRect = _rect(tester, _surfaceFor('Button'));
    expect(popupRect.top, closeTo(inputRect.bottom, 1));
    expect(popupRect.width, closeTo(inputRect.width, 1));
    final viewport = _rect(tester, find.byType(Overlay).last);
    expect(viewport.contains(popupRect.topLeft), isTrue);
    expect(viewport.contains(popupRect.bottomRight), isTrue);
    await tester.tap(find.text('Button'));
    await tester.pumpAndSettle();
    expect(tester.widget<TextField>(find.byType(TextField)).controller?.text, 'Button');
    expect(find.byType(ListView), findsNothing);
    await tester.tap(find.text('Clear'));
    await tester.pumpAndSettle();
    expect(tester.widget<TextField>(find.byType(TextField)).controller?.text, isEmpty);
    await tester.enterText(find.byType(TextField), 'No match');
    await tester.pumpAndSettle();
    expect(find.text('No results found.'), findsOneWidget);
    await tester.tapAt(_rect(tester, find.byType(Overlay).last).center);
    await tester.pumpAndSettle();
    expect(tester.widget<TextField>(find.byType(TextField)).controller?.text, isEmpty);
    expect(find.text('No results found.'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('live knobs preserve the query and change both connected and detached surfaces', (tester) async {
    await _pump(tester);
    final search = find.byType(DievasSearchWithDropdown<String>);
    final state = WidgetbookState.of(tester.element(search));
    final theme = DievasTheme.of(tester.element(search));
    await tester.enterText(find.byType(TextField), 'button');
    await tester.pumpAndSettle();
    state.updateQueryField(group: 'knobs', field: 'Override background colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Override active border colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Override inactive border colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Override hover border colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Override border radius', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Border radius', value: 'r32');
    state.updateQueryField(group: 'knobs', field: 'Show shadow', value: 'false');
    state.updateQueryField(group: 'knobs', field: 'Floating label', value: 'true');
    await tester.pumpAndSettle();
    expect(find.text('Button'), findsOneWidget);
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller?.text, 'button');
    expect(field.decoration?.labelText, 'Search components');
    final inputDecoration = tester.widget<Container>(_inputSurface).decoration as BoxDecoration;
    expect(inputDecoration.color, theme.colours.core.primary);
    expect((inputDecoration.border as Border).top.color, theme.colours.core.primary);
    expect((inputDecoration.borderRadius as BorderRadius).topLeft, theme.border.r32.topLeft);
    expect((inputDecoration.borderRadius as BorderRadius).bottomLeft, Radius.zero);
    if (tester.widget<Container>(_surfaceFor('Button')).decoration case BoxDecoration(
      :final color,
      :final borderRadius,
      :final boxShadow,
    )) {
      expect(color, theme.colours.core.primary);
      expect(
        borderRadius,
        BorderRadius.only(bottomLeft: theme.border.r32.bottomLeft, bottomRight: theme.border.r32.bottomRight),
      );
      expect(boxShadow, isEmpty);
    } else {
      fail('Expected dropdown surface');
    }

    state.updateQueryField(group: 'knobs', field: 'Override distance to target', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Distance to target', value: 'sm');
    state.updateQueryField(group: 'knobs', field: 'Right to left', value: 'true');
    await tester.pumpAndSettle();
    final detached = tester.widget<Container>(_inputSurface).decoration as BoxDecoration;
    expect(detached.borderRadius, theme.border.r32);
    expect(_rect(tester, _surfaceFor('Button')).top, greaterThan(_rect(tester, _inputSurface).bottom));
    expect(Directionality.of(tester.element(find.text('Button'))), TextDirection.rtl);
    state.updateQueryField(group: 'knobs', field: 'Enabled', value: 'false');
    await tester.pumpAndSettle();
    expect(tester.widget<TextField>(find.byType(TextField)).enabled, isFalse);
    expect(find.text('Button'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
