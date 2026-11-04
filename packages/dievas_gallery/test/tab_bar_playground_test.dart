import 'package:dievas/dievas.dart';
import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/nav_disclosure/dievas_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('reference examples retain selections and controller state through live controls', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1600, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=tabbar/playground',
        directories: [tabBarComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    final standard = find.byKey(const ValueKey('reference-0'));
    final disabled = find.byKey(const ValueKey('reference-1'));
    final pill = find.byKey(const ValueKey('reference-2'));
    final controller = find.byKey(const ValueKey('controller-tabs'));
    expect(find.byType(DievasTabBar), findsNWidgets(4));
    expect(tester.widget<DievasTabBar>(standard).selectedIndex, 2);
    expect(tester.widget<DievasTabBar>(pill).selectedIndex, 0);
    final panel = find.byKey(const ValueKey('tab-page-1'));
    expect(tester.widget<ColoredBox>(panel).color, const Color(DievasColourPrimitives.royalPurpleAlpha8F));
    expect(tester.getSize(panel).height, 112);
    expect(tester.getSize(panel).width, tester.getSize(controller).width);
    await tester.tap(
      find.descendant(
        of: panel,
        matching: find.byWidgetPredicate(
          (widget) => switch (widget) {
            DievasIconButton(semanticLabel: 'Next tab') => true,
            _ => false,
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.widget<DievasTabBar>(controller).tabController?.index, 2);
    tester.widget<DievasTabBar>(controller).tabController?.index = 1;
    await tester.pumpAndSettle();

    await tester.tapAt(tester.getCenter(find.descendant(of: standard, matching: find.text('Tab2'))));
    await tester.pumpAndSettle();
    final disabledTab = find.descendant(of: disabled, matching: find.bySemanticsLabel('Example 2, tab 2'));
    final semantics = tester.ensureSemantics();
    try {
      await tester.tapAt(tester.getCenter(disabledTab));
      await tester.pumpAndSettle();
    } finally {
      semantics.dispose();
    }
    expect(tester.widget<DievasTabBar>(disabled).selectedIndex, 0);
    await tester.tapAt(tester.getCenter(find.descendant(of: pill, matching: find.text('Tab3'))));
    await tester.pumpAndSettle();
    final external = tester.widget<DievasTabBar>(controller).tabController;
    expect(external?.index, 1);
    external?.index = 2;
    await tester.pumpAndSettle();
    final state = WidgetbookState.of(tester.element(standard));
    for (final field in ['Expanded', 'Leading', 'Trailing', 'Override selected text colour', 'Right to left']) {
      state.updateQueryField(group: 'knobs', field: field, value: 'true');
    }
    state.updateQueryField(group: 'knobs', field: 'Size', value: 'sm');
    await tester.pumpAndSettle();
    expect(tester.widget<DievasTabBar>(standard).selectedIndex, 1);
    expect(tester.widget<DievasTabBar>(pill).selectedIndex, 2);
    expect(tester.widget<DievasTabBar>(controller).tabController?.index, 2);
    for (final bar in tester.widgetList<DievasTabBar>(find.byType(DievasTabBar))) {
      expect(bar.tabBarSize, DievasTabBarSize.sm);
      expect(bar.tabStyle.selectedTextColour, isNotNull);
    }
    expect(Directionality.of(tester.element(standard)), TextDirection.rtl);
    expect(tester.takeException(), isNull);
  });
}
