import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/store/store_listing.dart';

class ViewStores extends StatelessWidget {

  ViewStores({Key key}) : super(key: key);

  final storeData = [
    { 
      "name": "Whole Foods",
      "city": "Berkeley",
      "state": "California"
    },
        { 
      "name": "Sprouts",
      "city": "Oakland",
      "state": "California"
    },
    { 
      "name": "Trader Joe's",
      "city": "Berkeley",
      "state": "California"
    },
    { 
      "name": "Safeway",
      "city": "Oakland",
      "state": "California"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'View Stores',
      view: Column(children: <Widget>[
        Expanded(
          flex: 1,
          child: Row(children: <Widget>[
            Expanded(
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                color: Colors.white,
                child: Text("Change location"),
                padding: EdgeInsets.all(20)
              )
            ),
            Expanded(
              child: RaisedButton(
                onPressed: () {},
                shape: CircleBorder(),
                color: Colors.white,
                child: Text("Map View"),
                padding: EdgeInsets.all(40)
              )
            )
          ])
        ),
        Expanded(
          flex: 3,
          child: ListView.builder(
            itemCount: storeData.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.25,
                child: StoreListing(
                  name: storeData[index]["name"],
                  city: storeData[index]["city"],
                  state: storeData[index]["state"]
                )
              );
            }
          ),
        )
      ]),
    );
  }
}