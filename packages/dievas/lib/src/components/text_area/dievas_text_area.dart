import 'package:dievas/src/theme/component/text_input/dievas_text_input_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// A multiline text input area.
///
/// Shares the same token architecture as [DievasTextInput]. Height is driven
/// by [minLines] / [maxLines] rather than a fixed size enum — always uses the
/// `md` content padding and typography variant.
///
/// Moon reference: Textarea
///
/// ```dart
/// DievasTextArea(
///   controller: _ctrl,
///   label: 'Bio',
///   hint: 'Tell us about yourself...',
///   minLines: 3,
///   maxLines: 6,
/// )
/// DievasTextArea(controller: _ctrl, errorText: 'Required', maxLines: 4)
/// ```
class DievasTextArea extends StatelessWidget {
  const DievasTextArea({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.warningText,
    this.minLines = 3,
    this.maxLines = 6,
    this.enabled = true,
    this.keyboardType = TextInputType.multiline,
    this.textInputAction = TextInputAction.newline,
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

  /// Error message. Overrides [helperText] and switches the border to error colour.
  final String? errorText;

  /// Non-blocking validation feedback. Overrides [helperText] and switches the
  /// border to the warning colour. Takes precedence over the normal state but
  /// yields to [errorText] when both are set.
  final String? warningText;

  /// Minimum visible lines. Defaults to 3.
  final int minLines;

  /// Maximum lines before the field scrolls. Defaults to 6.
  final int? maxLines;

  final bool enabled;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final bool autofocus;
  final int? maxLength;
  final bool autocorrect;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).textInput;
    final hasError = switch (errorText) {
      final error? => error.isNotEmpty,
      _ => false,
    };
    final hasWarning = switch (warningText) {
      final warning? when !hasError => warning.isNotEmpty,
      _ => false,
    };

    // TextArea always uses md tokens

    final (borderColour, focusedBorderColour) = switch ((hasError, hasWarning)) {
      (true, _) => (theme.borderColourError, theme.borderColourError),
      (false, true) => (theme.borderColourWarning, theme.borderColourWarning),
      _ => (theme.borderColour, theme.borderColourFocused),
    };

    final border = OutlineInputBorder(
      borderRadius: theme.borderRadius,
      borderSide: BorderSide(color: borderColour, width: theme.strokeWidth),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: theme.borderRadius,
      borderSide: BorderSide(color: focusedBorderColour, width: theme.strokeWidthFocused),
    );

    final disabledBorder = OutlineInputBorder(
      borderRadius: theme.borderRadius,
      borderSide: BorderSide(color: theme.borderColour, width: theme.strokeWidth),
    );

    final content = _DievasTextFieldContent(
      theme: theme,
      hasError: hasError,
      hasWarning: hasWarning,
      label: label,
      helperText: helperText,
      errorText: errorText,
      warningText: warningText,
      field: TextField(
        controller: controller,
        focusNode: focusNode,
        style: theme.inputStyle.md,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onEditingComplete: onEditingComplete,
        autofocus: autofocus,
        maxLength: maxLength,
        autocorrect: autocorrect,
        enabled: enabled,
        minLines: minLines,
        maxLines: maxLines,
        cursorColor: theme.borderColourFocused,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: theme.placeholderStyle.md,
          contentPadding: theme.contentPadding.md,
          filled: true,
          fillColor: theme.bgColour,
          border: border,
          enabledBorder: border,
          focusedBorder: focusedBorder,
          disabledBorder: disabledBorder,
          errorBorder: focusedBorder,
          focusedErrorBorder: focusedBorder,
          isDense: true,
          counterText: '',
        ),
      ),
    );

    return switch (enabled) {
      true => content,
      _ => Opacity(opacity: theme.disabledOpacity, child: content),
    };
  }
}

class _DievasTextFieldContent extends StatelessWidget {
  const _DievasTextFieldContent({
    required this.theme,
    required this.hasError,
    required this.hasWarning,
    required this.field,
    this.label,
    this.helperText,
    this.errorText,
    this.warningText,
  });

  final DievasTextInputThemeData theme;
  final bool hasError;
  final bool hasWarning;
  final Widget field;

  final String? label;
  final String? helperText;
  final String? errorText;
  final String? warningText;

  @override
  Widget build(BuildContext context) {
    final feedback = switch ((errorText, hasError, warningText, hasWarning, helperText)) {
      (final error?, true, _, _, _) => (
        message: error,
        style: theme.errorStyle.copyWith(color: theme.borderColourError),
      ),
      (_, _, final warning?, true, _) => (
        message: warning,
        style: theme.errorStyle.copyWith(color: theme.borderColourWarning),
      ),
      (_, _, _, _, final helper?) => (message: helper, style: theme.helperStyle),
      _ => null,
    };

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        if (label case final text?) ...[
          DefaultTextStyle(style: theme.labelStyle, child: Text(text)),
          SizedBox(height: theme.labelSpacing),
        ],
        field,
        if (feedback case (message: final message, style: final style)?) ...[
          SizedBox(height: theme.helperSpacing),
          DefaultTextStyle(style: style, child: Text(message)),
        ],
      ],
    );
  }
}
