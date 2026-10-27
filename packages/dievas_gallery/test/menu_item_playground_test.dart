import 'dart:io';
import 'dart:ui' as ui;

import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/nav_disclosure/dievas_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('reference controls remain interactive across live knob changes', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1600, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final font = FontLoader('MartianMono')
      ..addFont(rootBundle.load('packages/dievas/lib/assets/fonts/MartianMono-Regular.ttf'));
    await font.load();
    await (FontLoader('MaterialIcons')..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=menuitem/playground',
        directories: [menuItemComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    final items = find.byType(DievasMenuItem);
    expect(items, findsNWidgets(5));
    final state = WidgetbookState.of(tester.element(items.first));
    await tester.ensureVisible(find.byType(DievasCheckbox));
    await tester.tap(find.byType(DievasCheckbox));
    await tester.pumpAndSettle();
    expect(tester.widget<DievasCheckbox>(find.byType(DievasCheckbox)).value, DievasCheckboxValue.checked);
    await tester.ensureVisible(find.text('Expandable menu item'));
    await tester.tap(find.text('Expandable menu item'));
    await tester.pumpAndSettle();
    expect(find.text('Notifications'), findsOneWidget);
    state.updateQueryField(group: 'knobs', field: 'Override label colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Label colour', value: 'Brand');
    state.updateQueryField(group: 'knobs', field: 'Right to left', value: 'true');
    await tester.pumpAndSettle();
    expect(tester.widget<DievasCheckbox>(find.byType(DievasCheckbox)).value, DievasCheckboxValue.checked);
    expect(find.text('Notifications'), findsOneWidget);
    for (final item in tester.widgetList<DievasMenuItem>(items)) {
      expect(item.labelColour, DievasTheme.coloursOf(tester.element(items.first)).core.primary);
    }
    for (final (field, value) in [
      ('Override gaps', 'true'),
      ('Horizontal gap', 'smPlus'),
      ('Vertical gap', 'xs'),
      ('Override padding', 'true'),
      ('Padding', 'sm'),
      ('Override width', 'true'),
      ('Width', 'width256'),
      ('Override height', 'true'),
      ('Height', 'height256'),
    ]) {
      state.updateQueryField(group: 'knobs', field: field, value: value);
    }
    await tester.pumpAndSettle();
    final theme = DievasTheme.of(tester.element(items.first));
    for (final item in tester.widgetList<DievasMenuItem>(items)) {
      expect(item.horizontalGap, theme.spacing.smPlus);
      expect(item.verticalGap, theme.spacing.xs);
      expect(item.padding, EdgeInsets.all(theme.spacing.sm));
      expect(item.width, theme.sizing.width256);
      expect(item.height, theme.sizing.height256);
    }
    for (final field in ['Override gaps', 'Override padding', 'Override width', 'Override height']) {
      state.updateQueryField(group: 'knobs', field: field, value: 'false');
    }
    await tester.pumpAndSettle();
    state.updateQueryField(group: 'knobs', field: 'Enabled', value: 'false');
    await tester.pumpAndSettle();
    expect(tester.widget<DievasCheckbox>(find.byType(DievasCheckbox)).onChanged, isNull);
    expect(tester.takeException(), isNull);

    // Optional local artifact for visual review; normal test runs write nothing.
    if (Platform.environment['DIEVAS_MENU_PREVIEW'] case final path?) {
      state.updateQueryField(group: 'knobs', field: 'Enabled', value: 'true');
      state.updateQueryField(group: 'knobs', field: 'Right to left', value: 'false');
      state.updateQueryField(group: 'knobs', field: 'Override label colour', value: 'false');
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('DievasMenuItem'));
      await tester.pumpAndSettle();
      final boundary = tester.renderObject<RenderRepaintBoundary>(find.byType(RepaintBoundary).first);
      await tester.runAsync(() async {
        final image = await boundary.toImage();
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        if (bytes case final data?) File(path).writeAsBytesSync(data.buffer.asUint8List());
        image.dispose();
      });
    }
  });
}
