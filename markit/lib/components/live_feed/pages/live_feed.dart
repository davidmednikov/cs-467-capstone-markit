import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/live_feed/components/price_mark.dart';
import 'package:markit/components/live_feed/components/review_mark.dart';
import 'package:markit/components/live_feed/components/timeline_view.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/location_service.dart';

class LiveFeed extends StatelessWidget {

  ApiService apiService = new ApiService();
  LocationService locationService = new LocationService();

  LiveFeed({Key key}) : super(key: key);

//dummy data until GET request to Recent Marks API endpoint is added
  final markData = [
    { 
      "tags": ["Charmin Ultra Soft 8ct", "paper towels 8ct"],
      "store": "Safeway",
      "price": 3.99,
      "user": "easyshoppin72",
      "date": "4/26/2020",
    },
    {
      "store": "Safeway",
      "user": "easyshoppin72",
      "date": "4/25/2020",
      "comment": "Pretty good prices!",
      "rating": 4,
    },
    {
      "tags": ["Kettle Chips Salt and Vinegar 6oz", "potato chips 6oz"],
      "store": "Whole Foods",
      "price": 2.99,
      "user": "frugaldude01",
      "date": "4/25/2020",
    },
    {
      "tags": ["Folgers Dark Roast 12oz", "coffee 12oz"],
      "store": "Safeway",
      "price": 5.99,
      "user": "frugaldude01",
      "date": "4/25/2020",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'Live Feed',
      // view: ListView.builder(
      //   itemCount: markData.length,
      //   itemBuilder: (context, index) {
      //     if (markData[index]["price"] != null) {
      //       return Container(
      //         padding: EdgeInsets.all(10),
      //         height: MediaQuery.of(context).size.height * 0.25,
      //         child: PriceMark(
      //           tags: markData[index]["tags"],
      //           store: markData[index]["store"],
      //           user: markData[index]["user"],
      //           date: markData[index]["date"],
      //           price: markData[index]["price"],
      //         )
      //       );
      //     } else {
      //       return Container(
      //         padding: EdgeInsets.all(10),
      //         height: MediaQuery.of(context).size.height * 0.25,
      //         child: ReviewMark(
      //           comment: markData[index]["comment"],
      //           rating: markData[index]["rating"],
      //           store: markData[index]["store"],
      //           user: markData[index]["user"],
      //           date: markData[index]["date"],
      //         )
      //       );
      //     }
      //   }
      // ),
      // view: TimelineView(items: markData)
      view: FutureBuilder(
        future: getMerged(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            return TimelineView(items: snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey)),
            );
          }
        }
      )
    );
  }

  Future<List> getMerged() async {
    Position location = await locationService.getLocation();
    String pricesUrl = 'https://markit-api.azurewebsites.net/prices/query?latitude=${location.latitude}&longitude=${location.longitude}';
    String ratingsUrl = 'https://markit-api.azurewebsites.net/ratings/query?latitude=${location.latitude}&longitude=${location.longitude}';
    List prices = await apiService.getList(pricesUrl);
    List ratings = await apiService.getList(ratingsUrl);
    List combined = prices + ratings;
    combined.sort((b, a) => a['createdAt'].compareTo(b['createdAt']));
    return combined;
  }

  Future<List> getPrices() async {
    Position location = await locationService.getLocation();
    String pricesUrl = 'https://markit-api.azurewebsites.net/prices/query?latitude=${location.latitude}&longitude=${location.longitude}';
    List prices = await apiService.getList(pricesUrl);
    return prices;
  }

  Future<List> getReviews() async {
    Position location = await locationService.getLocation();
    String ratingsUrl = 'https://markit-api.azurewebsites.net/ratings/query?latitude=${location.latitude}&longitude=${location.longitude}';
    List ratings = await apiService.getList(ratingsUrl);
    return ratings;
  }
}