import 'package:flutter/material.dart';

class MyLists extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => ViewLists(key: _viewListsState),
              settings: settings,
            );
            break;
          case 'addList':
            return MaterialPageRoute(
              builder: (context) => AddList(),
              settings: settings,
            );
            break;
          case 'viewList':
            return MaterialPageRoute(
              builder: (context) => ViewList(),
              settings: settings,
            );
            break;
          case 'addTag':
            return MaterialPageRoute(
              builder: (context) => AddTag(),
              settings: settings,
            );
            break;
          case 'viewTag':
            return MaterialPageRoute(
              builder: (context) => ViewTag(),
              settings: settings,
            );
            break;
          default:
            throw Exception("Invalid route");
        }
      }
    );
  }

    String navigate() {
      BuildContext context = _viewListsState.currentState.context;
      NavigatorState navigator = Navigator.of(context);
      String route = ModalRoute.of(context).settings.name;
      if (route == '/') {
        Navigator.of(context).pushNamed('addList');
        return 'addList';
      }
      Navigator.of(context).pushNamed('addTag');
      return 'addTag';
    }
}