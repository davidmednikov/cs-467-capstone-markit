import 'package:flutter/material.dart';

import 'navigator.dart';
import 'navigation_options.dart';
import '../../shopping_list/my_lists.dart';
import '../../shopping_list/view_list.dart';

class ListsNavigator extends StatefulWidget {

  ListsNavigator({Key key}) : super(key: key);

  GlobalKey<MyListsState> myListsKey = GlobalKey<MyListsState>();
  GlobalKey<ViewListState> viewListKey = GlobalKey<ViewListState>();

  @override
  ListsNavigatorState createState() => ListsNavigatorState();
}

class ListsNavigatorState extends State<ListsNavigator> {

  Map<String, Map<String, Widget>> _routesToPageMap;

  @override
  void initState() {
    super.initState();
    _routesToPageMap = getListsRoutes(widget.myListsKey, widget.viewListKey);
  }

  @override
  Widget build(BuildContext context) {
    return MarkitNavigator(
      routesToPagesMap: _routesToPageMap,
    );
  }

  void navigate() {
    if (widget.viewListKey.currentContext == null) {
      Navigator.of(widget.myListsKey.currentContext).pushNamed('addList');
    } else {
      Navigator.of(widget.viewListKey.currentContext).pushNamed('addTag');
    }
  }
}