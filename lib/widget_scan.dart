import 'dart:io';

import 'package:path/path.dart' as path;

import 'generate_route.dart';
import 'util/util.dart';

class WidgetScan {
  WidgetScan({
    this.rule,
    this.limitPath,
  });

  final RegExp? rule;
  final String? limitPath;

  late List<WidgetObject> _widgetList;

  void run() {
    getWidgetList();
    generateRoute();
  }

  List<WidgetObject> getWidgetList() {
    _widgetList = <WidgetObject>[];
    final String dirPath = limitPath ?? path.join(Directory.current.path, 'lib', 'view');
    final RegExp regExp = rule ?? getSuffixRegExp('view');
    Directory(dirPath).listSync(recursive: true).forEach(
      (FileSystemEntity item) {
        if (FileSystemEntity.isFileSync(item.path)) {
          final String? fileName = regExp.stringMatch(getFileName(item.path).toLowerCase());
          if (!isNullOrEmpty(fileName)) {
            _widgetList.add(
              WidgetObject(
                // If has same file name, whether change key to path plus name.
                fileName!,
                getFileRelativePath(item.path, dirPath),
                getWidgetName(fileName),
              ),
            );
          }
        }
      },
    );

    return _widgetList..sort();
  }

  void generateRoute() {
    GenerateRoute(_widgetList).generate();
  }

  RegExp getSuffixRegExp(String suffix) {
    return RegExp('.*$suffix(?=.dart)');
  }
}

class WidgetObject implements Comparable<WidgetObject> {
  const WidgetObject(this.name, this.path, this.widgetName);

  final String name;
  final String path;
  final String widgetName;

  @override
  String toString() {
    return 'name: $name; path: $path; widgetName: $widgetName;';
  }

  @override
  int compareTo(WidgetObject other) {
    return path.compareTo(other.path);
  }
}
