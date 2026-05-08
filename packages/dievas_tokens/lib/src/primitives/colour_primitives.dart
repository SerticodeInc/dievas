// Raw colour values as ARGB integers with no Flutter dependency.
//
// These are the atomic building blocks of Dievas. They carry no semantic
// meaning and should only be consumed by the semantic token layer.
//
// Scale convention: 50 (lightest) -> 950 (darkest).
// Families are arranged as a practical colour ring, then nature/material
// palettes for brand systems that need warmer, more organic colour.

/// Raw Dievas colour primitives exposed as ARGB integer constants.
abstract final class DievasColourPrimitives {
  // Static.
  static const int white = 0xFFFFFFFF;
  static const int black = 0xFF000000;
  static const int transparent = 0x00000000;

  // Neutral axis.
  static const int slate50 = 0xFFF8FAFC;
  static const int slate100 = 0xFFF1F5F9;
  static const int slate200 = 0xFFE2E8F0;
  static const int slate300 = 0xFFCBD5E1;
  static const int slate400 = 0xFF94A3B8;
  static const int slate500 = 0xFF64748B;
  static const int slate600 = 0xFF475569;
  static const int slate700 = 0xFF334155;
  static const int slate800 = 0xFF1E293B;
  static const int slate900 = 0xFF0F172A;
  static const int slate950 = 0xFF020617;

  static const int zinc50 = 0xFFFAFAFA;
  static const int zinc100 = 0xFFF4F4F5;
  static const int zinc200 = 0xFFE4E4E7;
  static const int zinc300 = 0xFFD4D4D8;
  static const int zinc400 = 0xFFA1A1AA;
  static const int zinc500 = 0xFF71717A;
  static const int zinc600 = 0xFF52525B;
  static const int zinc700 = 0xFF3F3F46;
  static const int zinc800 = 0xFF27272A;
  static const int zinc900 = 0xFF18181B;
  static const int zinc950 = 0xFF09090B;

  static const int neutral50 = 0xFFFAFAFA;
  static const int neutral100 = 0xFFF5F5F5;
  static const int neutral200 = 0xFFE5E5E5;
  static const int neutral300 = 0xFFD4D4D4;
  static const int neutral400 = 0xFFA3A3A3;
  static const int neutral500 = 0xFF737373;
  static const int neutral600 = 0xFF525252;
  static const int neutral700 = 0xFF404040;
  static const int neutral800 = 0xFF262626;
  static const int neutral900 = 0xFF171717;
  static const int neutral950 = 0xFF0A0A0A;

  static const int stone50 = 0xFFFAFAF9;
  static const int stone100 = 0xFFF5F5F4;
  static const int stone200 = 0xFFE7E5E4;
  static const int stone300 = 0xFFD6D3D1;
  static const int stone400 = 0xFFA8A29E;
  static const int stone500 = 0xFF78716C;
  static const int stone600 = 0xFF57534E;
  static const int stone700 = 0xFF44403C;
  static const int stone800 = 0xFF292524;
  static const int stone900 = 0xFF1C1917;
  static const int stone950 = 0xFF0C0A09;

  // Colour ring: warm reds through greens, blues, violets, and back to rose.
  static const int red50 = 0xFFFEF2F2;
  static const int red100 = 0xFFFEE2E2;
  static const int red200 = 0xFFFECACA;
  static const int red300 = 0xFFFCA5A5;
  static const int red400 = 0xFFF87171;
  static const int red500 = 0xFFEF4444;
  static const int red600 = 0xFFDC2626;
  static const int red700 = 0xFFB91C1C;
  static const int red800 = 0xFF991B1B;
  static const int red900 = 0xFF7F1D1D;
  static const int red950 = 0xFF450A0A;

  static const int vermilion50 = 0xFFFFF1ED;
  static const int vermilion100 = 0xFFFFDED6;
  static const int vermilion200 = 0xFFFFBFB0;
  static const int vermilion300 = 0xFFFF947F;
  static const int vermilion400 = 0xFFFF654D;
  static const int vermilion500 = 0xFFEF3E2E;
  static const int vermilion600 = 0xFFD92C20;
  static const int vermilion700 = 0xFFB5221B;
  static const int vermilion800 = 0xFF901F1A;
  static const int vermilion900 = 0xFF741F1A;
  static const int vermilion950 = 0xFF3F0D0A;

