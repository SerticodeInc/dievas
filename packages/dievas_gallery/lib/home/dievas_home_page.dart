import 'package:flutter/material.dart';

/// Custom home page shown in the Widgetbook canvas when no component is selected.
///
/// Self-contained — uses inline color constants from the Dievas dark palette
/// rather than InheritedWidget lookup (the addons haven't fired yet at this
/// route, so DievasTheme.of(context) is not available here).
class DievasHomePage extends StatelessWidget {
  const DievasHomePage({super.key});

  static const _bg = Color(0xFF020617);
  static const _bgSubtle = Color(0xFF0F172A);
  static const _bgElevated = Color(0xFF1E293B);
  static const _brand = Color(0xFF818CF8);
  static const _textHi = Color(0xFFF8FAFC);
  static const _textMid = Color(0xFF94A3B8);
  static const _textLo = Color(0xFF64748B);
  static const _border = Color(0xFF334155);
  static const _borderBrand = Color(0xFF818CF8);
  static const _success = Color(0xFF4ADE80);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: _bg,
    body: SingleChildScrollView(
      padding: const .symmetric(horizontal: 48, vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              _Eyebrow(),
              const SizedBox(height: 24),
              _Headline(),
              const SizedBox(height: 16),
              _Subtitle(),
              const SizedBox(height: 56),
              _StatsRow(),
              const SizedBox(height: 56),
              const _SectionLabel('Components'),
              const SizedBox(height: 16),
              _ComponentCategory(
                name: 'Buttons',
                count: 4,
                components: const ['FilledButton', 'OutlinedButton', 'TextButton', 'IconButton'],
              ),
              const SizedBox(height: 8),
              _ComponentCategory(
                name: 'Display',
                count: 7,
                components: const ['Avatar', 'Badge', 'CircularProgress', 'Divider', 'Icon', 'LinearProgress', 'Tag'],
              ),
              const SizedBox(height: 8),
              _ComponentCategory(
                name: 'Form',
                count: 5,
                components: const ['Checkbox', 'Radio', 'Switch', 'TextField', 'TextArea'],
              ),
              const SizedBox(height: 8),
              _ComponentCategory(
                name: 'Overlays',
                count: 4,
                shipped: false,
                components: const ['BottomSheet', 'Toast', 'Modal', 'Tooltip'],
              ),
              const SizedBox(height: 56),
              _HintBadge(),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    ),
  );
}

class _Eyebrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 6,
        height: 6,
        decoration: const BoxDecoration(color: DievasHomePage._brand, shape: .circle),
      ),
      const SizedBox(width: 10),
      const Text(
        'FLUTTER DESIGN SYSTEM',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          letterSpacing: 2.5,
          color: DievasHomePage._brand,
          fontWeight: .w500,
        ),
      ),
    ],
  );
}

class _Headline extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Text(
    'Dievas',
    style: TextStyle(fontSize: 80, fontWeight: .w900, color: DievasHomePage._textHi, height: 0.92, letterSpacing: -3),
  );
}

class _Subtitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Text(
    "Ports Moon Design System's component catalogue.\n"
    'Token-driven. InheritedModel-first. Multi-brand.',
    style: TextStyle(fontSize: 15, color: DievasHomePage._textMid, height: 1.75, fontWeight: .w400),
  );
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(
      children: [
        _StatCell(value: '3', label: 'packages'),
        _Divider(),
        _StatCell(value: '2', label: 'default themes'),
        _Divider(),
        _StatCell(value: '16', label: 'components'),
        _Divider(),
        _StatCell(value: '∞', label: 'brand configs'),
      ],
    ),
  );
}

class _StatCell extends StatelessWidget {
  const _StatCell({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: .w900,
            color: DievasHomePage._textHi,
            height: 1,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            letterSpacing: 1.8,
            color: DievasHomePage._textLo,
            fontWeight: .w500,
          ),
        ),
      ],
    ),
  );
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, margin: const .symmetric(horizontal: 24), color: DievasHomePage._border);
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: const TextStyle(
      fontFamily: 'monospace',
      fontSize: 10,
      letterSpacing: 2,
      color: DievasHomePage._textLo,
      fontWeight: .w500,
    ),
  );
}

class _ComponentCategory extends StatelessWidget {
  const _ComponentCategory({required this.name, required this.count, required this.components, this.shipped = true});

  final String name;
  final int count;
  final List<String> components;
  final bool shipped;

  @override
  Widget build(BuildContext context) {
    final dotColor = shipped ? DievasHomePage._success : DievasHomePage._border;
    final borderColor = shipped ? DievasHomePage._border : DievasHomePage._bgElevated;

    return Container(
      decoration: BoxDecoration(
        color: DievasHomePage._bgSubtle,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: dotColor, shape: .circle),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: DievasHomePage._textHi,
                fontWeight: .w500,
              ),
            ),
          ),
          Expanded(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final c in components)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: DievasHomePage._bgElevated,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: DievasHomePage._border.withAlpha(100)),
                    ),
                    child: Text(
                      c,
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 10, color: DievasHomePage._textMid),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '$count',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 13, color: DievasHomePage._textLo),
          ),
        ],
      ),
    );
  }
}

class _HintBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: const .symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: DievasHomePage._bgSubtle,
      border: .all(color: DievasHomePage._borderBrand.withAlpha(80)),
      borderRadius: .circular(12),
    ),
    child: Row(
      mainAxisSize: .min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(color: DievasHomePage._brand, shape: .circle),
        ),
        const SizedBox(width: 12),
        const Text(
          'Select a component from the sidebar to explore use cases',
          style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: DievasHomePage._textMid),
        ),
      ],
    ),
  );
}
