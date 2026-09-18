part of 'example_theme.dart';

/// Raw brand token values for the Example App.
///
/// The brand is **Coral Peach**, led by [brand] — the exact `#EB6B52` the
/// landing's theme wall uses for its light-sheet signature ("coral peach,
/// redder than plain amber"). Two decisions shape everything else:
///
/// - **Indigo is the secondary, not a second brand.** It is the theme wall's
///   dark-sheet signature, so the light/dark sheet pairing carries into the
///   product instead of being left behind on the marketing page.
/// - **The neutrals are warm.** Peach lives around 8° on the hue wheel; a cool
///   slate neutral beside it reads as an accident. The light-mode ramp is a
///   stone tone pushed slightly red and yellow, so paper, text, and borders all
///   meet warm-on-warm — the same effect the landing's chapters section chases.
///   Dark-mode surfaces step out of that: see the ink set below.
///
/// Pure `int` ARGB values — no [Color] wrapping here. Wrapping happens in the
/// colour sets of [ExampleLightThemeData] / [ExampleDarkThemeData].
///
/// This is the single source of colour for the Example App — both theme files
/// resolve every role through here and define nothing of their own.
abstract final class ExampleColours {
  ExampleColours._();

  // ── Brand: coral peach ───────────────────────────────────────────────
  // #EB6B52, the theme_section light-sheet signature. Dark mode lifts it to
  // #F0885B — the peach the landing uses on its dark craft card — so the brand
  // still glows against ink instead of muddying out.

  /// Primary brand, light mode. The theme_section signature peach.
  static const int brand = 0xFFEB6B52;

  /// Primary brand, dark mode.
  static const int brandDark = 0xFFF0885B;

  /// Subtle brand tint, light mode — the landing's peach chip background.
  static const int brandSubtle = 0xFFFCEDE4;

  /// Subtle brand tint, dark mode — a deep peach-stained ink.
  static const int brandSubtleDark = 0xFF3A2A20;

  /// Text and icons on any brand surface.
  ///
  /// Deep espresso rather than white. White only reaches ~3.1:1 over the peach
  /// (fine for a tag, not for a button label); espresso clears AA in both modes
  /// — 5.2:1 over [brand], 6.4:1 over [brandDark] — and it keeps the brand
  /// warm end to end.
  static const int onBrand = 0xFF3B1A11;

  // Peach ramp — tints and shades of [brand], for hover, press, and disabled.

  static const int peach500 = brand;
  static const int peach600 = 0xFFD8543A;
  static const int peach700 = 0xFFB5402B;

  /// Hover / press of [brandDark].
  static const int peachDarkHover = 0xFFF79B74;
  static const int peachDarkActive = 0xFFFDAA88;

  // ── Secondary: indigo ─────────────────────────────────────────────────
  // #6366F1, the theme wall's dark-sheet signature. Only its tints and shades
  // are surfaced — the secondary action is a support role, not a co-brand.

  static const int indigo50 = 0xFFEEF2FF;
  static const int indigo100 = 0xFFE0E7FF;
  static const int indigo200 = 0xFFC7D2FE;
  static const int indigo400 = 0xFF818CF8;
  static const int indigo600 = 0xFF4F46E5;
  static const int indigo800 = 0xFF3730A3;
  static const int indigo900 = 0xFF312E81;
  static const int indigo950 = 0xFF1E1B4B;

  // ── Neutrals: warm stone ──────────────────────────────────────────────
  // A single ramp from warm paper to warm ink. Light mode reads the dark end
  // for text and borders; dark mode reads the light end for text and uses the
  // dedicated ink constants below for surfaces.

  static const int warm50 = 0xFFFAF7F3;
  static const int warm100 = 0xFFF5F0E9;
  static const int warm200 = 0xFFE8E0D4;
  static const int warm300 = 0xFFD8CCBC;
  static const int warm400 = 0xFFAE9E8C;
  static const int warm500 = 0xFF8C7B68;
  static const int warm600 = 0xFF6C5C4B;
  static const int warm900 = 0xFF1E1813;

  // ── Ink: dark-mode surfaces ───────────────────────────────────────────
  // A neutral black ramp led by #171717 — every dark surface is a step up the
  // same gray ladder, so the dark sheet reads as one clean black rather than a
  // peach-stained charcoal. Brand warmth in dark mode comes from the peach
  // accents and the warm text, not from the ground it sits on.

  /// The dark scaffold — the primary black.
  static const int inkBase = 0xFF171717;

  /// One step up: sidebars, code blocks.
  static const int inkSubtle = 0xFF1E1E1E;

  /// Two steps up: cards, sheets, striped table rows.
  static const int inkElevated = 0xFF262626;

