library widget_scan;

import 'package:flutter/widgets.dart';

class WidgetScan {
  List<WidgetObject> getWidgetList([String limitPath]) {
    return List<WidgetObject>();
  }

  Map<String, WidgetBuilder> translateToRoutes(List<WidgetObject> widgetList) {
    return Map<String, WidgetBuilder>();
  }
}

class WidgetObject {
  Widget widget;
  String name;
}
