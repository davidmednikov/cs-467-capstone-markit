import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

import 'package:markit/components/live_feed/components/price_mark.dart';
import 'package:markit/components/live_feed/components/review_mark.dart';
import 'package:markit/components/models/store_model.dart';

// code for TimelineView class modified from Flutter Timeline plug-in by Furkan Tektas at:
// https://github.com/furkantektas/timeline_list/blob/master/example/lib/timeline.dart#L38
class TimelineView extends StatelessWidget {
  final List items;
  final Position location;

  TimelineView({Key key, this.items, this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Timeline.builder(
      itemBuilder: timelineBuilder,
      itemCount: items.length,
      physics: ClampingScrollPhysics(),
      position: TimelinePosition.Left
    );
  }

  TimelineModel timelineBuilder(BuildContext context, int index) {
    final item = items[index];
    if (item['price'] != null) {
      return TimelineModel(
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: PriceMark(
            tags: List<String>.from(item['tagNames']),
            store: StoreModel.fromJson(item['store']),
            user: item['userName'], // Needs to be MarkitUser
            submittedDate: DateTime.parse(item['createdAt']),
            price: item['price'],
            location: location,
          )
        ),
        position: TimelineItemPosition.left,
        isFirst: index == 0,
        isLast: index == items.length,
        icon: Icon(
          Icons.local_offer,
          color: Colors.white,
        ),
        iconBackground: Colors.deepOrange
      );
    } else {
      return TimelineModel(
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ReviewMark(
            comment: item['comment'],
            rating: item['points'],
            store: StoreModel.fromJson(item['store']),
            user: item['userName'],
            submittedDate: DateTime.parse(item['createdAt']),
            location: location,
          )
        ),
        position: TimelineItemPosition.left,
        isFirst: index == 0,
        isLast: index == items.length,
        icon: Icon(
          Icons.rate_review,
          color: Colors.white
        ),
        iconBackground: Colors.deepOrange
      );
    }
  }
}