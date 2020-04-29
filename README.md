# Widget Scan
Scan all widgets in the project and process them accordingly.
Now only focus on the scanning widget view, and mapped the corresponding route.

## Installing

How to use this library.

### 1. Depend it

Add this to your package's **pubspec.yaml** file:

```
dependencies:
  widget_scan:
    git: git@github.com:Nomeleel/widget_scan.git
```

Now it is not upload to the dart package repository, it can be referenced through git.

### 2. Load it

After the first step is saved, the library will be obtained automatically, or you can try to obtain it manually.

with Pub:

```
pub get
```

with Flutter:

```
flutter pub get
```

### 3. Run it

with Pub:

```
pub run widget_scan
```

with Flutter:

```
flutter pub run widget_scan
```

### 4. Import it

Now the corresponding route has been generated in **view_routes.dart**, and in your project code, you can use:

```
import 'package:widget_scan/route/view_routes.dart';
```

### 5. Use it

The **view_routes.dart** content is as follows.

```
import 'package:flutter/widgets.dart';
import 'view_export_list.dart';

Map<String, WidgetBuilder> viewRoutes = {
  'first_view': (BuildContext context) => FirstView(),
  'second_view': (BuildContext context) => SecondView(),
};
```

The depend **view_export_list.dart** content is as follows.

```
export 'package:xxxxxxx/view/sudoku/first_view.dart';
export 'package:xxxxxxx/view/sudoku/second_view.dart';
```

If you use ***CupertinoApp*** or ***MaterialApp***, you can directly assign *viewRoutes* to *routes* attribute.

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Title',
      home: MyHomePage(),
      routes: viewRoutes,
    );
  }
}
```

Then you can use the route name to navigate.

```
Navigator.of(context).pushNamed(
    'first_view', 
    arguments: 'This is first view',
);
```

# Naming constraints

If you want to use this library correctly, you need to follow the following constraints in naming, of course, this is also the naming constraint recommended by Flutter.

+ File naming with underscore interval, first letter lowercase.

```
examples:
view_routes.dart
widget_helper.dart
```

+ Files of the same category are added same suffixes.

```
examples:
view
main_view.dart
first_view.dart

helper
date_helper.dart
widget_helper.dart
```

+ Use **Pascal** for class naming.

```
examples:
AnimationController
ClipRRect
ConstrainedBox
SizeTransition
```
