import 'dart:io';

import 'package:path/path.dart' as path;

String getFileName(String filePath) {
  return filePath?.substring(filePath.lastIndexOf(path.separator) + 1);
}

String getWidgetName(String fileName) {
  return fileName
      .split('_')
      .map((String item) => toUpperCaseOnlyFirstLetter(item))
      .join('');
}

String toUpperCaseOnlyFirstLetter(String str) {
  return str[0].toUpperCase() + str.substring(1).toLowerCase();
}

String getFileRelativePath(String filePath, String basePath) {
  return filePath
      ?.substring(basePath.length + 1)
      ?.replaceAll(path.separator, '/');
}

bool isNullOrEmpty(String str) {
  return str?.isEmpty ?? true;
}

String getTargetPackageName() {
  final File file = File(path.join(Directory.current.path, 'pubspec.yaml'));
  // TODO(Nomeleel): check
  return file.readAsLinesSync()[0].split(':').last.trim();
}

String getWidgetScanRefPath() {
  final File file = File(path.join(Directory.current.path, '.packages'));
  final String targetLine = file
      .readAsLinesSync()
      .lastWhere((String item) => item.contains('widget_scan'));
  return path.fromUri(targetLine.substring(targetLine.indexOf(':') + 1));
}

String getTargetFilePath(String filePath) {
  //return Uri.file(getWidgetScanRefPath() + path).toFilePath();
  return path.join(getWidgetScanRefPath(), filePath);
}

String getProjectLibPath([String filePath]) {
  return path.join(Directory.current.path, 'lib', filePath ?? '');
}

void createDirectory(String path) {
  final Directory directory = Directory(path);
  if (!directory.existsSync()) 
    directory.createSync();
}