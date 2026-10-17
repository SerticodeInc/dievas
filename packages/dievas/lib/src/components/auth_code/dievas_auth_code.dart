import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dievas/src/theme/component/auth_code/dievas_auth_code_theme_data.dart';
import 'package:dievas/src/theme/dievas_theme.dart';

/// Shape of each authentication-code field.
enum DievasAuthCodeShape { box, circle, underline }

/// A digit by digit passcode entry field backed by a hidden [TextField].
///
/// [onCompleted] fires for each distinct completed edit. Moon reference: AuthCode.
///
/// ```dart
/// DievasAuthCode(codeLength: 6, onCompleted: (code) => verify(code))
/// ```
class DievasAuthCode extends StatefulWidget {
  const DievasAuthCode({
    super.key,
    required this.codeLength,
    required this.onCompleted,
    this.obscureText = false,
    this.enabled = true,
    this.autofocus = true,
    this.mainAxisAlignment = .center,
    this.shape = .box,
    this.textColour,
    this.cursorColour,
    this.selectedFillColour,
    this.activeFillColour,
    this.inactiveFillColour,
    this.selectedBorderColour,
    this.activeBorderColour,
    this.inactiveBorderColour,
    this.errorBorderColour,
    this.borderRadius,
    this.gap,
    this.hasError = false,
    this.errorShakeAnimation = false,
    this.peekWhenObscuring = false,
    this.onChanged,
    this.semanticLabel = 'Authentication code',
  }) : assert(codeLength >= 1 && codeLength <= 7),
       assert(gap == null || gap >= 0);

  /// Horizontal placement within the available width.
  final MainAxisAlignment mainAxisAlignment;

  /// Field outline; circle uses the smaller field dimension as its diameter.
  final DievasAuthCodeShape shape;

  final Color? textColour;
  final Color? cursorColour;

  /// Selected means the cursor position; active means a filled field.
  final Color? selectedFillColour;
  final Color? activeFillColour;
  final Color? inactiveFillColour;
  final Color? selectedBorderColour;
  final Color? activeBorderColour;
  final Color? inactiveBorderColour;
  final Color? errorBorderColour;
  final BorderRadius? borderRadius;
  final double? gap;

  /// Applies the theme's error border to all fields.
  final bool hasError;

  /// Shakes on errors and when enabled during an existing error. Respects reduced motion.
  final bool errorShakeAnimation;

  /// Briefly reveals the last typed digit, but never a multi-digit paste.
  final bool peekWhenObscuring;

  /// Reports edits, including deletion and incomplete codes.
  final ValueChanged<String>? onChanged;
  final String semanticLabel;

  /// Number of digit boxes (1-7).
  final int codeLength;

