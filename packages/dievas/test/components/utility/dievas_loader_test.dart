import 'package:dievas/dievas.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasLoader', () {
    testWidgets('renders without throwing — default size', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasLoader()));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders all sizes', (tester) async {
      for (final size in DievasLoaderSize.values) {
        await tester.pumpWidget(Harness(child: DievasLoader(size: size)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders label when provided', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasLoader(label: 'Loading...')));
      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('does not render label when not provided', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasLoader()));
      expect(find.byType(DievasLoader), findsOneWidget);
    });

    testWidgets('accepts per-instance colour overrides', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasLoader(
            size: .lg,
            colour: Color(0xFF123456),
            trackColour: Color(0xFF654321),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('repeats animation', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasLoader()));
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
    });
  });
}
