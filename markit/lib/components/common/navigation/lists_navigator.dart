import 'package:flutter/material.dart';

import 'package:markit/components/common/navigation/navigation_options.dart';
import 'package:markit/components/common/navigation/tab_navigator.dart';
import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/models/shopping_list_model.dart';
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

  void navigateToNewList() {
    Navigator.of(widget.myListsKey.currentContext).pushNamed('newList');
  }

  void navigateToPriceCheck(bool replaceRoute) {
    ShoppingListModel list = widget.viewListKey.currentState.shoppingList;
    if (list.listTags.length > 0) {
      widget.dynamicFabKey.currentState.changePage('priceCheck');
      if (!replaceRoute) {
        Navigator.of(widget.viewListKey.currentContext).pushNamed('priceCheck',
          arguments: widget.viewListKey.currentState.shoppingList);
      }
      Navigator.of(widget.viewListKey.currentContext).pushReplacementNamed('priceCheck',
        arguments: widget.viewListKey.currentState.shoppingList);
    } else {
      widget.viewListKey.currentState.showError('Price Check requires at least 1 tag.');
    }
  }

  void navigateToAddTag() {
    int listId = widget.viewListKey.currentState.shoppingList.id;
    Navigator.of(widget.viewListKey.currentContext).pushNamed('addTag', arguments: listId)
    .then((newTag) {
      if (newTag != null) {
        widget.viewListKey.currentState.addTag(newTag);
      }
    });
  }
}