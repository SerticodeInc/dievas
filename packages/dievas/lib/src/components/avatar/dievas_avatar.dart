import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// Avatar sizes. Existing xs - xl dimensions are retained; xl2 adds 80 dp.
enum DievasAvatarSize { xs, sm, md, lg, xl, xl2 }

/// Circle or rounded square avatar surface.
enum DievasAvatarShape { circle, square }

/// Badge corners mirror in right-to-left layouts, following reading direction.
enum DievasAvatarBadgeAlignment { topLeft, topRight, bottomLeft, bottomRight }

/// An image backed avatar with optional foreground content and a status badge.
///
/// [content] overlays an image. Without custom content, the image takes
/// precedence over [initials], with initials/person shown while loading or on
/// failure. Initials use at most two complete grapheme clusters.
///
/// The default shape is rounded square. Use [shape] to request a circle.
class DievasAvatar extends StatelessWidget {
  const DievasAvatar({
    super.key,
    this.imageProvider,
    this.initials,
    this.content,
    this.size = .md,
    this.shape = .square,
    this.semanticLabel,
    this.backgroundColour,
    this.initialsColour,
    this.placeholderColour,
    this.borderColour,
    this.borderWidth = 1,
    this.borderRadius,
    this.width,
    this.height,
    this.textStyle,
    this.showBadge = false,
    this.badgeColour,
    this.badgeSize,
    this.badgeMarginValue,
    this.badgeAlignment = .bottomRight,
    this.badgeSemanticLabel,
  }) : assert(width == null || width > 0),
       assert(height == null || height > 0),
       assert(borderWidth >= 0),
       assert(badgeSize == null || badgeSize > 0),
       assert(badgeMarginValue == null || badgeMarginValue >= 0);

  final ImageProvider? imageProvider;
  final String? initials;

  /// Optional foreground widget, including over [imageProvider].
  final Widget? content;
  final DievasAvatarSize size;
  final DievasAvatarShape shape;
  final String? semanticLabel;
  final Color? backgroundColour;
  final Color? initialsColour;
  final Color? placeholderColour;

  /// Optional border painted above the image and content.
  final Color? borderColour;
  final double borderWidth;

  /// Explicit radius takes precedence over [shape]. Resolves directional radii.
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final bool showBadge;
  final Color? badgeColour;
  final double? badgeSize;

