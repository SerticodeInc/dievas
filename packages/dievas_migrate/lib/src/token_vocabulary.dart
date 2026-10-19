/// The lowercased vocabulary introduced by the Dievas token rename.
///
/// This covers every renamed surface, not just sizes: scales, concrete radii,
/// breakpoints, elevation, and typographic role suffixes. Every changed member
/// is a pure function of its old name, so the rename table lives here as a
/// scale map plus two role patterns.
library;

/// Types whose members were renamed. A diagnostic only migrates when the
/// declaring type is listed here, which keeps unrelated enums that reuse the
/// same member names (`DievasButtonSize.MD`, record keys like `SM:`)
/// untouched.
const Set<String> renamedTypes = {
  'DievasBreakpointPrimitives',
  'DievasBreakpointSemantic',
  'DievasSpacingSemantic',
  'DievasRadiusSemantic',
  'DievasElevationSemantic',
  'DievasElevationShadowLayer',
  'DievasSizingSemantic',
  'DievasTypographySemantic',
  'DievasGridBreakpoint',
  'DievasSpacingThemeData',
  'DievasBorderThemeData',
  'DievasElevationThemeData',
  'DievasSizingThemeData',
  'DievasTypographyThemeData',
};

/// Theme data constructors and `copyWith` are the only call sites where a named
/// parameter takes a renamed member. A named parameter diagnostic carries no
/// declaring type, so the enclosing member is the guard.
const Set<String> renamedParameterOwners = {
  'DievasSpacingThemeData',
  'DievasBorderThemeData',
  'DievasElevationThemeData',
  'DievasSizingThemeData',
  'DievasTypographyThemeData',
  'DievasGridBreakpoint',
  'copyWith',
};

/// Prefixes allowed before a renamed member inside a doc comment, so
/// `[context.spacing.MD]` and `[DievasSpacingSemantic.MD]` migrate while
/// `[DievasButtonSize.MD]` stays.
const Set<String> commentReceiverNames = {...renamedTypes, 'spacing', 'border', 'elevation', 'sizing', 'typography'};

/// Straight scale renames: `all` and concrete radii.
const Map<String, String> scaleRenames = {
  'NONE': 'none',
  'XS': 'xs',
  'SM': 'sm',
  'SMPlus': 'smPlus',
  'MD': 'md',
  'MDPlus': 'mdPlus',
  'LG': 'lg',
  'LGPlus': 'lgPlus',
  'XL': 'xl',
  'XLPlus': 'xlPlus',
  'XL2': 'xl2',
  'XL2Plus': 'xl2Plus',
  'XL3': 'xl3',
  'XL4': 'xl4',
  'XL5': 'xl5',
  'R28': 'r28',
  'R32': 'r32',
  'R36': 'r36',
  'R40': 'r40',
  'R48': 'r48',
  'R56': 'r56',
  'R64': 'r64',
  'FULL': 'full',
};

final RegExp roleRename = RegExp(
  '^(display|heading|title|body|label|code|buttonHeight|inputHeight|icon|avatar)(XS|SM|MD|LG|XL)\$',
);

/// Maps a pre-1.0.2 member name to its lowercased form, or `null` when the name
/// does not belong to the renamed vocabulary.
String? renamedMember(String old) {
  if (scaleRenames[old] case final String renamed) {
    return renamed;
  }
  return _roleRename(old);
}

String? _roleRename(String old) {
  final RegExpMatch? match = roleRename.firstMatch(old);
  if (match == null) {
    return null;
  }
  return switch ((match.group(1), match.group(2))) {
    (final String base, final String suffix) => '$base${suffix[0]}${suffix.substring(1).toLowerCase()}',
    _ => null,
  };
}

/// Old member names, longest first, for building alternation patterns.
final List<String> renamedMembersByLength = _collectMembers();

List<String> _collectMembers() {
  final Set<String> members = {...scaleRenames.keys};
  for (final String base in const [
    'display',
    'heading',
    'title',
    'body',
    'label',
    'code',
    'buttonHeight',
    'inputHeight',
    'icon',
    'avatar',
  ]) {
    for (final String suffix in const ['XS', 'SM', 'MD', 'LG', 'XL']) {
      members.add('$base$suffix');
    }
  }
  final List<String> ordered = members.toList()..sort((String a, String b) => b.length.compareTo(a.length));
  return List.unmodifiable(ordered);
}
