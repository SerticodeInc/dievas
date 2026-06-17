import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasSnackbar', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasSnackbar(message: 'Snackbar message')));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders message text', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasSnackbar(message: 'Snackbar message')));
      expect(find.text('Snackbar message'), findsOneWidget);
    });

    testWidgets('renders leading icon when provided', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasSnackbar(
            message: 'Message',
            leadingIcon: Icon(Icons.check, key: Key('snack_icon')),
          ),
        ),
      );
      expect(find.byKey(const Key('snack_icon')), findsOneWidget);
    });

    testWidgets('renders action label when provided', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasSnackbar(
            message: 'Message',
            action: DievasSnackbarAction(label: 'Undo', onPressed: () {}),
          ),
        ),
      );
      expect(find.text('Undo'), findsOneWidget);
    });

    testWidgets('fires action onPressed when tapped', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        Harness(
          child: DievasSnackbar(
            message: 'Message',
            action: DievasSnackbarAction(label: 'Undo', onPressed: () => pressed = true),
          ),
        ),
      );
      await tester.tap(find.text('Undo'));
      expect(pressed, isTrue);
    });

    testWidgets('renders with custom background color', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasSnackbar(message: 'Message', backgroundColor: Colors.red),
        ),
      );
      expect(tester.takeException(), isNull);
    });
  });
}
