import 'package:dievas/dievas.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  testWidgets('tap requests a value without changing caller-owned state', (tester) async {
    final requests = <bool>[];
    await tester.pumpWidget(Harness(child: DievasSwitch(value: false, onChanged: requests.add)));
    await tester.tap(find.byType(DievasSwitch));
    await tester.tap(find.byType(DievasSwitch));
    expect(requests, [true, true]);
    expect(tester.widget<DievasSwitch>(find.byType(DievasSwitch)).value, isFalse);
  });

  for (final entry in const [
    (DievasSwitchSize.xxs, Size(32, 16)),
    (DievasSwitchSize.xs, Size(44, 24)),
    (DievasSwitchSize.sm, Size(60, 32)),
  ]) {
    testWidgets('${entry.$1.name} uses reference geometry', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: Center(
            child: DievasSwitch(value: false, onChanged: (_) {}, switchSize: entry.$1),
          ),
        ),
      );
      expect(tester.getSize(find.byType(DievasSwitch)), entry.$2);
    });
  }

  testWidgets('keyboard activation and caller-owned focus survive replacement', (tester) async {
    final node = FocusNode();
    addTearDown(node.dispose);
    final requests = <bool>[];
    await tester.pumpWidget(
      Harness(
        child: DievasSwitch(value: false, onChanged: requests.add, focusNode: node),
      ),
    );
    node.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    expect(requests, [true, true]);
    await tester.pumpWidget(const SizedBox());
    expect(() => node.addListener(() {}), returnsNormally);
  });

  testWidgets('reports toggled and disabled semantics', (tester) async {
    final semantics = tester.ensureSemantics();
    try {
      await tester.pumpWidget(
        const Harness(child: DievasSwitch(value: true, onChanged: null, semanticLabel: 'Dark mode')),
      );
      expect(
        tester.getSemantics(find.bySemanticsLabel('Dark mode')),
        matchesSemantics(label: 'Dark mode', hasToggledState: true, isToggled: true, hasEnabledState: true),
      );
    } finally {
      semantics.dispose();
    }
  });

  for (final rtl in [false, true]) {
    testWidgets('drag follows ${rtl ? 'RTL' : 'LTR'} and settles to accepted state', (tester) async {
      bool value = false;
      final requests = <bool>[];
      const thumbContent = SizedBox.expand(key: ValueKey('thumb-content'));
      await tester.pumpWidget(
        Harness(
          child: Directionality(
            textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
            child: Center(
              child: StatefulBuilder(
                builder: (context, setState) => DievasSwitch(
                  value: value,
                  width: 100,
                  activeThumbWidget: thumbContent,
                  inactiveThumbWidget: thumbContent,
                  onChanged: (next) {
                    requests.add(next);
                    setState(() => value = next);
                  },
                ),
              ),
            ),
          ),
        ),
      );
      await tester.drag(find.byType(DievasSwitch), Offset(rtl ? -70 : 70, 0));
      await tester.pumpAndSettle();
      expect(requests, [true]);
      expect(value, isTrue);
      final track = tester.getRect(find.byType(DievasSwitch));
      final thumb = tester.getRect(find.byKey(const ValueKey('thumb-content')));
      final inset = DievasLightThemeData().components.toggle.thumbPadding;
      expect(thumb.center.dy, closeTo(track.center.dy, 0.01));
      expect(rtl ? thumb.left - track.left : track.right - thumb.right, closeTo(inset, 0.01));
    });
  }

  testWidgets('rejected drag returns thumb to controlled value', (tester) async {
    final requests = <bool>[];
    const thumbContent = SizedBox.expand(key: ValueKey('thumb-content'));
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasSwitch(
            value: false,
            width: 100,
            onChanged: requests.add,
            activeThumbWidget: thumbContent,
            inactiveThumbWidget: thumbContent,
          ),
        ),
      ),
    );
    await tester.drag(find.byType(DievasSwitch), const Offset(70, 0));
    await tester.pumpAndSettle();
    expect(requests, [true]);
    final track = tester.getRect(find.byType(DievasSwitch));
    final thumb = tester.getRect(find.byKey(const ValueKey('thumb-content')));
    expect(thumb.left - track.left, closeTo(DievasLightThemeData().components.toggle.thumbPadding, 0.01));
  });

  testWidgets('disabled switch ignores pointer and keyboard', (tester) async {
    final node = FocusNode();
    addTearDown(node.dispose);
    await tester.pumpWidget(
      Harness(
        child: Center(child: DievasSwitch(value: false, onChanged: null, focusNode: node)),
      ),
    );
    await tester.tap(find.byType(DievasSwitch));
    await tester.drag(find.byType(DievasSwitch), const Offset(70, 0));
    node.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    expect(tester.widget<DievasSwitch>(find.byType(DievasSwitch)).value, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion settles immediately and switches custom slots', (tester) async {
    bool value = false;
    await tester.pumpWidget(
      Harness(
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: Center(
            child: StatefulBuilder(
              builder: (context, setState) => DievasSwitch(
                value: value,
                onChanged: (next) => setState(() => value = next),
                activeThumbWidget: const Text('A'),
                inactiveThumbWidget: const Text('B'),
                activeTrackWidget: const Text('ON'),
                inactiveTrackWidget: const Text('OFF'),
              ),
            ),
          ),
        ),
      ),
    );
    expect(find.text('B'), findsOneWidget);
    await tester.tap(find.byType(DievasSwitch));
    await tester.pump();
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsNothing);
    expect(tester.hasRunningAnimations, isFalse);
  });

  testWidgets('long labels wrap in a narrow RTL row', (tester) async {
    await tester.pumpWidget(
      Harness(
        child: Directionality(
          textDirection: .rtl,
          child: Center(
            child: SizedBox(
              width: 130,
              child: DievasSwitch(value: false, onChanged: (_) {}, label: 'A long notification preference label'),
            ),
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('instance geometry and colours override theme defaults', (tester) async {
    const active = Color(0xFF225588);
    const inactive = Color(0xFFDDCCAA);
    const thumb = Color(0xFFABCDEF);
    await tester.pumpWidget(
      Harness(
        child: Center(
          child: DievasSwitch(
            value: true,
            onChanged: (_) {},
            width: 80,
            height: 40,
            thumbSize: 24,
            padding: const EdgeInsetsDirectional.fromSTEB(4, 8, 12, 8),
            activeTrackColour: active,
            inactiveTrackColour: inactive,
            thumbColour: thumb,
          ),
        ),
      ),
    );
    expect(tester.getSize(find.byType(DievasSwitch)), const Size(80, 40));
    final containers = tester.widgetList<Container>(
      find.descendant(of: find.byType(DievasSwitch), matching: find.byType(Container)),
    );
    expect(
      containers.map((container) => container.decoration),
      containsAll([
        isA<BoxDecoration>().having((decoration) => decoration.color, 'active track', active),
        isA<BoxDecoration>().having((decoration) => decoration.color, 'thumb', thumb),
      ]),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('haptics can be disabled independently of activation', (tester) async {
    final calls = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      calls.add(call);
      return null;
    });
    addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, null));
    final requests = <bool>[];
    await tester.pumpWidget(
      Harness(
        child: Center(child: DievasSwitch(value: false, onChanged: requests.add, hasHapticFeedback: false)),
      ),
    );
    await tester.tap(find.byType(DievasSwitch));
    expect(requests, [true]);
    expect(calls.where((call) => call.method == 'HapticFeedback.vibrate'), isEmpty);
    await tester.pumpWidget(
      Harness(
        child: Center(child: DievasSwitch(value: false, onChanged: requests.add)),
      ),
    );
    await tester.tap(find.byType(DievasSwitch));
    expect(calls.where((call) => call.method == 'HapticFeedback.vibrate'), hasLength(1));
  });

  test('theme retains explicit switch geometry and shadow through copies', () {
    final theme = DievasLightThemeData().components.toggle;
    final custom = theme.copyWith(trackWidth: 72, thumbSize: 20, thumbShadow: const []);
    expect(custom.trackWidth, 72);
    expect(custom.thumbSize, 20);
    expect(custom.thumbShadow, isEmpty);
    expect(custom.copyWith(), custom);
    expect(custom, isNot(theme));
  });
}