  static const int orange50 = 0xFFFFF7ED;
  static const int orange100 = 0xFFFFEDD5;
  static const int orange200 = 0xFFFED7AA;
  static const int orange300 = 0xFFFDBA74;
  static const int orange400 = 0xFFFB923C;
  static const int orange500 = 0xFFF97316;
  static const int orange600 = 0xFFEA580C;
  static const int orange700 = 0xFFC2410C;
  static const int orange800 = 0xFF9A3412;
  static const int orange900 = 0xFF7C2D12;
  static const int orange950 = 0xFF431407;

  static const int amber50 = 0xFFFFFBEB;
  static const int amber100 = 0xFFFEF3C7;
  static const int amber200 = 0xFFFDE68A;
  static const int amber300 = 0xFFFCD34D;
  static const int amber400 = 0xFFFBBF24;
  static const int amber500 = 0xFFF59E0B;
  static const int amber600 = 0xFFD97706;
  static const int amber700 = 0xFFB45309;
  static const int amber800 = 0xFF92400E;
  static const int amber900 = 0xFF78350F;
  static const int amber950 = 0xFF451A03;

  static const int yellow50 = 0xFFFEFCE8;
  static const int yellow100 = 0xFFFEF9C3;
  static const int yellow200 = 0xFFFEF08A;
  static const int yellow300 = 0xFFFDE047;
  static const int yellow400 = 0xFFFACC15;
  static const int yellow500 = 0xFFEAB308;
  static const int yellow600 = 0xFFCA8A04;
  static const int yellow700 = 0xFFA16207;
  static const int yellow800 = 0xFF854D0E;
  static const int yellow900 = 0xFF713F12;
  static const int yellow950 = 0xFF422006;

  static const int chartreuse50 = 0xFFF7FFE5;
  static const int chartreuse100 = 0xFFECFFC2;
  static const int chartreuse200 = 0xFFD9FF85;
  static const int chartreuse300 = 0xFFBDFA44;
  static const int chartreuse400 = 0xFFA3E815;
  static const int chartreuse500 = 0xFF82C900;
  static const int chartreuse600 = 0xFF66A000;
  static const int chartreuse700 = 0xFF4E7905;
  static const int chartreuse800 = 0xFF415F0B;
  static const int chartreuse900 = 0xFF374F0F;
  static const int chartreuse950 = 0xFF1A2B02;

  static const int lime50 = 0xFFF7FEE7;
  static const int lime100 = 0xFFECFCCB;
  static const int lime200 = 0xFFD9F99D;
  static const int lime300 = 0xFFBEF264;
  static const int lime400 = 0xFFA3E635;
  static const int lime500 = 0xFF84CC16;
  static const int lime600 = 0xFF65A30D;
  static const int lime700 = 0xFF4D7C0F;
  static const int lime800 = 0xFF3F6212;
  static const int lime900 = 0xFF365314;
  static const int lime950 = 0xFF1A2E05;

  static const int green50 = 0xFFF0FDF4;
  static const int green100 = 0xFFDCFCE7;
  static const int green200 = 0xFFBBF7D0;
  static const int green300 = 0xFF86EFAC;
  static const int green400 = 0xFF4ADE80;
  static const int green500 = 0xFF22C55E;
  static const int green600 = 0xFF16A34A;
  static const int green700 = 0xFF15803D;
  static const int green800 = 0xFF166534;
  static const int green900 = 0xFF14532D;
  static const int green950 = 0xFF052E16;

  static const int emerald50 = 0xFFECFDF5;
  static const int emerald100 = 0xFFD1FAE5;
  static const int emerald200 = 0xFFA7F3D0;
  static const int emerald300 = 0xFF6EE7B7;
  static const int emerald400 = 0xFF34D399;
  static const int emerald500 = 0xFF10B981;
  static const int emerald600 = 0xFF059669;
  static const int emerald700 = 0xFF047857;
  static const int emerald800 = 0xFF065F46;
  static const int emerald900 = 0xFF064E3B;
  static const int emerald950 = 0xFF022C22;

  static const int teal50 = 0xFFF0FDFA;
  static const int teal100 = 0xFFCCFBF1;
  static const int teal200 = 0xFF99F6E4;
  static const int teal300 = 0xFF5EEAD4;
  static const int teal400 = 0xFF2DD4BF;
  static const int teal500 = 0xFF14B8A6;
  static const int teal600 = 0xFF0D9488;
  static const int teal700 = 0xFF0F766E;
  static const int teal800 = 0xFF115E59;
  static const int teal900 = 0xFF134E4A;
  static const int teal950 = 0xFF042F2E;

