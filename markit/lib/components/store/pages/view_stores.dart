import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:markit/components/common/scaffold/dynamic_fab.dart';

import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/location_service.dart';
import 'package:markit/components/service/notification_service.dart';
import 'package:markit/components/store/components/view_stores_page.dart';

class ViewStores extends StatefulWidget {

  GlobalKey<DynamicFabState> dynamicFabKey;

  ViewStores({Key key, this.dynamicFabKey}) : super(key: key);

  ApiService apiService = new ApiService();
  LocationService locationService = new LocationService();
  NotificationService notificationService = new NotificationService();

  GlobalKey<ViewStoresPageState> viewStoresPageKey = new GlobalKey();

  @override
  ViewStoresState createState() => ViewStoresState();
}

class ViewStoresState extends State<ViewStores> {
  Position location;
  bool locationChanged = false;

  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'View Stores',
      view: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getStores(),
              builder: (context, snapshot) => viewStoresPageOrLoading(snapshot),
            ),
          ),
        ],
      ),
      viewStoresKey: widget.key,
    );
  }

  Future<List> getStores() async {
    if (!locationChanged) {
      location = await widget.locationService.getLocation();
    }
    final String url = 'https://markit-api.azurewebsites.net/store/query?latitude=${location.latitude}&longitude=${location.longitude}';
    List storesResponse = await widget.apiService.getList(url);
    if (storesResponse.length == 0) {
      widget.notificationService.showErrorNotification('No stores found nearby.');
    }
    return storesResponse;
  }

  Widget viewStoresPageOrLoading(AsyncSnapshot<List> snapshot) {
    if (snapshot.hasData) {
      List<StoreModel> stores = List<Map>.from(snapshot.data).map((store) => StoreModel.fromJson(store)).toList();
      return ViewStoresPage(key: widget.viewStoresPageKey, storesNearMe: stores, location: location, dynamicFabKey: widget.dynamicFabKey);
    }
    return Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange)),
    );
  }

  void changeLocation(Position position) {
    locationChanged = true;
    setState(() {
      location = position;
    });
  }
}