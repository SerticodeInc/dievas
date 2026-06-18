// Semantic z-index tokens.
//
// Pure Dart. No Flutter dependency.
// Centralized stacking order to prevent z-index conflicts across the
// design system. Every overlay, popover, and floating element must
// reference these constants — never raw integers.

/// Semantic z-index tokens for the Dievas design system.
///
/// Each token occupies a dedicated band of the stacking spectrum.
/// Bands are spaced 100 units apart to leave room for intermediate
/// layers within each band (e.g., a modal's backdrop vs its content).
abstract final class DievasZIndexSemantic {
  /// Dropdown menus and select popups.
  static const int dropdown = 100;

  /// Sticky elements within a scroll container.
  static const int sticky = 200;

  /// Fixed headers, nav bars, and persistent banners.
  static const int fixedHeader = 300;

  /// Scrim / backdrop behind modals and sheets.
  static const int modalBackdrop = 400;

  /// Modal dialogs, bottom sheets, side panels.
  static const int modal = 500;

  /// Popovers, contextual menus, floating pickers.
  static const int popover = 600;

  /// Tooltips on hover or focus.
  static const int tooltip = 700;

  /// Toast notifications and snack bars.
  static const int toast = 800;

  /// Full-screen loaders and spinners.
  static const int loader = 900;
}
