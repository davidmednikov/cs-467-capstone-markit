import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/location_service.dart';
import 'package:markit/components/store/components/view_stores_page.dart';

class ViewStores extends StatefulWidget {

  ApiService apiService = new ApiService();
  LocationService locationService = new LocationService();

  GlobalKey<ViewStoresPageState> viewStoresPageKey = new GlobalKey();

  ViewStores({Key key}) : super(key: key);

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
    return widget.apiService.getList(url);
  }

  Widget viewStoresPageOrLoading(AsyncSnapshot<List> snapshot) {
    if (snapshot.hasData) {
      List<StoreModel> stores = List<Map>.from(snapshot.data).map((store) => StoreModel.fromJson(store)).toList();
      return ViewStoresPage(key: widget.viewStoresPageKey, storesNearMe: stores, location: location);
    }
    return Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey)),
    );
  }

  void changeLocation(Position position) {
    locationChanged = true;
    setState(() {
      location = position;
    });
  }
}