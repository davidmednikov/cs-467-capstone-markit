import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:markit/components/live_feed/components/price_mark.dart';
import 'package:markit/components/live_feed/components/review_mark.dart';
import 'package:markit/components/models/markit_user_model.dart';
import 'package:markit/components/models/store_model.dart';

class RecentMarks extends StatelessWidget {

  List marks;
  final Position location;

  RecentMarks({Key key, this.marks, this.location}) : super(key: key);

  final DateFormat formatter = new DateFormat("yyyy-MM-ddTHH:mm:ss");

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: marks.length,
      itemBuilder: (BuildContext context, int index) {
        final Map<String, Object> item = marks[index];
        if (item['price'] != null) {
          return PriceMark(
            tags: List<String>.from(item['tagNames']),
            store: StoreModel.fromJson(item['store']),
            user: MarkitUserModel.fromJsonForLiveFeed(item['user']),
            submittedDate: formatter.parse(item['createdAt'], true),
            price: item['price'],
            location: location
          );
        } else {
          return ReviewMark(
            comment: item['comment'],
            rating: item['points'],
            store: StoreModel.fromJson(item['store']),
            user: MarkitUserModel.fromJsonForLiveFeed(item['user']),
            submittedDate: formatter.parse(item['createdAt'], true),
            location: location
          );
        }
      }
    );
  }
}