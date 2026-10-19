import 'package:dievas/dievas.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasCheckbox', () {
    testWidgets('tristate cycles unchecked, checked, mixed and back', (tester) async {
      await tester.pumpWidget(const Harness(child: _Interactive(tristate: true)));
      for (final expected in [
        DievasCheckboxValue.checked,
        DievasCheckboxValue.indeterminate,
        DievasCheckboxValue.unchecked,
      ]) {
        await tester.tap(find.byType(DievasCheckbox));
        await tester.pumpAndSettle();
        expect(tester.widget<DievasCheckbox>(find.byType(DievasCheckbox)).value, expected);
      }
    });

    testWidgets('binary mode toggles and recovers a supplied mixed value', (tester) async {
      await tester.pumpWidget(const Harness(child: _Interactive()));
      for (final expected in [DievasCheckboxValue.checked, DievasCheckboxValue.unchecked]) {
        await tester.tap(find.byType(DievasCheckbox));
        await tester.pumpAndSettle();
        expect(tester.widget<DievasCheckbox>(find.byType(DievasCheckbox)).value, expected);
      }
      DievasCheckboxValue? result;
      await tester.pumpWidget(
        Harness(
          child: DievasCheckbox(value: .indeterminate, onChanged: (value) => result = value),
        ),
      );
      await tester.tap(find.byType(DievasCheckbox));
      expect(result, DievasCheckboxValue.checked);
    });

    testWidgets('supports keyboard activation and disables it with the callback', (tester) async {
      int changes = 0;
      final focus = FocusNode();
      await tester.pumpWidget(
        Harness(
          child: DievasCheckbox(value: .unchecked, focusNode: focus, autofocus: true, onChanged: (_) => changes++),
        ),
      );
      await tester.pumpAndSettle();
      expect(focus.hasFocus, isTrue);
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      expect(changes, 1);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      expect(changes, 2);
      await tester.pumpWidget(
        Harness(
          child: DievasCheckbox(value: .unchecked, focusNode: focus, onChanged: null),
        ),
      );
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.tap(find.byType(DievasCheckbox));
      expect(changes, 2);
      await tester.pumpWidget(const SizedBox.shrink());
      focus.dispose();
    });

    testWidgets('has a 40px hit target around a 16px box', (tester) async {
      int changes = 0;
      await tester.pumpWidget(
        Harness(
          child: Center(
            child: DievasCheckbox(value: .unchecked, onChanged: (_) => changes++),
          ),
        ),
      );
      expect(tester.getSize(find.byType(DievasCheckbox)), const Size(40, 40));
      final bounds = tester.getRect(find.byType(DievasCheckbox));
      await tester.tapAt(bounds.topLeft + const Offset(2, 2));
      expect(changes, 1);
      expect(tester.getSize(find.byType(CustomPaint).last), const Size(16, 16));
    });

    testWidgets('label row is clickable and mirrors its trailing box in RTL', (tester) async {
      int changes = 0;
      for (final direction in TextDirection.values) {
        await tester.pumpWidget(
          Harness(
            child: Directionality(
              textDirection: direction,
              child: SizedBox(
                width: 300,
                child: DievasCheckbox(
                  value: .unchecked,
                  label: 'With label',
                  labelPosition: .start,
                  isFullWidth: true,
                  onChanged: (_) => changes++,
                ),
              ),
            ),
          ),
        );
        await tester.tap(find.text('With label'));
        final textX = tester.getCenter(find.text('With label')).dx;
        final boxX = tester.getCenter(find.byType(CustomPaint).last).dx;
        expect(direction == .ltr ? boxX > textX : boxX < textX, isTrue);
      }
      expect(changes, 2);
    });

    testWidgets('long labels wrap without parent-data or overflow errors', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(2)),
            child: Center(
              child: SizedBox(
                width: 180,
                child: DievasCheckbox(
                  value: .checked,
                  label: 'Accept these lengthy terms and conditions',
                  onChanged: (_) {},
                ),
              ),
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('mixed semantics expose the accessible label and mixed state', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        Harness(
          child: DievasCheckbox(value: .indeterminate, tristate: true, semanticLabel: 'Select all', onChanged: (_) {}),
        ),
      );
      expect(
        tester.getSemantics(find.bySemanticsLabel('Select all')),
        matchesSemantics(
          label: 'Select all',
          hasCheckedState: true,
          isCheckStateMixed: true,
          hasEnabledState: true,
          isEnabled: true,
          hasTapAction: true,
          isFocusable: true,
          hasFocusAction: true,
        ),
      );
      handle.dispose();
    });

    testWidgets('value drawing animates normally and snaps under reduced motion', (tester) async {
      for (final reduced in [false, true]) {
        await tester.pumpWidget(
          Harness(
            child: MediaQuery(
              data: MediaQueryData(disableAnimations: reduced),
              child: const _Interactive(),
            ),
          ),
        );
        await tester.tap(find.byType(DievasCheckbox));
        await tester.pump();
        final first = tester.widget<CustomPaint>(find.byType(CustomPaint).last).painter;
        await tester.pump(const Duration(milliseconds: 70));
        final second = tester.widget<CustomPaint>(find.byType(CustomPaint).last).painter;
        if ((first, second) case (final first?, final second?)) {
          expect(second.shouldRepaint(first), !reduced);
        }
        await tester.pumpAndSettle();
        await tester.pumpWidget(const SizedBox.shrink());
      }
    });

    testWidgets('renders without throwing — unchecked', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasCheckbox(value: .unchecked, onChanged: null)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders checked state', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasCheckbox(value: .checked, onChanged: null)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders indeterminate state', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasCheckbox(value: .indeterminate, onChanged: null)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with label', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasCheckbox(value: .checked, onChanged: null, label: 'Accept terms'),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('Accept terms'), findsOneWidget);
    });

    testWidgets('fires onChanged on tap', (tester) async {
      DievasCheckboxValue? result;
      await tester.pumpWidget(
        Harness(
          child: DievasCheckbox(value: .unchecked, onChanged: (v) => result = v),
        ),
      );
      await tester.tap(find.byType(DievasCheckbox));
      expect(result, DievasCheckboxValue.checked);
    });

    testWidgets('disabled when onChanged is null', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasCheckbox(value: .checked, onChanged: null)));
      expect(tester.takeException(), isNull);
    });
  });
}

class _Interactive extends StatefulWidget {
  const _Interactive({this.tristate = false});
  final bool tristate;

  @override
  State<_Interactive> createState() => _InteractiveState();
}

class _InteractiveState extends State<_Interactive> {
  DievasCheckboxValue _value = .unchecked;

  @override
  Widget build(BuildContext context) =>
      DievasCheckbox(value: _value, tristate: widget.tristate, onChanged: (value) => setState(() => _value = value));
}
