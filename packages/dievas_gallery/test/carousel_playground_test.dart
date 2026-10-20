import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/display/dievas_carousel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('reference examples expose controls and synchronize arrows with dots', (tester) async {
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=carousel/playground',
        directories: [carouselComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(DievasCarousel), findsNWidgets(2));
    expect(tester.widget<DievasDotIndicator>(find.byType(DievasDotIndicator)).activeIndex, 2);
    final buttons = find.byType(DievasIconButton);
    await tester.ensureVisible(buttons.last);
    await tester.tap(buttons.last);
    await tester.pumpAndSettle();
    expect(tester.widget<DievasDotIndicator>(find.byType(DievasDotIndicator)).activeIndex, 3);
    await tester.tap(buttons.last);
    await tester.pumpAndSettle();
    expect(tester.widget<DievasDotIndicator>(find.byType(DievasDotIndicator)).activeIndex, 4);
    expect(tester.widget<DievasIconButton>(buttons.last).onPressed, isNull);
    final state = WidgetbookState.of(tester.element(find.byType(DievasCarousel).first));
    expect(
      state.knobs.keys,
      containsAll(['Item extent', 'Gap', 'Anchor', 'Velocity factor', 'Auto play', 'Loop', 'Clamp max extent']),
    );
    state.updateQueryField(group: 'knobs', field: 'Item extent', value: '180');
    state.updateQueryField(group: 'knobs', field: 'Loop', value: 'true');
    await tester.pumpAndSettle();
    expect(tester.widget<DievasIconButton>(buttons.last).onPressed, isNotNull);
    expect(tester.takeException(), isNull);
  });
}
