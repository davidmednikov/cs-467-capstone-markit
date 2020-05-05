import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/list_tag_model.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/shopping_list/components/list_tag_tile.dart';

class ViewList extends StatefulWidget {

  GlobalKey<DynamicFabState> dynamicFabKey;

  ViewList({Key key, this.dynamicFabKey}) : super(key: key);

  ApiService apiService = new ApiService();

  @override
  ViewListState createState() => ViewListState();
}

class ViewListState extends State<ViewList> {

  ShoppingListModel shoppingList;

  bool tagAddedOrDeleted = false;

  @override
  Widget build(BuildContext context) {
    if (!tagAddedOrDeleted) {
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
      tagAddedOrDeleted = true;
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
          return ListTagTile(listTag: tag, dynamicFabKey: widget.dynamicFabKey, viewListKey: widget.key);
        },
      ),
    );
  }

  Future<int> deleteTag(int listTagId) async {
    String url = 'https://markit-api.azurewebsites.net/list/${shoppingList.id}/listTag/$listTagId';
    int statusCode = await widget.apiService.deleteResponseCode(url);
    if (statusCode == 200) {
      setState(() {
        shoppingList.listTags.removeWhere((listTag) => listTag.id == listTagId);
        tagAddedOrDeleted = true;
      });
    }
    return statusCode;
  }
}