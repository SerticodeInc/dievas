import 'package:flutter/material.dart';

import 'package:dievas/l10n/dievas_localizations.dart';
import 'package:dievas/src/components/buttons/dievas_icon_button.dart';
import 'package:dievas/src/components/buttons/dievas_button_builder.dart';
import 'package:dievas/src/theme/dievas_theme.dart';

/// Input sizes for the search composites.
enum DievasSearchSize { sm, md, lg, xl }

/// Shared input surface for the two search composites; not a package export.
class DievasSearchField extends StatefulWidget {
  const DievasSearchField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSearch,
    required this.onClear,
    required this.enabled,
    required this.hasFloatingLabel,
    this.onClose,
    this.hint,
    this.clearLabel,
    this.leadingIcon,
    this.size,
    this.borderRadius,
    this.activeBorderColour,
    this.inactiveBorderColour,
    this.hoverBorderColour,
    this.backgroundColour,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSearch;
  final VoidCallback onClear;
  final bool enabled;
  final bool hasFloatingLabel;
  final VoidCallback? onClose;
  final String? hint;
  final String? clearLabel;
  final Widget? leadingIcon;
  final DievasSearchSize? size;
  final BorderRadiusGeometry? borderRadius;
  final Color? activeBorderColour;
  final Color? inactiveBorderColour;
  final Color? hoverBorderColour;
  final Color? backgroundColour;

  @override
  State<DievasSearchField> createState() => _DievasSearchFieldState();
}

class _DievasSearchFieldState extends State<DievasSearchField> {
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_refresh);
  }

  @override
  void didUpdateWidget(DievasSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      oldWidget.focusNode.removeListener(_refresh);
      widget.focusNode.addListener(_refresh);
    }
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_refresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).search;
    final sizing = DievasTheme.sizingOf(context);
    final spacing = DievasTheme.spacingOf(context);
    final strings = DievasLocalizations.of(context);
    final radius = (widget.borderRadius ?? theme.borderRadius).resolve(Directionality.of(context));
    final height = switch (widget.size) {
      .sm => sizing.height32,
      .md => sizing.height40,
      .lg => sizing.height48,
      .xl => sizing.height56,
      null => theme.height,
    };
    final inputStyle = switch (widget.size) {
      .lg || .xl => DievasTheme.typographyOf(context).bodyMd,
      _ => theme.inputStyle,
    };
    final padding = switch (widget.size) {
      .sm => EdgeInsets.symmetric(horizontal: spacing.sm),
      .xl => EdgeInsets.symmetric(horizontal: spacing.md),
      _ => theme.contentPadding.copyWith(top: spacing.none, bottom: spacing.none),
    };
    final borderColour = switch ((widget.focusNode.hasFocus, _hovered)) {
      (true, _) => widget.activeBorderColour ?? theme.borderColourFocused,
      (_, true) => widget.hoverBorderColour ?? theme.borderColour,
      _ => widget.inactiveBorderColour ?? theme.borderColour,
    };
    final hint = widget.hint ?? strings.searchHint;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        behavior: .opaque,
        onTap: widget.enabled ? _activate : null,
        child: Opacity(
          opacity: widget.enabled ? 1 : theme.disabledOpacity,
          child: Container(
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              color: widget.backgroundColour ?? theme.bgColour,
              borderRadius: radius,
              border: Border.all(color: borderColour, width: theme.strokeWidth),
            ),
            child: Row(
              children: [
                switch (widget.leadingIcon) {
                  final icon? => icon,
                  _ => _SearchIcon(colour: theme.iconColour, size: theme.iconSize, stroke: theme.strokeWidth),
                },
                SizedBox(width: spacing.sm),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    enabled: widget.enabled,
                    style: inputStyle,
                    textAlignVertical: .center,
                    strutStyle: StrutStyle.fromTextStyle(inputStyle, forceStrutHeight: true),
                    cursorHeight: inputStyle.fontSize,
                    onTap: widget.onSearch,
                    onChanged: (_) => widget.onSearch(),
                    decoration: InputDecoration(
                      hintText: widget.hasFloatingLabel ? null : hint,
                      labelText: widget.hasFloatingLabel ? hint : null,
                      hintStyle: inputStyle.copyWith(color: theme.placeholderStyle.color),
                      labelStyle: inputStyle.copyWith(color: theme.placeholderStyle.color),
                      floatingLabelBehavior: widget.hasFloatingLabel ? .auto : .never,
                      contentPadding: .zero,
                      isDense: true,
                      isCollapsed: !widget.hasFloatingLabel,
                      filled: false,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                _SearchClearButton(
                  label: widget.clearLabel ?? strings.searchClearLabel,
                  height: height - theme.strokeWidth * 2,
                  onPressed: widget.enabled ? widget.onClear : null,
                ),
                if (widget.onClose case final close?) ...[
                  SizedBox(
                    height: sizing.iconSm,
                    child: VerticalDivider(width: spacing.sm, thickness: theme.strokeWidth, color: theme.dividerColour),
                  ),
                  DievasIconButton(
                    size: .sm,
                    semanticLabel: strings.searchCloseLabel,
                    foregroundColor: theme.iconColour,
                    onPressed: widget.enabled ? close : null,
                    icon: Icon(Icons.close, size: sizing.iconSm),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _refresh() => setState(() {});

  void _activate() {
    widget.focusNode.requestFocus();
    widget.onSearch();
  }
}

class _SearchIcon extends StatelessWidget {
  const _SearchIcon({required this.colour, required this.size, required this.stroke});
  final Color colour;
  final double size;
  final double stroke;

  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: Size.square(size), painter: _SearchIconPainter(colour, stroke));
}

class _SearchIconPainter extends CustomPainter {
  const _SearchIconPainter(this.colour, this.stroke);
  final Color colour;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = colour
      ..strokeWidth = stroke
      ..style = .stroke
      ..strokeCap = .round;
    canvas.drawCircle(Offset(size.width * .42, size.height * .42), size.shortestSide * .3, paint);
    canvas.drawLine(Offset(size.width * .64, size.height * .64), Offset(size.width * .9, size.height * .9), paint);
  }

  @override
  bool shouldRepaint(_SearchIconPainter oldDelegate) => colour != oldDelegate.colour || stroke != oldDelegate.stroke;
}

class _SearchClearButton extends StatelessWidget {
  const _SearchClearButton({required this.label, required this.height, required this.onPressed});

  final String label;
  final double height;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final components = DievasTheme.componentsOf(context);
    final button = components.textButton.primary;
    return DievasButtonBuilder(
      state: .idle,
      style: button.style,
      shape: RoundedRectangleBorder(borderRadius: DievasTheme.borderOf(context).sm),
      disabledOpacity: button.disabledOpacity,
      pressOpacity: button.pressOpacity,
      iconSpacing: button.iconSpacing.sm,
      iconSize: button.iconSize.sm,
      textStyle: components.search.inputStyle.copyWith(color: components.search.iconColour),
      height: height,
      padding: EdgeInsetsDirectional.only(start: DievasTheme.spacingOf(context).sm),
      showBorder: false,
      foregroundColor: components.search.iconColour,
      label: label,
      onPressed: onPressed,
    );
  }
}
