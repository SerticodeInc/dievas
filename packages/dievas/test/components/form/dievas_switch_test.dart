import 'package:dievas/dievas.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasSwitch', () {
    testWidgets('renders without throwing — off', (tester) async {
      await tester.pumpWidget(Harness(child: DievasSwitch(value: false, onChanged: (_) {})));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders on state', (tester) async {
      await tester.pumpWidget(Harness(child: DievasSwitch(value: true, onChanged: (_) {})));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with label', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasSwitch(value: true, onChanged: null, label: 'Dark mode')));
      expect(tester.takeException(), isNull);
      expect(find.text('Dark mode'), findsOneWidget);
    });

    testWidgets('fires onChanged on tap', (tester) async {
      bool? result;
      await tester.pumpWidget(Harness(child: DievasSwitch(value: false, onChanged: (v) => result = v)));
      await tester.tap(find.byType(DievasSwitch));
      expect(result, isTrue);
    });

    testWidgets('disabled when onChanged is null', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasSwitch(value: true, onChanged: null)));
      expect(tester.takeException(), isNull);
    });
  });
}
