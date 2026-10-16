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
        Text('Standard motion', style: context.typography.titleMD),
        SizedBox(height: context.spacing.SM),
        Text(
          '${context.animation.standard.inMilliseconds} ms with standard easing',
          style: context.typography.codeSM.copyWith(color: context.colours.text.textSecondary),
        ),
        SizedBox(height: context.spacing.MD),
        Container(
          height: context.sizing.buttonHeightLG + context.spacing.MD,
          padding: EdgeInsets.all(context.spacing.SM),
          decoration: BoxDecoration(color: context.colours.background.cardBackground, borderRadius: context.border.LG),
          child: AnimatedAlign(
            alignment: _atEnd ? Alignment.centerRight : Alignment.centerLeft,
            duration: MediaQuery.disableAnimationsOf(context) ? Duration.zero : context.animation.standard,
            curve: context.animation.easingStandard,
            child: ExcludeSemantics(
              child: CircleAvatar(
                radius: context.sizing.avatarSM * avatarRadiusFactor,
                backgroundColor: context.colours.core.primary,
              ),
            ),
          ),
        ),
        SizedBox(height: context.spacing.MD),
        DievasOutlinedButton(label: 'Replay motion', onPressed: () => setState(() => _atEnd = !_atEnd)),
        if (MediaQuery.disableAnimationsOf(context)) ...[
          SizedBox(height: context.spacing.SM),
          Text('Reduced motion is enabled. The position changes instantly.', style: context.typography.bodySM),
        ],
      ],
    );
  }
}
