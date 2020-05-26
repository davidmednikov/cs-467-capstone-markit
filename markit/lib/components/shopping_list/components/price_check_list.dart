import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:select_dialog/select_dialog.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/models/price_check_model.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/service/location_service.dart';
import 'package:markit/components/service/notification_service.dart';
import 'package:markit/components/shopping_list/components/price_check_store_tile.dart';

class PriceCheckList extends StatefulWidget {

  ShoppingListModel shoppingList;

  GlobalKey<DynamicFabState> dynamicFabKey;

  PriceCheckList({Key key, this.shoppingList, this.dynamicFabKey}) : super(key: key);

  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();
  LocationService locationService = new LocationService();
  NotificationService notificationService = new NotificationService();

  @override
  PriceCheckListState createState() => PriceCheckListState();
}

class PriceCheckListState extends State<PriceCheckList> {

  String sortBy = 'Price Only';

  int minStars;
  bool starFilterEnabled = false;

  List<StoreModel> storesInPriceCheck;

  Position position;

  bool showNotifications = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: runPriceCheck(),
      builder: (context, snapshot) => showStoreTiles(context, snapshot),
    );
  }

  Widget showStoreTiles(BuildContext context, AsyncSnapshot<List> snapshot) {
    if (snapshot.hasData) {
      return buildStoreList(List<Map>.from(snapshot.data));
    }
    return Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange)),
    );
  }

  Widget buildStoreList(List<Map> storeMaps) {
    List<PriceCheckModel> priceCheckStores = storeMaps.map((store) => PriceCheckModel.fromJson(store)).toList();
    if (sortBy == 'Price Only') {
      priceCheckStores.sort((a, b) => a.priceRank.compareTo(b.priceRank));
    } else if (sortBy == 'Price & Staleness') {
      priceCheckStores.sort((a, b) => a.priceAndStalenessRank.compareTo(b.priceAndStalenessRank));
    } else if (sortBy == 'Staleness Only') {
      priceCheckStores.sort((a, b) => a.stalenessRank.compareTo(b.stalenessRank));
    }
    if (starFilterEnabled) {
      priceCheckStores.removeWhere((store) => store.store.averageRating == null || store.store.averageRating < minStars);
    }
    storesInPriceCheck = priceCheckStores.map((store) => store.store).toList();
    return Expanded(
      child: ListView.builder(
        itemCount: priceCheckStores.length,
        itemBuilder: (context, index) {
          PriceCheckModel store = priceCheckStores[index];
          return PriceCheckStoreTile(dynamicFabKey: widget.dynamicFabKey, storePriceCheck: store, shoppingList: widget.shoppingList, userLocation: position);
        },
      ),
    );
  }

  Future<List> runPriceCheck() async {
    int userId = await widget.authService.getUserIdFromStorage();
    position = await widget.locationService.getLocation();
    String url = 'https://markit-api.azurewebsites.net/user/$userId/list/${widget.shoppingList.id}/analyze?latitude=${position.latitude}&longitude=${position.longitude}';
    Map priceCheckResponse = await widget.apiService.getMap(url);
    if (priceCheckResponse['errors'] != null && priceCheckResponse['statusCode'] == 400) {
      showNotification('No nearby stores found.');
      return [];
    } else {
      List<Map> storeMaps = List.from(priceCheckResponse['rankings']);
      storeMaps.removeWhere((store) => store['missingItems'] == true);
      if (storeMaps.length == 0) {
        showNotification('No nearby stores match all tags in your list.');
      }
      return storeMaps;
    }
  }

  void showNotification(String message) {
    if (showNotifications) {
      widget.notificationService.showErrorNotification(message);
    }
  }

  void changeSorting(String newSortBy) {
    setState(() {
      sortBy = newSortBy;
    });
  }

  void setStarFilter(int stars) {
    if (stars != null && stars > 0) {
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

  void stopShowingNotifications() {
    showNotifications = false;
  }

  Future<StoreModel> promptForStore() async {
    StoreModel store;
    if (storesInPriceCheck.length > 0) {
      await SelectDialog.showModal<StoreModel>(
        context,
        label: 'Which Store did you shop at?',
        selectedValue: storesInPriceCheck[0],
        items: List.generate(storesInPriceCheck.length, (index) => storesInPriceCheck[index]),
        onChange: (StoreModel selected) {
          setState(() {
            store = selected;
          });
        },
      );
      return Future.value(store);
    } else {
      widget.notificationService.showErrorNotification('No available stores to review.');
      return Future.value(null);
    }
  }
}