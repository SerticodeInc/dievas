import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(
  WidgetTester tester, {
  required bool dropdown,
  TextEditingController? controller,
  FocusNode? focusNode,
  bool enabled = true,
  bool? show,
  ValueChanged<String>? onChanged,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: DievasTheme(
        data: DievasLightThemeData(),
        child: Scaffold(
          body: SizedBox(
            width: 360,
            child: switch (dropdown) {
              true => DievasSearchWithDropdown<String>(
                items: const ['Apple', 'Banana'],
                displayString: (value) => value,
                onSelected: (_) {},
                controller: controller,
                focusNode: focusNode,
                enabled: enabled,
                show: show,
                onChanged: onChanged,
              ),
              false => DievasSearchWithList<String>(
                items: const ['Apple', 'Banana'],
                displayString: (value) => value,
                onSelected: (_) {},
                controller: controller,
                focusNode: focusNode,
                enabled: enabled,
                show: show,
                onChanged: onChanged,
              ),
            },
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  for (final dropdown in [false, true]) {
    testWidgets('${dropdown ? 'Dropdown' : 'List'} handles owned/external replacements and visibility precedence', (
      tester,
    ) async {
      final first = TextEditingController(text: 'Apple');
      final second = TextEditingController.fromValue(
        const TextEditingValue(text: 'Banana', selection: TextSelection.collapsed(offset: 3)),
      );
      final firstFocus = FocusNode();
      final secondFocus = FocusNode();
      final changes = <String>[];
      addTearDown(first.dispose);
      addTearDown(second.dispose);
      addTearDown(firstFocus.dispose);
      addTearDown(secondFocus.dispose);
      await _pump(tester, dropdown: dropdown);
      await tester.enterText(find.byType(TextField), 'Owned');
      await _pump(tester, dropdown: dropdown, controller: first, focusNode: firstFocus, onChanged: changes.add);
      expect(tester.widget<TextField>(find.byType(TextField)).controller, same(first));
      expect(tester.widget<TextField>(find.byType(TextField)).focusNode, same(firstFocus));
      await _pump(tester, dropdown: dropdown, controller: second, focusNode: secondFocus, onChanged: changes.add);
      first.text = 'Detached';
      expect(changes, isEmpty);
      expect(tester.widget<TextField>(find.byType(TextField)).controller, same(second));
      final value = second.value;
      await _pump(tester, dropdown: dropdown, onChanged: changes.add);
      final owned = tester.widget<TextField>(find.byType(TextField));
      expect(owned.controller?.value, value);
      expect(owned.focusNode, isNot(same(secondFocus)));
      second.text = 'Still caller owned';
      expect(changes, isEmpty);
      secondFocus.requestFocus();
      await _pump(tester, dropdown: dropdown, show: true);
      expect(find.byType(ListView), findsOneWidget);
      await _pump(tester, dropdown: dropdown, show: false);
      expect(find.byType(ListView), findsNothing);
      await _pump(tester, dropdown: dropdown, show: true, enabled: false);
      expect(find.byType(ListView), findsNothing);
      await _pump(tester, dropdown: dropdown, enabled: true);
      expect(find.byType(ListView), findsNothing);
      await tester.pumpWidget(const SizedBox());
      first.text = 'Alive';
      second.text = 'Alive';
      expect(tester.takeException(), isNull);
    });
  }
}
