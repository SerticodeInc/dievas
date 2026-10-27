import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/search/dievas_search_with_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

Future<void> _pump(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(1600, 1200));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    Widgetbook.material(
      initialRoute: '/?path=searchwithlist/playground',
      directories: [searchWithListComponent],
      addons: [DievasThemeAddon()],
    ),
  );
  await tester.pumpAndSettle();
}

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
  testWidgets('inline reference opens all component names, Clear restores and Close dismisses', (tester) async {
    await _pump(tester);
    expect(find.text('Search results displayed as a list.'), findsOneWidget);
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();
    expect(find.text('Accordion'), findsOneWidget);
    expect(find.text('Button'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '  BUTTON  ');
    await tester.pumpAndSettle();
    expect(find.text('Accordion'), findsNothing);
    expect(find.text('Button'), findsOneWidget);
    await tester.tap(find.text('Clear'));
    await tester.pumpAndSettle();
    expect(find.text('Accordion'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Close search'));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsNothing);
    expect(find.text('Search results displayed as a list.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('live input colours, radius, sizing and behaviour preserve the inline query', (tester) async {
    await _pump(tester);
    final search = find.byType(DievasSearchWithList<String>);
    final state = WidgetbookState.of(tester.element(search));
    final theme = DievasTheme.of(tester.element(search));
    await tester.enterText(find.byType(TextField), 'button');
    await tester.pumpAndSettle();
    for (final field in [
      'Override active border colour',
      'Override inactive border colour',
      'Override hover border colour',
      'Override background colour',
      'Override border radius',
      'Floating label',
    ]) {
      state.updateQueryField(group: 'knobs', field: field, value: 'true');
    }
    state.updateQueryField(group: 'knobs', field: 'Border radius', value: 'r32');
    state.updateQueryField(group: 'knobs', field: 'Input size', value: 'lg');
    await tester.pumpAndSettle();
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller?.text, 'button');
    expect(field.decoration?.labelText, 'Search components');
    expect(find.text('Button'), findsOneWidget);
    final decoration = tester.widget<Container>(_inputSurface).decoration as BoxDecoration;
    expect(decoration.color, theme.colours.core.primary);
    expect((decoration.border as Border).top.color, theme.colours.core.primary);
    expect(decoration.borderRadius, theme.border.r32);
    expect(tester.widget<Container>(_inputSurface).constraints?.maxHeight, theme.sizing.height48);
    state.updateQueryField(group: 'knobs', field: 'Right to left', value: 'true');
    await tester.pumpAndSettle();
    expect(Directionality.of(tester.element(find.text('Button'))), TextDirection.rtl);
    state.updateQueryField(group: 'knobs', field: 'Enabled', value: 'false');
    await tester.pumpAndSettle();
    expect(find.text('Button'), findsNothing);
    expect(tester.widget<TextField>(find.byType(TextField)).enabled, isFalse);
    expect(tester.takeException(), isNull);
  });
}
