library widget_scan;

import 'dart:io';
import 'route/routeTemplate.dart';
import 'package:flutter/widgets.dart';

class WidgetScan {
  List<WidgetObject> getWidgetList(RegExp rule, {String limitPath}) {
    List<WidgetObject> widgetList = List<WidgetObject>();
    String dirPath = limitPath ?? Directory.current.path + '\\lib';
    Directory(dirPath)
      ..listSync(recursive: true).forEach((item) {
        if (FileSystemEntity.isFileSync(item.path)) {
          String fileName = rule.stringMatch(_getFileName(item.path));
          if (!_isNullOrEmpty(fileName)) {
            widgetList.add(WidgetObject(fileName, _getFileRelativePath(item.path, dirPath), fileName.toUpperCase()));
          }
        }
      });

    return widgetList;
  }

  generateRoute(List<WidgetObject> widgetList) async {
    File file = File(Directory.current.path + r'\lib\route\routeTest.text');
    String content = await file.readAsString();
    File targetFile = File(Directory.current.path + r'\lib\route\routeTemplate.dart');
    await targetFile.writeAsString(content);
  }

  Map<String, WidgetBuilder> getRoutes() {
    return Routes.routes;
  }

  String _getFileName(String path) {
    return path?.substring(path.lastIndexOf(r'\') + 1);
  }

  String _getFileRelativePath(String path, String basePath) {
    return path?.substring(basePath.length + 1)?.replaceAll(r'\', '/');
  }

  bool _isNullOrEmpty(String str) {
    return str == null || str.isEmpty;
  }

  RegExp getSuffixRegExp(String suffix) {
    return RegExp('.*$suffix');
  }
}

class WidgetObject {
  String name;
  String path;
  String widgetName;

  WidgetObject(this.name, this.path, this.widgetName);

}
