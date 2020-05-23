import 'package:flutter/material.dart';
import 'package:google_maps_webservice/src/core.dart';

import 'package:markit/components/mark_price/components/item_form.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/google_maps_api_service.dart';

class MarkPrice extends StatefulWidget {

  MarkPrice({Key key}) : super(key: key);

  @override
  _MarkPriceState createState() => _MarkPriceState();
}

class _MarkPriceState extends State<MarkPrice> {
  ApiService apiService = new ApiService();
  GoogleMapsApiService googleMapsApiService = new GoogleMapsApiService();

  String upc;
  List<Map> tags;
  double latitude;
  double longitude;
  Location location;

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    upc = arguments['upc'];
    tags = List<Map>.from(arguments['tags']);
    latitude = arguments['latitude'];
    longitude = arguments['longitude'];
    location = Location(latitude, longitude);
    return Scaffold(
      appBar: AppBar(title: Text('Mark Your Price'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: FutureBuilder(
            future: getClosestStore(),
            builder: (context, snapshot) => showLoadingOrForm(snapshot),
          )
        ),
      ),
    );
  }

  Future<StoreModel> getClosestStore() async {
    StoreModel store = await googleMapsApiService.getClosestStore();
    Map<String, Object> postStore = {
      'googlePlaceId': store.googlePlaceId,
      'name': store.name,
      'streetAddress': store.streetAddress,
      'city': store.city,
      'state': store.state,
      'postalCode': store.postalCode,
      'coordinate': {
        'latitude': store.latitude,
        'longitude': store.longitude,
      }
    };

    Map<String, Object> response = await addStore(postStore);
    final int storeId = response['id'];
    store.id = storeId;
    return store;
  }

  Widget showLoadingOrForm(AsyncSnapshot<StoreModel> snapshot) {
    if (snapshot.hasData) {
      StoreModel store = snapshot.data;
      return ItemForm(upc: upc, matchingTags: tags, location: location, guessedStore: store);
    }
    return Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey)),
    );
  }

  Future<Map> addStore(newStore) {
    String url = 'https://markit-api.azurewebsites.net/store';
    return apiService.postResponseMap(url, newStore);
  }
}