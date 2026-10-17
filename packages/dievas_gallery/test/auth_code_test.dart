import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/form/dievas_auth_code.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('AuthCode exposes reference controls and applies selected tokens', (tester) async {
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=authcode/playground',
        directories: [authCodeComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(DievasAuthCode), findsNWidgets(4));
    final state = WidgetbookState.of(tester.element(find.byType(DievasAuthCode).first));
    final labels = state.knobs.keys.toList();
    for (final label in [
      'Main axis alignment',
      'Shape',
      'Text colour',
      'Cursor colour',
      'Selected fill colour',
      'Active fill colour',
      'Inactive fill colour',
      'Selected border colour',
      'Active border colour',
      'Inactive border colour',
      'Error border colour',
    ]) {
      expect(labels, contains(label));
    }
    expect(labels.indexOf('Override selected fill colour') + 1, labels.indexOf('Selected fill colour'));
    state.updateQueryField(group: 'knobs', field: 'Override selected fill colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Selected fill colour', value: 'Brand');
    state.updateQueryField(group: 'knobs', field: 'Has error', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Peek when obscuring', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Obscure text', value: 'true');
    await tester.pumpAndSettle();
    state.updateQueryField(group: 'knobs', field: 'Error shake animation', value: 'true');
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    for (final fieldFinder in [find.byType(DievasAuthCode).first, find.byType(DievasAuthCode).last]) {
      expect(
        tester
            .widget<Transform>(find.descendant(of: fieldFinder, matching: find.byType(Transform)).first)
            .transform
            .storage[12],
        isNot(0),
      );
    }
    await tester.pumpAndSettle();
    final field = tester.widget<DievasAuthCode>(find.byType(DievasAuthCode).first);
    expect(
      field.selectedFillColour,
      DievasTheme.coloursOf(tester.element(find.byType(DievasAuthCode).first)).core.primary,
    );
    expect(field.hasError, isTrue);
    expect(field.peekWhenObscuring, isTrue);
    expect(field.obscureText, isTrue);
    expect(field.errorShakeAnimation, isTrue);
    await tester.tap(find.text('Replay error shake'));
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(
      tester
          .widget<Transform>(
            find.descendant(of: find.byType(DievasAuthCode).last, matching: find.byType(Transform)).first,
          )
          .transform
          .storage[12],
      isNot(0),
    );
    await tester.pumpAndSettle();
    for (final length in [4, 5, 6, 7]) {
      state.updateQueryField(group: 'knobs', field: 'Code length', value: '$length digits');
      await tester.pumpAndSettle();
      expect(tester.widget<DievasAuthCode>(find.byType(DievasAuthCode).first).codeLength, length);
    }
    expect(tester.takeException(), isNull);
  });
}
