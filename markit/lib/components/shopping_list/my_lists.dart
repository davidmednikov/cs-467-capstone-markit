import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'add_list.dart';
import 'add_tag.dart';
import 'view_list.dart';
import 'view_lists.dart';
import 'view_tag.dart';

class MyLists extends StatefulWidget {

  MyLists({Key key}) : super(key: key);

  @override
  MyListsState createState() => MyListsState();
}

class MyListsState extends State<MyLists> {

  final GlobalKey<ViewListsState> _viewListsState = GlobalKey<ViewListsState>();

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