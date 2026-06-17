import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasMenuItem', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasMenuItem(label: 'Profile')));
      expect(tester.takeException(), isNull);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('renders with leading icon', (tester) async {
      await tester.pumpWidget(
        Harness(child: const DievasMenuItem(label: 'Settings', leadingIcon: Icon(Icons.settings))),
      );
      expect(tester.takeException(), isNull);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('renders with subtitle', (tester) async {
      await tester.pumpWidget(
        Harness(child: const DievasMenuItem(label: 'Delete', subtitle: 'This cannot be undone')),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('This cannot be undone'), findsOneWidget);
    });

    testWidgets('renders with trailing widget', (tester) async {
      await tester.pumpWidget(
        Harness(child: const DievasMenuItem(label: 'Profile', trailing: Icon(Icons.chevron_right))),
      );
      expect(tester.takeException(), isNull);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('fires onTap callback', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        Harness(child: DievasMenuItem(label: 'Tap me', onTap: () => tapped = true)),
      );
      await tester.tap(find.text('Tap me'));
      expect(tapped, isTrue);
    });

    testWidgets('does not fire onTap when disabled', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        Harness(child: DievasMenuItem(label: 'Disabled', onTap: () => tapped = true, enabled: false)),
      );
      await tester.tap(find.text('Disabled'));
      expect(tapped, isFalse);
    });

    testWidgets('renders dense variant', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasMenuItem(label: 'Dense', dense: true)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders disabled state', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasMenuItem(label: 'Disabled', enabled: false)));
      expect(tester.takeException(), isNull);
    });
  });
}