  /// Visible separation between black surfaces.
  static const int inkBorder = 0xFF2E2E2E;

  /// Inputs sit a touch recessed below the scaffold.
  static const int inkInputBg = 0xFF1B1B1B;

  static const int inkInputBorder = 0xFF383838;

  // ── Functional: actions ──────────────────────────────────────────────
  // Danger is pushed a step deeper than the peach so an error never reads as
  // a brand element.

  static const int error = 0xFFDC2626;
  static const int errorHover = 0xFFB91C1C;
  static const int errorDark = 0xFFF87171;
  static const int errorHoverDark = 0xFFFCA5A5;
  static const int success = 0xFF22C55E;
  static const int successDark = 0xFF4ADE80;

  // ── Functional: feedback surfaces ─────────────────────────────────────
  // Alert backgrounds, borders, icons, and text — the Example App's own set,
  // not the Dievas defaults. Three rules shaped it:
  //
  // - Info is indigo, the brand's own secondary. A generic sky-blue alert
  //   beside a peach brand reads as an operating-system popup.
  // - Warning is amber, which shares the peach's warm hemisphere and sits on
  //   the warm paper without a seam.
  // - Error is pushed a full step redder and deeper than the peach so a
  //   failure never reads as a brand element — the same logic as [error].
  //
  // Light tints sit on warm paper; dark sets are deep jewelled tones that hold
  // their own against the #171717 scaffold without glowing.

  // Success — green.
  static const int successBg = 0xFFEAF9EE;
  static const int successBorder = 0xFFBCE5C6;
  static const int successIcon = 0xFF16A34A;
  static const int successText = 0xFF14653C;
  static const int successBgDark = 0xFF0E2B1C;
  static const int successBorderDark = 0xFF1E5B36;
  static const int successIconDark = successDark;
  static const int successTextDark = 0xFFB6F0C9;

  // Warning — amber.
  static const int warningBg = 0xFFFBF3E2;
  static const int warningBorder = 0xFFEED5A8;
  static const int warningIcon = 0xFFD97706;
  static const int warningText = 0xFF7C4A03;
  static const int warningBgDark = 0xFF2C2208;
  static const int warningBorderDark = 0xFF8A5A0B;
  static const int warningIconDark = 0xFFFBBF24;
  static const int warningTextDark = 0xFFF2CE82;

  // Error — crimson, deeper than the peach.
  static const int errorBg = 0xFFFBE4E4;
  static const int errorBorder = 0xFFF3B8B8;
  static const int errorIcon = error;
  static const int errorText = 0xFF8F1D1D;
  static const int errorBgDark = 0xFF311214;
  static const int errorBorderDark = 0xFF9B1C1C;
  static const int errorIconDark = errorDark;
  static const int errorTextDark = 0xFFF6B8B8;

  // Info — indigo, the brand secondary.
  static const int infoBg = indigo50;
  static const int infoBorder = indigo200;
  static const int infoIcon = indigo600;
  static const int infoText = indigo900;
  static const int infoBgDark = indigo950;
  static const int infoBorderDark = indigo800;
  static const int infoIconDark = indigo400;
  static const int infoTextDark = indigo200;

  // Input validation outlines.
  static const int inputBorderError = error;
  static const int inputBorderWarning = warningIcon;
  static const int inputBorderErrorDark = errorDark;
  static const int inputBorderWarningDark = warningIconDark;

  // ── Static / overlays ─────────────────────────────────────────────────

  static const int actualWhite = 0xFFFFFFFF;

  /// The same neutral black as [inkBase] — also the elevation shadow colour.
  static const int staticBlack = inkBase;

  static const int transparent = 0x00000000;
  static const int overlay = 0x80000000;
}

/// Resolved font families for the Example App.
///
/// Uses [GoogleFonts] to bundle the brand faces at runtime. The Dievas default
/// themes ship MartianMono; brand apps override typography to use their own
/// typefaces, exactly as shown in [buildExampleTypography].
abstract final class ExampleFonts {
  ExampleFonts._();
  static String? _grotesk;
  static String? _mono;

  /// Hanken Grotesk — display and body. A warm humanist grotesque that stands
  /// in for the landing's MaisonNeue: both carry that slightly extended,
  /// medium-weight warmth that makes a peach palette feel editorial rather
  /// than bubbly.
  static String get hankenGrotesk =>
      _grotesk ??= GoogleFonts.hankenGrotesk().fontFamily ?? 'Hanken Grotesk';

  /// DM Mono — code. The same face the landing loads for `--font-mono`.
  static String get dmMono => _mono ??= GoogleFonts.dmMono().fontFamily ?? 'DM Mono';
}
