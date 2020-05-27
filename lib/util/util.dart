import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path/src/internal_style.dart';

final currentStyle = path.style as InternalStyle;

String getFileName(String path) {
  return path?.substring(path.lastIndexOf(currentStyle.separator) + 1);
}

String getWidgetName(String fileName) {
  return fileName.split('_').map((item) => toUpperCaseOnlyFirstLetter(item)).join('');
}

String toUpperCaseOnlyFirstLetter(String str) {
  return str[0].toUpperCase() + str.substring(1).toLowerCase();
}

String getFileRelativePath(String path, String basePath) {
  return path?.substring(basePath.length + 1)?.replaceAll(currentStyle.separator, '/');
}

bool isNullOrEmpty(String str) {
  return str == null || str.isEmpty;
}

String getTargetPackageName() {
  File file = File(path.join(Directory.current.path, 'pubspec.yaml'));
  // TODO check
  return file.readAsLinesSync()[0].split(':').last.trim();
}

String getWidgetScanRefPath() {
  File file = File(path.join(Directory.current.path, '.packages'));
  String targetLine = file.readAsLinesSync().lastWhere(
    (item) => item.contains('widget_scan'));
  return path.fromUri(targetLine.substring(targetLine.indexOf(':') + 1));
}

String getTargetFilePath(String filePath) {
  //return Uri.file(getWidgetScanRefPath() + path).toFilePath();
  return path.join(getWidgetScanRefPath(), filePath);
}
