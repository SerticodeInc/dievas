// ignore_for_file: avoid_print

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
  print('Spacing MD: ${DievasSpacingSemantic.MD}');
  print('Spacing XL: ${DievasSpacingSemantic.XL}');
  final brand = DievasBrandPalettes.sky.rolesForLight();
  print('Selected brand: ${brand.brand}');
  print('Text on brand: ${brand.onBrand}');
}
