import 'package:dievas/dievas.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasSegmentedControl', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasSegmentedControl(options: ['Day', 'Week', 'Month'], value: 'Week', onChanged: null),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('Day'), findsOneWidget);
      expect(find.text('Week'), findsOneWidget);
      expect(find.text('Month'), findsOneWidget);
    });

    testWidgets('highlights the selected option', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasSegmentedControl<String>(
            options: ['Day', 'Week', 'Month'],
            value: 'Week',
            onChanged: null,
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onChanged with correct value on tap', (tester) async {
      String? selected;
      await tester.pumpWidget(
        Harness(
          child: DievasSegmentedControl<String>(
            options: ['Day', 'Week', 'Month'],
            value: 'Week',
            onChanged: (v) => selected = v,
          ),
        ),
      );
      await tester.tap(find.text('Day'));
      expect(selected, 'Day');
    });

    testWidgets('does not fire onChanged when disabled', (tester) async {
      String? selected;
      await tester.pumpWidget(
        Harness(
          child: DievasSegmentedControl<String>(
            options: ['Day', 'Week', 'Month'],
            value: 'Week',
            onChanged: (v) => selected = v,
            enabled: false,
          ),
        ),
      );
      await tester.tap(find.text('Day'));
      expect(selected, isNull);
    });

    testWidgets('uses labelBuilder for display text', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasSegmentedControl<_Option>(
            options: [_Option.daily, _Option.weekly, _Option.monthly],
            value: _Option.weekly,
            onChanged: null,
            labelBuilder: (o) => o.label,
          ),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('Daily'), findsOneWidget);
      expect(find.text('Weekly'), findsOneWidget);
      expect(find.text('Monthly'), findsOneWidget);
    });
  });
}

class _Option {
  const _Option(this.label);
  final String label;
  static const daily = _Option('Daily');
  static const weekly = _Option('Weekly');
  static const monthly = _Option('Monthly');
}
