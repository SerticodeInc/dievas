import 'package:dievas/dievas.dart';
import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('semantic easing defaults preserve cubic motion and allow overrides', () {
    const animation = DievasAnimationThemeData();
    for (final (curve, token) in [
      (animation.easingStandard, DievasEasingSemantic.standard),
      (animation.easingEnter, DievasEasingSemantic.enter),
      (animation.easingExit, DievasEasingSemantic.exit),
    ]) {
      final expected = Cubic(token.x1, token.y1, token.x2, token.y2);
      for (final time in [0.0, 0.25, 0.5, 0.75, 1.0]) {
        expect(curve.transform(time), expected.transform(time));
      }
    }
    expect(animation.copyWith(easingEnter: Curves.linear).easingEnter, Curves.linear);
    expect(animation.copyWith().easingStandard, animation.easingStandard);
  });

  testWidgets('z-index changes rebuild their dependents and survive theme copies', (tester) async {
    final colours = DievasLightThemeData().colours;
    var theme = DievasGlobalThemeData(colours: colours);
    var zIndexBuilds = 0;
    var spacingBuilds = 0;
    late StateSetter update;
    final child = Column(
      children: [
        Builder(
          builder: (context) {
            zIndexBuilds++;
            expect(context.zIndex.modal, theme.zIndex.modal);
            expect(context.border.R64, BorderRadius.circular(DievasRadiusSemantic.R64));
            return const SizedBox();
          },
        ),
        Builder(
          builder: (context) {
            spacingBuilds++;
            context.spacing.MD;
            return const SizedBox();
          },
        ),
      ],
    );
    await tester.pumpWidget(
      StatefulBuilder(
        builder: (context, setState) {
          update = setState;
          return DievasTheme(data: theme, child: child);
        },
      ),
    );
    expect(theme.zIndex.modal, DievasZIndexSemantic.modal);
    expect(zIndexBuilds, 1);
    expect(spacingBuilds, 1);
    update(() => theme = DievasGlobalThemeData(colours: colours, zIndex: theme.zIndex.copyWith(modal: 550)));
    await tester.pump();
    expect(zIndexBuilds, 2);
    expect(spacingBuilds, 1);
    final copy = theme.copyWith(components: theme.components);
    expect(copy.zIndex.modal, 550);
    expect(copy.zIndex, theme.zIndex);
  });
}
