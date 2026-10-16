import 'dart:convert';
import 'dart:io';

import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:test/test.dart';

// Independently recorded upstream values and provenance live in the fixture.
const _primitives = <String, int>{
  'royalPurple': DievasColourPrimitives.royalPurple,
  'springMint': DievasColourPrimitives.springMint,
  'coolGreyLight': DievasColourPrimitives.coolGreyLight,
  'white': DievasColourPrimitives.white,
  'nearWhite': DievasColourPrimitives.nearWhite,
  'black': DievasColourPrimitives.black,
  'steelGrey': DievasColourPrimitives.steelGrey,
  'royalPurpleAlpha1F': DievasColourPrimitives.royalPurpleAlpha1F,
  'blackAlpha0A': DievasColourPrimitives.blackAlpha0A,
  'blackAlpha8F': DievasColourPrimitives.blackAlpha8F,
  'amberGold': DievasColourPrimitives.amberGold,
  'coralPink': DievasColourPrimitives.coralPink,
  'leafGreen': DievasColourPrimitives.leafGreen,
  'crimsonRed': DievasColourPrimitives.crimsonRed,
  'paleMint': DievasColourPrimitives.paleMint,
  'warmTan': DievasColourPrimitives.warmTan,
  'royalBlue': DievasColourPrimitives.royalBlue,
  'cocoaBrown': DievasColourPrimitives.cocoaBrown,
  'amberGoldAlpha8F': DievasColourPrimitives.amberGoldAlpha8F,
  'amberGoldAlpha14': DievasColourPrimitives.amberGoldAlpha14,
  'coralPinkAlpha8F': DievasColourPrimitives.coralPinkAlpha8F,
  'coralPinkAlpha14': DievasColourPrimitives.coralPinkAlpha14,
  'leafGreenAlpha8F': DievasColourPrimitives.leafGreenAlpha8F,
  'leafGreenAlpha14': DievasColourPrimitives.leafGreenAlpha14,
  'crimsonRedAlpha8F': DievasColourPrimitives.crimsonRedAlpha8F,
  'crimsonRedAlpha14': DievasColourPrimitives.crimsonRedAlpha14,
  'paleMintAlpha8F': DievasColourPrimitives.paleMintAlpha8F,
  'paleMintAlpha14': DievasColourPrimitives.paleMintAlpha14,
  'warmTanAlpha8F': DievasColourPrimitives.warmTanAlpha8F,
  'warmTanAlpha14': DievasColourPrimitives.warmTanAlpha14,
  'royalBlueAlpha8F': DievasColourPrimitives.royalBlueAlpha8F,
  'royalBlueAlpha14': DievasColourPrimitives.royalBlueAlpha14,
  'royalPurpleAlpha8F': DievasColourPrimitives.royalPurpleAlpha8F,
  'royalPurpleAlpha14': DievasColourPrimitives.royalPurpleAlpha14,
  'cocoaBrownAlpha8F': DievasColourPrimitives.cocoaBrownAlpha8F,
  'cocoaBrownAlpha14': DievasColourPrimitives.cocoaBrownAlpha14,
  'charcoal': DievasColourPrimitives.charcoal,
  'charcoalDeep': DievasColourPrimitives.charcoalDeep,
  'steelGreyLight': DievasColourPrimitives.steelGreyLight,
  'whiteAlpha14': DievasColourPrimitives.whiteAlpha14,
};

Future<void> main() async {
  final reference =
      jsonDecode(await File('${Directory.current.path}/test/fixtures/moon_colours_reference.json').readAsString())
          as Map<String, dynamic>;
  final themes = reference['default_themes'] as Map<String, dynamic>;
  final mappings = reference['primitive_mapping'] as Map<String, dynamic>;

  for (final mode in ['light', 'dark']) {
    test('every Moon $mode colour has an exact ARGB primitive', () {
      final colours = themes[mode] as Map<String, dynamic>;
      final names = mappings[mode] as Map<String, dynamic>;

      expect(names.keys.toSet(), colours.keys.toSet());
      expect(colours.length, 43);
      for (final entry in colours.entries) {
        expect(
          _primitives[names[entry.key]],
          int.parse(entry.value as String),
          reason: 'Moon $mode.${entry.key} must retain its exact colour and alpha.',
        );
      }
    });
  }
}
