import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:markit/components/live_feed/components/price_mark.dart';
import 'package:markit/components/live_feed/components/review_mark.dart';
import 'package:markit/components/models/markit_user_model.dart';
import 'package:markit/components/models/store_model.dart';

// code for TimelineView class modified from Flutter Timeline plug-in by Furkan Tektas at:
// https://github.com/furkantektas/timeline_list/blob/master/example/lib/timeline.dart#L38
class TimelineView extends StatelessWidget {
  final List items;
  final Position location;

  GlobalKey<BottomScaffoldState> bottomScaffoldKey;

  TimelineView({Key key, this.items, this.location, this.bottomScaffoldKey}) : super(key: key);

  final DateFormat formatter = new DateFormat("yyyy-MM-ddTHH:mm:ss");

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
            user: MarkitUserModel.fromJsonForLiveFeed(item['user']),
            submittedDate: formatter.parse(item['createdAt'], true),
            price: item['price'],
            location: location,
            bottomScaffoldKey: bottomScaffoldKey,
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
            user: MarkitUserModel.fromJsonForLiveFeed(item['user']),
            submittedDate: formatter.parse(item['createdAt'], true),
            location: location,
            bottomScaffoldKey: bottomScaffoldKey,
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