import 'package:flutter/material.dart';

import 'package:markit/components/common/navigation/navigation_options.dart';
import 'package:markit/components/common/navigation/tab_navigator.dart';
import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/shopping_list/components/price_check_list.dart';
import 'package:markit/components/shopping_list/pages/my_lists.dart';
import 'package:markit/components/shopping_list/pages/price_check_store.dart';
import 'package:markit/components/shopping_list/pages/view_list.dart';


class ListsNavigator extends StatefulWidget {

  GlobalKey<DynamicFabState> dynamicFabKey;

  ListsNavigator({Key key, this.dynamicFabKey}) : super(key: key);

  GlobalKey<MyListsState> myListsKey = GlobalKey<MyListsState>();
  GlobalKey<ViewListState> viewListKey = GlobalKey<ViewListState>();
  GlobalKey<PriceCheckListState> priceCheckListKey = GlobalKey<PriceCheckListState>();
  GlobalKey<PriceCheckStoreState> priceCheckStoreKey = GlobalKey<PriceCheckStoreState>();

  @override
  ListsNavigatorState createState() => ListsNavigatorState();
}

class ListsNavigatorState extends State<ListsNavigator> {

  Map<String, Widget> _routesToPageMap;

  @override
  void initState() {
    super.initState();
    _routesToPageMap = getListsRoutes(widget.myListsKey, widget.viewListKey, widget.priceCheckListKey, widget.priceCheckStoreKey, widget.dynamicFabKey);
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

  void navigateToAddTag() {
    int listId = widget.viewListKey.currentState.shoppingList.id;
    Navigator.of(widget.viewListKey.currentContext).pushNamed('addTag', arguments: listId)
    .then((newTag) {
      if (newTag != null) {
        widget.viewListKey.currentState.addTag(newTag);
      }
    });
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

  void navigateToAddRating() async {
    ShoppingListModel list = widget.priceCheckListKey.currentState.widget.shoppingList;
    if (widget.priceCheckStoreKey.currentState == null) {
      StoreModel store = await widget.priceCheckListKey.currentState.promptForStore();
      if (store != null) {
        widget.dynamicFabKey.currentState.changePage('addRating');
        Map arguments = {
          'shoppingList': list,
          'store': store,
        };
        arguments['pickedFromList'] = true;
        Navigator.of(widget.viewListKey.currentContext).pushNamed('addRating', arguments: arguments);
      }
    } else {
      StoreModel store = widget.priceCheckStoreKey.currentState.priceCheckStore.store;
      widget.dynamicFabKey.currentState.changePage('addRating');
      Map arguments = {
        'shoppingList': list,
        'store': store,
      };
      arguments['pickedFromList'] = false;
      Navigator.of(widget.viewListKey.currentContext).pushNamed('addRating', arguments: arguments);
    }
  }

  void popBackToPriceCheck() async {
    if (widget.priceCheckStoreKey.currentState == null) {
      widget.dynamicFabKey.currentState.changePage('priceCheck');
    } else {
      widget.dynamicFabKey.currentState.changePage('priceCheckStore');
    }
    Navigator.of(widget.priceCheckStoreKey.currentContext).pop();
  }
}