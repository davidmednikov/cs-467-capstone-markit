import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rating_bar/rating_bar.dart';

import 'package:markit/components/common/status_icon.dart';
import 'package:markit/components/models/markit_user_model.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/live_feed_service.dart';
import 'package:markit/components/service/location_service.dart';

class ReviewMark extends StatelessWidget {
  final String comment;
  final int rating;
  final StoreModel store;
  final String user;
  // final MarkitUserModel user;
  final DateTime submittedDate;
  final Position location;

  ReviewMark({
    Key key,
    this.comment,
    this.rating,
    this.store,
    this.user,
    this.submittedDate,
    this.location,
  }) : super(key: key);

  final DateFormat formatter = new DateFormat.yMd();
  final LocationService locationService = new LocationService();

  @override
  Widget build(BuildContext context) {
    String strDate = formatter.format(submittedDate);
    double distance = locationService.locationBetweenInMiles(location.latitude, location.longitude, store.latitude, store.longitude);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      elevation: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      '${LiveFeedService.getTimeString(submittedDate)}',
                      style: TextStyle(
                        color: Colors.grey
                      )
                    ),
                  )
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      '$strDate',
                      style: TextStyle(
                        color: Colors.grey
                      )
                    ),
                  )
                ),
              ),
            ],
          ),
          Row(
            children:[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 5, bottom: 5, top: 5),
                  child: Row(
                    children: [
                      Flexible(
                        child: getCommentWidget(),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: getRatingBar(),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '$store',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text('${distance.toStringAsFixed(2)} mi away',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 5, top: 5, right: 15, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text('$user',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: StatusIcon(userReputation: 100),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getRatingBar() {
    double rating = store.averageRating == null ? 0 : store.averageRating;
    return RatingBar.readOnly(
      initialRating: (rating * 2).roundToDouble() / 2.0,
      isHalfAllowed: true,
      emptyIcon: FontAwesomeIcons.star,
      filledIcon: FontAwesomeIcons.solidStar,
      halfFilledIcon: FontAwesomeIcons.starHalfAlt,
      size: 16,
    );
  }

  Widget getCommentWidget() {
    if (comment != null && comment.length > 0) {
      return Text(comment,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.left,
      );
    }
    return Text('(No comment)',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        textAlign: TextAlign.left,
      );
  }
}