  static const int cyan50 = 0xFFECFEFF;
  static const int cyan100 = 0xFFCFFAFE;
  static const int cyan200 = 0xFFA5F3FC;
  static const int cyan300 = 0xFF67E8F9;
  static const int cyan400 = 0xFF22D3EE;
  static const int cyan500 = 0xFF06B6D4;
  static const int cyan600 = 0xFF0891B2;
  static const int cyan700 = 0xFF0E7490;
  static const int cyan800 = 0xFF155E75;
  static const int cyan900 = 0xFF164E63;
  static const int cyan950 = 0xFF083344;

  static const int sky50 = 0xFFF0F9FF;
  static const int sky100 = 0xFFE0F2FE;
  static const int sky200 = 0xFFBAE6FD;
  static const int sky300 = 0xFF7DD3FC;
  static const int sky400 = 0xFF38BDF8;
  static const int sky500 = 0xFF0EA5E9;
  static const int sky600 = 0xFF0284C7;
  static const int sky700 = 0xFF0369A1;
  static const int sky800 = 0xFF075985;
  static const int sky900 = 0xFF0C4A6E;
  static const int sky950 = 0xFF082F49;

  static const int blue50 = 0xFFEFF6FF;
  static const int blue100 = 0xFFDBEAFE;
  static const int blue200 = 0xFFBFDBFE;
  static const int blue300 = 0xFF93C5FD;
  static const int blue400 = 0xFF60A5FA;
  static const int blue500 = 0xFF3B82F6;
  static const int blue600 = 0xFF2563EB;
  static const int blue700 = 0xFF1D4ED8;
  static const int blue800 = 0xFF1E40AF;
  static const int blue900 = 0xFF1E3A8A;
  static const int blue950 = 0xFF172554;

  static const int indigo50 = 0xFFEEF2FF;
  static const int indigo100 = 0xFFE0E7FF;
  static const int indigo200 = 0xFFC7D2FE;
  static const int indigo300 = 0xFFA5B4FC;
  static const int indigo400 = 0xFF818CF8;
  static const int indigo500 = 0xFF6366F1;
  static const int indigo600 = 0xFF4F46E5;
  static const int indigo700 = 0xFF4338CA;
  static const int indigo800 = 0xFF3730A3;
  static const int indigo900 = 0xFF312E81;
  static const int indigo950 = 0xFF1E1B4B;

  static const int violet50 = 0xFFF5F3FF;
  static const int violet100 = 0xFFEDE9FE;
  static const int violet200 = 0xFFDDD6FE;
  static const int violet300 = 0xFFC4B5FD;
  static const int violet400 = 0xFFA78BFA;
  static const int violet500 = 0xFF8B5CF6;
  static const int violet600 = 0xFF7C3AED;
  static const int violet700 = 0xFF6D28D9;
  static const int violet800 = 0xFF5B21B6;
  static const int violet900 = 0xFF4C1D95;
  static const int violet950 = 0xFF2E1065;

  static const int purple50 = 0xFFFAF5FF;
  static const int purple100 = 0xFFF3E8FF;
  static const int purple200 = 0xFFE9D5FF;
  static const int purple300 = 0xFFD8B4FE;
  static const int purple400 = 0xFFC084FC;
  static const int purple500 = 0xFFA855F7;
  static const int purple600 = 0xFF9333EA;
  static const int purple700 = 0xFF7E22CE;
  static const int purple800 = 0xFF6B21A8;
  static const int purple900 = 0xFF581C87;
  static const int purple950 = 0xFF3B0764;

  static const int fuchsia50 = 0xFFFDF4FF;
  static const int fuchsia100 = 0xFFFAE8FF;
  static const int fuchsia200 = 0xFFF5D0FE;
  static const int fuchsia300 = 0xFFF0ABFC;
  static const int fuchsia400 = 0xFFE879F9;
  static const int fuchsia500 = 0xFFD946EF;
  static const int fuchsia600 = 0xFFC026D3;
  static const int fuchsia700 = 0xFFA21CAF;
  static const int fuchsia800 = 0xFF86198F;
  static const int fuchsia900 = 0xFF701A75;
  static const int fuchsia950 = 0xFF4A044E;

