import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/nav_disclosure/dievas_breadcrumb.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('breadcrumb controls, hidden navigation and reset work in both examples', (tester) async {
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=breadcrumb/playground',
        directories: [breadcrumbComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    final trails = find.byType(DievasBreadcrumb<int>);
    expect(trails, findsNWidgets(2));
    final state = WidgetbookState.of(tester.element(trails.first));
    expect(
      state.knobs.keys,
      containsAll([
        'Item count',
        'Visible item count',
        'Gap',
        'Leading',
        'Trailing',
        'Override item colour',
        'Current item colour',
        'Hover effect colour',
        'Divider colour',
      ]),
    );
    await tester.tap(find.text('…'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Page 3'));
    await tester.pumpAndSettle();
    for (final trail in tester.widgetList<DievasBreadcrumb<int>>(trails)) {
      expect(trail.items, [0, 1, 2, 3]);
      expect(trail.selectedItem, 3);
    }
    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle();
    expect(tester.widget<DievasBreadcrumb<int>>(trails.first).items.length, 7);
    state.updateQueryField(group: 'knobs', field: 'Item count', value: '8');
    state.updateQueryField(group: 'knobs', field: 'Override item colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Item colour', value: 'Brand');
    state.updateQueryField(group: 'knobs', field: 'Leading', value: 'true');
    await tester.pumpAndSettle();
    for (final trail in tester.widgetList<DievasBreadcrumb<int>>(trails)) {
      expect(trail.items.length, 8);
      expect(trail.leading, isA<DievasIcon>());
      expect(trail.itemColour, DievasTheme.coloursOf(tester.element(trails.first)).core.primary);
    }
    state.updateQueryField(group: 'dievas-theme', field: 'theme', value: 'Dark');
    await tester.pumpAndSettle();
    expect(
      tester.widget<DievasBreadcrumb<int>>(trails.first).itemColour,
      DievasTheme.coloursOf(tester.element(trails.first)).core.primary,
    );
    state.updateQueryField(group: 'knobs', field: 'Override item colour', value: 'false');
    state.updateQueryField(group: 'knobs', field: 'Collapse middle items', value: 'false');
    await tester.pumpAndSettle();
    expect(tester.widget<DievasBreadcrumb<int>>(trails.first).itemColour, isNull);
    expect(tester.widget<DievasBreadcrumb<int>>(trails.first).visibleItemCount, isNull);
    expect(tester.takeException(), isNull);
  });
}
