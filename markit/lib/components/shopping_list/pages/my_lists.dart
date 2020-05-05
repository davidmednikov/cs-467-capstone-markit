import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/shopping_list/components/shopping_list_tile.dart';



class MyLists extends StatefulWidget {

  GlobalKey<DynamicFabState> dynamicFabKey;

  MyLists({Key key, this.dynamicFabKey}) : super(key: key);

  ApiService apiService = new ApiService();

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
          FutureBuilder(
            future: getLists(),
            builder: (context, snapshot) => showListOrLoading(context, snapshot),
          ),
        ],
      ),
    );
  }

  Widget showListOrLoading(BuildContext context, AsyncSnapshot<List> snapshot) {
    if (snapshot.hasData) {
      List<Object> listObjects = snapshot.data;
      return showListOrIcon(listObjects);
    }
    return Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey)),
    );
  }

  Widget showListOrIcon(List<Object> listObjects) {
    if (listObjects.length == 0) {
      return Center(
        child: Opacity(
          opacity: 0.35,
          child: FaIcon(FontAwesomeIcons.home, size: 125, color: Colors.grey),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: listObjects.length,
        itemBuilder: (context, index) {
          ShoppingListModel list = ShoppingListModel.fromJson(listObjects[index]);
          return ShoppingListTile(shoppingList: list, dynamicFabKey: widget.dynamicFabKey, myListsKey: widget.key);
        },
      ),
    );
  }

  Future<List> getLists() async {
    String url = 'https://markit-api.azurewebsites.net/user/10/lists';
    return widget.apiService.getList(url);
  }

  Future<int> deleteList(int listId) async {
    String url = 'https://markit-api.azurewebsites.net/list/$listId';
    int statusCode = await widget.apiService.deleteResponseCode(url);
    if (statusCode == 200) {
      setState(() {});
    }
    return statusCode;
  }
}