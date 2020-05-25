import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/service/location_service.dart';
import 'package:markit/components/service/notification_service.dart';
import 'package:markit/components/store/components/store_listing_tile.dart';

class ViewStoresPage extends StatefulWidget {

  List<StoreModel> storesNearMe;
  Position location;

  ViewStoresPage({Key key, this.storesNearMe, this.location}) : super(key: key);

  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();
  LocationService locationService = new LocationService();
  NotificationService notificationService = new NotificationService();

  @override
  ViewStoresPageState createState() => ViewStoresPageState();
}

class ViewStoresPageState extends State<ViewStoresPage> {

  bool mapViewEnabled = false;

  @override
  Widget build(BuildContext context) {
    return showListOrMapView();
  }

  Widget showListOrMapView() {
    if (mapViewEnabled) {
      return mapView();
    }
    return storesList();
  }

  Widget storesList() {
    return ListView.builder(
      itemCount: widget.storesNearMe.length,
      itemBuilder: (context, index) {
        return StoreListingTile(
          store: widget.storesNearMe[index],
          letter: String.fromCharCode(index + 65),
          position: widget.location,
        );
      }
    );
  }

  Widget mapView() {
    return Placeholder();
  }

  void toggleMapView(String selectedView) {
    setState(() {
      mapViewEnabled = selectedView == 'Map View';
    });
  }
}