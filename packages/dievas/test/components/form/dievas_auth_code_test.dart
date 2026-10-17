import 'package:dievas/dievas.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasAuthCode', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(Harness(child: DievasAuthCode(codeLength: 4, onCompleted: (_) {})));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders different code lengths', (tester) async {
      for (var len in [4, 6, 7]) {
        await tester.pumpWidget(
          Harness(
            child: DievasAuthCode(codeLength: len, onCompleted: (_) {}),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders with obscure text', (tester) async {
      await tester.pumpWidget(Harness(child: DievasAuthCode(codeLength: 6, obscureText: true, onCompleted: (_) {})));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders disabled state', (tester) async {
      await tester.pumpWidget(Harness(child: DievasAuthCode(codeLength: 4, enabled: false, onCompleted: (_) {})));
      expect(tester.takeException(), isNull);
    });

    testWidgets('filters input and reports completed edits, deletion and replacement', (tester) async {
      final completed = <String>[];
      final changed = <String>[];
      await tester.pumpWidget(
        Harness(
          child: DievasAuthCode(codeLength: 4, onCompleted: completed.add, onChanged: changed.add),
        ),
      );
      await tester.enterText(find.byType(TextField), 'a12b345');
      await tester.pump();
      expect(completed, ['1234']);
      expect(
        find.byWidgetPredicate(
          (widget) => switch (widget) {
            Text(data: '1') => true,
            _ => false,
          },
        ),
        findsOneWidget,
      );
      await tester.enterText(find.byType(TextField), '123');
      await tester.enterText(find.byType(TextField), '1235');
      await tester.enterText(find.byType(TextField), '1235');
      expect(completed, ['1234', '1235']);
      expect(changed, contains('123'));
    });

    testWidgets('peeks at a typed digit then masks it; pasted codes stay masked', (tester) async {
      await tester.pumpWidget(
        Harness(child: DievasAuthCode(codeLength: 4, obscureText: true, peekWhenObscuring: true, onCompleted: (_) {})),
      );
      await tester.enterText(find.byType(TextField), '1');
      await tester.pump();
      expect(
        find.byWidgetPredicate(
          (widget) => switch (widget) {
            Text(data: '1') => true,
            _ => false,
          },
        ),
        findsOneWidget,
      );
      await tester.pump(const Duration(milliseconds: 701));
      expect(
        find.byWidgetPredicate(
          (widget) => switch (widget) {
            Text(data: '1') => true,
            _ => false,
          },
        ),
        findsNothing,
      );
      await tester.enterText(find.byType(TextField), '1234');
      await tester.pump();
      expect(find.text('4'), findsNothing);
      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('preserves valid digits when length shrinks during a peek', (tester) async {
      final length = ValueNotifier(6);
      addTearDown(length.dispose);
      await tester.pumpWidget(
        Harness(
          child: ValueListenableBuilder<int>(
            valueListenable: length,
            builder: (context, value, _) =>
                DievasAuthCode(codeLength: value, obscureText: true, peekWhenObscuring: true, onCompleted: (_) {}),
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), '12345');
      await tester.enterText(find.byType(TextField), '123456');
      length.value = 4;
      await tester.pump();
      expect(tester.widget<TextField>(find.byType(TextField)).controller?.text, '1234');
      expect(tester.takeException(), isNull);
    });

    testWidgets('selected, filled, inactive and error borders use independent overrides', (tester) async {
      final error = ValueNotifier(false);
      addTearDown(error.dispose);
      await tester.pumpWidget(
        Harness(
          child: ValueListenableBuilder<bool>(
            valueListenable: error,
            builder: (context, value, _) => DievasAuthCode(
              codeLength: 4,
              hasError: value,
              selectedBorderColour: Colors.red,
              activeBorderColour: Colors.green,
              inactiveBorderColour: Colors.blue,
              selectedFillColour: Colors.orange,
              activeFillColour: Colors.yellow,
              inactiveFillColour: Colors.purple,
              errorBorderColour: Colors.pink,
              onCompleted: (_) {},
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), '1');
      await tester.pump();
      List<BoxDecoration> fields() => tester
          .widgetList<Container>(find.byType(Container))
          .map((widget) => widget.decoration)
          .whereType<BoxDecoration>()
          .where((decoration) => decoration.border != null)
          .toList();
      expect(fields().map((field) => field.color), [Colors.yellow, Colors.orange, Colors.purple, Colors.purple]);
      expect(fields().map((field) => field.border?.top.color), [Colors.green, Colors.red, Colors.blue, Colors.blue]);
      error.value = true;
      await tester.pump();
      expect(fields().map((field) => field.border?.top.color), everyElement(Colors.pink));
    });

    testWidgets('all shapes fit a narrow viewport with seven fields and large gaps', (tester) async {
      for (final shape in DievasAuthCodeShape.values) {
        await tester.pumpWidget(
          Harness(
            child: SizedBox(
              width: 160,
              child: DievasAuthCode(codeLength: 7, shape: shape, gap: 32, autofocus: false, onCompleted: (_) {}),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('disabled fields cannot focus and expose an accessible input label', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasAuthCode(codeLength: 4, enabled: false, semanticLabel: 'Verification code', onCompleted: (_) {}),
        ),
      );
      await tester.tap(find.byType(DievasAuthCode));
      await tester.pump();
      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.focusNode?.hasFocus, isFalse);
      expect(field.decoration?.labelText, 'Verification code');
      expect(field.autofillHints, contains(AutofillHints.oneTimeCode));
      expect(field.enabled, isFalse);
    });

    testWidgets('error transitions shake and reduced motion keeps the fields still', (tester) async {
      for (final reducedMotion in [false, true]) {
        final error = ValueNotifier(false);
        await tester.pumpWidget(
          Harness(
            child: MediaQuery(
              data: MediaQueryData(disableAnimations: reducedMotion),
              child: ValueListenableBuilder<bool>(
                valueListenable: error,
                builder: (context, value, _) => DievasAuthCode(
                  codeLength: 4,
                  autofocus: false,
                  hasError: value,
                  errorShakeAnimation: true,
                  onCompleted: (_) {},
                ),
              ),
            ),
          ),
        );
        error.value = true;
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 50));
        final transform = tester.widget<Transform>(
          find.descendant(of: find.byType(DievasAuthCode), matching: find.byType(Transform)).first,
        );
        expect(transform.transform.storage[12], reducedMotion ? equals(0) : isNot(0));
        await tester.pump(const Duration(milliseconds: 400));
        await tester.pumpWidget(const SizedBox());
        error.dispose();
      }
    });
  });
}
