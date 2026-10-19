import 'package:dievas_migrate/src/token_vocabulary.dart';
import 'package:test/test.dart';

void main() {
  group('renamedMember', () {
    test('renames scales', () {
      expect(renamedMember('NONE'), 'none');
      expect(renamedMember('MD'), 'md');
      expect(renamedMember('SMPlus'), 'smPlus');
      expect(renamedMember('XL2Plus'), 'xl2Plus');
      expect(renamedMember('FULL'), 'full');
      expect(renamedMember('R28'), 'r28');
      expect(renamedMember('R64'), 'r64');
    });

    test('renames role suffixes', () {
      expect(renamedMember('buttonHeightXS'), 'buttonHeightXs');
      expect(renamedMember('iconXL'), 'iconXl');
      expect(renamedMember('displayLG'), 'displayLg');
      expect(renamedMember('codeMD'), 'codeMd');
      expect(renamedMember('inputHeightSM'), 'inputHeightSm');
    });

    test('ignores names outside the vocabulary', () {
      for (final name in ['touchMin', 'shadowColour', 'O50', 's4', 'md', 'xs']) {
        expect(renamedMember(name), isNull, reason: name);
      }
    });

    test('ignores enum members that reuse a scale suffix', () {
      expect(renamedMember('Minimum'), isNull);
      expect(renamedMember('MDPIus'), isNull);
    });
  });

  test('renamedMembersByLength lists longest names first', () {
    final lengths = renamedMembersByLength.map((name) => name.length).toList();
    final ordered = [...lengths]..sort((a, b) => b.compareTo(a));
    expect(lengths, orderedEquals(ordered));
    expect(renamedMembersByLength, contains('buttonHeightXS'));
    expect(renamedMembersByLength, contains('R28'));
  });
}
