import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  bool tagAdded = false;

  @override
  Widget build(BuildContext context) {
    if (!tagAdded) {
      shoppingList = ModalRoute.of(context).settings.arguments;
    }
    return WillPopScope(
      child: TopScaffold(
        title: shoppingList.name,
        view: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showListOrIcon(context),
          ],
        ),
      ),
      onWillPop: notifyFabOfPop,
    );
  }

  void changeList(ShoppingListModel updatedList) {
    setState(() {
      shoppingList = updatedList;
      tagAdded = true;
    });
  }

  Future<bool> notifyFabOfPop() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    widget.dynamicFabKey.currentState.changePage('myLists');
    return Future.value(true);
  }

  Widget showListOrIcon(BuildContext context) {
    if (shoppingList.listTags.length == 0) {
      return Center(
        child: Opacity(
          opacity: 0.35,
          child: FaIcon(FontAwesomeIcons.shoppingBasket, size: 125, color: Colors.grey),
        )
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: shoppingList.listTags.length,
        itemBuilder: (context, index) {
          ListTagModel tag = shoppingList.listTags[index];
          return ListTagTile(listTag: tag, dynamicFabKey: widget.dynamicFabKey);
        },
      ),
    );
  }
}