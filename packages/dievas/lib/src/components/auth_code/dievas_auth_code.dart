import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dievas/src/theme/component/auth_code/dievas_auth_code_theme_data.dart';
import 'package:dievas/src/theme/dievas_theme.dart';

/// A digit-by-digit passcode entry field.
///
/// Each digit renders in its own box with a blinking cursor on the active
/// position. The keyboard is a hidden [TextField] that captures input and
/// forwards it to the visible digit boxes.
///
/// [onCompleted] fires once when the user fills all [codeLength] boxes.
///
/// Moon reference: AuthCode
///
/// ```dart
/// DievasAuthCode(codeLength: 6, onCompleted: (code) => verify(code))
/// DievasAuthCode(codeLength: 4, obscureText: true, onCompleted: (pin) => ...)
/// ```
class DievasAuthCode extends StatefulWidget {
  const DievasAuthCode({
    super.key,
    required this.codeLength,
    required this.onCompleted,
    this.obscureText = false,
    this.enabled = true,
    this.autofocus = true,
  });

  /// Number of digit boxes (1-8).
  final int codeLength;

  /// Fires once when all [codeLength] digits are filled.
  final ValueChanged<String> onCompleted;

  /// When `true` each filled digit shows a dot instead of the character.
  final bool obscureText;

  /// When `false` the field is read-only.
  final bool enabled;

  /// Whether to focus the hidden input on mount.
  final bool autofocus;

  @override
  State<DievasAuthCode> createState() => _DievasAuthCodeState();
}

class _DievasAuthCodeState extends State<DievasAuthCode> with SingleTickerProviderStateMixin {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _cursorController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600))
      ..repeat(reverse: true);
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _cursorController.dispose();
    super.dispose();
  }

  int get _filledCount => _controller.text.length;

  void _onTextChange(String value) {
    setState(() {});
    if (value.length >= widget.codeLength) {
      widget.onCompleted(value.substring(0, widget.codeLength));
    }
  }

  void _onTapField() {
    if (!widget.enabled) return;
    if (!_focusNode.hasFocus) _focusNode.requestFocus();
    final pos = _controller.text.length.clamp(0, widget.codeLength);
    _controller.selection = TextSelection.collapsed(offset: pos);
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).authCode;
    final totalWidth = theme.width * widget.codeLength + theme.gap * (widget.codeLength - 1);

    Widget group = SizedBox(
      width: totalWidth,
      height: theme.height,
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                enabled: widget.enabled,
                autofocus: widget.autofocus,
                maxLength: widget.codeLength,
                buildCounter: (_, {required int currentLength, required bool isFocused, required int? maxLength}) =>
                    const SizedBox.shrink(),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                enableInteractiveSelection: false,
                onChanged: _onTextChange,
                style: theme.digitStyle,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: .min,
            children: [
              for (var i = 0; i < widget.codeLength; i++) ...[
                if (i > 0) SizedBox(width: theme.gap),
                _DigitBox(
                  index: i,
                  controller: _controller,
                  filledCount: _filledCount,
                  isFocused: _focusNode.hasFocus,
                  obscureText: widget.obscureText,
                  cursorController: _cursorController,
                ),
              ],
            ],
          ),
        ],
      ),
    );

    if (!widget.enabled) {
      group = Opacity(opacity: theme.disabledOpacity, child: group);
    }

    return GestureDetector(onTap: _onTapField, child: group);
  }
}

class _DigitBox extends StatelessWidget {
  const _DigitBox({
    required this.index,
    required this.controller,
    required this.filledCount,
    required this.isFocused,
    required this.obscureText,
    required this.cursorController,
  });

  final int index;
  final TextEditingController controller;
  final int filledCount;
  final bool isFocused;
  final bool obscureText;
  final AnimationController cursorController;

  bool get _isFilled => index < filledCount;
  bool get _isActive => index == filledCount && isFocused;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).authCode;

    final borderColour = switch ((_isFilled, _isActive)) {
      (true, _) || (_, true) => theme.borderColourFocused,
      _ => theme.borderColour,
    };
    final strokeWidth = switch ((_isFilled, _isActive)) {
      (true, _) || (_, true) => theme.strokeWidthFocused,
      _ => theme.strokeWidth,
    };

    return Container(
      width: theme.width,
      height: theme.height,
      decoration: BoxDecoration(
        color: theme.bgColour,
        borderRadius: theme.borderRadius,
        border: Border.all(color: borderColour, width: strokeWidth),
      ),
      alignment: .center,
      child: switch ((_isFilled, _isActive)) {
        (true, _) => _FilledDigit(index: index, controller: controller, obscureText: obscureText, theme: theme),
        (_, true) => _Cursor(cursorController: cursorController, theme: theme),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _FilledDigit extends StatelessWidget {
  const _FilledDigit({required this.index, required this.controller, required this.obscureText, required this.theme});

  final int index;
  final TextEditingController controller;
  final bool obscureText;
  final DievasAuthCodeThemeData theme;

  @override
  Widget build(BuildContext context) {
    if (obscureText) {
      final r = theme.cursorHeight / 3;
      final dotColour = theme.digitStyle.color ?? DievasTheme.colorsOf(context).text.textPrimary;
      return Container(
        width: r,
        height: r,
        decoration: BoxDecoration(shape: .circle, color: dotColour),
      );
    }
    return Text(controller.text[index], style: theme.digitStyle);
  }
}

class _Cursor extends AnimatedWidget {
  const _Cursor({required this.cursorController, required this.theme}) : super(listenable: cursorController);

  final AnimationController cursorController;
  final DievasAuthCodeThemeData theme;

  @override
  Widget build(BuildContext context) => Opacity(
    opacity: cursorController.value,
    child: Container(
      width: theme.cursorWidth,
      height: theme.cursorHeight,
      decoration: BoxDecoration(color: theme.cursorColour, borderRadius: .circular(theme.cursorWidth / 2)),
    ),
  );
}
