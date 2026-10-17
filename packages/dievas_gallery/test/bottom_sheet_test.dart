import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/overlays/dievas_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('BottomSheet opens inside the preview, returns selections, and applies knobs', (tester) async {
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=bottomsheet/playground',
        directories: [bottomSheetComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(DievasBottomSheet), findsNothing);
    final state = WidgetbookState.of(tester.element(find.byType(DievasFilledButton).first));
    final labels = state.knobs.keys.toList();
    for (final label in [
      'Background colour',
      'Barrier colour',
      'Border radius',
      'Height fraction',
      'Close progress threshold',
      'Enable drag',
      'Expanded',
      'Use safe area',
      'Show close button',
      'Keyboard form',
    ]) {
      expect(labels, contains(label));
    }
    expect(labels.indexOf('Override background colour') + 1, labels.indexOf('Background colour'));
    state.updateQueryField(group: 'knobs', field: 'Override background colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Background colour', value: 'Brand');
    state.updateQueryField(group: 'knobs', field: 'Override border radius', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Border radius', value: '28');
    state.updateQueryField(group: 'knobs', field: 'Show drag handle', value: 'false');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open bottom sheet'));
    await tester.pumpAndSettle();
    expect(find.byType(DievasBottomSheet), findsOneWidget);
    final sheet = tester.widget<DievasBottomSheet>(find.byType(DievasBottomSheet));
    expect(sheet.showDragHandle, isFalse);
    expect(sheet.showCloseButton, isTrue);
    final close = tester.widget<DievasIconButton>(find.byType(DievasIconButton).last);
    expect(close.backgroundColor, isNotNull);
    expect(close.shape, isA<CircleBorder>());
    expect(tester.getCenter(find.text('Pick your choice!')).dx, tester.getCenter(find.byType(DievasBottomSheet)).dx);
    final toolbar = tester.getRect(find.byType(NavigationToolbar));
    expect(tester.getTopLeft(find.text('Item nr:').first).dx, toolbar.left);
    expect(tester.widget<ListTile>(find.byType(ListTile).last).hoverColor, Colors.transparent);
    final colour = DievasTheme.coloursOf(tester.element(find.byType(DievasBottomSheet))).core.primary;
    expect(
      tester
          .widgetList<Container>(find.byType(Container))
          .any(
            (widget) => switch (widget.decoration) {
              BoxDecoration(:final color) => color == colour,
              _ => false,
            },
          ),
      isTrue,
    );
    final previewBounds = tester.getRect(find.byType(Navigator).last);
    final sheetBounds = tester.getRect(find.byType(DievasBottomSheet));
    expect(previewBounds.contains(sheetBounds.topLeft), isTrue);
    expect(sheetBounds.height, lessThan(previewBounds.height));
    expect(
      tester.widget<ClipRRect>(find.byType(ClipRRect).last).borderRadius,
      const BorderRadius.vertical(top: Radius.circular(28)),
    );
    await tester.tap(find.text('0').last);
    await tester.pumpAndSettle();
    expect(find.text('Selected item 0'), findsOneWidget);
    expect(find.byType(DievasBottomSheet), findsNothing);
    state.updateQueryField(group: 'knobs', field: 'Keyboard form', value: 'true');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open bottom sheet'));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsNWidgets(2));
    await tester.tap(find.byTooltip('Close').last);
    await tester.pumpAndSettle();
    expect(find.text('Sheet dismissed'), findsOneWidget);
    state.updateQueryField(group: 'knobs', field: 'Keyboard form', value: 'false');
    state.updateQueryField(group: 'knobs', field: 'Fit content', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Item count', value: '3');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open bottom sheet'));
    await tester.pumpAndSettle();
    expect(tester.widget<ListView>(find.byType(ListView).last).shrinkWrap, isTrue);
    expect(tester.getSize(find.byType(DievasBottomSheet)).height, lessThan(previewBounds.height * 0.64));
    await tester.tap(find.byTooltip('Close').last);
    await tester.pumpAndSettle();
    state.updateQueryField(group: 'knobs', field: 'Custom trailing action', value: 'true');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open bottom sheet'));
    await tester.pumpAndSettle();
    expect(tester.widget<DievasBottomSheet>(find.byType(DievasBottomSheet)).trailing, isA<DievasTextButton>());
    expect(find.byTooltip('Close'), findsNothing);
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(find.byType(DievasBottomSheet), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
