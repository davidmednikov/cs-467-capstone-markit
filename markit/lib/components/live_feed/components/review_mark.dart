import 'package:date_format/date_format.dart';
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
    DateTime convertedDate = DateTime.parse(date);
    String strDate = formatDate(convertedDate, [mm, '/', dd, '/', yy]);

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
                '$strDate',
                style: TextStyle(
                  color: Colors.grey
                )
              )
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Text(
            '<${rating.toString()} stars> at $store',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text('"$comment"'),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('by $user'),
              Text('<Icon>')
            ],
          ),
          Spacer(flex: 1)
      ])
    );
  }
}