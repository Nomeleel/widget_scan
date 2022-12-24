import 'dart:io';

import 'util/util.dart';
import 'widget_scan.dart';

class GenerateRoute {
  GenerateRoute(
    this.widgetList,
  );

  List<WidgetObject> widgetList;

  void generate() {
    generateViewRoutes();
  }

  void generateViewRoutes() {
    // TODO(Nomeleel): String Builder?
    // If has same file name, whether change key to path plus name.
    String exportContent = '';
    String routesContent = '';
    const String importContent = "import 'view_export_list.dart';";
    final String packageName = getTargetPackageName();
    if (widgetList != null) {
      final void Function(WidgetObject) generateContent = (WidgetObject item) {
        exportContent += "export 'package:$packageName/view/${item.path}';\n";
        routesContent += "  '${item.name}': (BuildContext context) => const ${item.widgetName}(),\n";
      };
      widgetList.forEach(generateContent);
    }

    if (exportContent.isNotEmpty) {
      createDirectory(getProjectLibPath('route'));
      final File file = File(getProjectLibPath('route/view_export_list.dart'));
      file.writeAsString(exportContent);

      final File templateFile = File(getTargetFilePath('route/route_template'));
      // TODO(Nomeleel): String Builder?
      final String templateContent = templateFile
          .readAsStringSync()
          .replaceAll('// Import here.', importContent)
          .replaceAll('// Replace here.', routesContent);
      File(getProjectLibPath('route/view_routes.dart')).writeAsString(templateContent);
    }
  }
}
