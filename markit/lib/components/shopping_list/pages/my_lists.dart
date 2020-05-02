import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:markit/components/common/scaffold/dynamic_fab.dart';

import 'package:http/http.dart';
import 'dart:convert';

import 'package:markit/components/service/api_service.dart';

import '../../common/scaffold/top_scaffold.dart';
import '../components/shopping_list_tile.dart';

import '../../models/shopping_list_model.dart';

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
            future: getListsResponse(),
            builder: (context, snapshot) => showListOrLoading(context, snapshot),
          ),
        ],
      ),
    );
  }

  Widget showListOrLoading(BuildContext context, AsyncSnapshot<Response> snapshot) {
    if (snapshot.hasData) {
      String body = snapshot.data.body;
      Map<String, Object> data = jsonDecode(body);
      List<Object> listObjects = data['data'];
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
          child: FaIcon(FontAwesomeIcons.listUl, size: 125, color: Colors.grey),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: listObjects.length,
        itemBuilder: (context, index) {
          ShoppingListModel list = ShoppingListModel.fromJson(listObjects[index]);
          return ShoppingListTile(shoppingList: list, dynamicFabKey: widget.dynamicFabKey);
        },
      ),
    );
  }

  Future<Response> getListsResponse() async {
    String url = 'https://markit-api.azurewebsites.net/user/3/lists';
    return widget.apiService.makeGetCall(url, true);
  }
}