  /// Fires for each distinct edit that fills all [codeLength] digits.
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

class _DievasAuthCodeState extends State<DievasAuthCode> with TickerProviderStateMixin {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final AnimationController _cursorController;
  late final AnimationController _shakeController;
  Timer? _peekTimer;
  int? _peekIndex;
  String _previousText = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _cursorController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _shakeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _focusNode.addListener(_onFocusChange);
    if (widget.hasError && widget.errorShakeAnimation) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _shakeIfEnabled();
      });
    }
  }

  @override
  void dispose() {
    _peekTimer?.cancel();
    _shakeController.dispose();
    _controller.dispose();
    _focusNode.dispose();
    _cursorController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DievasAuthCode oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.codeLength != widget.codeLength) {
      _peekTimer?.cancel();
      _peekIndex = null;
    }
    if (oldWidget.codeLength != widget.codeLength && _controller.text.length > widget.codeLength) {
      _controller.text = _controller.text.substring(0, widget.codeLength);
      _previousText = _controller.text;
    }
    if (!widget.enabled || !widget.obscureText || !widget.peekWhenObscuring) {
      _peekTimer?.cancel();
      _peekIndex = null;
    }
    if (!widget.enabled) _focusNode.unfocus();
    if (widget.hasError && (!oldWidget.hasError || widget.errorShakeAnimation != oldWidget.errorShakeAnimation)) {
      _shakeIfEnabled();
    }
    if (!widget.hasError || !widget.errorShakeAnimation) _shakeController.reset();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).authCode;
    final fieldGap = widget.gap ?? theme.gap;
    final totalWidth = theme.width * widget.codeLength + fieldGap * (widget.codeLength - 1);

    final group = LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.hasBoundedWidth ? constraints.maxWidth : totalWidth;
        final effectiveGap = math.min(fieldGap, availableWidth / (widget.codeLength * 2));
        final fieldWidth = math.min(
          theme.width,
          (availableWidth - effectiveGap * (widget.codeLength - 1)) / widget.codeLength,
        );

        return SizedBox(
          width: availableWidth,
          height: theme.height,
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0,
                  alwaysIncludeSemantics: true,
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    enabled: widget.enabled,
                    obscureText: widget.obscureText,
                    autofillHints: const [AutofillHints.oneTimeCode],
                    enableSuggestions: false,
                    autocorrect: false,
                    autofocus: widget.autofocus,
                    maxLength: widget.codeLength,
                    buildCounter: (_, {required int currentLength, required bool isFocused, required int? maxLength}) =>
                        const SizedBox.shrink(),
                    keyboardType: .number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    enableInteractiveSelection: false,
                    onChanged: _onTextChange,
                    onTap: _onTapField,
                    style: theme.digitStyle,
                    decoration: InputDecoration(
                      labelText: widget.semanticLabel,
                      errorText: widget.hasError ? 'Invalid code' : null,
                      border: .none,
                      isDense: true,
                      contentPadding: .zero,
                    ),
                  ),
                ),
              ),
              ExcludeSemantics(
                child: IgnorePointer(
                  child: Row(
                    mainAxisAlignment: widget.mainAxisAlignment,
                    children: [
                      for (int i = 0; i < widget.codeLength; i++) ...[
                        if (i > 0) SizedBox(width: effectiveGap),
                        _DigitBox(
                          index: i,
                          options: widget,
                          width: fieldWidth,
                          peek: i == _peekIndex,
                          controller: _controller,
                          filledCount: _filledCount,
                          isFocused: _focusNode.hasFocus,
                          obscureText: widget.obscureText,
                          cursorController: _cursorController,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) => Transform.translate(
        offset: Offset(
          MediaQuery.disableAnimationsOf(context)
              ? 0
              : math.sin(_shakeController.value * math.pi * 6) * (1 - _shakeController.value) * 8,
          0,
        ),
        child: child,
      ),
      child: Opacity(
        opacity: widget.enabled ? 1 : theme.disabledOpacity,
        child: GestureDetector(behavior: .opaque, onTap: _onTapField, child: group),
      ),
    );
  }

  void _shakeIfEnabled() {
    if (widget.enabled && widget.errorShakeAnimation && !MediaQuery.disableAnimationsOf(context)) {
      _shakeController.forward(from: 0);
    }
  }

  int get _filledCount => _controller.text.length;

  void _onFocusChange() {
    if (_focusNode.hasFocus && !MediaQuery.disableAnimationsOf(context)) {
      _cursorController.repeat(reverse: true);
    } else {
      _cursorController.stop();
      _cursorController.value = 1;
      _peekTimer?.cancel();
      _peekIndex = null;
    }
    setState(() {});
  }

  void _onTextChange(String value) {
    _peekTimer?.cancel();
    _peekIndex = switch ((widget.obscureText && widget.peekWhenObscuring, value.length - _previousText.length)) {
      (true, 1) => value.length - 1,
      _ => null,
    };
    if (_peekIndex != null) {
      _peekTimer = Timer(const Duration(milliseconds: 700), () => setState(() => _peekIndex = null));
    }
    final completed = value.length == widget.codeLength && value != _previousText;
    _previousText = value;
    setState(() {});
    widget.onChanged?.call(value);
    if (completed) widget.onCompleted(value);
  }

  void _onTapField() {
    if (!widget.enabled) return;
    if (!_focusNode.hasFocus) _focusNode.requestFocus();
    final pos = _controller.text.length.clamp(0, widget.codeLength);
    _controller.selection = TextSelection.collapsed(offset: pos);
  }
}

class _DigitBox extends StatelessWidget {
  const _DigitBox({
    required this.index,
    required this.options,
    required this.width,
    required this.peek,
    required this.controller,
    required this.filledCount,
    required this.isFocused,
    required this.obscureText,
    required this.cursorController,
  });

  final DievasAuthCode options;
  final double width;
  final bool peek;
  final int index;
  final TextEditingController controller;
  final int filledCount;
  final bool isFocused;
  final bool obscureText;
  final AnimationController cursorController;

  bool get _isFilled => index < filledCount;
  bool get _isActive => index == math.min(filledCount, options.codeLength - 1) && isFocused && options.enabled;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).authCode;

    final borderColour = switch ((options.hasError, _isActive, _isFilled)) {
      (true, _, _) => options.errorBorderColour ?? theme.borderColourError,
      (_, true, _) => options.selectedBorderColour ?? theme.borderColourFocused,
      (_, _, true) => options.activeBorderColour ?? theme.borderColourFocused,
      _ => options.inactiveBorderColour ?? theme.borderColour,
    };
    final fillColour = switch ((_isActive, _isFilled)) {
      (true, _) => options.selectedFillColour ?? theme.bgColour,
      (_, true) => options.activeFillColour ?? theme.bgColour,
      _ => options.inactiveFillColour ?? theme.bgColour,
    };
    final border = BorderSide(color: borderColour, width: theme.strokeWidth);
    final style = theme.digitStyle.copyWith(color: options.textColour);
    final strokeWidth = switch ((_isFilled, _isActive)) {
      (true, _) || (_, true) => theme.strokeWidthFocused,
      _ => theme.strokeWidth,
    };

    return Container(
      width: width,
      height: options.shape == .circle ? width : theme.height,
      decoration: BoxDecoration(
        color: fillColour,
        shape: options.shape == .circle ? .circle : .rectangle,
        borderRadius: options.shape == .box ? options.borderRadius ?? theme.borderRadius : null,
        border: options.shape == .underline ? Border(bottom: border) : .all(color: borderColour, width: strokeWidth),
      ),
      alignment: .center,
      child: switch ((_isFilled, _isActive)) {
        (true, _) => _FilledDigit(
          index: index,
          controller: controller,
          obscureText: obscureText && !peek,
          theme: theme,
          style: style,
        ),
        (_, true) => _Cursor(
          cursorController: cursorController,
          theme: theme,
          colour: options.cursorColour ?? theme.cursorColour,
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _FilledDigit extends StatelessWidget {
  const _FilledDigit({
    required this.index,
    required this.controller,
    required this.obscureText,
    required this.theme,
    required this.style,
  });

  final int index;
  final TextEditingController controller;
  final bool obscureText;
  final DievasAuthCodeThemeData theme;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    if (obscureText) {
      final r = theme.cursorHeight / 3;
      final dotColour = style.color ?? DievasTheme.coloursOf(context).text.textPrimary;
      return Container(
        width: r,
        height: r,
        decoration: BoxDecoration(shape: .circle, color: dotColour),
      );
    }

    return Text(controller.text[index], style: style);
  }
}

class _Cursor extends AnimatedWidget {
  const _Cursor({required this.cursorController, required this.theme, required this.colour})
    : super(listenable: cursorController);

  final Color colour;
  final AnimationController cursorController;
  final DievasAuthCodeThemeData theme;

  @override
  Widget build(BuildContext context) => Opacity(
    opacity: cursorController.value,
    child: Container(
      width: theme.cursorWidth,
      height: theme.cursorHeight,
      decoration: BoxDecoration(color: colour, borderRadius: .circular(theme.cursorWidth / 2)),
    ),
  );
}
