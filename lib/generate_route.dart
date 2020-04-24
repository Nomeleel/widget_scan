import 'dart:io';

import 'widget_scan.dart';
import 'util/util.dart';

class GenerateRoute {

  GenerateRoute(
    this.widgetList,
  );
  
  List<WidgetObject> widgetList;

  void generate() {
    generateViewRoutes();
  }

  void generateViewRoutes() {
    //TODO String Builder?
    // If has same file name, whether change key to path plus name.
    String exportContent = '';
    String routesContent = '';
    var packageName = getTargetPackageName();
    widgetList?.forEach((item) {
      exportContent += "export 'package:$packageName/${item.path}';\n";
      routesContent += "  '${item.name}': (BuildContext context) => ${item.widgetName}(),\n";
    });

    if (exportContent.length > 0) {
      File file = File(getTargetFilePath('route/view_export_list.dart'));
      file.writeAsString(exportContent);
    }
    
    if (routesContent.length > 0) {
      File templateFile = File(getTargetFilePath('route/route_template'));
      String templateContent = templateFile.readAsStringSync();
      File file = File(getTargetFilePath('route/view_routes.dart'));
      file.writeAsString(templateContent.replaceAll('// Replace here.', routesContent));
    }
  }

}