  /// Transparent separation cut out around the badge, including over images.
  final double? badgeMarginValue;
  final DievasAvatarBadgeAlignment badgeAlignment;
  final String? badgeSemanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).avatar;
    final dimension = switch (size) {
      .xs => theme.sizeXs,
      .sm => theme.sizeSm,
      .md => theme.sizeMd,
      .lg => theme.sizeLg,
      .xl => theme.sizeXl,
      .xl2 => theme.sizeXl2,
    };
    final style = switch (size) {
      .xs => theme.initialsStyleXs,
      .sm => theme.initialsStyleSm,
      .md => theme.initialsStyleMd,
      .lg => theme.initialsStyleLg,
      .xl => theme.initialsStyleXl,
      .xl2 => theme.initialsStyleXl2 ?? theme.initialsStyleXl,
    };
    final foreground = switch (content) {
      null => _AvatarFallback(initials: initials, iconColour: placeholderColour ?? theme.placeholderColour),
      _ => const SizedBox.shrink(),
    };

    return SizedBox(
      width: width ?? dimension,
      height: height ?? dimension,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bounds = constraints.biggest;
          final radius = switch ((borderRadius, shape)) {
            (final override?, _) => override.resolve(Directionality.of(context)),
            (_, .circle) => BorderRadius.circular(bounds.shortestSide / 2),
            (_, .square) => theme.borderRadiusSquare,
          };
          final diameter = math.min(badgeSize ?? bounds.shortestSide * theme.badgeSizeFactor, bounds.shortestSide);
          final badgeCentre = switch (badgeAlignment) {
            .topLeft => AlignmentDirectional.topStart,
            .topRight => AlignmentDirectional.topEnd,
            .bottomLeft => AlignmentDirectional.bottomStart,
            .bottomRight => AlignmentDirectional.bottomEnd,
          }.resolve(Directionality.of(context)).inscribe(Size.square(diameter), Offset.zero & bounds).center;
          final gap = badgeMarginValue ?? bounds.shortestSide * theme.badgeMarginFactor;

          return Stack(
            children: [
              Positioned.fill(
                child: Semantics(
                  label: semanticLabel,
                  image: imageProvider != null,
                  excludeSemantics: semanticLabel != null,
                  child: ClipPath(
                    clipper: _AvatarClipper(
                      radius: radius,
                      badgeCentre: badgeCentre,
                      cutoutRadius: showBadge ? diameter / 2 + gap : 0,
                    ),
                    child: DefaultTextStyle(
                      style: style
                          .merge(textStyle)
                          .copyWith(
                            color: switch ((initialsColour, textStyle?.color)) {
                              (final colour?, _) || (_, final colour?) => colour,
                              _ => theme.initialsColour,
                            },
                          ),
                      child: IconTheme(
                        data: IconThemeData(
                          color: placeholderColour ?? theme.placeholderColour,
                          size: bounds.shortestSide * 0.55,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: backgroundColour ?? theme.backgroundColour,
                            borderRadius: radius,
                          ),
                          foregroundDecoration: switch (borderColour) {
                            final colour? => BoxDecoration(
                              borderRadius: radius,
                              border: .all(color: colour, width: borderWidth),
                            ),
                            _ => null,
                          },
                          child: Stack(
                            fit: .expand,
                            children: [
                              switch (imageProvider) {
                                final provider? => Image(
                                  image: provider,
                                  fit: .cover,
                                  excludeFromSemantics: true,
                                  frameBuilder: (context, child, frame, synchronous) =>
                                      synchronous || frame != null ? child : foreground,
                                  errorBuilder: (context, error, stackTrace) => foreground,
                                ),
                                _ => content == null ? foreground : const SizedBox.shrink(),
                              },
                              if (content case final child?) Center(child: child),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (showBadge)
                Positioned(
                  left: badgeCentre.dx - diameter / 2,
                  top: badgeCentre.dy - diameter / 2,
                  width: diameter,
                  height: diameter,
                  child: Semantics(
                    label: badgeSemanticLabel,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: .circle,
                        color: switch ((badgeColour, theme.badgeColour)) {
                          (final colour?, _) || (_, final colour?) => colour,
                          _ => DievasTheme.coloursOf(context).feedback.feedbackSuccess.icon,
                        },
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  const _AvatarFallback({required this.initials, required this.iconColour});

  final String? initials;
  final Color iconColour;

  @override
  Widget build(BuildContext context) => Center(
    child: switch (initials) {
      final text? when text.isNotEmpty => Text(
        text.toUpperCase().characters.take(2).toString(),
        style: DefaultTextStyle.of(context).style,
        maxLines: 1,
        overflow: .clip,
      ),
      _ => Icon(Icons.person, color: iconColour),
    },
  );
}

class _AvatarClipper extends CustomClipper<Path> {
  const _AvatarClipper({required this.radius, required this.badgeCentre, required this.cutoutRadius});

  final BorderRadius radius;
  final Offset badgeCentre;
  final double cutoutRadius;

  @override
  Path getClip(Size size) {
    final surface = Path()..addRRect(radius.toRRect(Offset.zero & size));
    return switch (cutoutRadius) {
      final radius when radius > 0 => Path.combine(
        .difference,
        surface,
        Path()..addOval(Rect.fromCircle(center: badgeCentre, radius: radius)),
      ),
      _ => surface,
    };
  }

  @override
  bool shouldReclip(_AvatarClipper oldClipper) =>
      radius != oldClipper.radius || badgeCentre != oldClipper.badgeCentre || cutoutRadius != oldClipper.cutoutRadius;
}
