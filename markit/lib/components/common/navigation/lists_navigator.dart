import 'package:flutter/material.dart';

import 'package:markit/components/common/navigation/navigation_options.dart';
import 'package:markit/components/common/navigation/tab_navigator.dart';
import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/shopping_list/pages/my_lists.dart';
import 'package:markit/components/shopping_list/pages/view_list.dart';


class ListsNavigator extends StatefulWidget {

  GlobalKey<DynamicFabState> dynamicFabKey;

  ListsNavigator({Key key, this.dynamicFabKey}) : super(key: key);

  GlobalKey<MyListsState> myListsKey = GlobalKey<MyListsState>();
  GlobalKey<ViewListState> viewListKey = GlobalKey<ViewListState>();

  @override
  ListsNavigatorState createState() => ListsNavigatorState();
}

class ListsNavigatorState extends State<ListsNavigator> {

  Map<String, Widget> _routesToPageMap;

  @override
  void initState() {
    super.initState();
    _routesToPageMap = getListsRoutes(widget.myListsKey, widget.viewListKey, widget.dynamicFabKey);
  }

  @override
  Widget build(BuildContext context) {
    return TabNavigator(
      routesToPagesMap: _routesToPageMap,
    );
  }

  void navigate(int actionIndex) async {
    if (widget.viewListKey.currentContext == null) {
      widget.dynamicFabKey.currentState.changePage('newList');
      Navigator.of(widget.myListsKey.currentContext).pushNamed('newList');
    } else {
      if (actionIndex == 0) {
        print('runprice');
      } else {
        widget.dynamicFabKey.currentState.changePage('addTag');
        int listId = widget.viewListKey.currentState.shoppingList.id;
        Navigator.of(widget.viewListKey.currentContext).pushNamed('addTag', arguments: listId)
        .then((newTag) {
          if (newTag != null) {
            widget.viewListKey.currentState.addTag(newTag);
          }
        });
      }
    }
  }
}