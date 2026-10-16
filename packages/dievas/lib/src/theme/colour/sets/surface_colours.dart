import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

/// Surface colour roles for specialized contexts within the Dievas design system.
///
/// These are distinct from [BackgroundColours] — they describe surfaces with
/// specific functional roles (canvas, code blocks, sidebars, table stripes)
/// rather than the generic background elevation stack.
final class SurfaceColours extends Equatable {
  const SurfaceColours({
    required this.canvasBackground,
    required this.codeBlockBackground,
    required this.sidebarBackground,
    required this.tableRowAlternateBackground,
  });

  /// Canvas / drawing surface. Distinguishable from [pageBackground] for creative
  /// workspaces, whiteboards, and illustration areas.
  final Color canvasBackground;

  /// Code block / inline code background. Visually distinct so code stands
  /// apart from surrounding content.
  final Color codeBlockBackground;

  /// Sidebar / navigation rail background. Provides a visual anchor for
  /// persistent navigation alongside the main content area.
  final Color sidebarBackground;

  /// Alternating table row background. Applied to every other row for
  /// horizontal scan ability in data tables and list views.
  final Color tableRowAlternateBackground;

  SurfaceColours copyWith({
    Color? canvasBackground,
    Color? codeBlockBackground,
    Color? sidebarBackground,
    Color? tableRowAlternateBackground,
  }) => SurfaceColours(
    canvasBackground: canvasBackground ?? this.canvasBackground,
    codeBlockBackground: codeBlockBackground ?? this.codeBlockBackground,
    sidebarBackground: sidebarBackground ?? this.sidebarBackground,
    tableRowAlternateBackground: tableRowAlternateBackground ?? this.tableRowAlternateBackground,
  );

  static SurfaceColours lerp(SurfaceColours a, SurfaceColours b, double t) => SurfaceColours(
    canvasBackground: Color.lerp(a.canvasBackground, b.canvasBackground, t)!,
    codeBlockBackground: Color.lerp(a.codeBlockBackground, b.codeBlockBackground, t)!,
    sidebarBackground: Color.lerp(a.sidebarBackground, b.sidebarBackground, t)!,
    tableRowAlternateBackground: Color.lerp(a.tableRowAlternateBackground, b.tableRowAlternateBackground, t)!,
  );

  @override
  List<Object?> get props => [canvasBackground, codeBlockBackground, sidebarBackground, tableRowAlternateBackground];
}
