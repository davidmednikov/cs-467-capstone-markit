import 'package:flutter/material.dart';
import 'package:markit/components/common/scaffold/dynamic_fab.dart';

import '../../common/scaffold/top_scaffold.dart';
import '../components/shopping_list_tile.dart';

import '../../models/shopping_list_model.dart';

class MyLists extends StatefulWidget {

  List<ShoppingListModel> myLists;

  GlobalKey<DynamicFabState> dynamicFabKey;

  MyLists({Key key, this.myLists, this.dynamicFabKey}) : super(key: key);

  @override
  MyListsState createState() => MyListsState();
}

class MyListsState extends State<MyLists> {

  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'My Lists',
      view: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.myLists.length,
              itemBuilder: (context, index) {
                ShoppingListModel list = widget.myLists[index];
                return ShoppingListTile(shoppingList: list, dynamicFabKey: widget.dynamicFabKey);
              },
            ),
          ),
        ],
      ),
    );
  }
}