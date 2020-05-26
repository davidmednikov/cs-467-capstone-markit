import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/live_feed/components/timeline_view.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/live_feed_service.dart';
import 'package:markit/components/service/location_service.dart';

class LiveFeed extends StatefulWidget {

  LiveFeed({Key key}) : super(key: key);

  ApiService apiService = new ApiService();
  LiveFeedService liveFeedService = new LiveFeedService();
  LocationService locationService = new LocationService();

@override
  LiveFeedState createState() => LiveFeedState();
}

class LiveFeedState extends State<LiveFeed> {

//dummy data until GET request to Recent Marks API endpoint is added

  List<Map> liveFeedEvents;

  Position location;

  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'Live Feed',
      view: FutureBuilder(
        future: getLiveFeedEvents(),
        builder: (context, snapshot) => showTimelineOrLoading(snapshot),
      ),
    );
  }

  Future<List<Map>> getLiveFeedEvents() async {
    List<Map> prices = List<Map>.from(await getRecentPrices());
    List<Map> ratings = List<Map>.from(await getRecentRatings());
    List combined = prices + ratings;
    combined.sort((b, a) => a['createdAt'].compareTo(b['createdAt']));
    return combined;
  }

  Future<List> getRecentPrices() async {
    location = await widget.locationService.getLocation();
    String url = 'https://markit-api.azurewebsites.net/prices/query?latitude=${location.latitude}&longitude=${location.longitude}';
    return widget.apiService.getList(url);
  }

  Future<List> getRecentRatings() async {
    location = await widget.locationService.getLocation();
    String url = 'https://markit-api.azurewebsites.net/ratings/query?latitude=${location.latitude}&longitude=${location.longitude}';
    return widget.apiService.getList(url);
  }

  Widget showTimelineOrLoading(AsyncSnapshot<List<Map>> snapshot) {
    if (snapshot.hasData) {
      List<Map> events = snapshot.data;
      return TimelineView(items: events, location: location);
    }
    return Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange)),
    );
  }
}