import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/service/location_service.dart';
import 'package:markit/components/profile/components/recent_marks.dart';
import 'package:markit/components/store/components/store_details.dart';

class Store extends StatelessWidget {

  StoreModel store;

  GlobalKey<BottomScaffoldState> bottomScaffoldKey;

  Store({Key key, this.store, this.bottomScaffoldKey}) : super(key: key);

  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();
  LocationService locationService = new LocationService();

  Position location;

  int totalReviews;
  int totalPrices;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getStoreInfo(),
      builder: (context, snapshot) => showTemplateOrFull(context, snapshot),
    );
  }

  Widget showTemplateOrFull(BuildContext context, AsyncSnapshot<Map> snapshot) {
    if (snapshot.hasData) {
      Map activityInfo = snapshot.data;
      totalReviews = activityInfo['totalRatings'];
      totalPrices = activityInfo['totalPrices'];
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          storePageStack(context),
          Expanded(
            child: RecentMarks(
              marks: activityInfo['activity'],
              location: location,
              bottomScaffoldKey: bottomScaffoldKey,
              topPaddingFactor: 0.125,
            ),
          ),
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        storePageStack(context),
      ],
    );
  }

  Widget storePageStack(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      overflow: Overflow.visible,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.275,
          width: MediaQuery.of(context).size.width,
          child: mapView(context),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          height: MediaQuery.of(context).size.height * 0.2,
          child: StoreDetails(
            store: store,
            location: location,
            totalReviews: totalReviews,
            totalPrices: totalPrices
          ),
        ),
      ],
    );
  }

  Widget mapView(BuildContext context) {
    return GoogleMap(
      markers: getMarker(),
      initialCameraPosition: CameraPosition(
        target: LatLng(store.latitude, store.longitude),
        zoom: 16,
      ),
      onTap: (latLng) => showFullScreenMap(context),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      rotateGesturesEnabled: false,
      zoomGesturesEnabled: false,
      tiltGesturesEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
    );
  }

  Set<Marker> getMarker() {
    Set<Marker> markers = new Set();
    markers.add(
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(store.latitude, store.longitude),
        icon: bottomScaffoldKey.currentState.widget.markerIcon,
        infoWindow: InfoWindow(title: store.name, snippet: store.streetAddress),
      )
    );
    return markers;
  }

  Future<Map> getStoreInfo() async {
    if (location == null) {
      location = await locationService.getLocation();
    }
    return await getActivity();
  }

  Future<Map> getActivity() async {
    String ratingsUrl = 'https://markit-api.azurewebsites.net/store/${store.id}/ratings';
    final Map ratingsResponse = await apiService.getMap(ratingsUrl);
    final int numRatings = ratingsResponse['totalRecords'];
    String pricesUrl = 'https://markit-api.azurewebsites.net/store/${store.id}/prices';
    final Map pricesResponse = await apiService.getMap(pricesUrl);
    final int numPrices = pricesResponse['totalRecords'];
    List activity = sortMarks(ratingsResponse['ratings'], pricesResponse['userPrices']);
    return {
      'totalRatings': numRatings,
      'totalPrices': numPrices,
      'activity': activity,
    };
  }

  List sortMarks(List ratings, List prices) {
    List marksList = ratings + prices;
    marksList.sort((b, a) => a['createdAt'].compareTo(b['createdAt']));
    return marksList;
  }

  void showFullScreenMap(BuildContext context) {
    bottomScaffoldKey.currentState.dynamicFabState.currentState.changePage('viewStoreMap');
    Navigator.of(context).pushNamed('viewMap', arguments: store);
  }
}