import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/location_service.dart';
import 'package:markit/components/store/components/store_listing.dart';

class ViewStores extends StatelessWidget {

  ApiService apiService = new ApiService();
  LocationService locationService = new LocationService();

  ViewStores({Key key}) : super(key: key);

  final storeData = [
    { 
      "name": "Whole Foods",
      "city": "Berkeley",
      "state": "California"
    },
        { 
      "name": "Sprouts",
      "city": "Oakland",
      "state": "California"
    },
    { 
      "name": "Trader Joe's",
      "city": "Berkeley",
      "state": "California"
    },
    { 
      "name": "Safeway",
      "city": "Oakland",
      "state": "California"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'View Stores',
      view: Column(children: <Widget>[
        Expanded(
          flex: 1,
          child: Row(children: <Widget>[
            Expanded(
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                color: Colors.white,
                child: Text("Change location"),
                padding: EdgeInsets.all(20)
              )
            ),
            Expanded(
              child: RaisedButton(
                onPressed: () {},
                shape: CircleBorder(),
                color: Colors.white,
                child: Text("Map View"),
                padding: EdgeInsets.all(40)
              )
            )
          ])
        ),
        FutureBuilder(
          future: getStores(),
          builder: (context, snapshot) => showStoresOrLoading(context, snapshot)
        )
      ]),
    );
  }

  Future<List> getStores() async {
    Position location = await locationService.getLocation();
    final String url = 'https://markit-api.azurewebsites.net/store/query?latitude=${location.latitude}&longitude=${location.longitude}';
    return apiService.getList(url);
  }

  Widget showStoresOrLoading(context, snapshot) {
    if (snapshot.hasData) {
      List<Object> stores = snapshot.data;
      return showStores(stores);
    }
    return Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey)),
    );
  }

// should an icon be shown when no stores are returned?
  Widget showStores(stores) {
    return Expanded(
      flex: 3,
        child: ListView.builder(
          itemCount: stores.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.25,
              child: StoreListing(
                name: stores[index]['name'],
                streetAddress: stores[index]['streetAddress'],
                city: stores[index]['city'],
                state: stores[index]['state'],
                postalCode: stores[index]['postalCode']
              )
            );
          }
        ),
    );
  }
}