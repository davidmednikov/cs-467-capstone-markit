import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/shopping_list/components/price_check_tile.dart';

class PriceCheckList extends StatefulWidget {

  ShoppingListModel shoppingList;

  GlobalKey<DynamicFabState> dynamicFabKey;

  PriceCheckList({Key key, this.shoppingList, this.dynamicFabKey}) : super(key: key);

  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();

  @override
  PriceCheckListState createState() => PriceCheckListState();
}

class PriceCheckListState extends State<PriceCheckList> {

  String sortBy = 'Price Only';

  int minStars;
  bool starFilterEnabled;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: runPriceCheck(),
      builder: (context, snapshot) => showStoreTiles(context, snapshot),
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
    List<Map> storeMaps = List<Map>.from(storeObjects);
    if (sortBy == 'Price Only') {
        storeMaps.sort((a, b) => a['priceRank'].compareTo(b['priceRank']));
    } else if (sortBy == 'Price & Staleness') {
      storeMaps.sort((a, b) => a['priceAndStalenessRank'].compareTo(b['priceAndStalenessRank']));
    }
    return Expanded(
      child: ListView.builder(
        itemCount: storeMaps.length,
        itemBuilder: (context, index) {
          StoreModel store = StoreModel.fromJsonForPriceRun(storeMaps[index]);
          return PriceCheckTile(dynamicFabKey: widget.dynamicFabKey, storePriceRun: store);
        },
      ),
    );
  }

  Future<Map> runPriceCheck() async {
    int userId = await widget.authService.getUserIdFromStorage();
    String url = 'https://markit-api.azurewebsites.net/user/$userId/list/${widget.shoppingList.id}/analyze';
    return widget.apiService.getMap(url);
  }

  void changeSorting(String newSortBy) {
    setState(() {
      sortBy = newSortBy;
    });
  }

  void setStarFilter(int stars) {
    if (stars != null) {
      setState(() {
        minStars = stars;
        starFilterEnabled = true;
      });
    } else {
      setState(() {
        minStars = 0;
        starFilterEnabled = false;
      });
    }
  }


  Future<bool> notifyFabOfPop() {
    widget.dynamicFabKey.currentState.changePage('viewList');
    return Future.value(true);
  }
}