import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

enum _Variant { filled, outlined, text }

void main() {
  for (final variant in _Variant.values) {
    group(variant.name, () {
      testWidgets('tap, keyboard activation, and long press call distinct actions', (tester) async {
        int taps = 0;
        int holds = 0;
        await tester.pumpWidget(
          Harness(
            child: _Fixture(variant: variant, onPressed: () => taps++, onLongPress: () => holds++),
          ),
        );
        await tester.tap(find.text('Action'));
        expect(taps, 1);
        await tester.longPress(find.text('Action'));
        expect(holds, 1);
        expect(taps, 1);
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        expect(taps, 2);
      });

      testWidgets('long-press-only buttons work and blocked states ignore both actions', (tester) async {
        int holds = 0;
        int taps = 0;
        await tester.pumpWidget(
          Harness(
            child: _Fixture(variant: variant, onLongPress: () => holds++),
          ),
        );
        await tester.longPress(find.text('Action'));
        expect(holds, 1);
        for (final state in [DievasButtonState.loading, DievasButtonState.disabled]) {
          await tester.pumpWidget(
            Harness(
              child: _Fixture(variant: variant, state: state, onPressed: () => taps++, onLongPress: () => holds++),
            ),
          );
          await tester.tap(find.byType(_Fixture));
          await tester.longPress(find.byType(_Fixture));
        }
        expect(taps, 0);
        expect(holds, 1);
        await tester.pumpWidget(const SizedBox.shrink());
        expect(tester.takeException(), isNull);
      });

      testWidgets('full width fills the parent and loading preserves the footprint', (tester) async {
        await tester.pumpWidget(
          Harness(
            child: Center(
              child: SizedBox(
                width: 280,
                child: _Fixture(variant: variant, fullWidth: true, onPressed: () {}),
              ),
            ),
          ),
        );
        final bounds = tester.getSize(find.byType(_Fixture));
        expect(bounds.width, 280);
        await tester.pumpWidget(
          Harness(
            child: Center(
              child: SizedBox(
                width: 280,
                child: _Fixture(variant: variant, fullWidth: true, state: .loading, onPressed: () {}),
              ),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 100));
        expect(tester.getSize(find.byType(_Fixture)), bounds);
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox.shrink());
      });

      testWidgets('loading fades and scales both ways without changing size', (tester) async {
        await tester.pumpWidget(
          Harness(
            child: Center(
              child: _Fixture(variant: variant, onPressed: () {}),
            ),
          ),
        );
        final before = tester.getSize(find.byType(_Fixture));
        await tester.pumpWidget(
          Harness(
            child: Center(
              child: _Fixture(variant: variant, state: .loading, onPressed: () {}),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 70));
        final fades = tester.widgetList<FadeTransition>(
          find.descendant(of: find.byType(_Fixture), matching: find.byType(FadeTransition)),
        );
        expect(fades.every((fade) => fade.opacity.value > 0 && fade.opacity.value < 1), isTrue);
        expect(
          tester
              .widgetList<ScaleTransition>(
                find.descendant(of: find.byType(_Fixture), matching: find.byType(ScaleTransition)),
              )
              .any((scale) => scale.scale.value < 1),
          isTrue,
        );
        expect(find.byType(DievasLoader), findsOneWidget);
        expect(tester.getSize(find.byType(_Fixture)), before);
        await tester.pump(const Duration(milliseconds: 250));
        await tester.pumpWidget(
          Harness(
            child: Center(
              child: _Fixture(variant: variant, onPressed: () {}),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 70));
        expect(find.byType(DievasLoader), findsOneWidget);
        expect(tester.getSize(find.byType(_Fixture)), before);
        await tester.pumpAndSettle();
        expect(find.byType(DievasLoader), findsNothing);
      });

      testWidgets('loading transition opt-out and reduced motion switch instantly', (tester) async {
        for (final (animate, reduced) in [(false, false), (true, true)]) {
          await tester.pumpWidget(
            Harness(
              child: MediaQuery(
                data: MediaQueryData(disableAnimations: reduced),
                child: Center(
                  child: _Fixture(variant: variant, animateLoading: animate, onPressed: () {}),
                ),
              ),
            ),
          );
          await tester.pumpWidget(
            Harness(
              child: MediaQuery(
                data: MediaQueryData(disableAnimations: reduced),
                child: Center(
                  child: _Fixture(variant: variant, state: .loading, animateLoading: animate, onPressed: () {}),
                ),
              ),
            ),
          );
          final fades = tester.widgetList<FadeTransition>(
            find.descendant(of: find.byType(_Fixture), matching: find.byType(FadeTransition)),
          );
          expect(fades.every((fade) => fade.opacity.value == 0 || fade.opacity.value == 1), isTrue);
          await tester.pumpWidget(
            Harness(
              child: MediaQuery(
                data: MediaQueryData(disableAnimations: reduced),
                child: Center(
                  child: _Fixture(variant: variant, animateLoading: animate, onPressed: () {}),
                ),
              ),
            ),
          );
          expect(find.byType(DievasLoader), findsNothing);
        }
      });

      testWidgets('rapid loading reversals keep one content instance and settle', (tester) async {
        for (final state in [
          DievasButtonState.idle,
          DievasButtonState.loading,
          DievasButtonState.idle,
          DievasButtonState.loading,
          DievasButtonState.idle,
        ]) {
          await tester.pumpWidget(
            Harness(
              child: Center(
                child: _Fixture(variant: variant, state: state, onPressed: () {}),
              ),
            ),
          );
          await tester.pump(const Duration(milliseconds: 30));
          expect(find.text('Action'), findsOneWidget);
        }
        await tester.pumpAndSettle();
        expect(find.byType(DievasLoader), findsNothing);
        expect(tester.takeException(), isNull);
      });

      testWidgets('full-width icon-only buttons stay finite with unbounded width', (tester) async {
        await tester.pumpWidget(
          Harness(
            child: Center(
              child: UnconstrainedBox(
                constrainedAxis: .vertical,
                child: _Fixture(variant: variant, label: '', fullWidth: true, onPressed: () {}),
              ),
            ),
          ),
        );
        expect(tester.getSize(find.byType(_Fixture)).width.isFinite, isTrue);
        expect(tester.takeException(), isNull);
      });

      testWidgets('long labels wrap on narrow screens with large RTL text', (tester) async {
        await tester.pumpWidget(
          Harness(
            child: MediaQuery(
              data: const MediaQueryData(textScaler: TextScaler.linear(2)),
              child: Directionality(
                textDirection: .rtl,
                child: Center(
                  child: SizedBox(
                    width: 180,
                    child: _Fixture(variant: variant, label: 'A long action label that must wrap', onPressed: () {}),
                  ),
                ),
              ),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('pulse animates on press and reduced motion suppresses it', (tester) async {
        for (final reduced in [false, true]) {
          await tester.pumpWidget(
            Harness(
              child: MediaQuery(
                data: MediaQueryData(disableAnimations: reduced),
                child: Center(
                  child: _Fixture(variant: variant, pulse: true, onPressed: () {}),
                ),
              ),
            ),
          );
          final gesture = await tester.startGesture(tester.getCenter(find.text('Action')));
          await tester.pump(const Duration(milliseconds: 120));
          await tester.pump(const Duration(milliseconds: 60));
          final scales = tester.widgetList<Transform>(
            find.descendant(of: find.byType(_Fixture), matching: find.byType(Transform)),
          );
          expect(scales.any((transform) => transform.transform.storage.first < 0.999), !reduced);
          await gesture.up();
          await tester.pumpAndSettle();
          await tester.tap(find.text('Action'));
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 60));
          expect(
            tester
                .widgetList<Transform>(find.descendant(of: find.byType(_Fixture), matching: find.byType(Transform)))
                .any((transform) => transform.transform.storage.first < 0.999),
            !reduced,
          );
          await tester.pumpAndSettle();
        }
      });

      testWidgets('border hiding wins over an explicit border colour', (tester) async {
        await tester.pumpWidget(
          Harness(
            child: _Fixture(variant: variant, showBorder: false, onPressed: () {}),
          ),
        );
        final surface = tester
            .widgetList<Container>(find.descendant(of: find.byType(_Fixture), matching: find.byType(Container)))
            .where(
              (container) => switch (container.decoration) {
                ShapeDecoration() => true,
                _ => false,
              },
            )
            .single;
        expect(switch (surface.decoration) {
          ShapeDecoration(shape: OutlinedBorder(:final side)) => side,
          _ => null,
        }, BorderSide.none);
      });
    });
  }
}

class _Fixture extends StatelessWidget {
  const _Fixture({
    required this.variant,
    this.state = .idle,
    this.fullWidth = false,
    this.label = 'Action',
    this.pulse = false,
    this.showBorder,
    this.animateLoading = true,
    this.onPressed,
    this.onLongPress,
  });

  final _Variant variant;
  final DievasButtonState state;
  final bool fullWidth;
  final String label;
  final bool pulse;
  final bool? showBorder;
  final bool animateLoading;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) => switch (variant) {
    .filled => DievasFilledButton(
      label: label,
      state: state,
      isFullWidth: fullWidth,
      showPulseEffect: pulse,
      animateLoading: animateLoading,
      showPulseEffectJiggle: pulse,
      showBorder: showBorder,
      borderColor: Colors.red,
      leadingIcon: const DievasIcon(Icons.add),
      trailingIcon: const DievasIcon(Icons.keyboard_arrow_right),
      onPressed: onPressed,
      onLongPress: onLongPress,
    ),
    .outlined => DievasOutlinedButton(
      label: label,
      state: state,
      isFullWidth: fullWidth,
      showPulseEffect: pulse,
      animateLoading: animateLoading,
      showPulseEffectJiggle: pulse,
      showBorder: showBorder,
      borderColor: Colors.red,
      leadingIcon: const DievasIcon(Icons.add),
      trailingIcon: const DievasIcon(Icons.keyboard_arrow_right),
      onPressed: onPressed,
      onLongPress: onLongPress,
    ),
    .text => DievasTextButton(
      label: label,
      state: state,
      isFullWidth: fullWidth,
      showPulseEffect: pulse,
      animateLoading: animateLoading,
      showPulseEffectJiggle: pulse,
      showBorder: showBorder,
      borderColor: Colors.red,
      leadingIcon: const DievasIcon(Icons.add),
      trailingIcon: const DievasIcon(Icons.keyboard_arrow_right),
      onPressed: onPressed,
      onLongPress: onLongPress,
    ),
  };
}
