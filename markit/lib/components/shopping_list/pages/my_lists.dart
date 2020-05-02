import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:markit/components/common/scaffold/dynamic_fab.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

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
          FutureBuilder(
            future: getListsResponse(),
            builder: (context, snapshot) => showListOrLoading(context, snapshot),
          ),
        ],
      ),
    );
  }

  Widget showListOrLoading(BuildContext context, AsyncSnapshot<http.Response> snapshot) {
    if (snapshot.hasData) {
      String body = snapshot.data.body;
      Map<String, Object> data = jsonDecode(body);
      List<Object> listObjects = data['lists'];
      return showListOrIcon(listObjects);
    }
    return Center(
      // padding: EdgeInsets.symmetric(vertical: 7),
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

  Future<http.Response> getListsResponse() {
    String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ0ZXN0MSIsImp0aSI6IjMiLCJleHAiOjE1ODg0ODMzMDAsImlzcyI6Imh0dHBzOi8vbWFya2l0LWFwaS5henVyZXdlYnNpdGVzLm5ldC8iLCJhdWQiOiJodHRwczovL21hcmtpdC1hcGkuYXp1cmV3ZWJzaXRlcy5uZXQvIn0.ruxeoK7t8aKFJ5X6Y5OxNgk975qs4pLVVR48aGAjucM';
    String url = 'https://markit-api.azurewebsites.net/user/3/lists';
    Future<http.Response> response = http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    return response;
  }
}