part of '../example_foundations_screen.dart';

class _MotionPreview extends StatefulWidget {
  const _MotionPreview();

  @override
  State<_MotionPreview> createState() => _MotionPreviewState();
}

class _MotionPreviewState extends State<_MotionPreview> {
  bool _atEnd = false;

  @override
  Widget build(BuildContext context) {
    const avatarRadiusFactor = 0.5;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text('Standard motion', style: context.typography.titleMd),
        SizedBox(height: context.spacing.sm),
        Text(
          '${context.animation.standard.inMilliseconds} ms with standard easing',
          style: context.typography.codeSm.copyWith(color: context.colours.text.textSecondary),
        ),
        SizedBox(height: context.spacing.md),
        Container(
          height: context.sizing.buttonHeightLg + context.spacing.md,
          padding: EdgeInsets.all(context.spacing.sm),
          decoration: BoxDecoration(color: context.colours.background.cardBackground, borderRadius: context.border.lg),
          child: AnimatedAlign(
            alignment: _atEnd ? Alignment.centerRight : Alignment.centerLeft,
            duration: MediaQuery.disableAnimationsOf(context) ? Duration.zero : context.animation.standard,
            curve: context.animation.easingStandard,
            child: ExcludeSemantics(
              child: CircleAvatar(
                radius: context.sizing.avatarSm * avatarRadiusFactor,
                backgroundColor: context.colours.core.primary,
              ),
            ),
          ),
        ),
        SizedBox(height: context.spacing.md),
        DievasOutlinedButton(label: 'Replay motion', onPressed: () => setState(() => _atEnd = !_atEnd)),
        if (MediaQuery.disableAnimationsOf(context)) ...[
          SizedBox(height: context.spacing.sm),
          Text('Reduced motion is enabled. The position changes instantly.', style: context.typography.bodySm),
        ],
      ],
    );
  }
}
