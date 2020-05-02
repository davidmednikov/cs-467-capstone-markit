import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../common/scaffold/top_scaffold.dart';
import './review_mark.dart';
import './price_mark.dart';

class LiveFeed extends StatelessWidget {

  LiveFeed({Key key}) : super(key: key);

//dummy data until GET request to Recent Marks API endpoint is added
  final markData = [
    { 
      "tags": ["Charmin Ultra Soft 8ct", "paper towels 8ct"],
      "store": "Safeway",
      "price": 3.99,
      "user": "easyshoppin72",
      "date": "4/26/2020",
    },
    {
      "store": "Safeway",
      "user": "easyshoppin72",
      "date": "4/25/2020",
      "comment": "Pretty good prices!",
      "rating": 4,
    },
    {
      "tags": ["Kettle Chips Salt and Vinegar 6oz", "potato chips 6oz"],
      "store": "Whole Foods",
      "price": 2.99,
      "user": "frugaldude01",
      "date": "4/25/2020",
    },
    {
      "tags": ["Folgers Dark Roast 12oz", "coffee 12oz"],
      "store": "Safeway",
      "price": 5.99,
      "user": "frugaldude01",
      "date": "4/25/2020",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'Live Feed',
      view: ListView.builder(
        itemCount: markData.length,
        itemBuilder: (context, index) {
          if (markData[index]["price"] != null) {
            return Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.25,
              child: PriceMark(
                tags: markData[index]["tags"],
                store: markData[index]["store"],
                user: markData[index]["user"],
                date: markData[index]["date"],
                price: markData[index]["price"],
              )
            );
          } else {
            return Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.25,
              child: ReviewMark(
                comment: markData[index]["comment"],
                rating: markData[index]["rating"],
                store: markData[index]["store"],
                user: markData[index]["user"],
                date: markData[index]["date"],
              )
            );
          }
        }
      ),
    );
  }
}