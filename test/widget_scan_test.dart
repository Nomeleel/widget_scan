import 'package:flutter_test/flutter_test.dart';

import 'package:widget_scan/widget_scan.dart';

void main() {
  test('to do', () async {
    final widgetScan = WidgetScan();
    //widgetScan.getWidgetList(widgetScan.getSuffixRegExp('View'));
    //widgetScan.generateRoute(widgetScan.getWidgetList(widgetScan.getSuffixRegExp('View')));
    await widgetScan.generateRoute(null);
    widgetScan.getRoutes().keys.forEach((item){
      print(item);
    });
    //ToDo
  });
}
