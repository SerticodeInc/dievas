import 'package:dievas_tokens/dievas_tokens.dart';

void main() {
  // Primitives
  print('Colour: ${DievasColourPrimitives.blue500}');
  print('Font weight: ${DievasFontWeightPrimitives.medium}');

  // Semantics — light scheme
  print('Light background: ${DievasColourSemanticLight.bgBase}');
  print('Light primary: ${DievasColourSemanticLight.actionPrimary}');

  // Semantics — dark scheme
  print('Dark background: ${DievasColourSemanticDark.bgBase}');
  print('Dark primary: ${DievasColourSemanticDark.actionPrimary}');

  // Spacing
  print('Spacing md: ${DievasSpacingPrimitives.s4}');
  print('Spacing xl: ${DievasSpacingPrimitives.s8}');
}
