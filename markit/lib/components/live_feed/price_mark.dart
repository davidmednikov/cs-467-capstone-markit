import 'package:flutter/material.dart';

class PriceMark extends StatelessWidget {
  final List<String> tags;
  final String store;
  final double price;
  final String user;
  final String date;

  PriceMark({
    Key key,
    this.tags,
    this.store,
    this.user,
    this.date,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(date)
            )
          ),
          Spacer(flex: 3),
          Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(tags[0]),
                Text(tags[1])
              ],
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Align(
                alignment: Alignment(0, 0),
                child: Text(price.toString()),
              ),
            )
          ]),
          Spacer(flex: 3),
          Align(
            alignment: Alignment(0, 0),
            child: Column(children: <Widget>[
              Text(store)
            ],)
          ),
          Spacer(flex: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(user),
              Text("<Icon>")
            ],
          ),
          Spacer(flex: 1)
      ])
    );
  }
}