import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'gallery_components.dart';

void main() => runApp(const DievasGallery());

class DievasGallery extends StatelessWidget {
  const DievasGallery({super.key});

  @override
  Widget build(BuildContext context) => Widgetbook.material(
    home: const DievasHomePage(),
    directories: [
      WidgetbookCategory(
        name: 'Foundations',
        children: [colorTokensComponent, typographyScaleComponent, spacingTokensComponent, elevationOpacityComponent],
      ),
      WidgetbookCategory(
        name: 'Components',
        children: [
          WidgetbookFolder(
            name: 'Buttons',
            children: [filledButtonComponent, outlinedButtonComponent, textButtonComponent, iconButtonComponent],
          ),
          WidgetbookFolder(
            name: 'Display',
            children: [
              dotIndicatorComponent,
              avatarComponent,
              badgeComponent,
              circularLoaderComponent,
              circularProgressComponent,
              dividerComponent,
              emptyStateComponent,
              iconComponent,
              linearLoaderComponent,
              linearProgressComponent,
              tagComponent,
            ],
          ),
          WidgetbookFolder(
            name: 'Form',
            children: [
              authCodeComponent,
              checkboxComponent,
              dropdownComponent,
              radioComponent,
              segmentedControlComponent,
              switchComponent,
              textInputComponent,
              textAreaComponent,
              textInputGroupComponent,
            ],
          ),
          WidgetbookFolder(name: 'Feedback', children: [alertComponent, bannerComponent, snackbarComponent]),
          WidgetbookFolder(name: 'Overlays', children: [bottomSheetComponent, modalComponent, tooltipComponent]),
          WidgetbookFolder(name: 'Utility', children: [loaderComponent]),
          WidgetbookFolder(name: 'Search', children: [searchWithListComponent, searchWithDropdownComponent]),
          WidgetbookFolder(
            name: 'Nav / Disclosure',
            children: [
              breadcrumbComponent,
              menuItemComponent,
              tabBarComponent,
              accordionComponent,
              drawerComponent,
              popoverComponent,
            ],
          ),
        ],
      ),
    ],
    addons: [
      ComponentBoundaryAddon(),
      DievasThemeAddon(),
      InspectorAddon(),
      TextScaleAddon(min: 0.75, max: 1.5, initialScale: 1),
    ],
  );
}
