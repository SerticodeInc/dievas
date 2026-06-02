import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final drawerComponent = WidgetbookComponent(
  name: 'Drawer',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'With Backdrop', builder: (ctx) => _WithBackdrop()),
  ],
);

class _Playground extends StatefulWidget {
  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  final _drawerKey = GlobalKey<DievasDrawerState>();

  @override
  Widget build(BuildContext context) {
    final width = context.knobs.double.slider(label: 'Width', initialValue: 280, min: 160, max: 400);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Demo'),
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () => _drawerKey.currentState?.open()),
      ),
      body: DievasDrawer(
        key: _drawerKey,
        width: width,
        drawer: ListView(
          children: [
            DrawerHeader(child: Text('Menu', style: DievasTheme.typographyOf(context).titleMd)),
            const ListTile(title: Text('Item 1')),
            const ListTile(title: Text('Item 2')),
            const ListTile(title: Text('Item 3')),
          ],
        ),
        child: Container(
          color: DievasTheme.colorsOf(context).background.bgBase,
          child: const Center(child: Text('Main content area')),
        ),
      ),
    );
  }
}

class _WithBackdrop extends StatefulWidget {
  @override
  State<_WithBackdrop> createState() => _WithBackdropState();
}

class _WithBackdropState extends State<_WithBackdrop> {
  final _drawerKey = GlobalKey<DievasDrawerState>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Drawer with Backdrop'),
      leading: IconButton(icon: const Icon(Icons.menu), onPressed: () => _drawerKey.currentState?.open()),
    ),
    body: DievasDrawer(
      key: _drawerKey,
      drawer: ListView(
        children: [
          DrawerHeader(child: Text('Menu', style: DievasTheme.typographyOf(context).titleMd)),
          ListTile(title: const Text('Item 1'), onTap: () => _drawerKey.currentState?.close()),
          ListTile(title: const Text('Item 2'), onTap: () => _drawerKey.currentState?.close()),
          ListTile(title: const Text('Item 3'), onTap: () => _drawerKey.currentState?.close()),
        ],
      ),
      child: Container(
        color: DievasTheme.colorsOf(context).background.bgBase,
        child: Center(
          child: ComponentBoundary(
            child: TextButton(onPressed: () => _drawerKey.currentState?.close(), child: const Text('Tap to close')),
          ),
        ),
      ),
    ),
  );
}