  static const int pink50 = 0xFFFDF2F8;
  static const int pink100 = 0xFFFCE7F3;
  static const int pink200 = 0xFFFBCFE8;
  static const int pink300 = 0xFFF9A8D4;
  static const int pink400 = 0xFFF472B6;
  static const int pink500 = 0xFFEC4899;
  static const int pink600 = 0xFFDB2777;
  static const int pink700 = 0xFFBE185D;
  static const int pink800 = 0xFF9D174D;
  static const int pink900 = 0xFF831843;
  static const int pink950 = 0xFF500724;

  static const int rose50 = 0xFFFFF1F2;
  static const int rose100 = 0xFFFFE4E6;
  static const int rose200 = 0xFFFECDD3;
  static const int rose300 = 0xFFFDA4AF;
  static const int rose400 = 0xFFFB7185;
  static const int rose500 = 0xFFF43F5E;
  static const int rose600 = 0xFFE11D48;
  static const int rose700 = 0xFFBE123C;
  static const int rose800 = 0xFF9F1239;
  static const int rose900 = 0xFF881337;
  static const int rose950 = 0xFF4C0519;

  // Nature and material palettes.
  static const int sand50 = 0xFFFCFAF4;
  static const int sand100 = 0xFFF6EEDC;
  static const int sand200 = 0xFFEBDDBE;
  static const int sand300 = 0xFFDEC79B;
  static const int sand400 = 0xFFCDAA71;
  static const int sand500 = 0xFFB98B4D;
  static const int sand600 = 0xFF956B38;
  static const int sand700 = 0xFF73502F;
  static const int sand800 = 0xFF5B402A;
  static const int sand900 = 0xFF493526;
  static const int sand950 = 0xFF281B11;

  static const int clay50 = 0xFFFCF6F1;
  static const int clay100 = 0xFFF5E6DA;
  static const int clay200 = 0xFFEAC8B4;
  static const int clay300 = 0xFFDCA184;
  static const int clay400 = 0xFFCB7657;
  static const int clay500 = 0xFFB9573A;
  static const int clay600 = 0xFF9D422D;
  static const int clay700 = 0xFF803527;
  static const int clay800 = 0xFF692E25;
  static const int clay900 = 0xFF572821;
  static const int clay950 = 0xFF31120D;

  static const int terracotta50 = 0xFFFFF4ED;
  static const int terracotta100 = 0xFFFFE3D2;
  static const int terracotta200 = 0xFFFFC4A4;
  static const int terracotta300 = 0xFFFF986D;
  static const int terracotta400 = 0xFFF06E42;
  static const int terracotta500 = 0xFFD95732;
  static const int terracotta600 = 0xFFB84228;
  static const int terracotta700 = 0xFF923323;
  static const int terracotta800 = 0xFF762B21;
  static const int terracotta900 = 0xFF61251E;
  static const int terracotta950 = 0xFF36100B;

  static const int bark50 = 0xFFFAF7F2;
  static const int bark100 = 0xFFF0E6D8;
  static const int bark200 = 0xFFE0CAB0;
  static const int bark300 = 0xFFCCA681;
  static const int bark400 = 0xFFB47E55;
  static const int bark500 = 0xFF98613A;
  static const int bark600 = 0xFF7A4A2E;
  static const int bark700 = 0xFF623B28;
  static const int bark800 = 0xFF4E3024;
  static const int bark900 = 0xFF402920;
  static const int bark950 = 0xFF24140D;

  static const int olive50 = 0xFFF8FAEE;
  static const int olive100 = 0xFFECF1D4;
  static const int olive200 = 0xFFD8E3AA;
  static const int olive300 = 0xFFBFD176;
  static const int olive400 = 0xFFA5BB4C;
  static const int olive500 = 0xFF879A33;
  static const int olive600 = 0xFF697A28;
  static const int olive700 = 0xFF526024;
  static const int olive800 = 0xFF444F22;
  static const int olive900 = 0xFF3B4320;
  static const int olive950 = 0xFF1E250D;

  static const int sage50 = 0xFFF5F8F2;
  static const int sage100 = 0xFFE5EDDD;
  static const int sage200 = 0xFFCEDDC2;
  static const int sage300 = 0xFFACC49D;
  static const int sage400 = 0xFF88A873;
  static const int sage500 = 0xFF698D56;
  static const int sage600 = 0xFF526F42;
  static const int sage700 = 0xFF415735;
  static const int sage800 = 0xFF35472D;
  static const int sage900 = 0xFF2D3B27;
  static const int sage950 = 0xFF172013;

