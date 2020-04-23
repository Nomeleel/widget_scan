import 'dart:io';

import 'widget_scan.dart';

class GenerateRoute {

  GenerateRoute(
    this.widgetList,
    this.packageName,
  );
  
  List<WidgetObject> widgetList;
  String packageName;

  void generate() {
    generateViewCollection();
  }

  void generateViewCollection() {
    //TODO String Builder?
    String contents = '';
    widgetList.forEach((item) {
      contents += "export 'package:$packageName/${item.path}';\n";
    });
    if (contents.length > 0) {
      File file = File(r'viewRoute.dart');
      file.writeAsStringSync(contents);
      // Close?
    }
  }

}