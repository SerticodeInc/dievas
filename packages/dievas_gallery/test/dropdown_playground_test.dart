import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/form/dievas_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

Finder _surfaceFor(String text) => find
    .ancestor(
      of: find.text(text).first,
      matching: find.byWidgetPredicate(
        (widget) => switch (widget) {
          Container(decoration: BoxDecoration(color: final Color _)) => true,
          _ => false,
        },
      ),
    )
    .first;

BoxDecoration _decoration(WidgetTester tester, String text) =>
    switch (tester.widget<Container>(_surfaceFor(text)).decoration) {
      final BoxDecoration decoration => decoration,
      _ => throw StateError('Expected dropdown surface decoration'),
    };

Future<void> _pumpGallery(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(1600, 1200));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    Widgetbook.material(
      initialRoute: '/?path=dropdown/playground',
      directories: [dropdownComponent],
      addons: [DievasThemeAddon()],
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('reference keeps the hint, counts checked choices and clears them from the tag', (tester) async {
    await _pumpGallery(tester);
    await tester.tap(find.text('Choose an option'));
    await tester.pumpAndSettle();
    for (final choice in ['Choice #1', 'Choice #2', 'Choice #3']) {
      await tester.tap(find.text(choice));
      await tester.pumpAndSettle();
    }
    final tag = find.byType(DievasTag);
    expect(tester.widget<DievasTag>(tag).label, '3');
    expect(find.text('Choose an option'), findsOneWidget);
    expect(
      tester.widgetList<DievasCheckbox>(find.byType(DievasCheckbox)).every((checkbox) => checkbox.value == .checked),
      isTrue,
    );
    await tester.tap(find.descendant(of: tag, matching: find.byIcon(Icons.close)));
    await tester.pumpAndSettle();
    expect(find.byType(DievasTag), findsNothing);
    expect(find.text('Choice #1'), findsOneWidget);
    expect(
      tester.widgetList<DievasCheckbox>(find.byType(DievasCheckbox)).every((checkbox) => checkbox.value == .unchecked),
      isTrue,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('open menu stays below its trigger and reflects live surface knobs', (tester) async {
    await _pumpGallery(tester);
    expect(tester.takeException(), isNull);
    final dropdown = find.byType(DievasDropdown<String>).first;
    final state = WidgetbookState.of(tester.element(dropdown));
    final theme = DievasTheme.of(tester.element(dropdown));
    await tester.tap(find.text('Choose an option'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    final triggerRect = tester.getRect(dropdown);
    final popupRect = tester.getRect(_surfaceFor('Choice #1'));
    final viewport = tester.getRect(find.byType(Overlay).last);
    expect(popupRect.top, greaterThan(triggerRect.bottom));
    expect(popupRect.left, closeTo(triggerRect.left, 1));
    expect(popupRect.width, closeTo(triggerRect.width, 1));
    expect(viewport.contains(popupRect.topLeft), isTrue);
    expect(viewport.contains(popupRect.bottomRight), isTrue);
    await tester.tapAt(Offset(viewport.right + 10, viewport.center.dy));
    await tester.pumpAndSettle();
    expect(find.text('Choice #1'), findsOneWidget);

    state.updateQueryField(group: 'knobs', field: 'Override background colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Override border colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Override border radius', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Border radius', value: 'r32');
    state.updateQueryField(group: 'knobs', field: 'Show shadow', value: 'false');
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('Choice #1'), findsOneWidget);
    final surface = _decoration(tester, 'Choice #1');
    expect(surface.color, theme.colours.core.primary);
    expect(surface.border, Border.all(color: theme.colours.core.primary, width: theme.border.strokeThin));
    expect(surface.borderRadius, theme.border.r32);
    expect(surface.boxShadow, isEmpty);

    state.updateQueryField(group: 'knobs', field: 'Constrain width to trigger', value: 'false');
    state.updateQueryField(group: 'knobs', field: 'Maximum width', value: '160');
    state.updateQueryField(group: 'knobs', field: 'Maximum height', value: '80');
    state.updateQueryField(group: 'knobs', field: 'Anchor position', value: 'top');
    state.updateQueryField(group: 'knobs', field: 'Right to left', value: 'true');
    await tester.pumpAndSettle();
    expect(tester.getRect(_surfaceFor('Choice #1')).bottom, lessThan(tester.getRect(dropdown).top));
    expect(tester.getSize(_surfaceFor('Choice #1')).width, lessThan(triggerRect.width));
    expect(tester.getSize(_surfaceFor('Choice #1')).height, lessThan(popupRect.height));
    expect(Directionality.of(tester.element(find.text('Choice #1'))), TextDirection.rtl);

    state.updateQueryField(group: 'knobs', field: 'Show border', value: 'false');
    await tester.pumpAndSettle();
    expect(_decoration(tester, 'Choice #1').border, isNull);
    await tester.tap(find.text('Choice #1'));
    await tester.pumpAndSettle();
    expect(tester.widget<DievasDropdown<String>>(dropdown).selectedValues, ['Choice #1']);
    state.updateQueryField(group: 'knobs', field: 'Enabled', value: 'false');
    await tester.pumpAndSettle();
    expect(find.text('Choice #1'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('button opens a nested menu and selecting a value closes both menus', (tester) async {
    await _pumpGallery(tester);
    await tester.tap(find.text('Piccolo'));
    await tester.pumpAndSettle();
    expect(find.text('Roshi'), findsOneWidget);
    await tester.tap(find.text('Roshi'));
    await tester.pumpAndSettle();
    expect(find.text('Roshi60'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Roshi60'));
    await tester.pumpAndSettle();
    expect(find.text('Roshi60'), findsOneWidget);
    expect(find.text('Roshi'), findsNothing);
    expect(find.text('Krillin'), findsNothing);
    final button = tester.widget<DievasFilledButton>(find.byType(DievasFilledButton));
    expect(button.backgroundColor, const Color(0x8F49B356));
    await tester.tap(find.text('Roshi60'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Krillin'));
    await tester.pumpAndSettle();
    expect(tester.widget<DievasFilledButton>(find.byType(DievasFilledButton)).backgroundColor, const Color(0xFFFFB319));
    expect(find.text('Krillin'), findsOneWidget);
    final paintedButton = find.descendant(
      of: find.byType(DievasFilledButton),
      matching: find.byWidgetPredicate(
        (widget) => switch (widget) {
          Container(decoration: ShapeDecoration(color: const Color(0xFFFFB319))) => true,
          _ => false,
        },
      ),
    );
    expect(paintedButton, findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
