import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  List<BitmapDescriptor> markerIcons = [];
  bool gotMarkers = false;

  @override
  void initState() {
    super.initState();
    // getMarkersForMap();
    WidgetsBinding.instance.addPostFrameCallback((_) => getMarkersForMap());
  }

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
    return GoogleMap(
      markers: createMarkersFromStores(),
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.location.latitude, widget.location.longitude),
        zoom: 13.0,
      ),
    );
  }

  Set<Marker> createMarkersFromStores() {
    Set<Marker> markers = new Set();
    for (int i = 0; i < widget.storesNearMe.length; i++) {
      Marker marker = Marker(
        markerId: MarkerId(String.fromCharCode(i + 65)),
        position: LatLng(widget.storesNearMe[i].latitude, widget.storesNearMe[i].longitude),
        icon: markerIcons[i],
      );
      markers.add(marker);
    }
    return markers;
  }

  void getMarkersForMap() async {
    if (markerIcons.length == 0 && !gotMarkers) {
      for (int i = 0; i < widget.storesNearMe.length; i++) {
        BitmapDescriptor marker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
          'assets/img/map_markers/letter_${String.fromCharCode(i + 97)}.png',
        );
        markerIcons.add(marker);
      }
      gotMarkers = true;
    }
  }

  void toggleMapView(String selectedView) {
    setState(() {
      mapViewEnabled = selectedView == 'Map View';
    });
  }
}