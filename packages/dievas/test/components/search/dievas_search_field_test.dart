import 'package:dievas/dievas.dart';
import 'package:dievas/src/components/search/dievas_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('hint, value and caret share the field centre; Clear uses one trailing inset', (tester) async {
    await (FontLoader(
      'MartianMono',
    )..addFont(rootBundle.load('packages/dievas/lib/assets/fonts/MartianMono-Regular.ttf'))).load();
    final controller = TextEditingController();
    final focus = FocusNode();
    addTearDown(controller.dispose);
    addTearDown(focus.dispose);
    final theme = DievasLightThemeData();
    for (final direction in [TextDirection.ltr, TextDirection.rtl]) {
      await tester.pumpWidget(
        MaterialApp(
          home: DievasTheme(
            data: theme,
            child: Scaffold(
              body: Directionality(
                textDirection: direction,
                child: Center(
                  child: SizedBox(
                    width: 380,
                    child: DievasSearchField(
                      controller: controller,
                      focusNode: focus,
                      enabled: true,
                      hasFloatingLabel: false,
                      hint: 'Search components',
                      onSearch: () {},
                      onClear: controller.clear,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      controller.clear();
      focus.unfocus();
      await tester.pumpAndSettle();
      final surface = find
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
      final centre = tester.getCenter(surface).dy;
      final resting = tester.widget<Container>(surface).decoration as BoxDecoration;
      expect((resting.border as Border).top.color, theme.components.search.borderColour);
      expect(tester.getCenter(find.text('Search components')).dy, closeTo(centre, 1));
      expect(tester.getCenter(find.text('Clear')).dy, closeTo(centre, 1));
      final expectedInset = theme.components.search.contentPadding.right + theme.components.search.strokeWidth;
      final inset = switch (direction) {
        .ltr => tester.getTopRight(surface).dx - tester.getTopRight(find.text('Clear')).dx,
        .rtl => tester.getTopLeft(find.text('Clear')).dx - tester.getTopLeft(surface).dx,
      };
      expect(inset, closeTo(expectedInset, 1));
      await tester.tap(find.byType(TextField));
      await tester.enterText(find.byType(TextField), 'Search');
      await tester.pumpAndSettle();
      final focused = tester.widget<Container>(surface).decoration as BoxDecoration;
      expect((focused.border as Border).top.color, theme.components.search.borderColourFocused);
      final editable = tester.state<EditableTextState>(find.byType(EditableText)).renderEditable;
      final caret = editable.getLocalRectForCaret(const TextPosition(offset: 0));
      expect(editable.localToGlobal(caret.center).dy, closeTo(centre, 1));
      expect(tester.getCenter(find.byType(EditableText)).dy, closeTo(centre, 1));
      expect(tester.takeException(), isNull);
    }
  });
}
