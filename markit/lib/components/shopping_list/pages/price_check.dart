import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/shopping_list/components/price_check_tile.dart';

class PriceCheck extends StatefulWidget {

  GlobalKey<DynamicFabState> dynamicFabKey;

  PriceCheck({Key key, this.dynamicFabKey}) : super(key: key);

  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();

  @override
  PriceCheckState createState() => PriceCheckState();
}

class PriceCheckState extends State<PriceCheck> {

  ShoppingListModel shoppingList;

  @override
  Widget build(BuildContext context) {
    shoppingList = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      child: TopScaffold(
        title: 'Price Check',
        view: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: runPriceCheck(),
              builder: (context, snapshot) => showStoreTiles(context, snapshot),
            )
          ],
        ),
      ),
      onWillPop: notifyFabOfPop,
    );
  }

  Widget showStoreTiles(BuildContext context, AsyncSnapshot<Map> snapshot) {
    if (snapshot.hasData) {
      List<Object> storeObjects = snapshot.data['rankings'];
      return buildStoreList(storeObjects);
    }
    return Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey)),
    );
  }

  Widget buildStoreList(List<Object> storeObjects) {
    return Expanded(
      child: ListView.builder(
        itemCount: storeObjects.length,
        itemBuilder: (context, index) {
          StoreModel store = StoreModel.fromJsonForPriceRun(storeObjects[index]);
          return PriceCheckTile(dynamicFabKey: widget.dynamicFabKey, storePriceRun: store);
        },
      ),
    );
  }

  Future<Map> runPriceCheck() async {
    int userId = await widget.authService.getUserIdFromStorage();
    String url = 'https://markit-api.azurewebsites.net/user/$userId/list/${shoppingList.id}/analyze';
    return widget.apiService.getMap(url);
  }

  Future<bool> notifyFabOfPop() {
    widget.dynamicFabKey.currentState.changePage('viewList');
    return Future.value(true);
  }
}