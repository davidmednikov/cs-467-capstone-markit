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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      elevation: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                date,
                style: TextStyle(
                  color: Colors.grey
                )
              )
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Text(tags[0]),
          Text(tags[1]),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            '\$${price.toString()} at $store',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            )),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
            Text('by $user'),
            Text("<Icon>"),
          ]),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ])
    );
  }
}