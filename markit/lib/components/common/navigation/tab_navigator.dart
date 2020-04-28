import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {

  Map<String, Widget> routesToPagesMap;

  TabNavigator({Key key, this.routesToPagesMap}) : super(key: key);

   @override
  TabNavigatorState createState() => TabNavigatorState();
}

class TabNavigatorState extends State<TabNavigator> {

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
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
}