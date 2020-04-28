import 'package:flutter/material.dart';
import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/shopping_list/components/list_tag_tile.dart';
import '../../common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/list_tag_model.dart';
import 'package:markit/components/models/shopping_list_model.dart';

class ViewList extends StatefulWidget {

  GlobalKey<DynamicFabState> dynamicFabKey;

  ViewList({Key key, this.dynamicFabKey}) : super(key: key);

  @override
  ViewListState createState() => ViewListState();
}

class ViewListState extends State<ViewList> {

 ShoppingListModel shoppingList;

  @override
  Widget build(BuildContext context) {
    shoppingList = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      child: TopScaffold(
        title: shoppingList.name,
        view: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: shoppingList.listTags.length,
                itemBuilder: (context, index) {
                  ListTagModel tag = shoppingList.listTags[index];
                  return ListTagTile(listTag: tag);
                },
              ),
            ),
          ],
        ),
      ),
      onWillPop: notifyFabOfPop,
    );
  }

  Future<bool> notifyFabOfPop() {
    widget.dynamicFabKey.currentState.changePage('myLists');
    return Future.value(true);
  }
}