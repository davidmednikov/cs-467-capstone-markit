import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:select_dialog/select_dialog.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/service/location_service.dart';
import 'package:markit/components/shopping_list/components/price_check_tile.dart';

class PriceCheckList extends StatefulWidget {

  ShoppingListModel shoppingList;

  GlobalKey<DynamicFabState> dynamicFabKey;

  PriceCheckList({Key key, this.shoppingList, this.dynamicFabKey}) : super(key: key);

  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();
  LocationService locationService = new LocationService();

  @override
  PriceCheckListState createState() => PriceCheckListState();
}

class PriceCheckListState extends State<PriceCheckList> {

  String sortBy = 'Price Only';

  int minStars;
  bool starFilterEnabled;

  List<StoreModel> storesInPriceCheck;

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
    List<StoreModel> storeModels = storeMaps.map((store) => StoreModel.fromJsonForPriceRun(store)).toList();
    storesInPriceCheck = storeModels;
    return Expanded(
      child: ListView.builder(
        itemCount: storeModels.length,
        itemBuilder: (context, index) {
          StoreModel store = storeModels[index];
          return PriceCheckTile(dynamicFabKey: widget.dynamicFabKey, storePriceRun: store, shoppingList: widget.shoppingList);
        },
      ),
    );
  }

  Future<Map> runPriceCheck() async {
    int userId = await widget.authService.getUserIdFromStorage();
    LocationData location = await widget.locationService.getLocation();
    String url = 'https://markit-api.azurewebsites.net/user/$userId/list/${widget.shoppingList.id}/analyze?latitude=${location.latitude}&longitude=${location.longitude}';
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

  Future<StoreModel> promptForStore() async {
    StoreModel store;
    await SelectDialog.showModal<StoreModel>(
      context,
      label: "Which Store did you shop at?",
      selectedValue: storesInPriceCheck[0],
      items: List.generate(storesInPriceCheck.length, (index) => storesInPriceCheck[index]),
      onChange: (StoreModel selected) {
        setState(() {
          store = selected;
        });
      },
    );
    return store;
  }
}