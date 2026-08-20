import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
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

    testWidgets('applies per-instance background colour', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasAvatar(backgroundColour: Color(0xFF123456))));
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, const Color(0xFF123456));
    });

    testWidgets('applies per-instance initials colour', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasAvatar(initials: 'AB', initialsColour: Color(0xFF654321))));
      final text = tester.widget<Text>(find.text('AB'));
      expect(text.style?.color, const Color(0xFF654321));
    });

    testWidgets('applies per-instance placeholder colour', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasAvatar(placeholderColour: Color(0xFF112233))));
      final icon = tester.widget<Icon>(find.byIcon(Icons.person));
      expect(icon.color, const Color(0xFF112233));
    });

    testWidgets('renders border when border colour provided', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasAvatar(borderColour: Color(0xFFAA00BB))));
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, Border.all(color: const Color(0xFFAA00BB)));
    });

    testWidgets('omits border when no border colour provided', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasAvatar()));
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isNull);
    });

    testWidgets('falls back to theme when overrides are null', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasAvatar(),
          themeOverrides: (theme) => theme.copyWith(
            components: theme.components.copyWith(
              avatar: theme.components.avatar.copyWith(backgroundColour: const Color(0xFF0000FF)),
            ),
          ),
        ),
      );
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, const Color(0xFF0000FF));
    });
  });
}
