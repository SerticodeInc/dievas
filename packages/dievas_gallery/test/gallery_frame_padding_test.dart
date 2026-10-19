import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('the shared phone frame applies eight pixels inside the safe area', (tester) async {
    const probe = ValueKey('page-content');
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=padding/example',
        directories: [
          WidgetbookComponent(
            name: 'Padding',
            useCases: [
              WidgetbookUseCase(
                name: 'Example',
                builder: (_) => const SizedBox.expand(key: probe),
              ),
            ],
          ),
        ],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    final safeArea = tester.widget<SafeArea>(
      find.ancestor(of: find.byKey(probe), matching: find.byType(SafeArea)).first,
    );
    expect(safeArea.child, isA<Padding>());
    if (safeArea.child case Padding(:final padding)) {
      expect(padding, const EdgeInsets.all(8));
    }
    expect(tester.takeException(), isNull);
  });
}
