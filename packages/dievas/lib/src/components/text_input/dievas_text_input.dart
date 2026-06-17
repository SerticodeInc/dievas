import 'package:dievas/src/theme/component/text_input/dievas_text_input_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// Size variants for [DievasTextInput].
enum DievasTextInputSize {
  /// 40 dp container height — compact contexts.
  sm,

  /// 48 dp container height — default.
  md,

  /// 52 dp container height — prominent / hero inputs.
  lg,
}

/// A themed text input field.
///
/// All colours, sizes, and typography are token-driven via [DievasTheme].
/// No raw values appear in this file.
///
/// Moon reference: TextInput
///
/// ```dart
/// DievasTextInput(
///   controller: _ctrl,
///   label: 'Email',
///   hint: 'you@example.com',
///   leadingIcon: Icon(Icons.email_outlined),
/// )
/// DievasTextInput(controller: _ctrl, errorText: 'Invalid email', size: .sm)
/// DievasTextInput(controller: _ctrl, enabled: false)
/// ```
class DievasTextInput extends StatefulWidget {
  const DievasTextInput({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.leadingIcon,
    this.trailingIcon,
    this.size = DievasTextInputSize.md,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.autofocus = false,
    this.maxLength,
    this.autocorrect = true,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  /// Floating label rendered above the input container.
  final String? label;

  /// Placeholder text shown when the field is empty.
  final String? hint;

  /// Helper text shown below the input when there is no error.
  final String? helperText;

  /// Error message. Overrides [helperText] and switches the border to the
  /// error colour.
  final String? errorText;

  /// Leading widget inside the input container (icon, prefix, etc.).
  final Widget? leadingIcon;

  /// Trailing widget inside the input container (icon, suffix, etc.).
  final Widget? trailingIcon;

  final DievasTextInputSize size;

  /// When `false` the field is read-only and dimmed.
  final bool enabled;

  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final bool autofocus;
  final int? maxLength;
  final bool autocorrect;

  @override
  State<DievasTextInput> createState() => _DievasTextInputState();
}

class _DievasTextInputState extends State<DievasTextInput> {
  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).textInput;
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    final height = switch (widget.size) {
      .sm => theme.height.sm,
      .md => theme.height.md,
      .lg => theme.height.lg,
    };

    final contentPadding = switch (widget.size) {
      .sm => theme.contentPadding.sm,
      .md => theme.contentPadding.md,
      .lg => theme.contentPadding.lg,
    };

    final inputStyle = switch (widget.size) {
      .sm => theme.inputStyle.sm,
      .md => theme.inputStyle.md,
      .lg => theme.inputStyle.lg,
    };

    final placeholderStyle = switch (widget.size) {
      .sm => theme.placeholderStyle.sm,
      .md => theme.placeholderStyle.md,
      .lg => theme.placeholderStyle.lg,
    };

    final borderColor = hasError ? theme.borderColorError : theme.borderColor;
    final focusedBorderColor = hasError ? theme.borderColorError : theme.borderColorFocused;

    final border = OutlineInputBorder(
      borderRadius: theme.borderRadius,
      borderSide: BorderSide(color: borderColor, width: theme.strokeWidth),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: theme.borderRadius,
      borderSide: BorderSide(color: focusedBorderColor, width: theme.strokeWidthFocused),
    );

    final disabledBorder = OutlineInputBorder(
      borderRadius: theme.borderRadius,
      borderSide: BorderSide(color: theme.borderColor, width: theme.strokeWidth),
    );

    final content = _DievasTextInputFieldContent(
      theme: theme,
      hasError: hasError,
      label: widget.label,
      helperText: widget.helperText,
      errorText: widget.errorText,
      field: SizedBox(
        height: height,
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: inputStyle,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
          autofocus: widget.autofocus,
          maxLength: widget.maxLength,
          autocorrect: widget.autocorrect,
          enabled: widget.enabled,
          maxLines: 1,
          cursorColor: theme.borderColorFocused,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: placeholderStyle,
            contentPadding: contentPadding,
            filled: true,
            fillColor: theme.bgColor,
            border: border,
            enabledBorder: border,
            focusedBorder: focusedBorder,
            disabledBorder: disabledBorder,
            errorBorder: focusedBorder,
            focusedErrorBorder: focusedBorder,
            // Suppress internal helper/error text — we render our own below.
            isDense: true,
            counterText: '',
            prefixIconConstraints: switch (widget.leadingIcon) {
              null => null,
              _ => BoxConstraints(minWidth: theme.iconSize + contentPadding.left + theme.iconSpacing),
            },
            suffixIconConstraints: switch (widget.trailingIcon) {
              null => null,
              _ => BoxConstraints(minWidth: theme.iconSize + contentPadding.right + theme.iconSpacing),
            },
            prefixIcon: switch (widget.leadingIcon) {
              null => null,
              final leadingIcon => Padding(
                padding: EdgeInsetsDirectional.only(start: contentPadding.left, end: theme.iconSpacing),
                child: IconTheme(
                  data: IconThemeData(color: theme.iconColor, size: theme.iconSize),
                  child: leadingIcon,
                ),
              ),
            },
            suffixIcon: switch (widget.trailingIcon) {
              null => null,
              final trailingIcon => Padding(
                padding: EdgeInsetsDirectional.only(end: contentPadding.right, start: theme.iconSpacing),
                child: IconTheme(
                  data: IconThemeData(color: theme.iconColor, size: theme.iconSize),
                  child: trailingIcon,
                ),
              ),
            },
          ),
        ),
      ),
    );

    if (!widget.enabled) {
      return Opacity(opacity: theme.disabledOpacity, child: content);
    }

    return content;
  }
}

class _DievasTextInputFieldContent extends StatelessWidget {
  const _DievasTextInputFieldContent({
    required this.theme,
    required this.hasError,
    required this.field,
    this.label,
    this.helperText,
    this.errorText,
  });

  final DievasTextInputThemeData theme;
  final bool hasError;
  final Widget field;

  final String? label;
  final String? helperText;
  final String? errorText;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    crossAxisAlignment: .start,
    children: [
      if (label case final labelText?) ...[
        DefaultTextStyle(style: theme.labelStyle, child: Text(labelText)),
        SizedBox(height: theme.labelSpacing),
      ],
      field,
      if (errorText case final errorText? when hasError) ...[
        SizedBox(height: theme.helperSpacing),
        DefaultTextStyle(
          style: theme.errorStyle.copyWith(color: theme.borderColorError),
          child: Text(errorText),
        ),
      ] else if (helperText case final helperText?) ...[
        SizedBox(height: theme.helperSpacing),
        DefaultTextStyle(style: theme.helperStyle, child: Text(helperText)),
      ],
    ],
  );
}
