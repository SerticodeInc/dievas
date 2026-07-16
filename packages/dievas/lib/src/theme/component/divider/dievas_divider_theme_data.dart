import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'dievas_divider_indent.dart';

/// Theme data for [DievasDivider].
///
/// Token-derived by the component mapper. The widget reads this from
/// [DievasComponentThemeData.divider].
@immutable
final class DievasDividerThemeData extends Equatable {
  const DievasDividerThemeData({
    required this.thickness,
    required this.colour,
    this.indent = .none,
    this.endIndent = .none,
  });

  /// Divider stroke thickness (dp).
  final double thickness;

  /// Divider colour.
  final Color colour;

  /// Default leading indent. Falls back to [DievasDividerIndent.none].
  final DievasDividerIndent indent;

  /// Default trailing indent. Falls back to [DievasDividerIndent.none].
  final DievasDividerIndent endIndent;

  /// Creates a copy of this [DievasDividerThemeData] with the given fields replaced.
  DievasDividerThemeData copyWith({
    double? thickness,
    Color? colour,
    DievasDividerIndent? indent,
    DievasDividerIndent? endIndent,
  }) => DievasDividerThemeData(
    thickness: thickness ?? this.thickness,
    colour: colour ?? this.colour,
    indent: indent ?? this.indent,
    endIndent: endIndent ?? this.endIndent,
  );

  @override
  List<Object?> get props => [thickness, colour, indent, endIndent];
}
