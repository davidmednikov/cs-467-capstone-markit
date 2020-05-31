import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';

import 'package:markit/components/models/store_model.dart';

class ViewStoreMap extends StatefulWidget {

  GlobalKey<BottomScaffoldState> bottomScaffoldKey;

  ViewStoreMap({Key key, this.bottomScaffoldKey}) : super(key: key);

  @override
  ViewStoreMapState createState() => ViewStoreMapState();
}

class ViewStoreMapState extends State<ViewStoreMap> {

  StoreModel store;

  @override
  Widget build(BuildContext context) {
    store = ModalRoute.of(context).settings.arguments;
    return TopScaffold(
      noPadding: true,
      title: 'View Map',
      view: GoogleMap(
        markers: createMarkersFromStores(),
        initialCameraPosition: CameraPosition(
          target: LatLng(store.latitude, store.longitude),
          zoom: 16.0,
        ),
        myLocationEnabled: true,
      )
    );
  }

  Set<Marker> createMarkersFromStores() {
    Set<Marker> markers = new Set();
    Marker marker = Marker(
      markerId: MarkerId("1"),
      position: LatLng(store.latitude, store.longitude),
      icon: widget.bottomScaffoldKey.currentState.widget.markerIcon,
      infoWindow: InfoWindow(
        title: store.name,
        snippet: store.streetAddress
      ),
    );
    markers.add(marker);
    return markers;
  }
}