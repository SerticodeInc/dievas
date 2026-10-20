import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../knobs/knob_section.dart';
import '../../knobs/token_colour_knob.dart';
import '../../widgets/component_boundary.dart';

enum ButtonGalleryVariant { filled, outlined, text }

enum _Tone { primary, secondary, destructive }

/// Shared reference controls for the three standard button variants.
class ButtonPlayground extends StatefulWidget {
  const ButtonPlayground({super.key, required this.variant, this.showAll = false});

  final ButtonGalleryVariant variant;
  final bool showAll;

  @override
  State<ButtonPlayground> createState() => _ButtonPlaygroundState();
}

class _ButtonPlaygroundState extends State<ButtonPlayground> {
  String _feedback = 'Press a button';
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    context.knobSection('Content');
    final label = context.knobs.string(label: 'Label text', initialValue: 'DievasButton');
    final showLeading = context.knobs.boolean(label: 'Leading', initialValue: true);
    final showLabel = context.knobs.boolean(label: 'Label', initialValue: true);
    final showTrailing = context.knobs.boolean(label: 'Trailing');
    context.knobSection('Layout');
    final size = context.knobs.object.dropdown<DievasButtonSize>(
      label: 'Size',
      options: DievasButtonSize.values,
      initialOption: .md,
      labelBuilder: (value) => value.name,
    );
    final fullWidth = context.knobs.boolean(label: 'Full width');
    context.knobSection('Background');
    final overrideBackground = context.knobs.boolean(label: 'Override background colour');
    final background = context.tokenColourKnob(label: 'Background colour', role: .background);
    context.knobSection('Border');
    final showBorder = context.knobs.boolean(label: 'Show border', initialValue: widget.variant == .outlined);
    final overrideBorder = context.knobs.boolean(label: 'Override border colour');
    final border = context.tokenColourKnob(label: 'Border colour', role: .border);
    final overrideRadius = context.knobs.boolean(label: 'Override border radius');
    final radius = context.knobs.double.slider(label: 'Border radius', initialValue: 8, min: 0, max: 40);
    context.knobSection('Text');
    final overrideText = context.knobs.boolean(label: 'Override text colour');
    final foreground = context.tokenColourKnob(label: 'Text colour', role: .text);
    context.knobSection('Interaction');
    final disabled = context.knobs.boolean(label: 'Disabled');
    final loading = context.knobs.boolean(label: 'Loading');
    final animateLoading = context.knobs.boolean(label: 'Animate loading transition', initialValue: true);
    final pulse = context.knobs.boolean(label: 'Show pulse effect');
    final jiggle = context.knobs.boolean(label: 'Show pulse effect jiggle');
    final tone = context.knobs.object.dropdown(
      label: 'Style',
      options: widget.variant == .filled ? _Tone.values : [_Tone.primary, _Tone.destructive],
      labelBuilder: (value) => value.name,
    );
    final rtl = context.knobs.boolean(label: 'Right to left');

