import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/display/dievas_dot_indicator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('reference buttons select dots and knobs override their layout', (tester) async {
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=dotindicator/playground',
        directories: [dotIndicatorComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    final indicator = find.byType(DievasDotIndicator);
    expect(tester.widget<DievasDotIndicator>(indicator).activeIndex, 0);
    expect(find.byType(DievasFilledButton), findsNWidgets(4));
    await tester.tap(find.text('3'));
    await tester.pumpAndSettle();
    expect(tester.widget<DievasDotIndicator>(indicator).activeIndex, 2);
    final state = WidgetbookState.of(tester.element(indicator));
    state.updateQueryField(group: 'knobs', field: 'Override size', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Size', value: '12');
    state.updateQueryField(group: 'knobs', field: 'Count', value: '1');
    await tester.pumpAndSettle();
    expect(tester.widget<DievasDotIndicator>(indicator).size, 12);
    expect(tester.widget<DievasDotIndicator>(indicator).activeIndex, 0);
    expect(tester.takeException(), isNull);
  });
}
