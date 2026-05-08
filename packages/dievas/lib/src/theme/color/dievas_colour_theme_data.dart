import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show Brightness;

import 'sets/action_colours.dart';
import 'sets/background_colours.dart';
import 'sets/border_colours.dart';
import 'sets/core_colours.dart';
import 'sets/feedback_colours.dart';
import 'sets/icon_colours.dart';
import 'sets/input_colours.dart';
import 'sets/static_colours.dart';
import 'sets/switch_colours.dart';
import 'sets/text_colours.dart';

/// The complete colour sub-system for a Dievas theme.
///
/// Holds all typed colour set structs — one per domain. Consuming widgets
/// read from this via [DievasTheme.colorsOf(context)] or the context
/// extension shorthand `context.colors`.
///
/// Never reference primitive or semantic token integers directly in component
/// code — always go through this struct.
final class DievasColourThemeData extends Equatable {
  const DievasColourThemeData({
    required this.brightness,
    required this.core,
    required this.text,
    required this.icon,
    required this.background,
    required this.border,
    required this.action,
    required this.feedback,
    required this.input,
    required this.switchColours,
    required this.staticColours,
  });

  /// Whether this colour set is designed for a light or dark surface.
  final Brightness brightness;

  /// Brand identity colours — brand, brandSubtle, onBrand.
  final CoreColours core;

  /// Text colour roles across all contrast levels.
  final TextColours text;

  /// Icon colour roles.
  final IconColours icon;

  /// Surface and background colour roles.
  final BackgroundColours background;

  /// Border and divider colour roles.
  final BorderColours border;

  /// Interactive element colour roles across states and semantic intents.
  final ActionColours action;

  /// Feedback semantic colours — success, warning, error, info.
  final FeedbackColours feedback;

  /// Input field colour roles.
  final InputColours input;

  /// Toggle switch colour roles.
  final SwitchColours switchColours;

  /// Theme-invariant colours that do not flip between light and dark.
  final StaticColours staticColours;

  DievasColourThemeData copyWith({
    Brightness? brightness,
    CoreColours? core,
    TextColours? text,
    IconColours? icon,
    BackgroundColours? background,
    BorderColours? border,
    ActionColours? action,
    FeedbackColours? feedback,
    InputColours? input,
    SwitchColours? switchColours,
    StaticColours? staticColours,
  }) => DievasColourThemeData(
    brightness: brightness ?? this.brightness,
    core: core ?? this.core,
    text: text ?? this.text,
    icon: icon ?? this.icon,
    background: background ?? this.background,
    border: border ?? this.border,
    action: action ?? this.action,
    feedback: feedback ?? this.feedback,
    input: input ?? this.input,
    switchColours: switchColours ?? this.switchColours,
    staticColours: staticColours ?? this.staticColours,
  );

  static DievasColourThemeData lerp(DievasColourThemeData a, DievasColourThemeData b, double t) =>
      DievasColourThemeData(
        brightness: t < 0.5 ? a.brightness : b.brightness,
        core: CoreColours.lerp(a.core, b.core, t),
        text: TextColours.lerp(a.text, b.text, t),
        icon: IconColours.lerp(a.icon, b.icon, t),
        background: BackgroundColours.lerp(a.background, b.background, t),
        border: BorderColours.lerp(a.border, b.border, t),
        action: ActionColours.lerp(a.action, b.action, t),
        feedback: FeedbackColours.lerp(a.feedback, b.feedback, t),
        input: InputColours.lerp(a.input, b.input, t),
        switchColours: SwitchColours.lerp(a.switchColours, b.switchColours, t),
        staticColours: StaticColours.lerp(a.staticColours, b.staticColours, t),
      );

  @override
  List<Object?> get props => [
    brightness,
    core,
    text,
    icon,
    background,
    border,
    action,
    feedback,
    input,
    switchColours,
    staticColours,
  ];
}
