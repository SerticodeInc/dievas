import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// Size variants for [DievasAvatar].
enum DievasAvatarSize {
  /// 24 × 24 dp — inline / compact contexts.
  xs,

  /// 32 × 32 dp — default list row size.
  sm,

  /// 40 × 40 dp — standard card/header size.
  md,

  /// 48 × 48 dp — profile hero.
  lg,

  /// 64 × 64 dp — full-page profile.
  xl,
}

/// Visual style of the avatar container.
enum DievasAvatarShape {
  /// Fully circular container.
  circle,

  /// Rounded-square container — uses [DievasAvatarThemeData.borderRadiusSquare].
  square,
}

/// A circular or square container that displays a user's image, initials, or
/// a placeholder icon.
///
/// Content priority: [imageProvider] → [initials] → placeholder person icon.
///
/// Moon reference: Avatar
///
/// ```dart
/// DievasAvatar(
///   imageProvider: NetworkImage(user.avatarUrl),
///   semanticLabel: user.displayName,
/// )
/// DievasAvatar(initials: 'AB', size: .lg)
/// DievasAvatar(size: .sm, shape: .square)
/// DievasAvatar(
///   initials: 'AB',
///   backgroundColour: Colors.blue,
///   initialsColour: Colors.white,
///   borderColour: Colors.blueGrey,
/// )
/// ```
///
/// All colour parameters are optional; when `null` the theme values are used.
class DievasAvatar extends StatelessWidget {
  const DievasAvatar({
    super.key,
    this.imageProvider,
    this.initials,
    this.size = .md,
    this.shape = .circle,
    this.semanticLabel,
    this.backgroundColour,
    this.initialsColour,
    this.placeholderColour,
    this.borderColour,
  });

  /// Image to display. Takes precedence over [initials] and the placeholder.
  final ImageProvider? imageProvider;

  /// Up to two characters shown when no [imageProvider] is provided.
  final String? initials;

  /// Container size variant.
  final DievasAvatarSize size;

  /// Container shape — circle or rounded square.
  final DievasAvatarShape shape;

  /// Screen-reader description of this avatar.
  final String? semanticLabel;

  /// Container background colour — overrides the theme's default when provided.
  final Color? backgroundColour;

  /// Initials text colour — overrides the theme's default when provided.
  final Color? initialsColour;

  /// Placeholder icon colour — overrides the theme's default when provided.
  final Color? placeholderColour;

  /// Optional ring colour around the avatar. When `null`, no border is drawn.
  final Color? borderColour;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).avatar;

    final dimension = switch (size) {
      .xs => theme.sizeXs,
      .sm => theme.sizeSm,
      .md => theme.sizeMd,
      .lg => theme.sizeLg,
      .xl => theme.sizeXl,
    };

    final initialsStyle = switch (size) {
      .xs => theme.initialsStyleXs,
      .sm => theme.initialsStyleSm,
      .md => theme.initialsStyleMd,
      .lg => theme.initialsStyleLg,
      .xl => theme.initialsStyleXl,
    };

    final borderRadius = switch (shape) {
      .circle => BorderRadius.circular(dimension / 2),
      .square => theme.borderRadiusSquare,
    };

    final background = backgroundColour ?? theme.backgroundColour;

    final border = switch (borderColour) {
      final colour? => Border.all(color: colour),
      null => null,
    };

    final content = switch ((imageProvider, initials)) {
      (final provider?, _) => Image(image: provider, fit: .cover, width: dimension, height: dimension),
      (_, final text?) when text.isNotEmpty => Center(
        child: Text(
          (text.length > 2 ? text.substring(0, 2) : text).toUpperCase(),
          style: initialsStyle.copyWith(color: initialsColour ?? theme.initialsColour),
          maxLines: 1,
          overflow: .clip,
        ),
      ),
      // Placeholder — person outline icon via Unicode glyph or custom paint. We use a proportional icon size (60% of container) so it scales naturally.
      _ => Center(
        child: Icon(Icons.person, size: dimension * 0.55, color: placeholderColour ?? theme.placeholderColour),
      ),
    };

    final container = Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(color: background, borderRadius: borderRadius, border: border),
      clipBehavior: .antiAlias,
      child: content,
    );

    return switch (semanticLabel) {
      final label? => Semantics(
        label: label,
        image: imageProvider != null,
        child: ExcludeSemantics(child: container),
      ),
      _ => container,
    };
  }
}
