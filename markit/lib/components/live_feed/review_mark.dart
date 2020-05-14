import 'package:flutter/material.dart';

class ReviewMark extends StatelessWidget {
  final List<String> tags;
  final String store;
  final String user;
  final String date;
  final String comment;
  final int rating;

  ReviewMark({
    Key key,
    this.tags,
    this.store,
    this.user,
    this.date,
    this.comment,
    this.rating
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
          Spacer(flex: 1),
          Text(comment),
          Spacer(flex: 1),
          Text(
            '<${rating.toString()} stars> at $store',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          ),
          Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('by $user'),
              Text("<Icon>")
            ],
          ),
          Spacer(flex: 1)
      ])
    );
  }
}