import 'package:dievas/dievas.dart';
import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dialog and menu backgrounds can change independently', () {
    final original = DievasLightThemeData().colours;
    final theme = DievasGlobalThemeData(
      colours: original.copyWith(
        background: original.background.copyWith(dialogBackground: Colors.purple, menuBackground: Colors.green),
      ),
    );

    expect(theme.components.modal.backgroundColour, Colors.purple);
    expect(theme.components.dropdown.overlayBgColour, Colors.green);
    expect(theme.components.bottomSheet.backgroundColour, original.background.bottomSheetBackground);
    expect(theme.components.tooltip.backgroundColour, original.background.tooltipBackground);
  });

  test('palette selection updates component fills and contrast colours', () {
    final colours = applyBrandPalette(DievasDarkThemeData().colours, DievasBrandPalettes.amber);
    const fill = Color(DievasColourPrimitives.amber500);
    const text = Color(DievasColourPrimitives.slate950);

    expect(colours.action.badgePrimaryBackground, fill);
    expect(colours.action.checkboxCheckedBackground, fill);
    expect(colours.action.radioSelectedBackground, fill);
    expect(
      colours.action.segmentedControlSelectedBackground,
      DievasDarkThemeData().colours.action.segmentedControlSelectedBackground,
    );
    expect(colours.action.progressIndicator, fill);
    expect(colours.action.badgePrimaryText, text);
    expect(colours.action.checkboxCheckmark, text);
    expect(colours.action.radioDot, text);
    expect(
      colours.action.segmentedControlSelectedText,
      DievasDarkThemeData().colours.action.segmentedControlSelectedText,
    );
  });
}
