"""Analyse the published Dart examples and exercise adoption workflows."""
from pathlib import Path
import re
import subprocess
import tempfile
from textwrap import dedent

root = Path(__file__).resolve().parents[1]
imports = [
    "import 'package:dievas/dievas.dart';",
    "import 'package:dievas_tokens/dievas_tokens.dart';",
    "import 'package:flutter/material.dart';",
]
with tempfile.TemporaryDirectory(prefix='dievas-documentation-') as directory:
    consumer = Path(directory)
    (consumer / 'lib').mkdir()
    (consumer / 'test').mkdir()
    (consumer / 'pubspec.yaml').write_text('''name: dievas_documentation_examples
publish_to: none
environment:
  sdk: '>=3.11.4 <4.0.0'
dependencies:
  flutter:
    sdk: flutter
  dievas: 1.0.4
  dievas_tokens: 1.0.3
dev_dependencies:
  flutter_test:
    sdk: flutter
''')
    (consumer / 'analysis_options.yaml').write_text('''analyzer:
  errors:
    unused_import: ignore
''')
    count = 0
    for page in sorted((root / 'src/content/docs').rglob('*.mdx')):
        snippets = re.findall(r'```dart[^\n]*\n(.*?)\n\s*```', page.read_text(), re.S)
        if not snippets:
            continue
        code = '\n\n'.join(dedent(snippet) for snippet in snippets)
        declared_imports = re.findall(r"^import [^\n]+;", code, re.M)
        code = re.sub(r"^import [^\n]+;\n?", '', code, flags=re.M)
        declarations = '\n'.join(dict.fromkeys(imports + declared_imports))
        relative = page.relative_to(root / 'src/content/docs').with_suffix('')
        filename = '_'.join(relative.parts) + '.dart'
        (consumer / 'lib' / filename).write_text(declarations + '\n\n' + code + '\n')
        count += len(snippets)
    (consumer / 'test/adoption_test.dart').write_text('''
import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dievas_documentation_examples/start_first_screen.dart';
import 'package:dievas_documentation_examples/recipes_forms.dart';
import 'package:dievas_documentation_examples/recipes_settings.dart';
import 'package:dievas_documentation_examples/recipes_confirmation.dart';

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => DievasScope(
    builder: (context, theme, _) => MaterialApp(
      theme: theme.material,
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  testWidgets('first screen shows action feedback', (tester) async {
    await tester.pumpWidget(const DievasExampleApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Try an action'));
    await tester.pumpAndSettle();
    expect(find.text('Your first Dievas screen is ready.'), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('form validates and clears its error', (tester) async {
    await tester.pumpWidget(const _TestApp(child: ProfileForm()));
    await tester.tap(find.text('Validate name'));
    await tester.pumpAndSettle();
    expect(find.text('Enter your name.'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Ada');
    await tester.pumpAndSettle();
    expect(find.text('Enter your name.'), findsNothing);
    await tester.tap(find.text('Validate name'));
    await tester.pumpAndSettle();
    expect(find.text('Name validated'), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('appearance settings update the scope', (tester) async {
    await tester.pumpWidget(const _TestApp(child: AppearanceSettings()));
    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();
    final context = tester.element(find.byType(AppearanceSettings));
    expect(DievasScope.of(context).themeMode, ThemeMode.dark);
    expect(DievasTheme.of(context).colours.brightness, Brightness.dark);
    await tester.tap(find.text('Light'));
    await tester.pumpAndSettle();
    expect(DievasScope.of(context).themeMode, ThemeMode.light);
  });

  testWidgets('confirmation requires explicit acceptance', (tester) async {
    var confirmed = 0;
    await tester.pumpWidget(_TestApp(child: RemoveItemAction(
      onConfirmed: () => confirmed++,
    )));
    await tester.tap(find.text('Remove item'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(confirmed, 0);
    await tester.tap(find.text('Remove item'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Remove'));
    await tester.pumpAndSettle();
    expect(confirmed, 1);
  });
}
''')
    print(f'Checking {count} Dart blocks in a standalone hosted consumer.', flush=True)
    for command in [
        ['flutter', 'pub', 'get'],
        ['flutter', 'analyze', '--no-pub'],
        ['flutter', 'test', '--no-pub'],
    ]:
        subprocess.run(command, cwd=consumer, check=True)
