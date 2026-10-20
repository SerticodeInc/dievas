import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/display/dievas_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('Avatar playground exposes grouped controls and updates both examples', (tester) async {
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=avatar/playground',
        directories: [avatarComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(DievasAvatar), findsNWidgets(2));
    final state = WidgetbookState.of(tester.element(find.byType(DievasAvatar).first));
    final labels = state.knobs.keys.toList();
    for (final label in [
      'Content text',
      'Content type',
      'Image source',
      'Overlay content on image',
      'Size',
      'Shape',
      'Border radius',
      'Badge alignment',
      'Badge size',
      'Badge margin',
      'Text colour',
      'Background colour',
      'Badge colour',
      'Right to left',
    ]) {
      expect(labels, contains(label));
    }
    expect(labels.indexOf('Override text colour') + 1, labels.indexOf('Text colour'));
    expect(labels.indexOf('Override badge colour') + 1, labels.indexOf('Badge colour'));
    state.updateQueryField(group: 'knobs', field: 'Content text', value: 'XY');
    state.updateQueryField(group: 'knobs', field: 'Size', value: 'xl2');
    state.updateQueryField(group: 'knobs', field: 'Override badge colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Badge colour', value: 'Brand');
    state.updateQueryField(group: 'knobs', field: 'Badge alignment', value: 'topLeft');
    state.updateQueryField(group: 'knobs', field: 'Override badge size', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Badge size', value: '12');
    state.updateQueryField(group: 'knobs', field: 'Right to left', value: 'true');
    await tester.pumpAndSettle();
    for (final avatar in tester.widgetList<DievasAvatar>(find.byType(DievasAvatar))) {
      expect(avatar.initials, 'XY');
      expect(avatar.size, DievasAvatarSize.xl2);
      expect(avatar.badgeAlignment, DievasAvatarBadgeAlignment.topLeft);
      expect(avatar.badgeSize, 12);
      expect(avatar.showBadge, isTrue);
      expect(avatar.badgeColour, DievasTheme.coloursOf(tester.element(find.byType(DievasAvatar).first)).core.primary);
    }
    expect(Directionality.of(tester.element(find.byType(DievasAvatar).first)), TextDirection.rtl);
    state.updateQueryField(group: 'knobs', field: 'Image source', value: 'broken');
    await tester.pumpAndSettle();
    expect(find.text('XY'), findsNWidgets(2));
    state.updateQueryField(group: 'knobs', field: 'Content type', value: 'custom');
    state.updateQueryField(group: 'knobs', field: 'Overlay content on image', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Show badge', value: 'false');
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsNWidgets(2));
    expect(tester.widgetList<DievasAvatar>(find.byType(DievasAvatar)).every((avatar) => !avatar.showBadge), isTrue);
    expect(tester.takeException(), isNull);
  });
}
