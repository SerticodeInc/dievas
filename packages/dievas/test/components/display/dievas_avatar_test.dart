import 'dart:io';
import 'dart:typed_data';

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
      await tester.pumpWidget(
        Harness(
          child: const DievasAvatar(initials: 'AB', initialsColour: Color(0xFF654321)),
        ),
      );
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
      final decoration = container.foregroundDecoration as BoxDecoration;
      expect(decoration.border, Border.all(color: const Color(0xFFAA00BB)));
    });

    testWidgets('omits border when no border colour provided', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasAvatar()));
      final container = tester.widget<Container>(find.byType(Container));
      expect(container.foregroundDecoration, isNull);
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

    testWidgets('rounded-square default uses primary theme foreground and xl2 is 80dp', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasAvatar(size: .xl2, initials: 'MD'),
        ),
      );
      expect(tester.getSize(find.byType(DievasAvatar)), const Size(80, 80));
      final theme = DievasTheme.componentsOf(tester.element(find.byType(DievasAvatar))).avatar;
      final container = tester.widget<Container>(find.byType(Container));
      expect((container.decoration as BoxDecoration).borderRadius, theme.borderRadiusSquare);
      expect(tester.widget<Text>(find.text('MD')).style?.color, theme.initialsColour);
    });

    testWidgets('custom dimensions and directional radius take precedence over shape', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const Directionality(
            textDirection: .rtl,
            child: DievasAvatar(
              width: 96,
              height: 64,
              shape: .circle,
              borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(12)),
            ),
          ),
        ),
      );
      expect(tester.getSize(find.byType(DievasAvatar)), const Size(96, 64));
      final container = tester.widget<Container>(find.byType(Container));
      expect(
        (container.decoration as BoxDecoration).borderRadius,
        const BorderRadius.only(topRight: Radius.circular(12)),
      );
    });

    testWidgets('circle is clipped and a custom border paints in the foreground', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasAvatar(
            shape: .circle,
            borderColour: Colors.red,
            borderWidth: 3,
            content: ColoredBox(color: Colors.blue),
          ),
        ),
      );
      final clipper = tester.widget<ClipPath>(find.byType(ClipPath)).clipper;
      expect(clipper?.getClip(const Size(40, 40)).contains(Offset.zero), isFalse);
      expect(clipper?.getClip(const Size(40, 40)).contains(const Offset(20, 20)), isTrue);
      expect(
        (tester.widget<Container>(find.byType(Container)).foregroundDecoration as BoxDecoration).border,
        Border.all(color: Colors.red, width: 3),
      );
    });

    testWidgets('initials preserve complete emoji and combining characters', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasAvatar(initials: '👩🏽‍💻éz')));
      expect(find.text('👩🏽‍💻É'), findsOneWidget);
    });

    testWidgets('custom content inherits text and icon colours', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasAvatar(
            initials: 'AB',
            initialsColour: Colors.red,
            placeholderColour: Colors.blue,
            content: Builder(
              builder: (context) {
                expect(DefaultTextStyle.of(context).style.color, Colors.red);
                expect(IconTheme.of(context).color, Colors.blue);
                return const Text('Custom');
              },
            ),
          ),
        ),
      );
      expect(find.text('Custom'), findsOneWidget);
      expect(find.text('AB'), findsNothing);
    });

    testWidgets('badges follow all four corners in LTR and RTL rectangular avatars', (tester) async {
      for (final direction in TextDirection.values) {
        for (final alignment in DievasAvatarBadgeAlignment.values) {
          await tester.pumpWidget(
            Harness(
              child: Directionality(
                textDirection: direction,
                child: DievasAvatar(
                  width: 96,
                  height: 64,
                  showBadge: true,
                  badgeSize: 8,
                  badgeAlignment: alignment,
                  badgeSemanticLabel: 'Online',
                ),
              ),
            ),
          );
          final origin = tester.getTopLeft(find.byType(DievasAvatar));
          final logicalLeft = alignment == .topLeft || alignment == .bottomLeft;
          final isLeft = direction == .ltr ? logicalLeft : !logicalLeft;
          final isTop = alignment == .topLeft || alignment == .topRight;
          expect(tester.getTopLeft(find.bySemanticsLabel('Online')) - origin, Offset(isLeft ? 0 : 88, isTop ? 0 : 56));
          expect(tester.getSize(find.bySemanticsLabel('Online')), const Size(8, 8));
        }
      }
    });

    testWidgets('badge gap cuts through the avatar without painting a background ring', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasAvatar(
            width: 64,
            height: 64,
            showBadge: true,
            badgeSize: 8,
            badgeMarginValue: 4,
            badgeColour: Colors.red,
            badgeSemanticLabel: 'Online',
          ),
        ),
      );
      final clipper = tester.widget<ClipPath>(find.byType(ClipPath)).clipper;
      expect(clipper?.getClip(const Size(64, 64)).contains(const Offset(60, 60)), isFalse);
      expect(clipper?.getClip(const Size(64, 64)).contains(const Offset(54, 60)), isFalse);
      expect(clipper?.getClip(const Size(64, 64)).contains(const Offset(49, 60)), isTrue);
      final badge = tester.widget<DecoratedBox>(
        find.descendant(of: find.bySemanticsLabel('Online'), matching: find.byType(DecoratedBox)),
      );
      expect((badge.decoration as BoxDecoration).color, Colors.red);
    });

    testWidgets('badge and avatar labels remain distinct without duplicate initials', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasAvatar(
            initials: 'AB',
            semanticLabel: 'Ada avatar',
            showBadge: true,
            badgeSemanticLabel: 'Online',
          ),
        ),
      );
      expect(find.bySemanticsLabel('Ada avatar'), findsOneWidget);
      expect(find.bySemanticsLabel('Online'), findsOneWidget);
      expect(find.bySemanticsLabel('AB'), findsNothing);
    });

    testWidgets('failed images fall back to initials and placeholder without an exception', (tester) async {
      final provider = MemoryImage(Uint8List(0));
      await tester.pumpWidget(
        Harness(
          child: DievasAvatar(imageProvider: provider, initials: 'AB'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('AB'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(Harness(child: DievasAvatar(imageProvider: provider)));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('loaded images replace initials, preserve border, and allow content overlays', (tester) async {
      final provider = MemoryImage(File('test/fixtures/avatar.jpg').readAsBytesSync());
      await tester.pumpWidget(
        Harness(
          child: DievasAvatar(imageProvider: provider, initials: 'AB'),
        ),
      );
      expect(find.text('AB'), findsOneWidget);
      await tester.pumpWidget(
        Harness(
          child: DievasAvatar(
            imageProvider: provider,
            initials: 'AB',
            borderColour: Colors.red,
            content: const Icon(Icons.star),
          ),
        ),
      );
      await tester.runAsync(() => precacheImage(provider, tester.element(find.byType(DievasAvatar))));
      await tester.pumpAndSettle();
      expect(find.byType(RawImage), findsOneWidget);
      expect(tester.widget<RawImage>(find.byType(RawImage)).image, isNotNull);
      expect(find.text('AB'), findsNothing);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(
        (tester.widget<Container>(find.byType(Container)).foregroundDecoration as BoxDecoration).border,
        Border.all(color: Colors.red),
      );
      await tester.pumpWidget(
        Harness(
          child: DievasAvatar(imageProvider: provider, initials: 'AB'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('AB'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('badge defaults scale and theme copies preserve new properties', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasAvatar(size: .xl2, showBadge: true, badgeSemanticLabel: 'Online'),
          themeOverrides: (theme) => theme.copyWith(
            components: theme.components.copyWith(
              avatar: theme.components.avatar.copyWith(
                sizeXl2: 100,
                badgeSizeFactor: 0.1,
                badgeMarginFactor: 0.03,
                badgeColour: Colors.purple,
              ),
            ),
          ),
        ),
      );
      expect(tester.getSize(find.byType(DievasAvatar)), const Size(100, 100));
      expect(tester.getSize(find.bySemanticsLabel('Online')), const Size(10, 10));
    });
  });
}
