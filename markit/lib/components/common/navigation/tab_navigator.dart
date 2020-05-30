import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {

  Map<String, Widget> routesToPagesMap;

  String deepLinkInitRoute;

  TabNavigator({Key key, this.routesToPagesMap, this.deepLinkInitRoute}) : super(key: key);

   @override
  TabNavigatorState createState() => TabNavigatorState();
}

class TabNavigatorState extends State<TabNavigator> {

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: getInitialRoute(),
      onGenerateRoute: (RouteSettings settings) {
        for (MapEntry<String, Widget> route in widget.routesToPagesMap.entries) {
          if (route.key == settings.name) {
            return MaterialPageRoute(
              builder: (context) => route.value,
              settings: settings,
            );
          }
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(
        builder: (context) => widget.routesToPagesMap['/'],
        settings: settings,
      ),
    );
  }

  String getInitialRoute() {
    if (widget.deepLinkInitRoute != null) {
      return widget.deepLinkInitRoute;
    }
    return '/';
  }
}