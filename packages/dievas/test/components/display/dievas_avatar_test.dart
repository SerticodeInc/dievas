import 'package:dievas/dievas.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasAvatar', () {
    testWidgets('renders placeholder without throwing — default args', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasAvatar()));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders all sizes', (tester) async {
      for (final size in DievasAvatarSize.values) {
        await tester.pumpWidget(Harness(child: DievasAvatar(size: size)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders both shapes', (tester) async {
      for (final shape in DievasAvatarShape.values) {
        await tester.pumpWidget(Harness(child: DievasAvatar(shape: shape)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders initials when no image provider', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasAvatar(initials: 'AB')));
      expect(tester.takeException(), isNull);
      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('truncates initials to 2 characters', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasAvatar(initials: 'ABC')));
      expect(tester.takeException(), isNull);
      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('upper cases initials', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasAvatar(initials: 'ab')));
      expect(tester.takeException(), isNull);
      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('renders semantic label', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasAvatar(semanticLabel: 'User avatar')));
      expect(tester.takeException(), isNull);
      expect(find.bySemanticsLabel('User avatar'), findsOneWidget);
    });
  });
}
