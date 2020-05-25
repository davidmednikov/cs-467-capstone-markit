import 'package:flutter/material.dart';

import 'package:markit/components/live_feed/components/price_mark.dart';
import 'package:markit/components/live_feed/components/review_mark.dart';

class RecentMarks extends StatelessWidget {

  List marks;

  RecentMarks({Key key, this.marks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: marks.length,
      itemBuilder: (BuildContext context, int index) { //adjust based on available data 
        if (marks[index]['type'] == 'price') {
          return PriceMark();
        } else {
          return ReviewMark();
        }
        
      }
    );
  }
}