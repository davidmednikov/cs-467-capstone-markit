import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showListOrIcon(context),
        ],
      ),
    );
  }

  Widget showListOrIcon(BuildContext context) {
    if (widget.myLists.length == 0) {
      return Center(
        child: Opacity(
          opacity: 0.35,
          child: FaIcon(FontAwesomeIcons.listUl, size: 125, color: Colors.grey),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: widget.myLists.length,
        itemBuilder: (context, index) {
          ShoppingListModel list = widget.myLists[index];
          return ShoppingListTile(shoppingList: list, dynamicFabKey: widget.dynamicFabKey);
        },
      ),
    );
  }
}