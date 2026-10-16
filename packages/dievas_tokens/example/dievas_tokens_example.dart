// ignore_for_file: avoid_print

import 'package:dievas_tokens/dievas_tokens.dart';

void main() {
  // Primitives
  print('Colour: ${DievasColourPrimitives.blue500}');
  print('Font weight: ${DievasFontWeightPrimitives.medium}');

  // Semantics — light scheme
  print('Light background: ${DievasColourSemanticLight.pageBackground}');
  print('Light primary: ${DievasColourSemanticLight.buttonPrimaryBackground}');

  // Semantics — dark scheme
  print('Dark background: ${DievasColourSemanticDark.pageBackground}');
  print('Dark primary: ${DievasColourSemanticDark.buttonPrimaryBackground}');

  // Spacing
  print('Spacing MD: ${DievasSpacingSemantic.MD}');
  print('Spacing XL: ${DievasSpacingSemantic.XL}');
  final primary = DievasBrandPalettes.sky.rolesForLight();
  print('Selected primary: ${primary.primary}');
  print('Text on primary: ${primary.buttonPrimaryText}');
}
