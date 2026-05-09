import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';

/// Base sealed class for all Dievas button style variants.
///
/// Each subclass carries the resolved colours for a specific button type.
/// The [DievasButtonThemeStateStyle] record wraps two of these — one for
/// [idle] and one for [focused] — to drive state-based appearance changes.
@immutable
@internal
sealed class DievasButtonThemeStyle extends Equatable {
  const DievasButtonThemeStyle._({
    required this.foreground,
    required this.icon,
    required this.background,
    required this.borderSide,
  });

  /// Foreground (text) colour.
  final Color foreground;

  /// Icon colour. Typically matches [foreground].
  final Color icon;

  /// Background fill colour. `null` for transparent-background variants.
  final Color? background;

  /// Border. `null` for borderless variants.
  final BorderSide? borderSide;

  @override
  List<Object?> get props => [foreground, icon, background, borderSide];
}

/// Style tokens for [DievasFilledButton].
@immutable
@internal
final class DievasFilledButtonThemeStyle extends DievasButtonThemeStyle {
  const DievasFilledButtonThemeStyle({
    required super.foreground,
    required super.icon,
    required Color super.background,
  }) : super._(borderSide: null);
}

/// Style tokens for [DievasOutlinedButton].
@immutable
@internal
final class DievasOutlinedButtonThemeStyle extends DievasButtonThemeStyle {
  const DievasOutlinedButtonThemeStyle({
    required super.foreground,
    required super.icon,
    required BorderSide super.borderSide,
  }) : super._(background: null);
}

/// Style tokens for [DievasTextButton].
@immutable
@internal
final class DievasTextButtonThemeStyle extends DievasButtonThemeStyle {
  const DievasTextButtonThemeStyle({
    required super.foreground,
    required super.icon,
  }) : super._(background: null, borderSide: null);
}

/// Style tokens for [DievasIconButton].
@immutable
@internal
final class DievasIconButtonThemeStyle extends DievasButtonThemeStyle {
  const DievasIconButtonThemeStyle({
    required super.icon,
    required super.foreground,
    super.background,
  }) : super._(borderSide: null);
}
