import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

import 'package:markit/components/live_feed/components/price_mark.dart';
import 'package:markit/components/live_feed/components/review_mark.dart';
import 'package:markit/components/models/markit_user_model.dart';
import 'package:markit/components/models/store_model.dart';

class RecentMarks extends StatelessWidget {

  List marks;
  final Position location;

  GlobalKey<BottomScaffoldState> bottomScaffoldKey;

  double topPaddingFactor;

  RecentMarks({Key key, this.marks, this.location, this.bottomScaffoldKey, this.topPaddingFactor}) : super(key: key);

  final DateFormat formatter = new DateFormat("yyyy-MM-ddTHH:mm:ss");

  int bottomNavBarIndex;

  @override
  Widget build(BuildContext context) {
    bottomNavBarIndex = bottomScaffoldKey.currentState.selectedIndex;
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * topPaddingFactor),
      child: showTimelineOrIcon(),
    );
  }

  Widget showTimelineOrIcon() {
    if (marks.length == 0) {
      return Center(
        child: Opacity(
          opacity: 0.35,
          child: FaIcon(FontAwesomeIcons.commentSlash, size: 125, color: Colors.grey),
        ),
      );
    }
    return Timeline.builder(
      itemBuilder: timelineBuilder,
      itemCount: marks.length,
      physics: ClampingScrollPhysics(),
      position: TimelinePosition.Left
    );
  }

  TimelineModel timelineBuilder(BuildContext context, int index) {
    final item = marks[index];
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
            isSalePrice: item['isSalePrice'],
            location: location,
            bottomScaffoldKey: bottomScaffoldKey,
            hideStore: bottomNavBarIndex == 2,
            hideUser: bottomNavBarIndex == 3,
          )
        ),
        position: TimelineItemPosition.left,
        isFirst: index == 0,
        isLast: index == marks.length,
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
            hideStore: bottomNavBarIndex == 2,
            hideUser: bottomNavBarIndex == 3,
          )
        ),
        position: TimelineItemPosition.left,
        isFirst: index == 0,
        isLast: index == marks.length,
        icon: Icon(
          Icons.rate_review,
          color: Colors.white
        ),
        iconBackground: Colors.deepOrange
      );
    }
  }
}