  static const int moss50 = 0xFFF3F9ED;
  static const int moss100 = 0xFFE1EFD4;
  static const int moss200 = 0xFFC6E0AE;
  static const int moss300 = 0xFFA0CB80;
  static const int moss400 = 0xFF7FB05B;
  static const int moss500 = 0xFF5F913D;
  static const int moss600 = 0xFF497331;
  static const int moss700 = 0xFF3A5B2A;
  static const int moss800 = 0xFF304925;
  static const int moss900 = 0xFF2A3F22;
  static const int moss950 = 0xFF13210E;

  static const int forest50 = 0xFFF0F8F1;
  static const int forest100 = 0xFFDCEEDD;
  static const int forest200 = 0xFFBBDDC0;
  static const int forest300 = 0xFF8EC496;
  static const int forest400 = 0xFF62A86E;
  static const int forest500 = 0xFF408B4E;
  static const int forest600 = 0xFF31703E;
  static const int forest700 = 0xFF285933;
  static const int forest800 = 0xFF23482C;
  static const int forest900 = 0xFF1F3B26;
  static const int forest950 = 0xFF0D2112;

  static const int lagoon50 = 0xFFEDFCF8;
  static const int lagoon100 = 0xFFD2F5EA;
  static const int lagoon200 = 0xFFA9EAD8;
  static const int lagoon300 = 0xFF73D8C1;
  static const int lagoon400 = 0xFF41BFA7;
  static const int lagoon500 = 0xFF249F8B;
  static const int lagoon600 = 0xFF1C806F;
  static const int lagoon700 = 0xFF19665A;
  static const int lagoon800 = 0xFF185248;
  static const int lagoon900 = 0xFF17443D;
  static const int lagoon950 = 0xFF082722;

  static const int ocean50 = 0xFFEEF9FC;
  static const int ocean100 = 0xFFD5EFF6;
  static const int ocean200 = 0xFFB0DFEE;
  static const int ocean300 = 0xFF7CC8E0;
  static const int ocean400 = 0xFF45A9CA;
  static const int ocean500 = 0xFF258BAE;
  static const int ocean600 = 0xFF1E6F8C;
  static const int ocean700 = 0xFF1D5A72;
  static const int ocean800 = 0xFF1E4B5F;
  static const int ocean900 = 0xFF1C4051;
  static const int ocean950 = 0xFF0B2530;

  static const int glacier50 = 0xFFF3FBFC;
  static const int glacier100 = 0xFFE0F3F6;
  static const int glacier200 = 0xFFC5E7ED;
  static const int glacier300 = 0xFF9DD4E0;
  static const int glacier400 = 0xFF6CB7C9;
  static const int glacier500 = 0xFF4B9AAD;
  static const int glacier600 = 0xFF3F7D8E;
  static const int glacier700 = 0xFF376674;
  static const int glacier800 = 0xFF335660;
  static const int glacier900 = 0xFF2E4952;
  static const int glacier950 = 0xFF172C33;

  static const int dusk50 = 0xFFF7F6FB;
  static const int dusk100 = 0xFFEDEAF5;
  static const int dusk200 = 0xFFD9D3EA;
  static const int dusk300 = 0xFFBCAFD9;
  static const int dusk400 = 0xFF9B85C1;
  static const int dusk500 = 0xFF7D63A8;
  static const int dusk600 = 0xFF664B8D;
  static const int dusk700 = 0xFF523C72;
  static const int dusk800 = 0xFF45335E;
  static const int dusk900 = 0xFF3B2D4F;
  static const int dusk950 = 0xFF21162D;

  static const int berry50 = 0xFFFDF2F6;
  static const int berry100 = 0xFFFBE5ED;
  static const int berry200 = 0xFFF7CADA;
  static const int berry300 = 0xFFF0A1BC;
  static const int berry400 = 0xFFE66F97;
  static const int berry500 = 0xFFD94376;
  static const int berry600 = 0xFFC2265C;
  static const int berry700 = 0xFFA11B4C;
  static const int berry800 = 0xFF851940;
  static const int berry900 = 0xFF701838;
  static const int berry950 = 0xFF3E071A;
}
