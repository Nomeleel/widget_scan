import 'dart:io';

String getFileName(String path) {
  return path?.substring(path.lastIndexOf(r'\') + 1);
}

String getWidgetName(String fileName) {
  return fileName.split('_').map((item) => toUpperCaseOnlyFirstLetter(item)).join('');
}

String toUpperCaseOnlyFirstLetter(String str) {
  return str[0].toUpperCase() + str.substring(1).toLowerCase();
}

String getFileRelativePath(String path, String basePath) {
  return path?.substring(basePath.length + 1)?.replaceAll(r'\', '/');
}

bool isNullOrEmpty(String str) {
  return str == null || str.isEmpty;
}

String getTargetPackageName() {
  File file = File('${Directory.current.path}//pubspec.yaml');
  // TODO check
  return file.readAsLinesSync()[0].split(':').last.trim();
}

String getWidgetScanRefPath() {
  File file = File('${Directory.current.path}//.packages');
  String targetLine = file.readAsLinesSync().lastWhere(
    (item) => item.contains('widget_scan'));
  return targetLine.contains('file:')
      ? targetLine.substring(targetLine.lastIndexOf(':') - 1)
      : targetLine.split(':').last;
}

String getTargetFilePath(String path) {
  return Uri.file(getWidgetScanRefPath() + path).toFilePath();
}
