import 'package:flutter/material.dart';

class MarkitNavigator extends StatefulWidget {

  Map<String, Map<String, Widget>> routesToPagesMap;

  MarkitNavigator({Key key, this.routesToPagesMap}) : super(key: key);

   @override
  MarkitNavigatorState createState() => MarkitNavigatorState();
}

class MarkitNavigatorState extends State<MarkitNavigator> {

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        for (MapEntry<String, Map<String, Widget>> route in widget.routesToPagesMap.entries) {
          if (route.key == settings.name) {
            return MaterialPageRoute(
              builder: (context) => route.value['page'],
              settings: settings,
            );
          }
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(
        builder: (context) => widget.routesToPagesMap['/']['page'],
        settings: settings,
      ),
    );
  }

  void navigate(String route) {
    Navigator.pushNamed(context, route);
  }
}