import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _harness(Widget child) => DievasScope(
  lightTheme: DievasLightThemeData(),
  darkTheme: DievasDarkThemeData(),
  child: MaterialApp(home: Scaffold(body: child)),
);

void main() {
  group('DievasAvatar', () {
    testWidgets('renders placeholder without throwing — default args', (tester) async {
      await tester.pumpWidget(_harness(const DievasAvatar()));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders all sizes', (tester) async {
      for (final size in DievasAvatarSize.values) {
        await tester.pumpWidget(_harness(DievasAvatar(size: size)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders both shapes', (tester) async {
      for (final shape in DievasAvatarShape.values) {
        await tester.pumpWidget(_harness(DievasAvatar(shape: shape)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders initials when no image provider', (tester) async {
      await tester.pumpWidget(_harness(const DievasAvatar(initials: 'AB')));
      expect(tester.takeException(), isNull);
      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('truncates initials to 2 characters', (tester) async {
      await tester.pumpWidget(_harness(const DievasAvatar(initials: 'ABC')));
      expect(tester.takeException(), isNull);
      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('uppercases initials', (tester) async {
      await tester.pumpWidget(_harness(const DievasAvatar(initials: 'ab')));
      expect(tester.takeException(), isNull);
      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('renders semantic label', (tester) async {
      await tester.pumpWidget(_harness(const DievasAvatar(semanticLabel: 'User avatar')));
      expect(tester.takeException(), isNull);
      expect(find.bySemanticsLabel('User avatar'), findsOneWidget);
    });
  });
}
