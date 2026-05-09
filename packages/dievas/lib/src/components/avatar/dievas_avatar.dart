import 'package:flutter/widgets.dart';

/// Size variants for [DievasAvatar].
enum DievasAvatarSize {
  /// 24 × 24 dp — inline / compact contexts.
  xs,

  /// 32 × 32 dp — default list row size.
  sm,

  /// 40 × 40 dp — standard card/header size.
  md,

  /// 56 × 56 dp — profile hero.
  lg,

  /// 72 × 72 dp — full-page profile.
  xl,
}

/// Visual style of the avatar container.
enum DievasAvatarShape {
  /// Fully circular container.
  circle,

  /// Rounded-square container.
  square,
}

/// A circular or square container that displays a user's image, initials, or
/// a placeholder icon.
///
/// Moon reference: Avatar
///
/// ```dart
/// DievasAvatar(
///   imageProvider: NetworkImage(user.avatarUrl),
///   semanticLabel: user.displayName,
/// )
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

  /// Image to display. Takes precedence over [initials].
  final ImageProvider? imageProvider;

  /// Up to two characters shown when no image is provided.
  final String? initials;

  final DievasAvatarSize size;
  final DievasAvatarShape shape;

  /// Screen-reader description of this avatar.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    // Implementation lands in M3.
    assert(false, 'DievasAvatar is not yet implemented — it renders nothing. Implementation lands in M3.');
    return const SizedBox.shrink();
  }
}
