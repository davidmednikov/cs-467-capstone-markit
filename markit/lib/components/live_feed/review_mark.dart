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
          Align(
            alignment: Alignment(0, 0),
            child: Text(comment),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Align(
              alignment: Alignment(0, 0),
              child: Text(rating.toString())
            )
          ),
          Spacer(flex: 3),
          Align(
            alignment: Alignment(0, 0),
            child: Text(store)
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