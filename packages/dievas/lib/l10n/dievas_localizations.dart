import 'package:flutter/widgets.dart';

/// Localization strings for Dievas component-internal copy.
///
/// Consuming apps must register the delegate and supported locales in
/// their [MaterialApp] or [WidgetsApp]:
///
/// ```dart
/// MaterialApp(
///   localizationsDelegates: DievasLocalizations.localizationsDelegates,
///   supportedLocales: DievasLocalizations.supportedLocales,
///   ...
/// )
/// ```
///
/// Access strings in widgets via `context.l10n` (see [DievasL10nExtension]).
abstract class DievasLocalizations {
  /// The standard set of delegates needed to resolve [DievasLocalizations].
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [_DievasLocalizationsDelegate()];

  /// Locales this package provides translations for.
  static const List<Locale> supportedLocales = [Locale('en')];

  /// Returns the nearest [DievasLocalizations] instance from [context].
  ///
  /// Throws if no [DievasLocalizations] is found — ensure the delegate is
  /// registered before calling this.
  static DievasLocalizations of(BuildContext context) {
    final result = Localizations.of<DievasLocalizations>(context, DievasLocalizations);
    if (result != null) return result;
    // Fallback so gallery / tests work without full l10n setup.
    return _EnDievasLocalizations();
  }

  /// Default title shown when [DievasEmptyState] has no [title] provided.
  String get emptyStateDefaultTitle;

  /// Default body shown when [DievasEmptyState] has no [description] provided.
  String get emptyStateDefaultDescription;

  // ─── Bottom sheet ─────────────────────────────────────────────────────────

  /// Accessibility label for the bottom sheet drag handle.
  String get bottomSheetDragHandleLabel;

  /// Label for the bottom sheet close action (screen readers).
  String get bottomSheetCloseLabel;

  // ─── Modal ────────────────────────────────────────────────────────────────

  /// Accessibility label for the modal close button.
  String get modalCloseLabel;

  // ─── Snackbar ─────────────────────────────────────────────────────────────

  /// Default label for the snackbar dismiss action.
  String get snackbarDismissLabel;

  // ─── Alert ────────────────────────────────────────────────────────────────

  /// Accessibility label for the alert dismiss button.
  String get alertDismissLabel;

  // ─── Tooltip ──────────────────────────────────────────────────────────────

  /// Semantic label announced by screen readers when a tooltip is shown.
  String get tooltipLabel;
}

class _EnDievasLocalizations extends DievasLocalizations {
  _EnDievasLocalizations();

  @override
  String get emptyStateDefaultTitle => 'Nothing here yet';

  @override
  String get emptyStateDefaultDescription => 'Check back later or try a different filter.';

  @override
  String get bottomSheetDragHandleLabel => 'Drag to resize';

  @override
  String get bottomSheetCloseLabel => 'Close';

  @override
  String get modalCloseLabel => 'Close';

  @override
  String get snackbarDismissLabel => 'Dismiss';

  @override
  String get alertDismissLabel => 'Dismiss alert';

  @override
  String get tooltipLabel => 'Tooltip';
}

class _DievasLocalizationsDelegate extends LocalizationsDelegate<DievasLocalizations> {
  const _DievasLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<DievasLocalizations> load(Locale locale) async => _EnDievasLocalizations();

  @override
  bool shouldReload(_DievasLocalizationsDelegate old) => false;
}
