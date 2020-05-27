import 'dart:io';

import 'package:path/path.dart' as path;

import 'generate_route.dart';
import 'util/util.dart';

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
    String dirPath = limitPath ?? path.join(Directory.current.path, 'lib');
    RegExp regExp = rule ?? getSuffixRegExp('view');
    Directory(dirPath)
      ..listSync(recursive: true).forEach((item) {
        if (FileSystemEntity.isFileSync(item.path)) {
          String fileName = regExp.stringMatch(getFileName(item.path).toLowerCase());
          if (!isNullOrEmpty(fileName)) {
            _widgetList.add(WidgetObject(
              // If has same file name, whether change key to path plus name.
              fileName,
              getFileRelativePath(item.path, dirPath),
              getWidgetName(fileName),
            ));
          }
        }
      });
    
    return _widgetList;
  }

  generateRoute() {
    GenerateRoute(_widgetList).generate();
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
