import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:markit/components/live_feed/components/timeline_view.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/date_service.dart';
import 'package:markit/components/service/location_service.dart';
import 'package:markit/components/service/notification_service.dart';

class LiveFeed extends StatefulWidget {

  GlobalKey<BottomScaffoldState> bottomScaffoldKey;

  LiveFeed({Key key, this.bottomScaffoldKey}) : super(key: key);

  ApiService apiService = new ApiService();
  DateService dateService = new DateService();
  LocationService locationService = new LocationService();
  NotificationService notificationService = new NotificationService();

@override
  LiveFeedState createState() => LiveFeedState();
}

class LiveFeedState extends State<LiveFeed> {

  List<Map> liveFeedEvents;

  Position location;

  String selected = 'All';

  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'Live Feed',
      liveFeedKey: widget.key,
      view: FutureBuilder(
        future: getLiveFeedEvents(),
        builder: (context, snapshot) => showTimelineOrLoading(snapshot),
      ),
    );
  }

  void changeSelected(String newSelected) {
    setState(() {
      selected = newSelected;
    });
  }

  Future<List<Map>> getLiveFeedEvents() async {
    List<Map> activityList;
    if (selected == 'Prices') {
      activityList = await getRecentPrices();
      if (activityList.length == 0) {
        widget.notificationService.showErrorNotification('No prices found nearby.');
      }
    } else if (selected == 'Reviews') {
      activityList = await  getRecentRatings();
      if (activityList.length == 0) {
        widget.notificationService.showErrorNotification('No reviews found nearby.');
      }
    } else {
      activityList = await  getCombinedLiveFeed();
      if (activityList.length == 0) {
        widget.notificationService.showErrorNotification('No activity found nearby.');
      }
    }
    return activityList;
  }

  Future<List<Map>> getCombinedLiveFeed() async {
    List<Map> prices = await getRecentPrices();
    List<Map> ratings = await getRecentRatings();
    List combined = prices + ratings;
    combined.sort((b, a) => a['createdAt'].compareTo(b['createdAt']));
    return combined;
  }

  Future<List<Map>> getRecentPrices() async {
    if (location == null) {
      location = await widget.locationService.getLocation();
    }
    String url = 'https://markit-api.azurewebsites.net/prices/query?latitude=${location.latitude}&longitude=${location.longitude}';
    return List<Map>.from(await widget.apiService.getList(url));
  }

  Future<List<Map>> getRecentRatings() async {
    if (location == null) {
      location = await widget.locationService.getLocation();
    }
    String url = 'https://markit-api.azurewebsites.net/ratings/query?latitude=${location.latitude}&longitude=${location.longitude}';
    return List<Map>.from(await widget.apiService.getList(url));
  }

  Widget showTimelineOrLoading(AsyncSnapshot<List<Map>> snapshot) {
    if (snapshot.hasData) {
      List<Map> events = snapshot.data;
      return TimelineView(items: events, location: location, bottomScaffoldKey: widget.bottomScaffoldKey, selected: selected);
    }
    return Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange)),
    );
  }
}