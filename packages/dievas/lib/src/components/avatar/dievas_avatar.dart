import 'package:flutter/widgets.dart';

import '../../theme/dievas_theme.dart';

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
/// ```
class DievasAvatar extends StatelessWidget {
  const DievasAvatar({
    super.key,
    this.imageProvider,
    this.initials,
    this.size = .md,
    this.shape = .circle,
    this.semanticLabel,
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

    Widget content;

    if (imageProvider case final provider?) {
      content = Image(image: provider, fit: .cover, width: dimension, height: dimension);
    } else if (initials case final text? when text.isNotEmpty) {
      final label = text.length > 2 ? text.substring(0, 2).toUpperCase() : text.toUpperCase();
      content = Center(
        child: Text(
          label,
          style: initialsStyle.copyWith(color: theme.initialsColor),
          maxLines: 1,
          overflow: .clip,
        ),
      );
    } else {
      // Placeholder — person outline icon via Unicode glyph or custom paint.
      // We use a proportional icon size (60% of container) so it scales naturally.
      final iconDimension = dimension * 0.55;
      content = Center(
        child: Icon(
          const IconData(0xe7fd, fontFamily: 'MaterialIcons'), // person
          size: iconDimension,
          color: theme.placeholderColor,
        ),
      );
    }

    final container = Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(color: theme.backgroundColor, borderRadius: borderRadius),
      clipBehavior: .antiAlias,
      child: content,
    );

    if (semanticLabel == null) return container;

    return Semantics(
      label: semanticLabel,
      image: imageProvider != null,
      child: ExcludeSemantics(child: container),
    );
  }
}
