import 'dart:io';

import './generateRoute.dart';

class WidgetScan {

  WidgetScan({
    this.rule,
    this.limitPath,
  });

  final RegExp rule;
  final String limitPath;


  List<WidgetObject> _widgetList;

  void run() {
    getWidgetList();
    generateRoute();
  }

  List<WidgetObject> getWidgetList() {
    _widgetList = List<WidgetObject>();
    String dirPath = limitPath ?? Directory.current.path + r'\lib';
    RegExp regExp = rule ?? RegExp('.*View');
    Directory(dirPath)
      ..listSync(recursive: true).forEach((item) {
        if (FileSystemEntity.isFileSync(item.path)) {
          String fileName = regExp.stringMatch(_getFileName(item.path));
          if (!_isNullOrEmpty(fileName)) {
            _widgetList.add(WidgetObject(
              fileName,
              _getFileRelativePath(item.path, dirPath),
              fileName.toUpperCase(),
            ));
          }
        }
      });
    
    return _widgetList;
  }

  generateRoute() {
    GenerateRoute(_widgetList, getTargetPackageName()).generate();
  }

  String getTargetPackageName() {
    File file = File('${Directory.current.path}//pubspec.yaml');
    // TODO check
    return file.readAsLinesSync()[0].split(':').last.trim();
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
