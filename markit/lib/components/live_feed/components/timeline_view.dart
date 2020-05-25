import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

import 'package:markit/components/live_feed/components/price_mark.dart';
import 'package:markit/components/live_feed/components/review_mark.dart';

// code for TimelineView class modified from Flutter Timeline plug-in by Furkan Tektas at:
// https://github.com/furkantektas/timeline_list/blob/master/example/lib/timeline.dart#L38
class TimelineView extends StatelessWidget {
  final List items;

  TimelineView({Key key, this.items}) : super(key: key);

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
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.25,
          child: PriceMark(
            tags: item['tagNames'],
            store: item['store']['name'],
            user: item['userName'],
            date: item['createdAt'],
            price: item['price'],
          )
        ),
        position: TimelineItemPosition.left,
        isFirst: index == 0,
        isLast: index == items.length,
        icon: Icon(
          Icons.add_shopping_cart,
          color: Colors.white,
        ),
        iconBackground: Colors.deepOrange
      );
    } else {
      return TimelineModel(
        Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.25,
          child: ReviewMark(
            comment: item['comment'],
            rating: item['points'],
            store: item['store']['name'],
            user: item['userName'],
            date: item['createdAt'],
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