    return Center(
      child: SingleChildScrollView(
        child: Directionality(
          textDirection: rtl ? .rtl : .ltr,
          child: Column(
            mainAxisSize: .min,
            children: [
              for (final variant in widget.showAll ? ButtonGalleryVariant.values : [widget.variant]) ...[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: context.spacing.md),
                  child: Row(
                    children: [
                      const Expanded(child: DievasDivider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
                        child: Text('${variant.name} button', style: context.typography.labelXs),
                      ),
                      const Expanded(child: DievasDivider()),
                    ],
                  ),
                ),
                ComponentBoundary(
                  child: _PreviewButton(
                    variant: variant,
                    tone: tone,
                    size: size,
                    state: disabled
                        ? .disabled
                        : loading
                        ? .loading
                        : .idle,
                    label: showLabel ? label : '',
                    leading: showLeading ? const DievasIcon(Icons.crop_square) : null,
                    trailing: showTrailing ? const DievasIcon(Icons.keyboard_arrow_right) : null,
                    radius: overrideRadius ? BorderRadius.circular(radius) : null,
                    showBorder: widget.showAll ? variant == .outlined : showBorder,
                    background: overrideBackground ? background : null,
                    foreground: overrideText ? foreground : null,
                    border: overrideBorder ? border : null,
                    fullWidth: fullWidth,
                    pulse: pulse,
                    animateLoading: animateLoading,
                    jiggle: jiggle,
                    onPressed: disabled
                        ? null
                        : () => setState(() => _feedback = 'Pressed ${variant.name} (${++_count})'),
                    onLongPress: disabled
                        ? null
                        : () => setState(() => _feedback = 'Long pressed ${variant.name} (${++_count})'),
                  ),
                ),
              ],
              SizedBox(height: context.spacing.lg),
              Semantics(liveRegion: true, child: Text(_feedback, style: context.typography.bodySm)),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviewButton extends StatelessWidget {
  const _PreviewButton({
    required this.variant,
    required this.tone,
    required this.size,
    required this.state,
    required this.label,
    required this.leading,
    required this.trailing,
    required this.radius,
    required this.showBorder,
    required this.background,
    required this.foreground,
    required this.border,
    required this.fullWidth,
    required this.pulse,
    required this.animateLoading,
    required this.jiggle,
    required this.onPressed,
    required this.onLongPress,
  });

  final ButtonGalleryVariant variant;
  final _Tone tone;
  final DievasButtonSize size;
  final DievasButtonState state;
  final String label;
  final Widget? leading;
  final Widget? trailing;
  final BorderRadius? radius;
  final bool showBorder;
  final Color? background;
  final Color? foreground;
  final Color? border;
  final bool fullWidth;
  final bool pulse;
  final bool animateLoading;
  final bool jiggle;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) => switch (variant) {
    .filled => DievasFilledButton(
      label: label,
      leadingIcon: leading,
      trailingIcon: trailing,
      size: size,
      state: state,
      style: switch (tone) {
        .primary => .primary,
        .secondary => .secondary,
        .destructive => .destructive,
      },
      borderRadius: radius,
      showBorder: showBorder,
      backgroundColor: background,
      foregroundColor: foreground,
      borderColor: border,
      isFullWidth: fullWidth,
      showPulseEffect: pulse,
      animateLoading: animateLoading,
      showPulseEffectJiggle: jiggle,
      semanticLabel: label.isEmpty ? 'Filled action' : null,
      onPressed: onPressed,
      onLongPress: onLongPress,
    ),
    .outlined => DievasOutlinedButton(
      label: label,
      leadingIcon: leading,
      trailingIcon: trailing,
      size: size,
      state: state,
      style: tone == .destructive ? .destructive : .primary,
      borderRadius: radius,
      showBorder: showBorder,
      backgroundColor: background,
      foregroundColor: foreground,
      borderColor: border,
      isFullWidth: fullWidth,
      showPulseEffect: pulse,
      animateLoading: animateLoading,
      showPulseEffectJiggle: jiggle,
      semanticLabel: label.isEmpty ? 'Outlined action' : null,
      onPressed: onPressed,
      onLongPress: onLongPress,
    ),
    .text => DievasTextButton(
      label: label,
      leadingIcon: leading,
      trailingIcon: trailing,
      size: size,
      state: state,
      style: tone == .destructive ? .destructive : .primary,
      borderRadius: radius,
      showBorder: showBorder,
      backgroundColor: background,
      foregroundColor: foreground,
      borderColor: border,
      isFullWidth: fullWidth,
      showPulseEffect: pulse,
      animateLoading: animateLoading,
      showPulseEffectJiggle: jiggle,
      semanticLabel: label.isEmpty ? 'Text action' : null,
      onPressed: onPressed,
      onLongPress: onLongPress,
    ),
  };
}
