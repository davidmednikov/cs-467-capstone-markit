import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:markit/components/common/status_icon.dart';
import 'package:markit/components/models/markit_user_model.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/live_feed_service.dart';
import 'package:markit/components/service/location_service.dart';

class PriceMark extends StatelessWidget {
  final List<String> tags;
  final StoreModel store;
  final double price;
  final String user;
  // final MarkitUserModel user;
  final DateTime submittedDate;
  final Position location;

  PriceMark({
    Key key,
    this.tags,
    this.price,
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
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 5, bottom: 5, top: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 3),
                            child: Text('Tags:',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(getTagsList(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
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
                        child: Text('\$$price',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.right,
                        ),
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
                          Flexible(
                            child: Text(
                              '$store',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.left,
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
                              // overflow: TextOverflow.ellipsis,
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

  String getTagsList() {
    String returnString = '';
    for (int i = 0; i < tags.length; i++) {
      if (i != tags.length - 1 && tags.length != 1) {
        returnString += '${tags[i]} ,\n';
      } else {
        returnString += '${tags[i]}';
      }
    }
    return returnString;
  }
}